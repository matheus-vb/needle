import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeDeleteUser } from "../../../useCases/factories/user/make-delete-user";

export async function deleteUser(request: FastifyRequest, reply: FastifyReply){
    const deleteUserParamsSchema = z.object({
        userId: z.string()
    })

    const { userId } = deleteUserParamsSchema.parse(request.params)

    try{
        const deleteUserUseCase = makeDeleteUser()

        const { user } = await deleteUserUseCase.handle({ userId })

        return reply.status(200).send({ data: user })
    }catch(e){
        throw e
    }
}