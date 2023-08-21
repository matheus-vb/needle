import { Document } from "@prisma/client"
import { IDocumentRepository } from "../../repositories/IDocumentRepository"
import { BadRequest } from "../errors/BadRequest"

interface IUpdateDocumentUseCaseRequest {
    id: string
    text: string
    textString: string
}

interface IUpdateDocumentUseCaseReply {
    document: Document
}

export class UpdateDocumentUseCase {
    constructor(private docuementRepository: IDocumentRepository) {}

    async handle({
        id,
        text,
        textString
    }: IUpdateDocumentUseCaseRequest): Promise<IUpdateDocumentUseCaseReply> {
        let document = await this.docuementRepository.findById(id)
        if (!document) {
            throw new BadRequest()
        }

        document = await this.docuementRepository.updateDocument(id, text, textString);

        return {
            document,
        }
    }
}