import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeDeleteWorkspaceMemberUseCase } from "../../../useCases/factories/workspace/make-delete-workspace-member";

export async function deleteWorkspaceMember(request: FastifyRequest, reply: FastifyReply){
    const deleteWorkspaceMemberBodySchema = z.object({
        userId: z.string(),
        workspaceId : z.string()
    })

    const { userId, workspaceId } = deleteWorkspaceMemberBodySchema.parse(request.params);

    try{
        const deleteWorkspaceMemberUseCase = makeDeleteWorkspaceMemberUseCase();

        const { done } =  await deleteWorkspaceMemberUseCase.handle({
            userId,
            workspaceId,
        });

        return reply.status(200).send({ data: done })

    }catch(err){
        throw err
    }
}