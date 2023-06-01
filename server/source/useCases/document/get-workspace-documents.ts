import { Document } from "@prisma/client";
import { IDocumentRepository } from "../../repositories/IDocumentRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";

interface IGetWorkspaceDocumentsRequest {
    workspaceId: string
}

interface IGetWorkspaceDocumentsReply {
    documents: Document[]
}

export class GetWorkspaceDocuments {
    constructor(private documentRepository: IDocumentRepository, private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        workspaceId,
    }: IGetWorkspaceDocumentsRequest): Promise<IGetWorkspaceDocumentsReply> {
        const workspace = await this.workspaceRepository.findById(workspaceId);
        if(!workspace) {
            throw new Error();
        }

        const documents = await this.documentRepository.getWorkspaceDocuments(workspaceId);

        return {
            documents,
        }
    }
}