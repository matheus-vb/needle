import { Document } from "@prisma/client"
import { IDocumentRepository } from "../../repositories/IDocumentRepository"

interface IQueryDocumentByTitleUseCaseRequest {
    query: string
}

interface IQueryDocumentByTitleUseCaseReply {
    documents: Document[]
}

export class QueryDocumentByTitleUseCase {
    constructor(private documentsRepository: IDocumentRepository) {}

    async handle({
        query,
    }: IQueryDocumentByTitleUseCaseRequest): Promise<IQueryDocumentByTitleUseCaseReply> {
        const documents = await this.documentsRepository.queryDocumentByTitle(query);

        return {
            documents,
        }
    }
}