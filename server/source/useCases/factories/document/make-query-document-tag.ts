import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { QueryDocuemntByTagUseCase } from "../../document/query-document-tag";

export function makeQueryDocumentByTagUseCase() {
    const docuementRepository = new DocumentRepository();
    const useCase = new QueryDocuemntByTagUseCase(docuementRepository);

    return useCase;
}