import { Prisma, Document } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { IDocumentRepository } from "../IDocumentRepository";

export class DocumentRepository implements IDocumentRepository {
    async create(data: Prisma.DocumentCreateInput): Promise<Document> {
        const document = await prisma.document.create({
            data,
        })
        return document;
    }
}