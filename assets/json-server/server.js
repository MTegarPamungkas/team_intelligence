const jsonServer = require("json-server");
const path = require("path");
const cors = require("cors");
require("dotenv").config();

const server = jsonServer.create();
const router = jsonServer.router(path.join(__dirname, "db.json"));
server.db = router.db;
const middlewares = jsonServer.defaults({
  static: path.join(__dirname, "public"), // Optional: Serve static files if needed
});

server.use(
  cors({
    origin: [
      "http://localhost:3000",
      "http://127.0.0.1:3000",
      process.env.FRONTEND_URL || "http://localhost:3000", // Allow configurable frontend URL
    ],
    credentials: true,
    optionsSuccessStatus: 200,
  })
);

server.use(middlewares);
server.use(jsonServer.bodyParser);

// Validate database initialization
if (!server.db) {
  console.error("Error: Database not initialized. Check db.json file.");
  process.exit(1);
}

// Attach db to request
server.use((req, res, next) => {
  req.app.db = router.db;
  next();
});

// Load custom middleware
const customMiddleware = require("./middleware.js");
server.use(customMiddleware);

// Load custom routes
try {
  const customRoutes = require("./routes.json");
  if (Object.keys(customRoutes).length === 0) {
    console.warn("Warning: routes.json is empty. No custom routes applied.");
  } else {
    server.use(jsonServer.rewriter(customRoutes));
    console.log("Applied routes:", customRoutes);
  }
} catch (error) {
  console.warn(
    "Warning: routes.json not found or invalid. Proceeding without custom routes."
  );
}

// Global error handler
server.use((err, req, res, next) => {
  console.error("Server Error:", err);
  res.status(500).json({
    error: "Internal Server Error",
    message: err.message,
  });
});

// 404 handler for undefined routes
server.use("*", (req, res) => {
  res.status(404).json({
    error: "Endpoint not found",
    message: `${req.method} ${req.originalUrl} not available`,
  });
});

const PORT = process.env.PORT || 3001; // Align with CORS and typical dev port
const HOST = process.env.HOST || "0.0.0.0";

server.listen(PORT, HOST, () => {
  console.log(`🚀 Server running at http://${HOST}:${PORT}`);
  console.log(`📁 Database: db.json`);
  console.log(`🔒 JWT Authentication: Enabled`);
  console.log("\n📋 Available Endpoints:");
  console.log("🔓 Public:");
  console.log("  POST /api/login");
  console.log("  POST /api/register");
  console.log("\n🔒 Protected:");
  console.log("  GET /api/profile");
  console.log("  GET /api/my-projects");
  console.log("  GET /api/projects/:id/my-role");
  console.log("  GET /api/projects/summary");
  console.log("  GET /api/projects/:id/summary");
  console.log("  GET /api/projects/:id/activity");
  console.log("  GET /api/projects/:id/insights");
  console.log("  POST /api/projects/:id/tasks");
  console.log("  POST /api/projects/:id/insights/generate");
  console.log("  GET /api/notifications");
  console.log("  POST /api/projects/:id/ai-chats");
  console.log("  POST /api/token/refresh");
  console.log("\n🔧 JSON Server defaults:");
  console.log("  GET /api/users");
  console.log("  GET /api/projects");
  console.log("  GET /api/projectMembers");
  console.log("  GET /api/tasks");
  console.log("  GET /api/activities");
  console.log("  GET /api/insights");
  console.log("  GET /api/aiChats");
  console.log("  GET /api/notifications");
});
