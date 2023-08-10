import { FastifyInstance } from "fastify";
import { getUserNotifications } from "./get-user-notification";
import { deleteUserNotifications } from "./delete-users-notifications";

export async function notificationRoutes(app: FastifyInstance) {
    app.get('/notification/:userId', getUserNotifications);
    app.delete('/notification/:userId', deleteUserNotifications);
}