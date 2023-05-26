import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { UpdateDocumentUseCase } from "../../document/update-document";

export function makeUpdateDocumentUseCase() {
    const docuementRepository = new DocumentRepository();
    const useCase = new UpdateDocumentUseCase(docuementRepository);

    return useCase;
}