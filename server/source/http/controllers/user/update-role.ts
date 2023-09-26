import { Role } from "@prisma/client";
import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeUpdateRoleUseCase } from "../../../useCases/factories/user/make-update-role";

export async function updateRole(request: FastifyRequest, reply: FastifyReply){
    const updateRoleBodySchema = z.object({
        userId: z.string(),
        workspaceId: z.string(),
        role: z.nativeEnum(Role),
    })

    const { userId, workspaceId, role } = updateRoleBodySchema.parse(request.body)
    
    try{
        const updateRoleUseCase = makeUpdateRoleUseCase()

        const { done } = await updateRoleUseCase.handle({
            userId,
            workspaceId,
            role,
        })

        return reply.status(200).send({ data: done })
    } catch(err){
        throw err
    }
}
