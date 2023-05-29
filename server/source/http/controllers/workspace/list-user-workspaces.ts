import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeListWorkspaceUseCase } from "../../../useCases/factories/workspace/make-list-workspace";

export async function listUserWorkspaces(request: FastifyRequest, response: FastifyReply){
    const listWorkspaceBodySchema = z.object({
        id: z.string(),
    })

    const { id } = listWorkspaceBodySchema.parse(request.body);

    try{

        const listWorspaceUseCase = makeListWorkspaceUseCase();
        const { workspaces } = await listWorspaceUseCase.handle({id});

        return response.status(200).send(workspaces);
    }catch(e){
        throw e;
    }
}