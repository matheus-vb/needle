import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeDeleteUserNotifications } from "../../../useCases/factories/notification/make-delete-users-notifications";

export async function deleteUserNotifications(request: FastifyRequest, reply: FastifyReply) {
    const deleteUserNotificationsParamsSchema = z.object({
        userId: z.string()
    })

    const { userId } = deleteUserNotificationsParamsSchema.parse(request.params);

    try {
        const deleteUserNotificationsUseCase = makeDeleteUserNotifications()

        const { done } = await deleteUserNotificationsUseCase.handle({
            userId,
        })

        return reply.status(200).send({ data: done })
    } catch (err) {
        return reply.status(400).send({ err: err })
    }
}