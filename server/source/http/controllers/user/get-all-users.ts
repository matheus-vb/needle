import { FastifyReply, FastifyRequest } from "fastify";
import { makeGetAllUsers } from "../../../useCases/factories/user/make-get-all-users";

export async function getAllUsers(request: FastifyRequest, reply: FastifyReply) {
    try {
        const getAllUsersUseCase = makeGetAllUsers()

        const { users } = await getAllUsersUseCase.handle()

        return reply.status(200).send({ data: users })
    } catch(err) {
        throw err
    }
}