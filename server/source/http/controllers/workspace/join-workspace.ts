import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeJoinWorkspaceUseCase } from "../../../useCases/factories/workspace/make-join-workspace";
import { Role } from "@prisma/client";

export async function joinWorkspace(request: FastifyRequest, reply: FastifyReply){
    const joinWorkspaceBodySchema = z.object({
        userId: z.string(),
        accessCode: z.string(),
        role: z.nativeEnum(Role),
    })

    const { userId, accessCode, role } = joinWorkspaceBodySchema.parse(request.body);

    try{
        const joinWorkspaceUseCase = makeJoinWorkspaceUseCase();

        const { userWorkspace } = await joinWorkspaceUseCase.handle({
            userId,
            accessCode,
            role,
        });

        return reply.status(200).send({data: userWorkspace})
    }catch(err){
        throw err
    }
}