import { FastifyInstance } from "fastify";
import { updateDeviceToken } from "./update-device";
import { getRole } from "./get-role";

export async function userRoutes(app: FastifyInstance) {
    app.patch('/user/device', updateDeviceToken);
    app.get('/user/:workspaceId/:userId', getRole);
}