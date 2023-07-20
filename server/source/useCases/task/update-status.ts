import { Task, TaskStatus } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { z } from "zod"

interface IUpdateTaskStatusUseCaseRequest {
    taskId: string
    status: string
}

interface IUpdateTaskStatusUseCaseReply {
    task: Task
}

export class UpdateTaskStatusUseCase {
    constructor(private taskRepository: ITaskRepository) {}

    async handle({
        status,
        taskId,
    }: IUpdateTaskStatusUseCaseRequest): Promise<IUpdateTaskStatusUseCaseReply> {
        const originalTask = await this.taskRepository.findById(taskId);
        if(!originalTask) {
            throw new Error();
        }

        const statusEnum = z.nativeEnum(TaskStatus);
        const checkedStatus = statusEnum.parse(status);

        const task = await this.taskRepository.updateStatus(originalTask.id, checkedStatus);

        return {
            task,
        }
    }
}