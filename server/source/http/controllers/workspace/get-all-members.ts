import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetAllMembersUseCase } from "../../../useCases/factories/workspace/make-get-all-members";

export async function getAllMembers(request: FastifyRequest, reply: FastifyReply) {
    const getAllMembersBodySchema = z.object({
        workspaceId: z.string()
    })

    const { workspaceId } = getAllMembersBodySchema.parse(request.params);

    try {
        const getAllMembersUseCase = makeGetAllMembersUseCase()

        const { members } = await getAllMembersUseCase.handle({
            workspaceId
        })

        return reply.status(200).send({ data: members });
    } catch(err) {
        throw err
    }
}