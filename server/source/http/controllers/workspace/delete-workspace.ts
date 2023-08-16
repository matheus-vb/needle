import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeDeleteWorkspaceUseCase } from "../../../useCases/factories/workspace/make-delete-workspace";

export async function deleteWorkspace(request: FastifyRequest, reply: FastifyReply) {
    const deleteWorkspaceParamsSchema = z.object({
        accessCode: z.string(),
    })

    const { accessCode } = deleteWorkspaceParamsSchema.parse(request.params)

    try {
        const deleteWorkspaceUseCase = makeDeleteWorkspaceUseCase()

        const { workspace } = await deleteWorkspaceUseCase.handle({
            accessCode,
        })

        return reply.status(204).send({ data: workspace })
    } catch(err) {
        throw err
    }
}