import { FastifyInstance } from "fastify";
import { getUserNotifications } from "./get-user-notification";
import { getWorkspaceNotifications } from "./get-workspace-notifications";
import { deleteUserNotifications } from "./delete-users-notifications";

export async function notificationRoutes(app: FastifyInstance) {
    app.get('/notification/:userId', getUserNotifications);
    app.get('/workspace/notification/:workspaceId', getWorkspaceNotifications);
    app.delete('/notification/:userId', deleteUserNotifications);
}