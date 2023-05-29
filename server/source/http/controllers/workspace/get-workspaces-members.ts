import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetWorkspaceMembersUseCase } from "../../../useCases/factories/workspace/make-get-workspace-members";

export async function getWorkspaceMembers(request: FastifyRequest, response: FastifyReply){
    const getWorkspaceMembersBodySchema = z.object({
        workspaceId: z.string(),
        role: z.string()
    })

    const {workspaceId, role} = getWorkspaceMembersBodySchema.parse(request.params);

    try{
        const getWorkspaceMembersUseCase = makeGetWorkspaceMembersUseCase();

        const { members } = await getWorkspaceMembersUseCase.handle({workspaceId, role});

        return response.status(200).send(members);
    }catch(e){
        throw e;
    }
}