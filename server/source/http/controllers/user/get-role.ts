import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetRoleInWorkspaceUseCase } from "../../../useCases/factories/user/make-get-role";

export async function getRole(request: FastifyRequest, reply: FastifyReply) {
    const getRoleParamsSchema = z.object({
        workspaceId: z.string(),
        userId: z.string(),
    })

    const { workspaceId, userId } = getRoleParamsSchema.parse(request.params);

    try {
        const getRoleUseCase = makeGetRoleInWorkspaceUseCase();

        const { role } = await getRoleUseCase.handle({
            workspaceId,
            userId,
        })

        return reply.status(200).send({ data: role })
    } catch(err) {
        throw err
    }
}