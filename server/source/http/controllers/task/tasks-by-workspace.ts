import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeCreateTaskUseCase } from "../../../useCases/factories/task/make-create-task";
import { makeGetWorkspaceTasksUseCase } from "../../../useCases/factories/workspace/make-get-workspace-tasks";

export async function tasksByWorkspace(request: FastifyRequest, response: FastifyReply){
    
    const taskByWorkspaceBodySchema = z.object({
        workspaceId: z.string(),
    })

    const { workspaceId } = taskByWorkspaceBodySchema.parse(request.body)

    try{
       const getTasksByWorkspaceUseCase= makeGetWorkspaceTasksUseCase();

       const { tasks } = await getTasksByWorkspaceUseCase.handle({workspaceId});

       return response.status(200).send({data: tasks});
    }catch(e){
        throw e
    }
}