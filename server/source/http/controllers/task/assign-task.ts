import { FastifyReply, FastifyRequest } from "fastify";
import {z} from "zod"
import { makeAssignTaskUseCase } from "../../../useCases/factories/task/make-assign-task";

export async function assignTask(request: FastifyRequest, response: FastifyReply){
    const assignTaskBodySchema = z.object({
        id: z.string(),
        userId: z.string()
    })

    const {id, userId} = assignTaskBodySchema.parse(request.body)

    try{
        const assignTaskUseCase = makeAssignTaskUseCase();

        const { task }  = await assignTaskUseCase.handle({id, userId});
        
        return response.status(200).send(task);
    }catch(e){
        throw e;
    }
}