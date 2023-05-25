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
    findById(id: string): Promise<User | null> {
        throw new Error("Method not implemented.");
    }
    findByEmail(email: string): Promise<User | null> {
        throw new Error("Method not implemented.");
    }
}