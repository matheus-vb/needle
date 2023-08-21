import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeUpdateDeviceTokenUseCase } from "../../../useCases/factories/user/make-update-device";

export async function updateDeviceToken(request: FastifyRequest, reply: FastifyReply) {
    const updateDeviceTokenBodySchema = z.object({
        userId: z.string(),
        deviceToken: z.string()
    })

    const { userId, deviceToken } = updateDeviceTokenBodySchema.parse(request.body);

    try {
        const updateDeviceTokenUseCase = makeUpdateDeviceTokenUseCase()

        const { user } = await updateDeviceTokenUseCase.handle({
            userId,
            deviceToken,
        })

        return reply.status(200).send({ data: user });
    } catch(err) {
        throw err
    }
}