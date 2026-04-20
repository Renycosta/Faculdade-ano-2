/*
  Warnings:

  - Added the required column `treinador` to the `selecoes` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `selecoes` ADD COLUMN `treinador` VARCHAR(30) NOT NULL;
