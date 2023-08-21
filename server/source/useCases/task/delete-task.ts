import { Task, Document } from "@prisma/client";
import { DocumentRepository } from "../../repositories/Prisma/DocumentRepository";
import { TaskRepository } from "../../repositories/Prisma/TaskRepository";
import { BadRequest } from "../errors/BadRequest";

interface IDeleteTaskRequest {
    taskId: string;
}

interface IDeleteTaskResponse {
    task: Task;
    doc: Document;
}

export class DeleteTaskUseCase {
    constructor (private taskRepository: TaskRepository, private documentRepository: DocumentRepository) {}

    async handle({
        taskId,
    }: IDeleteTaskRequest){ 
        const task = await this.taskRepository.findById(taskId);

        if(!task){
            throw new BadRequest();
        }

        const docId = task.documentId
        const doc = await this.documentRepository.deleteDocument(docId);

        return {
            task,
            doc
        }
    }
}