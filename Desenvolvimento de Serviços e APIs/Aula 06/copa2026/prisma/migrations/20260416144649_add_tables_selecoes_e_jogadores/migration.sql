-- CreateTable
CREATE TABLE `selecoes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pais` VARCHAR(40) NOT NULL,
    `continente` VARCHAR(20) NOT NULL,
    `numCopas` SMALLINT NULL,
    `treinador` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jogadores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(60) NOT NULL,
    `posicao` ENUM('Goleiro', 'Lateral', 'Zagueiro', 'MeioCampo', 'Atacante') NOT NULL,
    `selecaoId` INTEGER NOT NULL,
    `dataNasc` DATETIME(3) NOT NULL,
    `numCamisa` SMALLINT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `jogadores` ADD CONSTRAINT `jogadores_selecaoId_fkey` FOREIGN KEY (`selecaoId`) REFERENCES `selecoes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
