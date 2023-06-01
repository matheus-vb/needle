/*
  Warnings:

  - Added the required column `author` to the `Document` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Document` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Document" ADD COLUMN     "author" TEXT NOT NULL,
ADD COLUMN     "type" TEXT NOT NULL;
