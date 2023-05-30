import { FastifyReply, FastifyRequest } from "fastify";
import {z} from "zod"
import { makeCreateWorkspaceUseCase } from "../../../useCases/factories/workspace/make-create-workspace";

export async function createWorkspace(request: FastifyRequest, response: FastifyReply){
    const createWorkspaceBodySchema = z.object({
        name: z.string(),
        userId: z.string(),
    })

    const { name, userId } = createWorkspaceBodySchema.parse(request.body);

    try{
        const createWorkspaceUseCase = makeCreateWorkspaceUseCase()
        const { workspace } = await createWorkspaceUseCase.handle({name, userId});
        return response.status(201).send(workspace)
    }catch(e){
        throw e
    }
}