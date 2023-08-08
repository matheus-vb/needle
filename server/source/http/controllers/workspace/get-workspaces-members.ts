import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetWorkspaceMembersUseCase } from "../../../useCases/factories/workspace/make-get-workspace-members";
import { Role } from "@prisma/client";

export async function getWorkspaceMembers(request: FastifyRequest, reply: FastifyReply){
    const getWorkspaceMembersBodySchema = z.object({
        workspaceId: z.string(),
        role: z.nativeEnum(Role)
    })

    const { workspaceId, role } = getWorkspaceMembersBodySchema.parse(request.params);

    try{
        const getWorkspaceMembersUseCase = makeGetWorkspaceMembersUseCase();

        const { members } = await getWorkspaceMembersUseCase.handle({
            workspaceId, 
            role
        });

        return reply.status(200).send({data: members});
    }catch(err){
        return reply.status(400).send({ err: err })
    }
}