import { Document } from "@prisma/client"
import { IDocumentRepository } from "../../repositories/IDocumentRepository"

interface IQueryDocumentByTitleUseCaseRequest {
    query: string,
    accessCode: string
}

interface IQueryDocumentByTitleUseCaseReply {
    documents: Document[]
}

export class QueryDocumentByTitleUseCase {
    constructor(private documentsRepository: IDocumentRepository) {}

    async handle({
        query,
        accessCode
    }: IQueryDocumentByTitleUseCaseRequest): Promise<IQueryDocumentByTitleUseCaseReply> {
        const documents = await this.documentsRepository.queryDocumentByTitle(query, accessCode);

        return {
            documents,
        }
    }
}