-- CreateTable
CREATE TABLE `notebooks` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `modelo` VARCHAR(60) NOT NULL,
    `marca` VARCHAR(20) NOT NULL,
    `processador` ENUM('AMD', 'Intel') NOT NULL,
    `preco` DECIMAL(10, 2) NOT NULL,
    `quantidade` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
