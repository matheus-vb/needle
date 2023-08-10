import { Document, Prisma, Task, TaskType } from "@prisma/client";

export interface IDocumentRepository {
    create(data: Prisma.DocumentCreateInput): Promise<Document>;
    findDocumentByTask(task: Task): Promise<Document | null>;
    updateDocument(id: string, text: string, textString: string): Promise<Document>;
    queryDocumentByTitle(query: string, accessCode: string): Promise<Document[]>;
    queryDocumentByTaskTag(tag: string, accessCode: string): Promise<Document[]>;
    queryDocumentByType(type: TaskType, accessCode: string): Promise<Document[]>;
    getWorkspaceDocuments(workspaceId: string): Promise<Document[]>;
    deleteDocumen(id : string): Promise<void>;
}