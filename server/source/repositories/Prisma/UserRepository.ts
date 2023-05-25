import { Prisma, User } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { IUserRepository } from "../IUserRepository";

export class UserRepository implements IUserRepository{
    async create(data: Prisma.UserCreateInput): Promise<User> {
        const user = await prisma.user.create({
            data,
        })
        return user
    }

    async findById(id: string): Promise<User | null> {
        const user = await prisma.user.findFirst({
            where:{
                id: id
            }
        })
        return user
    }
    async findByEmail(email: string): Promise<User | null> {
        const user = await prisma.user.findFirst({
            where:{
                email: email,
            }
        })
        return user
    }
}