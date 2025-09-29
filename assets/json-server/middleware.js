const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const { generateChatResponse, generateInsights } = require("./geminiHelper");
require("dotenv").config();

const JWT_SECRET = process.env.JWT_SECRET || "your_jwt_secret";
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || "1d";

const generateToken = (user) => {
  return jwt.sign(
    {
      id: user.id,
      name: user.name,
      email: user.email,
      defaultRole: user.defaultRole,
    },
    JWT_SECRET,
    { expiresIn: JWT_EXPIRES_IN }
  );
};

const verifyToken = (token) => {
  try {
    return jwt.verify(token, JWT_SECRET);
  } catch (error) {
    return null;
  }
};

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    return res.status(401).json({
      error: "Access token required",
      message: "Please log in first",
    });
  }

  const decoded = verifyToken(token);
  if (!decoded) {
    return res.status(403).json({
      error: "Invalid or expired token",
      message: "Please log in again",
    });
  }

  req.user = decoded;
  next();
};

const publicEndpoints = ["/api/login", "/api/register"];

const isPublicEndpoint = (path) => {
  return publicEndpoints.some((endpoint) => path.startsWith(endpoint));
};

module.exports = (req, res, next) => {
  if (!isPublicEndpoint(req.path)) {
    return authenticateToken(req, res, () => {
      handleRoutes(req, res, next);
    });
  }

  handleRoutes(req, res, next);
};

