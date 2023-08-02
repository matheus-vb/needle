import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetAllMembersNamesUseCase } from "../../../useCases/factories/workspace/make-get-all-members-names";

export async function getAllMembersNames(request: FastifyRequest, reply: FastifyReply) {
    const getAllMembersNamesBodySchema = z.object({
        workspaceId: z.string()
    })

    const { workspaceId } = getAllMembersNamesBodySchema.parse(request.params);

    try {
        const getAllMembersNamesUseCase = makeGetAllMembersNamesUseCase()

        const { members } = await getAllMembersNamesUseCase.handle({
            workspaceId
        })

        return reply.status(200).send({ data: members });
    } catch(err) {
        return reply.status(400).send({ message: err })
    }
}