/*
  Warnings:

  - You are about to drop the `jogadores` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `selecoes` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `jogadores` DROP FOREIGN KEY `jogadores_selecaoId_fkey`;

-- DropTable
DROP TABLE `jogadores`;

-- DropTable
DROP TABLE `selecoes`;

-- CreateTable
CREATE TABLE `selecao` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pais` VARCHAR(30) NOT NULL,
    `continente` ENUM('Africa', 'America', 'Antartida', 'Asia', 'Europa', 'Oceania') NOT NULL,
    `numCopas` INTEGER NULL,
    `treinador` VARCHAR(30) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jogador` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(60) NOT NULL,
    `posicao` ENUM('Goleiro', 'Lateral', 'Zagueiro', 'Meio_Campo', 'Atacante') NOT NULL,
    `dataNasc` DATETIME(3) NOT NULL,
    `numCamisa` INTEGER NOT NULL,
    `selecaoId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `jogador` ADD CONSTRAINT `jogador_selecaoId_fkey` FOREIGN KEY (`selecaoId`) REFERENCES `selecao`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
