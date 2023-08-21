import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeAddTagsUseCase } from "../../../useCases/factories/task/make-add-tags";

export async function addTag(request: FastifyRequest, reply: FastifyReply) {
    const addTagBodySchema = z.object({
        taskId: z.string(),
        tag: z.string(),
    })

    const { taskId, tag } = addTagBodySchema.parse(request.body);

    try {
        const addTagUseCase = makeAddTagsUseCase();

        const taskTag = await addTagUseCase.handle({
            taskId,
            tag,
        })

        return reply.status(201).send({ data: taskTag });
    } catch(err) {
        throw err
    }
}