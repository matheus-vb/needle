import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { GetWorkspaceDocuments } from "../../document/get-workspace-documents";

export function makeGetWorkspaceDocuments() {
    const workspaceRepository = new WorkspaceRepository();
    const documentRepository = new DocumentRepository();

    const useCase = new GetWorkspaceDocuments(documentRepository, workspaceRepository);

    return useCase;
}