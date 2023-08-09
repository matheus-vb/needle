import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeUpdateTask } from "../../../useCases/factories/task/make-update-task";

export async function updateTask(request: FastifyRequest, response: FastifyReply){
    
    const updateTaskBodySchema = z.object({
        userId: z.string(),
        taskId: z.string(),
        documentId: z.string(),
        title: z.string(),
        description:  z.string(),
        status:  z.string(),
        type:  z.string(),
        endDate:  z.coerce.date(),
        priority:  z.string(),
        text:  z.string(),
        textString:  z.string()
    })

    const { userId, taskId, documentId, title, description, status, type, endDate, priority, text, textString } = updateTaskBodySchema.parse(request.body)

    try {
        const updateTaskUseCase = makeUpdateTask()
        const { task } = await updateTaskUseCase.handle({
            userId,
            taskId,
            documentId,
            title,
            description,
            status,
            type,
            endDate,
            priority,
            text,
            textString 
        })

        return response.status(200).send({ task })
    }catch(e){
        throw e
    }
}