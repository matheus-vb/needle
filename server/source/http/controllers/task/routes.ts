import { FastifyInstance } from "fastify";
import { assignTask } from "./assign-task";
import { createTask } from "./create-task";
import { tasksByWorkspace } from "./tasks-by-workspace";
import { updateStatus } from "./update-status";
import { addTag } from "./add-tag";
import { queryTasks } from "./query-tasks";
import { editTask } from "./edit-task";

export async function taskRoutes(app: FastifyInstance) {
    app.post('/task/create', createTask);
    app.patch('/task/assign', assignTask);
    app.patch('/task', updateStatus);
    app.patch('/edit/task', editTask);
    app.get('/task/:workspaceId', tasksByWorkspace);
    app.post('/task/tag', addTag);
    app.get('/task/query/:workspaceId', queryTasks)
}