-- DropForeignKey
ALTER TABLE "User_Workspace" DROP CONSTRAINT "User_Workspace_userId_fkey";

-- DropForeignKey
ALTER TABLE "User_Workspace" DROP CONSTRAINT "User_Workspace_workspaceId_fkey";

-- AddForeignKey
ALTER TABLE "User_Workspace" ADD CONSTRAINT "User_Workspace_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User_Workspace" ADD CONSTRAINT "User_Workspace_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;
