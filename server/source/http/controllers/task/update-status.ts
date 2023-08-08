import { create } from "domain";
import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeCreateTaskUseCase } from "../../../useCases/factories/task/make-create-task";
import { makeUpdateStatusUseCase } from "../../../useCases/factories/task/make-update-status";

export async function updateStatus(request: FastifyRequest, response: FastifyReply) {

    const updateStatusBodySchema = z.object({
        taskId: z.string(),
        status: z.string()
    })

    const { taskId, status } = updateStatusBodySchema.parse(request.body)

    try {
        const updateStatusUseCase = makeUpdateStatusUseCase();

        const { task } = await updateStatusUseCase.handle({
            status,
            taskId
        })

        return response.status(201).send({ task });
    } catch (e) {
        throw e
    }
}