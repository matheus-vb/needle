import { DocumentRepository } from "../../repositories/Prisma/DocumentRepository";
import { TaskRepository } from "../../repositories/Prisma/TaskRepository";

interface IDeleteTaskRequest {
    taskId: string;
}

export class DeleteTaskUseCase {
    constructor (private taskRepository: TaskRepository, private documentRepository: DocumentRepository) {}

    async handle({
        taskId,
    }: IDeleteTaskRequest){ 
        const task = await this.taskRepository.findById(taskId);

        if(!task){
            throw new Error();
        }

        const docId = task.documentId
        await this.documentRepository.deleteDocumen(docId);
    }
}