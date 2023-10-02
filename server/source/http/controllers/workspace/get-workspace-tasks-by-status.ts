import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetWorkspaceTasksByStatus } from "../../../useCases/factories/workspace/make-get-workspace-tasks-by-status";
import { TaskStatus } from "@prisma/client";

export async function getWorkspaceTasksByStatus(request: FastifyRequest, reply: FastifyReply) {
    const getWorkspaceTasksFinished = z.object({
        workspaceId: z.string(),
        status: z.nativeEnum(TaskStatus)
    })

    const { workspaceId , status } = getWorkspaceTasksFinished.parse(request.params);

    try {
        const getWorkspaceTasksByStatusUseCase = makeGetWorkspaceTasksByStatus()

        const { finished } = await getWorkspaceTasksByStatusUseCase.handle({
            workspaceId, status
        })

        return reply.status(200).send({ data: finished });
    } catch(err) {
        throw err
    }
}