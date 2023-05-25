import { Document, Prisma } from "@prisma/client";

export interface IDocumentRepository {
    create(data: Prisma.DocumentCreateInput): Promise<Document>;
}