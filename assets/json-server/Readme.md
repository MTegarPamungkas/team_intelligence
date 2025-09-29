# JSON Server Mock API with JWT Authentication

## Description
This project utilizes `json-server` to create a mock API with JWT-based authentication. It serves a dummy database and custom routes for user management and project tracking.

## Setup
To set up the project, follow these steps:

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the server in development mode (with `nodemon`):
   ```bash
   npm run dev
   ```

3. Alternatively, run the server directly:
   ```bash
   npm start
   ```

4. For basic `json-server` usage (without custom middleware):
   ```bash
   npm run json-server
   ```

## File Structure
- `dummy_db.json`: Dummy database containing users, projects, members, activities, and insights.
- `routes.json`: Configuration for custom route rewrites.
- `server.js`: Main server file with CORS, JWT middleware, and error handling.
- `middleware.js`: Custom middleware for JWT authentication and protected routes.
- `package.json`: Project dependencies and scripts.

## Usage
The server runs on `http://localhost:3000` (or the configured `PORT` and `HOST`).

### Public Endpoints
- `POST /api/login`: Authenticate user and generate JWT token.
- `POST /api/register`: Register a new user.

### Protected Endpoints (Require JWT Token)
Include the JWT token in the `Authorization` header: `Bearer <token>`.
- `GET /api/profile`: Retrieve the current user's profile.
- `GET /api/my-projects`: Fetch the user's projects and team information.
- `GET /api/users/:id/projects`: Get projects for a specific user.
- `GET /api/projects/:id/my-role`: Retrieve the user's role in a specific project.
- `GET /api/projects/summary`: Get a summary of all projects with metrics.
- `GET /api/projects/:id/summary`: Get a detailed summary for a specific project.
- `POST /api/token/refresh`: Refresh the JWT token.

### JSON Server Default Endpoints
- `GET /api/users`: List all users.
- `GET /api/projects`: List all projects.
- `GET /api/members`: List all project memberships.
- `GET /api/activities`: List all project activities.
- `GET /api/insights`: List all project insights.

## Environment Variables
Create a `.env` file in the project root with the following variables:
```
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRES_IN=1h
PORT=3000
HOST=0.0.0.0
```

## Dependencies
- `json-server`: Mock API server.
- `jsonwebtoken`: JWT authentication.
- `cors`: Enable CORS for cross-origin requests.
- `dotenv`: Load environment variables.
- `nodemon`: Development server with auto-restart (dev dependency).

## License
This project is licensed under the MIT License.