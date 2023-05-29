import { FastifyInstance } from "fastify";
import { assignTask } from "./assign-task";
import { createTask } from "./create-task";
import { tasksByWorkspace } from "./tasks-by-workspace";
import { updateStatus } from "./update-status";

export async function taskRoutes(app: FastifyInstance) {
    app.post('/task/create', createTask);
    app.patch('/task/assign', assignTask);
    app.patch('/task', updateStatus);
    app.get('/task/:workspaceId', tasksByWorkspace);
}