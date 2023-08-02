/*
  Warnings:

  - Added the required column `userRole` to the `User_Workspace` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User_Workspace" ADD COLUMN     "userRole" "Role" NOT NULL;
