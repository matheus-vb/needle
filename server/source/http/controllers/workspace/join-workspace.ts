import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeJoinWorkspaceUseCase } from "../../../useCases/factories/workspace/make-join-workspace";

export async function joinWorkspace(request: FastifyRequest, response: FastifyReply){
    const joinWorkspaceBodySchema = z.object({
        userId: z.string(),
        accessCode: z.string()
    })

    const { userId, accessCode } = joinWorkspaceBodySchema.parse(request.body);

    try{
        const joinWorkspaceUseCase = makeJoinWorkspaceUseCase();

        const { userWorkspace } = await joinWorkspaceUseCase.handle({userId, accessCode});

        return response.status(200).send({data: userWorkspace})
    }catch(e){
        throw e;
    }
}