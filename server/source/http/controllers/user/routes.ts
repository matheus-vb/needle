import { FastifyInstance } from "fastify";
import { updateDeviceToken } from "./update-device";

export async function userRoutes(app: FastifyInstance) {
    app.patch('/user/device', updateDeviceToken);
}