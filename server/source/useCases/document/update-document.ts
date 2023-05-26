import { Document } from "@prisma/client"
import { IDocumentRepository } from "../../repositories/IDocumentRepository"

interface IUpdateDocumentUseCaseRequest {
    id: string
    text: string
}

interface IUpdateDocumentUseCaseReply {
    document: Document
}

export class UpdateDocumentUseCase {
    constructor(private docuementRepository: IDocumentRepository) {}

    async handle({
        id,
        text,
    }: IUpdateDocumentUseCaseRequest): Promise<IUpdateDocumentUseCaseReply> {
        const document = await this.docuementRepository.updateDocument(id, text);

        return {
            document,
        }
    }
}