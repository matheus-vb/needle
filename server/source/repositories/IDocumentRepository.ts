import { Document, Prisma, Task } from "@prisma/client";

export interface IDocumentRepository {
    create(data: Prisma.DocumentCreateInput): Promise<Document>;
    findDocumentByTask(task: Task): Promise<Document | null>;
    queryDocumentByTitle(query: string): Promise<Document[]>;
}