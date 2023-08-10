import { Task } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { IUserRepository } from "../../repositories/IUserRepository"
import { UserNotFound } from "../errors/UserNotFound"

interface IAssignTaskUseCaseRequest {
    id: string
    userId: string
}

interface IAssignTaskUseCaseReply {
    task: Task
}

export class AssignTaskUseCase {
    constructor(private taskRepository: ITaskRepository, private userRepository: IUserRepository) {}

    async handle({
        id,
        userId
    }: IAssignTaskUseCaseRequest): Promise<IAssignTaskUseCaseReply> {
        const originalTask = await this.taskRepository.findById(id);
        if (!originalTask) {
            throw new Error()
        }

        const user = await this.userRepository.findById(userId);
        if (!user) {
            throw new UserNotFound()
        }

        const task = await this.taskRepository.updateAssignee(id, userId);

        return {
            task,
        }
    }
}