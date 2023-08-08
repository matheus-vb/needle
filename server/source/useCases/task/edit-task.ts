import { Task } from "@prisma/client";
import { ITaskRepository } from "../../repositories/ITaskRepository";
import { IUserRepository } from "../../repositories/IUserRepository";
import { UserNotFound } from "../errors/UserNotFound";

interface IEditTaskRequest{
    taskId: string
    title: string
    description: string
    status: string
    type: string
    endDate: Date
    priority: string
    userId: string
}

interface IEditTaskReply{
    task: Task
}

export class EditTaskUseCase{
    constructor(private taskRepository: ITaskRepository,
                private userRepository: IUserRepository) {}

    async handle({
        taskId,
        title,
        description,
        status,
        type,
        endDate,
        priority,
        userId
    }:IEditTaskRequest) : Promise<IEditTaskReply> {
        const user = await this.userRepository.findById(userId)

        if(!user){
            throw new UserNotFound()
        }

        const task = await this.taskRepository.findById(taskId)

        if(!task){
            throw new UserNotFound()
        }

        const updatedTask = await this.taskRepository.updateTask(taskId, title, 
                                                                description, status, type, endDate, 
                                                                priority, priority, userId)
        
        return {
            task: updatedTask
        }
    }
}