async function handleRoutes(req, res, next) {
  // Login
  if (req.method === "POST" && req.path === "/api/login") {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: "Email and password are required" });
    }

    const users = req.app.db.get("users").value();
    const user = users.find((u) => u.email === email);

    if (!user || !bcrypt.compareSync(password, user.password)) {
      return res.status(401).json({ message: "Incorrect email or password" });
    }

    const token = generateToken(user);

    return res.json({
      message: "Login successful",
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        defaultRole: user.defaultRole,
        avatar: user.avatar,
        lastLogin: new Date().toISOString(),
      },
    });
  }

  // Register
  if (req.method === "POST" && req.path === "/api/register") {
    const { name, email, password, defaultRole } = req.body;

    if (!name || !email || !password) {
      return res
        .status(400)
        .json({ error: "Name, email, and password are required" });
    }

    const users = req.app.db.get("users").value();
    const existingUser = users.find((u) => u.email === email);

    if (existingUser) {
      return res.status(409).json({ message: "Email already registered" });
    }

    const maxId =
      users.length > 0 ? Math.max(...users.map((u) => parseInt(u.id))) : 0;
    const hashedPassword = bcrypt.hashSync(password, 10);
    const newUser = {
      id: String(maxId + 1),
      name,
      email,
      password: hashedPassword,
      avatar: `https://gravatar.com/avatar/${email}`,
      defaultRole: defaultRole || "Member",
      createdAt: new Date().toISOString(),
      lastLogin: null,
    };

    req.app.db.get("users").push(newUser).write();
    const token = generateToken(newUser);

    return res.status(201).json({
      message: "Registration successful",
      token,
      user: {
        id: newUser.id,
        name: newUser.name,
        email: newUser.email,
        defaultRole: newUser.defaultRole,
        avatar: newUser.avatar,
        createdAt: newUser.createdAt,
      },
    });
  }

  // Profile
  if (req.method === "GET" && req.path === "/api/profile") {
    const users = req.app.db.get("users").value();
    const user = users.find((u) => u.id === req.user.id);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    return res.json({
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        defaultRole: user.defaultRole,
        avatar: user.avatar,
        createdAt: user.createdAt,
        lastLogin: user.lastLogin,
      },
    });
  }

  // My Projects
  if (req.method === "GET" && req.path === "/api/my-projects") {
    const projectMembers = req.app.db.get("projectMembers").value();
    const projects = req.app.db.get("projects").value();
    const userMemberships = projectMembers.filter(
      (m) => m.userId === req.user.id && m.status === "active"
    );

    const userProjects = userMemberships
      .map((membership) => {
        const project = projects.find(
          (p) => p.id === membership.projectId && !p.archived
        );
        return project
          ? {
              project: {
                id: project.id,
                name: project.name,
                description: project.description,
                status: project.status,
                createdAt: project.createdAt,
                membersCount: project.membersCount,
                progress: project.progress,
              },
              role: membership.projectRole,
              permissions: membership.permissions,
            }
          : null;
      })
      .filter(Boolean);

    return res.json({
      message: "Projects retrieved successfully",
      totalProjects: userProjects.length,
      projects: userProjects,
    });
  }

  // My Role in Project
  if (
    req.method === "GET" &&
    req.path.match(/^\/api\/projects\/\d+\/my-role$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(404).json({
        error: "You are not registered in this project",
        project: {
          id: project.id,
          name: project.name,
        },
      });
    }

    const memberStatus =
      req.app.db
        .get("memberStatus")
        .find({ userId: req.user.id, projectId })
        .value() || {};

    return res.json({
      project: {
        id: project.id,
        name: project.name,
        description: project.description,
        status: project.status,
      },
      myRole: {
        membershipId: membership.id,
        projectRole: membership.projectRole,
        status: memberStatus.status || "unknown",
        currentTaskId: memberStatus.currentTaskId || null,
        mood: memberStatus.mood || "unknown",
        focusDuration: memberStatus.focusDuration || 0,
        efficiency: memberStatus.efficiency || 0,
        joinedAt: membership.joinedAt,
        permissions: membership.permissions,
      },
      user: {
        id: req.user.id,
        name: req.user.name,
        email: req.user.email,
        defaultRole: req.user.defaultRole,
      },
    });
  }

  // Token Refresh
  if (req.method === "POST" && req.path === "/api/token/refresh") {
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(" ")[1];

    if (!token) {
      return res.status(401).json({ error: "Token required" });
    }

    const decoded = verifyToken(token);
    if (!decoded) {
      return res.status(403).json({ error: "Invalid token" });
    }

    const users = req.app.db.get("users").value();
    const user = users.find((u) => u.id === decoded.id);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const newToken = generateToken(user);

    return res.json({
      message: "Token refreshed successfully",
      token: newToken,
    });
  }

  // Projects Summary
  if (req.method === "GET" && req.path === "/api/projects/summary") {
    const projects = req.app.db
      .get("projects")
      .value()
      .filter((p) => !p.archived);
    const projectMembers = req.app.db.get("projectMembers").value();
    const memberStatus = req.app.db.get("memberStatus").value();

    const summary = projects.map((project) => {
      const members = projectMembers.filter(
        (m) => m.projectId === project.id && m.status === "active"
      );
      const statusCounts = memberStatus
        .filter((ms) => ms.projectId === project.id)
        .reduce((acc, ms) => {
          acc[ms.status] = (acc[ms.status] || 0) + 1;
          return acc;
        }, {});
      const avgEfficiency =
        members.length > 0
          ? memberStatus
              .filter((ms) => ms.projectId === project.id)
              .reduce((sum, ms) => sum + (ms.efficiency || 0), 0) /
            members.length
          : 0;
      const totalFocusTime = memberStatus
        .filter((ms) => ms.projectId === project.id)
        .reduce((sum, ms) => sum + (ms.focusDuration || 0), 0);
      const moodCounts = memberStatus
        .filter((ms) => ms.projectId === project.id)
        .reduce((acc, ms) => {
          acc[ms.mood] = (acc[ms.mood] || 0) + 1;
          return acc;
        }, {});

      return {
        projectId: project.id,
        projectName: project.name,
        description: project.description,
        status: project.status,
        totalMembers: members.length,
        memberStatus: {
          active: statusCounts.focused || 0,
          available: statusCounts.available || 0,
          blocked: statusCounts.blocked || 0,
        },
        performance: {
          avgEfficiency: Math.round(avgEfficiency * 100) / 100,
          totalFocusTime,
          progress: project.progress,
        },
        moodDistribution: moodCounts,
        createdAt: project.createdAt,
      };
    });

    const overallSummary = {
      totalProjects: projects.length,
      activeProjects: projects.filter((p) => p.status === "active").length,
      totalMembers: projectMembers.length,
      overallStatus: {
        active: memberStatus.filter((ms) => ms.status === "focused").length,
        available: memberStatus.filter((ms) => ms.status === "available")
          .length,
        blocked: memberStatus.filter((ms) => ms.status === "blocked").length,
      },
      overallPerformance: {
        avgEfficiency:
          Math.round(
            (memberStatus.reduce((sum, ms) => sum + (ms.efficiency || 0), 0) /
              memberStatus.length) *
              100
          ) / 100,
        totalFocusTime: memberStatus.reduce(
          (sum, ms) => sum + (ms.focusDuration || 0),
          0
        ),
      },
    };

    return res.json({
      summary: overallSummary,
      projects: summary,
      requestedBy: req.user,
    });
  }

  // Project Summary
  if (
    req.method === "GET" &&
    req.path.match(/^\/api\/projects\/\d+\/summary$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(403).json({
        error: "Access denied",
        message: "You are not a member of this project",
        project: {
          id: project.id,
          name: project.name,
        },
      });
    }

    const projectMembers = req.app.db
      .get("projectMembers")
      .filter({ projectId, status: "active" })
      .value();
    const memberStatus = req.app.db
      .get("memberStatus")
      .filter({ projectId })
      .value();
    const activities = req.app.db
      .get("activities")
      .filter({ projectId })
      .value();
    const insights = req.app.db.get("insights").filter({ projectId }).value();
    const tasks = req.app.db
      .get("tasks")
      .filter({ projectId, archived: false })
      .value();

    const users = req.app.db.get("users").value();
    const userMap = users.reduce((acc, user) => {
      acc[user.id] = user.name;
      return acc;
    }, {});

    const membersWithNames = projectMembers.map((member) => ({
      ...member,
      name: userMap[member.userId] || "Unknown",
    }));

    const statusCounts = memberStatus.reduce((acc, ms) => {
      acc[ms.status] = (acc[ms.status] || 0) + 1;
      return acc;
    }, {});
    const avgEfficiency =
      memberStatus.length > 0
        ? memberStatus.reduce((sum, ms) => sum + (ms.efficiency || 0), 0) /
          memberStatus.length
        : 0;
    const totalFocusTime = memberStatus.reduce(
      (sum, ms) => sum + (ms.focusDuration || 0),
      0
    );
    const recentActivities = activities
      .sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp))
      .slice(0, 5);
    const criticalInsights = insights.filter((i) => i.priority === "critical");
    const moodCounts = memberStatus.reduce((acc, ms) => {
      acc[ms.mood] = (acc[ms.mood] || 0) + 1;
      return acc;
    }, {});
    const completedTasks = tasks.filter((t) => t.status === "completed").length;
    const completionRate =
      tasks.length > 0 ? (completedTasks / tasks.length) * 100 : 0;

    const projectSummary = {
      message: "Project summary retrieved successfully",
      project: {
        id: project.id,
        name: project.name,
        description: project.description,
        status: project.status,
        createdAt: project.createdAt,
        progress: project.progress,
        membersCount: project.membersCount,
      },
      teamMetrics: {
        totalMembers: projectMembers.length,
        memberStatus: {
          active: statusCounts.focused || 0,
          available: statusCounts.available || 0,
          blocked: statusCounts.blocked || 0,
        },
        performance: {
          avgEfficiency: Math.round(avgEfficiency * 100) / 100,
          totalFocusTime,
          completionRate: Math.round(completionRate * 100) / 100,
        },
        moodDistribution: moodCounts,
      },
      teamMembers: membersWithNames,
      // recentActivities,
      // criticalInsights,
      taskSummary: {
        totalTasks: tasks.length,
        completedTasks,
        completionRate: Math.round(completionRate * 100) / 100,
      },
      lastUpdated: new Date().toISOString(),
      requestedBy: req.user,
      accessLevel: membership.role,
    };

    return res.json(projectSummary);
  }

  // Project Activities
  if (
    req.method === "GET" &&
    req.path.match(/^\/api\/projects\/\d+\/activity$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(403).json({
        error: "Access denied",
        message: "You are not a member of this project",
        project: {
          id: project.id,
          name: project.name,
        },
      });
    }

    const activities = req.app.db
      .get("activities")
      .filter({ projectId })
      .filter((a) => a.visibility === "team" || a.userId === req.user.id)
      .orderBy("timestamp", "desc")
      .value();

    return res.json({
      message: "Project activities retrieved successfully",
      project: {
        id: project.id,
        name: project.name,
        description: project.description,
      },
      totalActivities: activities.length,
      activities,
      requestedBy: req.user,
    });
  }

  // Project Insights
  if (
    req.method === "GET" &&
    req.path.match(/^\/api\/projects\/\d+\/insights$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(403).json({
        error: "Access denied",
        message: "You are not a member of this project",
        project: {
          id: project.id,
          name: project.name,
        },
      });
    }

    const insights = req.app.db
      .get("insights")
      .filter({ projectId })
      .filter(
        (i) =>
          i.status === "active" &&
          (i.affectedUserIds.includes(req.user.id) ||
            membership.role === "leader")
      )
      .orderBy("createdAt", "desc")
      .value();

    const insightsByPriority = {
      critical: insights.filter((i) => i.priority === "critical").length,
      high: insights.filter((i) => i.priority === "high").length,
      medium: insights.filter((i) => i.priority === "medium").length,
      low: insights.filter((i) => i.priority === "low").length,
    };

    return res.json({
      message: "Project insights retrieved successfully",
      project: {
        id: project.id,
        name: project.name,
        description: project.description,
      },
      totalInsights: insights.length,
      insightsByPriority,
      insights,
      requestedBy: req.user,
    });
  }

  // Tasks (Create)
  if (
    req.method === "POST" &&
    req.path.match(/^\/api\/projects\/\d+\/tasks$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership || !membership.permissions.assign_tasks) {
      return res.status(403).json({
        error: "Access denied",
        message: "You do not have permission to create tasks",
      });
    }

    const {
      title,
      description,
      assignedTo,
      priority,
      startDate,
      dueDate,
      estimatedHours,
      tags,
    } = req.body;

    if (!title || !assignedTo || !priority) {
      return res
        .status(400)
        .json({ error: "Title, assignedTo, and priority are required" });
    }

    const assignedMember = req.app.db
      .get("projectMembers")
      .find({ userId: assignedTo, projectId, status: "active" })
      .value();

    if (!assignedMember) {
      return res
        .status(400)
        .json({ error: "Assigned user is not a project member" });
    }

    const tasks = req.app.db.get("tasks").value();
    const maxId =
      tasks.length > 0 ? Math.max(...tasks.map((t) => parseInt(t.id))) : 0;
    const newTask = {
      id: String(maxId + 1),
      projectId,
      title,
      description: description || "",
      assignedTo,
      assignedBy: req.user.id,
      status: "todo",
      priority,
      progress: 0,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      startDate: startDate || new Date().toISOString(),
      dueDate: dueDate || null,
      blockedReason: null,
      dependencies: [],
      estimatedHours: estimatedHours || 0,
      actualHours: 0,
      archived: false,
      tags: tags || [],
    };

    req.app.db.get("tasks").push(newTask).write();

    // Add activity
    const activities = req.app.db.get("activities").value();
    const activityId =
      activities.length > 0
        ? Math.max(...activities.map((a) => parseInt(a.id))) + 1
        : 1;
    req.app.db
      .get("activities")
      .push({
        id: String(activityId),
        projectId,
        userId: req.user.id,
        taskId: newTask.id,
        type: "task_assigned",
        action: "Task assigned",
        description: `Assigned task "${title}" to user ${assignedTo}`,
        visibility: "team",
        metadata: {},
        timestamp: new Date().toISOString(),
      })
      .write();

    return res.status(201).json({
      message: "Task created successfully",
      task: newTask,
    });
  }

  // Notifications
  if (req.method === "GET" && req.path === "/api/notifications") {
    const notifications = req.app.db
      .get("notifications")
      .filter({ userId: req.user.id })
      .orderBy("createdAt", "desc")
      .value();

    return res.json({
      message: "Notifications retrieved successfully",
      totalNotifications: notifications.length,
      notifications,
      requestedBy: req.user,
    });
  }

  // AI Chat (Create Message)
  if (
    req.method === "POST" &&
    req.path.match(/^\/api\/projects\/\d+\/ai-chats$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(403).json({
        error: "Access denied",
        message: "You are not a member of this project",
      });
    }

    if (!project.settings?.aiChatEnabled) {
      return res.status(403).json({
        error: "AI chat disabled",
        message: "AI chat is not enabled for this project",
      });
    }

    const { content, title } = req.body;

    if (!content) {
      return res.status(400).json({ error: "Content is required" });
    }

    // Ambil data project untuk context
    const projectData = {
      project,
      tasks: req.app.db.get("tasks").filter({ projectId }).value(),
      projectMembers: req.app.db
        .get("projectMembers")
        .filter({ projectId })
        .value()
        .map((member) => {
          const user = req.app.db
            .get("users")
            .find({ id: member.userId })
            .value();
          return {
            userId: member.userId,
            name: user?.name || "Unknown",
            role: member.role,
            projectRole: member.projectRole,
            status: member.status,
          };
        }),
      activities: req.app.db
        .get("activities")
        .filter({ projectId })
        .orderBy("timestamp", "desc")
        .take(10)
        .value(), // Last 10 activities
      insights: req.app.db.get("insights").filter({ projectId }).value(),
      memberStatus: req.app.db
        .get("memberStatus")
        .filter({ projectId })
        .value(),
    };

    try {
      // Generate response pakai Gemini
      const aiResponse = await generateChatResponse(projectData, content);

      // Update atau create chat
      const aiChats = req.app.db.get("aiChats").value();
      let chat = aiChats.find(
        (c) =>
          c.projectId === projectId &&
          c.userId === req.user.id &&
          c.title === (title || "Default Chat")
      );
      let newMessageId;

      if (chat) {
        // Append ke existing chat
        newMessageId =
          Math.max(...chat.messages.map((m) => parseInt(m.id))) + 1;
        chat.messages.push({
          id: String(newMessageId),
          role: "user",
          content,
          timestamp: new Date().toISOString(),
        });
        chat.messages.push({
          id: String(newMessageId + 1),
          role: "assistant",
          content: aiResponse.text,
          contextUsed: aiResponse.contextUsed,
          timestamp: new Date().toISOString(),
        });
        chat.updatedAt = new Date().toISOString();
        // Update di db (lodash way)
        req.app.db.get("aiChats").find({ id: chat.id }).assign(chat).write();
      } else {
        // Create new chat
        const maxId =
          aiChats.length > 0
            ? Math.max(...aiChats.map((c) => parseInt(c.id)))
            : 0;
        newMessageId = 1;
        chat = {
          id: String(maxId + 1),
          projectId,
          userId: req.user.id,
          title:
            title ||
            `Chat with AI on ${new Date().toISOString().split("T")[0]}`,
          status: "active",
          createdAt: new Date().toISOString(),
          updatedAt: new Date().toISOString(),
          messages: [
            {
              id: "1",
              role: "user",
              content,
              timestamp: new Date().toISOString(),
            },
            {
              id: "2",
              role: "assistant",
              content: aiResponse.text,
              contextUsed: aiResponse.contextUsed,
              timestamp: new Date().toISOString(),
            },
          ],
        };
        req.app.db.get("aiChats").push(chat).write();
      }

      return res.status(201).json({
        message: "Chat response generated successfully",
        chat,
      });
    } catch (error) {
      console.error("Gemini Error:", error);
      return res.status(500).json({
        error: "Failed to generate AI response",
        details: error.message,
      });
    }
  }

  // Generate AI Insights (On-Demand)
  if (
    req.method === "POST" &&
    req.path.match(/^\/api\/projects\/\d+\/insights\/generate$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership || !membership.permissions?.generate_insights) {
      return res.status(403).json({
        error: "Access denied",
        message: "You do not have permission to generate insights",
      });
    }

    if (!project.settings?.aiInsightsEnabled) {
      return res.status(403).json({
        error: "AI insights disabled",
        message: "AI insights are not enabled for this project",
      });
    }

    // Ambil data project
    const projectData = {
      project,
      tasks: req.app.db
        .get("tasks")
        .filter({ projectId, archived: false })
        .value(),
      activities: req.app.db.get("activities").filter({ projectId }).value(),
      memberStatus: req.app.db
        .get("memberStatus")
        .filter({ projectId })
        .value(),
      projectMembers: req.app.db
        .get("projectMembers")
        .filter({ projectId, status: "active" })
        .value()
        .map((member) => {
          const user = req.app.db
            .get("users")
            .find({ id: member.userId })
            .value();
          return {
            userId: member.userId,
            name: user?.name || "Unknown",
            email: user?.email,
            role: member.role,
            projectRole: member.projectRole,
            status: member.status,
          };
        }),
      insights: req.app.db
        .get("insights")
        .filter({ projectId, status: "active" })
        .value(),
    };

    try {
      // Generate insights pakai Gemini
      const newInsights = await generateInsights(projectData);

      if (!newInsights || newInsights.length === 0) {
        return res.status(200).json({
          message: "No new insights generated",
          reason: "No actionable insights found based on current project data",
          newInsights: [],
          totalInsights: req.app.db
            .get("insights")
            .filter({ projectId })
            .value().length,
        });
      }

      // Hapus insights lama yang active (atau simpan history), tambah yang baru
      req.app.db
        .get("insights")
        .filter({ projectId, status: "active" })
        .each((i) => {
          i.status = "dismissed";
          i.dismissedAt = new Date().toISOString();
        })
        .write();

      newInsights.forEach((insight) => {
        req.app.db.get("insights").push(insight).write();
      });

      // Tambah activity log
      const activities = req.app.db.get("activities").value();
      const maxActivityId =
        activities.length > 0
          ? Math.max(...activities.map((a) => parseInt(a.id)))
          : 0;
      req.app.db
        .get("activities")
        .push({
          id: String(maxActivityId + 1),
          projectId,
          userId: req.user.id,
          taskId: null,
          type: "ai_insight_generated",
          action: "Generated AI insights",
          description: `Generated ${newInsights.length} new AI insights`,
          visibility: "team",
          metadata: { count: newInsights.length },
          timestamp: new Date().toISOString(),
        })
        .write();

      return res.status(201).json({
        message: "AI insights generated successfully",
        newInsights,
        totalInsights: req.app.db.get("insights").filter({ projectId }).value()
          .length,
      });
    } catch (error) {
      console.error("Gemini Insights Error:", error);
      return res.status(500).json({
        error: "Failed to generate insights",
        details: error.message,
      });
    }
  }

  // Get AI Chats for Project
  if (
    req.method === "GET" &&
    req.path.match(/^\/api\/projects\/\d+\/ai-chats$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(403).json({
        error: "Access denied",
        message: "You are not a member of this project",
      });
    }

    const chats = req.app.db
      .get("aiChats")
      .filter({ projectId, userId: req.user.id, status: "active" })
      .orderBy("updatedAt", "desc")
      .value();

    return res.json({
      message: "AI chats retrieved successfully",
      project: {
        id: project.id,
        name: project.name,
      },
      totalChats: chats.length,
      chats,
      requestedBy: req.user,
    });
  }

  // Get specific AI Chat
  if (
    req.method === "GET" &&
    req.path.match(/^\/api\/projects\/\d+\/ai-chats\/\d+$/)
  ) {
    const projectId = req.path.split("/")[3];
    const chatId = req.path.split("/")[5];

    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(403).json({
        error: "Access denied",
        message: "You are not a member of this project",
      });
    }

    const chat = req.app.db
      .get("aiChats")
      .find({ id: chatId, projectId, userId: req.user.id })
      .value();

    if (!chat) {
      return res.status(404).json({
        error: "Chat not found",
        message: "Chat not found or you don't have access to it",
      });
    }

    return res.json({
      message: "AI chat retrieved successfully",
      chat,
      requestedBy: req.user,
    });
  }

  // Update member status
  if (
    req.method === "PUT" &&
    req.path.match(/^\/api\/projects\/\d+\/member-status$/)
  ) {
    const projectId = req.path.split("/")[3];
    const project = req.app.db.get("projects").find({ id: projectId }).value();

    if (!project || project.archived) {
      return res.status(404).json({ error: "Project not found or archived" });
    }

    const membership = req.app.db
      .get("projectMembers")
      .find({ userId: req.user.id, projectId, status: "active" })
      .value();

    if (!membership) {
      return res.status(403).json({
        error: "Access denied",
        message: "You are not a member of this project",
      });
    }

    const { status, mood, currentTaskId, focusDuration, efficiency } = req.body;

    // Validate status
    const validStatuses = ["available", "focused", "blocked", "offline"];
    if (status && !validStatuses.includes(status)) {
      return res.status(400).json({
        error: "Invalid status",
        message: `Status must be one of: ${validStatuses.join(", ")}`,
      });
    }

    const existingStatus = req.app.db
      .get("memberStatus")
      .find({ userId: req.user.id, projectId })
      .value();

    const statusUpdate = {
      userId: req.user.id,
      projectId,
      status: status || (existingStatus?.status ?? "available"),
      mood: mood || (existingStatus?.mood ?? "neutral"),
      currentTaskId: currentTaskId || (existingStatus?.currentTaskId ?? null),
      focusDuration: focusDuration ?? existingStatus?.focusDuration ?? 0,
      efficiency: efficiency ?? existingStatus?.efficiency ?? 0,
      updatedAt: new Date().toISOString(),
    };

    if (existingStatus) {
      // Update existing
      req.app.db
        .get("memberStatus")
        .find({ userId: req.user.id, projectId })
        .assign(statusUpdate)
        .write();
    } else {
      // Create new
      statusUpdate.createdAt = new Date().toISOString();
      req.app.db.get("memberStatus").push(statusUpdate).write();
    }

    // Add activity if status changed
    if (status && status !== existingStatus?.status) {
      const activities = req.app.db.get("activities").value();
      const maxActivityId =
        activities.length > 0
          ? Math.max(...activities.map((a) => parseInt(a.id)))
          : 0;
      req.app.db
        .get("activities")
        .push({
          id: String(maxActivityId + 1),
          projectId,
          userId: req.user.id,
          taskId: currentTaskId || null,
          type: "status_changed",
          action: "Status updated",
          description: `Changed status to ${status}`,
          visibility: "team",
          metadata: {
            newStatus: status,
            previousStatus: existingStatus?.status,
          },
          timestamp: new Date().toISOString(),
        })
        .write();
    }

    return res.json({
      message: "Member status updated successfully",
      memberStatus: statusUpdate,
      requestedBy: req.user,
    });
  }

  next();
}
