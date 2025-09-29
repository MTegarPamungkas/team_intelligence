const { GoogleGenAI } = require("@google/genai");
require("dotenv").config();

const GEMINI_API_KEY = process.env.GEMINI_API_KEY;

if (!GEMINI_API_KEY) {
  console.error("GEMINI_API_KEY not found in environment variables");
}

const ai = new GoogleGenAI({ apiKey: GEMINI_API_KEY });

async function generateChatResponse(projectData, userMessage) {
  try {
    if (!GEMINI_API_KEY) {
      throw new Error("GEMINI_API_KEY not configured");
    }

    // Prepare context dari project data
    const context = {
      projectInfo: {
        name: projectData.project.name,
        description: projectData.project.description,
        status: projectData.project.status,
        progress: projectData.project.progress,
        membersCount: projectData.project.membersCount,
      },
      members: projectData.projectMembers || [],
      memberStatus: projectData.memberStatus || [],
      tasks: projectData.tasks.map((task) => ({
        id: task.id,
        title: task.title,
        status: task.status,
        priority: task.priority,
        assignedTo: task.assignedTo,
        progress: task.progress,
        dueDate: task.dueDate,
      })),
      recentActivities: projectData.activities.slice(0, 5).map((activity) => ({
        type: activity.type,
        action: activity.action,
        description: activity.description,
        timestamp: activity.timestamp,
      })),
      insights: projectData.insights.map((insight) => ({
        title: insight.title,
        type: insight.type,
        priority: insight.priority,
        recommendation: insight.recommendation,
      })),
    };

    const prompt = `
  You are an AI assistant for a project management system. Here's the current project context:
  
  PROJECT: ${context.projectInfo.name}
  Description: ${context.projectInfo.description}
  Status: ${context.projectInfo.status}
  Progress: ${context.projectInfo.progress}%
  Team Members: ${context.projectInfo.membersCount}
  
  TEAM MEMBERS:
  ${context.members
    .map(
      (member) =>
        `- ${member.name} (ID: ${member.userId}, Role: ${member.projectRole}, Status: ${member.role})`
    )
    .join("\n")}
  
  MEMBER STATUS:
  ${context.memberStatus
    .map((status) => {
      const member = context.members.find((m) => m.userId === status.userId);
      return `- ${member?.name || "User " + status.userId}: ${status.status}${
        status.mood ? `, Mood: ${status.mood}` : ""
      }${
        status.efficiency
          ? `, Efficiency: ${Math.round(status.efficiency * 100)}%`
          : ""
      }`;
    })
    .join("\n")}
  
  CURRENT TASKS:
  ${context.tasks
    .map((task) => {
      const assignedMember = context.members.find(
        (m) => m.userId === task.assignedTo
      );
      return `- ${task.title} (${task.status}, Priority: ${
        task.priority
      }, Progress: ${task.progress}%, Assigned to: ${
        assignedMember?.name || "Unassigned"
      })`;
    })
    .join("\n")}
  
  RECENT ACTIVITIES:
  ${context.recentActivities
    .map(
      (activity) =>
        `- ${activity.action}: ${activity.description} (${activity.timestamp})`
    )
    .join("\n")}
  
  CURRENT INSIGHTS:
  ${context.insights
    .map(
      (insight) =>
        `- ${insight.title} (${insight.type}, Priority: ${insight.priority}): ${insight.recommendation}`
    )
    .join("\n")}
  
  User Question: ${userMessage}
  
  Please provide a helpful response based on the project context. Be concise but informative. Use actual member names when referring to team members.
  `;

    const response = await ai.models.generateContent({
      model: "gemini-2.0-flash-001",
      contents: prompt,
    });

    return {
      text: response.text,
      contextUsed: {
        tasksCount: context.tasks.length,
        activitiesCount: context.recentActivities.length,
        insightsCount: context.insights.length,
        membersCount: context.members.length,
      },
    };
  } catch (error) {
    console.error("Error generating chat response:", error);
    throw new Error(`Failed to generate chat response: ${error.message}`);
  }
}

