import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeDeleteTask } from "../../../useCases/factories/task/make-delete-task";

export async function deleteTask(request: FastifyRequest, response: FastifyReply){
    const deleteTaskBodySchema = z.object({
        taskId: z.string()
    })

    const { taskId } = deleteTaskBodySchema.parse(request.params)

    try{
        const deleteTaskUseCase = makeDeleteTask();

        deleteTaskUseCase.handle({ taskId })

        return response.status(204);
    }catch(e){
        throw(e)
    }
}