import { Document, Prisma, Task, TaskType } from "@prisma/client";

export interface IDocumentRepository {
    create(data: Prisma.DocumentCreateInput): Promise<Document>;
    findDocumentByTask(task: Task): Promise<Document | null>;
    updateDocument(id: string, text: string): Promise<Document>;
    queryDocumentByTitle(query: string): Promise<Document[]>;
    queryDocumentByTaskTag(tag: string, accessCode: string): Promise<Document[]>;
    queryDocumentByType(type: TaskType): Promise<Document[]>;
}