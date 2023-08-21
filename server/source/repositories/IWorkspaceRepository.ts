import { Prisma, Workspace } from "@prisma/client";

export interface IWorkspaceInterface {
    create(data: Prisma.WorkspaceCreateInput): Promise<Workspace>;
    findById(id: string): Promise<Workspace | null>;
    findByCode(code: string): Promise<Workspace | null>;
    findWorkspaceList(userId: string): Promise<Workspace[]>; 
    deleteWorkspace(id: string): Promise<Workspace>
}