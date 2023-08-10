import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeEditTask } from "../../../useCases/factories/task/make-edit-task";

export async function editTask(request: FastifyRequest, reply: FastifyReply){
    const createEditTaskBodySchema = z.object({
        taskId: z.string(),
        title: z.string(),
        description: z.string(),
        stats: z.string(),
        type: z.string(),
        endDate: z.coerce.date(),
        priority: z.string(),
    })

    const { taskId, title, description, stats, type, endDate, priority } = createEditTaskBodySchema.parse(request.body)


    try {
        const editTaskUseCase = makeEditTask();
        const { task}  = await editTaskUseCase.handle({
            taskId,
            title,
            description,
            status: stats,
            type,
            endDate,
            priority
        })

        return reply.status(200).send({task})
    }catch(e){
        throw e
    }
}