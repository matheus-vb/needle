import { Task, TaskPriority, TaskStatus, TaskType } from "@prisma/client";
import { z } from "zod";
import { ITaskRepository } from "../../repositories/ITaskRepository";
import { BadRequest } from "../errors/BadRequest";

interface IEditTaskRequest{
    taskId: string
    title: string
    description: string
    status: string
    type: string
    endDate: Date
    priority: string
    userId: string | null
}

interface IEditTaskReply{
    task: Task
}

export class EditTaskUseCase{
    constructor(private taskRepository: ITaskRepository) {}

    async handle({
        taskId,
        title,
        description,
        status,
        type,
        endDate,
        priority,
        userId,
    }:IEditTaskRequest) : Promise<IEditTaskReply> {
        const task = await this.taskRepository.findById(taskId)

        if(!task){
            throw new BadRequest()
        }

        const parseStatus = z.nativeEnum(TaskStatus)
        const parsePriority = z.nativeEnum(TaskPriority)
        const parseType = z.nativeEnum(TaskType)

        const checkedStatus = parseStatus.parse(status)
        const checkedType = parseType.parse(type)
        const checkedPriority = parsePriority.parse(priority)
        const updatedTask = await this.taskRepository.updateTask(taskId, title, 
                                                                description, checkedStatus, checkedType, endDate, 
                                                                checkedPriority, userId)
        
        return {
            task: updatedTask
        }
    }
}