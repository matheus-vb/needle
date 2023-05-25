import { Prisma, User } from "@prisma/client";
import { IUserRepository } from "../IUserRepository";

export class UserRepository implements IUserRepository{
    create(data: Prisma.UserCreateInput): Promise<User> {
        throw new Error("Method not implemented.");
    }
    findById(id: string): Promise<User | null> {
        throw new Error("Method not implemented.");
    }
    findByEmail(email: string): Promise<User | null> {
        throw new Error("Method not implemented.");
    }
}