import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetUserNotifications } from "../../../useCases/factories/notification/make-get-user-notifications";

export async function getUserNotifications(request: FastifyRequest, reply: FastifyReply) {
    const getUserNotificationsParamsSchema = z.object({
        userId: z.string()
    })

    const { userId } = getUserNotificationsParamsSchema.parse(request.params);

    try {
        const getUserNotificationsUseCase = makeGetUserNotifications()

        const { notifications } = await getUserNotificationsUseCase.handle({
            userId,
        })

        return reply.status(200).send({ data: notifications })
    } catch (err) {
        throw err
    }
}