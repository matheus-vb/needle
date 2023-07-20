import { z } from "zod"
import { IDocumentRepository } from "../../repositories/IDocumentRepository"
import { Document, TaskType } from "@prisma/client"

interface IQueryDocuemntByTypeUseCaseRequest {
    type: string,
    accessCode: string
}

interface IQueryDocuemntByTypeUseCaseReply {
    documents: Document[]
}

export class QueryDocuemntByTypeUseCase {
    constructor(private documentRepository: IDocumentRepository) {}

    async handle({
        type,
        accessCode
    }: IQueryDocuemntByTypeUseCaseRequest): Promise<IQueryDocuemntByTypeUseCaseReply> {
        const typeEnum = z.nativeEnum(TaskType);
        const checkedType = typeEnum.parse(type);
        
        const documents = await this.documentRepository.queryDocumentByType(checkedType, accessCode);

        return {
            documents,
        }
    }
}