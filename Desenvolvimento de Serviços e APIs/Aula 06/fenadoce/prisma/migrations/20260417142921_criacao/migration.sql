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
CREATE TABLE `candidatas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(60) NOT NULL,
    `clube` VARCHAR(20) NOT NULL,
    `idade` SMALLINT NOT NULL,
    `escolaridade` ENUM('Ensino_Médio', 'Graduação', 'Pós_Graduação') NOT NULL,
    `sonho` VARCHAR(80) NOT NULL,
    `n_votos` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `clientes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(60) NOT NULL,
    `cpf` VARCHAR(14) NOT NULL,
    `email` VARCHAR(80) NOT NULL,
    `cidade` VARCHAR(40) NOT NULL,

    UNIQUE INDEX `clientes_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `votos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `candidataId` INTEGER NOT NULL,
    `clienteId` INTEGER NOT NULL,
    `data` DATETIME(3) NOT NULL DEFAULT '2026-04-17T00:00:00+00:00',
    `justi` VARCHAR(120) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `votos` ADD CONSTRAINT `votos_candidataId_fkey` FOREIGN KEY (`candidataId`) REFERENCES `candidatas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `votos` ADD CONSTRAINT `votos_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `clientes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
