import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetWorkspaceDocuments } from "../../../useCases/factories/document/make-get-workspace-document";

export async function getWorkspaceDocuments(request: FastifyRequest, reply: FastifyReply) {
    const getWorkspaceDocumentsBodySchema = z.object({
        workspaceId: z.string(),
    })

    const { workspaceId } = getWorkspaceDocumentsBodySchema.parse(request.params);

    try {
        const getWorkspaceDocumentsUseCase = makeGetWorkspaceDocuments();

        const { documents } = await getWorkspaceDocumentsUseCase.handle({
            workspaceId,
        })

        return reply.status(200).send({ data: documents });
    } catch(err) {
        return reply.status(400).send({ error: err });
    }
}