async function generateInsights(projectData) {
  try {
    if (!GEMINI_API_KEY) {
      throw new Error("GEMINI_API_KEY not configured");
    }

    // Prepare comprehensive project analysis data
    const analysisData = {
      project: {
        name: projectData.project.name,
        status: projectData.project.status,
        progress: projectData.project.progress,
        createdAt: projectData.project.createdAt,
      },
      members: projectData.projectMembers || [],
      tasks: projectData.tasks.map((task) => ({
        id: task.id,
        title: task.title,
        status: task.status,
        priority: task.priority,
        progress: task.progress,
        dueDate: task.dueDate,
        estimatedHours: task.estimatedHours,
        actualHours: task.actualHours,
        assignedTo: task.assignedTo,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
      })),
      memberStatus: projectData.memberStatus.map((status) => ({
        userId: status.userId,
        status: status.status,
        mood: status.mood,
        efficiency: status.efficiency,
        focusDuration: status.focusDuration,
      })),
      activities: projectData.activities.slice(-20).map((activity) => ({
        type: activity.type,
        action: activity.action,
        timestamp: activity.timestamp,
      })),
      teamMetrics: {
        totalMembers: projectData.projectMembers?.length || 0,
        avgEfficiency:
          projectData.memberStatus.reduce(
            (sum, m) => sum + (m.efficiency || 0),
            0
          ) / Math.max(projectData.memberStatus.length, 1),
        totalFocusTime: projectData.memberStatus.reduce(
          (sum, m) => sum + (m.focusDuration || 0),
          0
        ),
      },
    };

    const prompt = `
  You are an AI project analyst. Analyze the following project data and generate actionable insights:
  
  PROJECT OVERVIEW:
  - Name: ${analysisData.project.name}
  - Status: ${analysisData.project.status}
  - Progress: ${analysisData.project.progress}%
  
  TEAM MEMBERS:
  ${analysisData.members
    .map(
      (member) =>
        `- ${member.name} (ID: ${member.userId}, Role: ${member.projectRole})`
    )
    .join("\n")}
  
  TASKS ANALYSIS:
  Total Tasks: ${analysisData.tasks.length}
  Completed: ${
    analysisData.tasks.filter((t) => t.status === "completed").length
  }
  In Progress: ${
    analysisData.tasks.filter((t) => t.status === "in_progress").length
  }
  Blocked: ${analysisData.tasks.filter((t) => t.status === "blocked").length}
  High Priority: ${
    analysisData.tasks.filter((t) => t.priority === "high").length
  }
  
  Task Details:
  ${analysisData.tasks
    .map((task) => {
      const assignedMember = analysisData.members.find(
        (m) => m.userId === task.assignedTo
      );
      return `- "${task.title}" assigned to ${
        assignedMember?.name || "Unassigned"
      } (Status: ${task.status}, Priority: ${task.priority}, Progress: ${
        task.progress
      }%)`;
    })
    .join("\n")}
  
  TEAM METRICS:
  - Total Members: ${analysisData.teamMetrics.totalMembers}
  - Average Efficiency: ${Math.round(
    analysisData.teamMetrics.avgEfficiency * 100
  )}%
  - Total Focus Time: ${analysisData.teamMetrics.totalFocusTime} hours
  
  MEMBER STATUS:
  ${analysisData.memberStatus
    .map((m) => {
      const member = analysisData.members.find(
        (mem) => mem.userId === m.userId
      );
      return `- ${member?.name || "User " + m.userId}: ${m.status} (Mood: ${
        m.mood
      }, Efficiency: ${Math.round(m.efficiency * 100)}%)`;
    })
    .join("\n")}
  
  RECENT ACTIVITIES (last 20):
  ${analysisData.activities.map((a) => `- ${a.type}: ${a.action}`).join("\n")}
  
  Generate 2-4 actionable insights in JSON format. Each insight should have:
  - id: unique string
  - title: brief descriptive title
  - type: one of ["performance", "productivity", "team", "deadline", "quality", "resource"]
  - priority: one of ["low", "medium", "high", "critical"]
  - description: detailed description (2-3 sentences) - USE ACTUAL MEMBER NAMES, not User IDs
  - recommendation: specific actionable recommendation - USE ACTUAL MEMBER NAMES, not User IDs
  - affectedUserIds: array of user IDs (use actual user IDs from member status)
  - estimatedImpact: one of ["low", "medium", "high"]
  - category: one of ["efficiency", "collaboration", "planning", "quality", "resources"]
  
  IMPORTANT: In the description and recommendation fields, always use actual member names (e.g., "Budi Santoso", "Lisa Chen") instead of "User 2" or "User 3".
  
  Respond ONLY with a valid JSON array of insights. No additional text or markdown.
  `;

    const response = await ai.models.generateContent({
      model: "gemini-2.0-flash-001",
      contents: prompt,
    });

    let insights;
    try {
      // Clean response text dan parse JSON
      const cleanResponse = response.text.trim().replace(/```json|```/g, "");
      insights = JSON.parse(cleanResponse);
    } catch (parseError) {
      console.error("Failed to parse AI response as JSON:", parseError);
      // Fallback dengan default insights
      insights = [
        {
          id: `insight_${Date.now()}`,
          title: "Project Analysis Complete",
          type: "performance",
          priority: "medium",
          description:
            "AI analysis completed but generated non-standard format. Manual review recommended.",
          recommendation:
            "Review project metrics manually and consider updating AI prompt configuration.",
          affectedUserIds: analysisData.memberStatus.map((m) => m.userId),
          estimatedImpact: "low",
          category: "planning",
        },
      ];
    }

    // Validate dan enrich insights
    const enrichedInsights = insights.map((insight, index) => ({
      ...insight,
      id: insight.id || `ai_insight_${Date.now()}_${index}`,
      projectId: projectData.project.id,
      status: "active",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      source: "ai_analysis",
      confidence: 0.8,
      metadata: {
        analysisDate: new Date().toISOString(),
        dataPoints: {
          tasksAnalyzed: analysisData.tasks.length,
          membersAnalyzed: analysisData.memberStatus.length,
          activitiesAnalyzed: analysisData.activities.length,
        },
      },
    }));

    return enrichedInsights;
  } catch (error) {
    console.error("Error generating insights:", error);
    throw new Error(`Failed to generate insights: ${error.message}`);
  }
}

module.exports = {
  generateChatResponse,
  generateInsights,
};
