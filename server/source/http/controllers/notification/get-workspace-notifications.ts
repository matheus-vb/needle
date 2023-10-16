import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetWorkspaceNotifications } from "../../../useCases/factories/notification/make-get-workspace-notifications";

export async function getWorkspaceNotifications(request: FastifyRequest, reply: FastifyReply) {
    const getWorkspaceNotificationsParamsSchema = z.object({
        workspaceId: z.string()
    })

    const { workspaceId } = getWorkspaceNotificationsParamsSchema.parse(request.params);

    try {
        const getWorkspaceNotificationsUseCase = makeGetWorkspaceNotifications()

        const { notifications } = await getWorkspaceNotificationsUseCase.handle({
            workspaceId,
        })

        return reply.status(200).send({ data: notifications })
    } catch (err) {
        throw err
    }
}