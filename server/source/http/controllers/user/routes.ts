import { FastifyInstance } from "fastify";
import { updateDeviceToken } from "./update-device";
import { getRole } from "./get-role";
import { deleteUser } from "./delete-user";
import { getAllUsers } from "./get-all-users";
import { updateRole } from "./update-role";

export async function userRoutes(app: FastifyInstance) {
    app.patch('/user/device', updateDeviceToken);
    app.get('/user/:workspaceId/:userId', getRole);
    app.delete('/user/delete/:userId', deleteUser)
    app.get('/user', getAllUsers);
    app.patch('/user/role', updateRole);
}
