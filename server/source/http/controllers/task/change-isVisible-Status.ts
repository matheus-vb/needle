import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeChangeIsVisibleStatus } from "../../../useCases/factories/task/make-change-isVisible-status";

export async function changeIsVisibleStatus(request: FastifyRequest, reply: FastifyReply){
    const changeIsVisibleStatusSchema = z.object({
        taskId: z.string(),
        isVisible: z.boolean(),
    })

    const {taskId, isVisible} = changeIsVisibleStatusSchema.parse(request.body);

    try {
        const changeIsVisibleUseCase = makeChangeIsVisibleStatus();

        const task = await changeIsVisibleUseCase.handle({taskId, isVisible});
        return reply.status(200).send({data: task});
    } catch(err) {
        throw err
    }
}