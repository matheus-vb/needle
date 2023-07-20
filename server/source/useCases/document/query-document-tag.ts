import { Document } from "@prisma/client";
import { IDocumentRepository } from "../../repositories/IDocumentRepository";

interface IQueryDocuemntByTagUseCaseRequest {
    tag: string,
    accessCode: string,
}

interface IQueryDocuemntByTagUseCaseReply {
    documents: Document[]
}

export class QueryDocuemntByTagUseCase {
    constructor(
        private documentRepository: IDocumentRepository,
    ) {}

    async handle({
        tag, accessCode
    }: IQueryDocuemntByTagUseCaseRequest): Promise<IQueryDocuemntByTagUseCaseReply> {
        const documents = await this.documentRepository.queryDocumentByTaskTag(tag, accessCode);

        return {
            documents,
        }
    }
}