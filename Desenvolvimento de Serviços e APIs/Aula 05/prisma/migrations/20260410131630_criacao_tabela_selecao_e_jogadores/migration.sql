/*
  Warnings:

  - You are about to drop the `viagens` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `viagens`;

-- CreateTable
CREATE TABLE `selecoes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pais` VARCHAR(30) NOT NULL,
    `continente` ENUM('Africa', 'America', 'Antartida', 'Asia', 'Europa', 'Oceania') NOT NULL,
    `numCopas` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jogadores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(60) NOT NULL,
    `posicao` ENUM('Goleiro', 'Lateral', 'Zagueiro', 'Meio_Campo', 'Atacante') NOT NULL,
    `dataNasc` DATETIME(3) NOT NULL,
    `numCamisa` INTEGER NOT NULL,
    `selecaoId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `jogadores` ADD CONSTRAINT `jogadores_selecaoId_fkey` FOREIGN KEY (`selecaoId`) REFERENCES `selecoes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
