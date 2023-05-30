import { TaskRepository } from "../../repositories/Prisma/TaskRepository";

interface IDeleteTaskRequest {
    taskId: string;
}

export class DeleteTaskUseCase {
    constructor (private taskRepository: TaskRepository) {}

    async handle({
        taskId,
    }: IDeleteTaskRequest){
        await this.taskRepository.deleteTask(taskId);
    }
}