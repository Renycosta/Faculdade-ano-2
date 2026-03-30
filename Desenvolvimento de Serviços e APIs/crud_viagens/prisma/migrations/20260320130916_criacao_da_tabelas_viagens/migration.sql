-- CreateTable
CREATE TABLE `viagens` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `destino` VARCHAR(60) NOT NULL,
    `transporte` ENUM('Terrestre', 'Maritimo', 'Aereo') NOT NULL DEFAULT 'Terrestre',
    `preco` DECIMAL(10, 2) NOT NULL,
    `dataSaida` DATETIME(3) NOT NULL,
    `dataRetorno` DATETIME(3) NOT NULL,
    `roteiro` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
