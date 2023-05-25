import { Task } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"

interface IAssignTaskUseCaseRequest {
    id: string
    userId: string
}

interface IAssignTaskUseCaseReply {
    task: Task
}

export class AssignTaskUseCase {
    constructor(private taskRepository: ITaskRepository) {}

    async handle({
        id,
        userId
    }: IAssignTaskUseCaseRequest): Promise<IAssignTaskUseCaseReply> {
        const originalTask = await this.taskRepository.findById(id);
        if (!originalTask) {
            throw new Error()
        }

        const task = await this.taskRepository.updateAssignee(id, userId);

        return {
            task,
        }
    }
}