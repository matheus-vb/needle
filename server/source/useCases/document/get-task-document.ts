import { Document } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { IDocumentRepository } from "../../repositories/IDocumentRepository";
import { BadRequest } from "../errors/BadRequest";

interface IGetTaskDocumentationUseCaseRequest {
    taskId: string
}

interface IGetTaskDocumentationUseCaseReply {
    document: Document
}

export class GetTaskDocumentationUseCase {
    constructor(private taskRepository: ITaskRepository, private documentRepository: IDocumentRepository) {}

    async handle({
        taskId,
    }: IGetTaskDocumentationUseCaseRequest): Promise<IGetTaskDocumentationUseCaseReply> {
        const task = await this.taskRepository.findById(taskId);
        if (!task) {
            throw new BadRequest();
        }

        const document = await this.documentRepository.findDocumentByTask(task);
        if(!document) {
            throw new BadRequest()
        }

        return {
            document
        }
    }
}