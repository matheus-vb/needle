import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { QueryDocuemntByTypeUseCase } from "../../document/query-document-type";

export function makeQueryDocumentByTitleUseCase() {
    const docuementRepository = new DocumentRepository();
    const useCase = new QueryDocuemntByTypeUseCase(docuementRepository);

    return useCase;
}