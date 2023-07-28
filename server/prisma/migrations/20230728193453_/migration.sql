/*
  Warnings:

  - Added the required column `taskPriority` to the `Task` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "TaskPriority" AS ENUM ('VERY_HIGH', 'HIGH', 'MEDIUM', 'LOW');

-- AlterTable
ALTER TABLE "Task" ADD COLUMN     "taskPriority" "TaskPriority" NOT NULL;
