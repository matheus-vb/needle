import { Prisma, User } from "@prisma/client"

interface IUserRepository {
    create(data: Prisma.UserCreateInput): Promise<User>;
    findById(id: string): Promise<User | null>;
    findByEmail(email: string): Promise<User | null>;
}