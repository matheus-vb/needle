import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetWorkspaceTasksFinished } from "../../../useCases/factories/workspace/make-get-workspace-tasks-finished";
import { TaskStatus } from "@prisma/client";

export async function getWorkspaceTasksFinished(request: FastifyRequest, reply: FastifyReply) {
    const getWorkspaceTasksFinished = z.object({
        workspaceId: z.string(),
        status: z.nativeEnum(TaskStatus).nullish()
    })

    const { workspaceId } = getWorkspaceTasksFinished.parse(request.params);

    try {
        const getWorkspaceTasksFinishedUseCase = makeGetWorkspaceTasksFinished()

        const { finished } = await getWorkspaceTasksFinishedUseCase.handle({
            workspaceId, status
        })

        return reply.status(200).send({ data: finished });
    } catch(err) {
        throw err
    }
}