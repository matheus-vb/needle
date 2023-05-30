import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { QueryDocuemntByTypeUseCase } from "../../document/query-document-type";

export function makeQueryDocumentByTypeUseCase() {
    const docuementRepository = new DocumentRepository();
    const useCase = new QueryDocuemntByTypeUseCase(docuementRepository);

    return useCase;
}