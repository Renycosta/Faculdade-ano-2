-- CreateTable
CREATE TABLE `Viagens` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Destino` VARCHAR(60) NOT NULL,
    `Transporte` ENUM('Terrestre', 'Aereo', 'Maritmo') NOT NULL DEFAULT 'Terrestre',
    `Preco` SMALLINT NOT NULL,
    `dataSaida` DATETIME NOT NULL,
    `dataRetorno` DATETIME NOT NULL,
    `roteiro` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
