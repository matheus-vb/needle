import { create } from "domain";
import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeCreateTaskUseCase } from "../../../useCases/factories/task/make-create-task";

export async function createTask(request: FastifyRequest, response: FastifyReply){
    
    const createTaskBodySchema = z.object({
        userId: z.string().nullish(),
        accessCode: z.string(),
        title: z.string(),
        description: z.string(),
        stats: z.string(),
        type: z.string(),
        endDate: z.coerce.date(),
        priority: z.string()
    })

    const {userId, accessCode, title, description, stats, type, endDate, priority} = createTaskBodySchema.parse(request.body)

    try{
        const creteTaskUseCase = makeCreateTaskUseCase();
        
        const { task } = await creteTaskUseCase.handle({userId: userId ? userId : null, accessCode, title, description, status: stats , type, endDate, priority});
        
        return response.status(201).send({task});
    }catch(e){
        throw e
    }
}