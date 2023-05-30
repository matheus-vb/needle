import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { QueryDocumentByTitleUseCase } from "../../document/query-document-title";

export function makeQueryDocumentByTitleUseCase() {
    const documentRepository = new DocumentRepository();
    const useCase = new QueryDocumentByTitleUseCase(documentRepository);

    return useCase;
}