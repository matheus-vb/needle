import { Document } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { IDocumentRepository } from "../../repositories/IDocumentRepository";

interface IGetTaskDocumentationRequest {
    taskId: string
}

interface IGetTaskDocumentationReply {
    document: Document
}

export class GetTaskDocumentation {
    constructor(private taskRepository: ITaskRepository, private documentRepository: IDocumentRepository) {}

    async handle({
        taskId,
    }: IGetTaskDocumentationRequest): Promise<IGetTaskDocumentationReply> {
        const task = await this.taskRepository.findById(taskId);
        if (!task) {
            throw new Error();
        }

        const document = await this.documentRepository.findDocumentByTask(task);
        if(!document) {
            throw new Error()
        }

        return {
            document
        }
    }
}