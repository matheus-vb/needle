import { FastifyInstance } from "fastify";
import { assignTask } from "./assign-task";
import { createTask } from "./create-task";
import { tasksByWorkspace } from "./tasks-by-workspace";
import { updateStatus } from "./update-status";
import { addTag } from "./add-tag";
import { queryTasks } from "./query-tasks";
import { editTask } from "./edit-task";
import { updateTask } from "./update-task";
import { deleteTask } from "./delete-task";

export async function taskRoutes(app: FastifyInstance) {
    app.post('/task/create', createTask);
    app.patch('/task/assign', assignTask);
    app.patch('/task', updateStatus);
    app.patch('/edit/task', editTask);
    app.patch('/update/task', updateTask)
    app.get('/task/:workspaceId', tasksByWorkspace);
    app.post('/task/tag', addTag);
    app.get('/task/query/:workspaceId', queryTasks)
    app.delete('/task/delete', deleteTask);
}