import { TaskPriority, TaskStatus, TaskType } from "@prisma/client";
import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeQueryTasksUseCase } from "../../../useCases/factories/task/make-query-task";

export async function queryTasks(request: FastifyRequest, reply: FastifyReply) {
    const queryTasksParamsSchema = z.object({
        workspaceId: z.string()
    })

    const { workspaceId } = queryTasksParamsSchema.parse(request.params);

    const queryTasksQuerySchema = z.object({
        area: z.nativeEnum(TaskType).nullish(),
        priority: z.nativeEnum(TaskPriority).nullish(),
        query: z.string().nullish(),
        status: z.nativeEnum(TaskStatus).nullish(),
    })

    const { area, priority, query, status } = queryTasksQuerySchema.parse(request.query);

    try {
        const queryTaskUseCase = makeQueryTasksUseCase()

        const { tasks } = await queryTaskUseCase.handle({
            workspaceId,
            area : area ? area : null,
            priority: priority ? priority : null,
            query: query ? query : null,
            status: status ? status : null,
        })

        return reply.status(200).send({ data: tasks })
    } catch(err) {
        throw err
    }
}