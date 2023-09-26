import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeInviteMemberUseCase } from "../../../useCases/factories/workspace/make-invite-member";

export async function inviteMember(request: FastifyRequest, reply: FastifyReply) {
    const inviteMemberBodySchema = z.object({
        userId: z.string(),
        workspaceId: z.string(),
        email: z.string().email(),
    })

    const { userId, workspaceId, email } = inviteMemberBodySchema.parse(request.body)

    try {
        const inviteMemberUseCase = makeInviteMemberUseCase()

        const { done } = await inviteMemberUseCase.handle({
            userId,
            workspaceId,
            email,
        })

        return reply.status(200).send({ data: done })
    } catch(err) {
        throw err
    }
}
