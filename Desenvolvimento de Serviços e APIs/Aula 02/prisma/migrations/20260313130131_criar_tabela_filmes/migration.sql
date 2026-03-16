-- CreateTable
CREATE TABLE `filmes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `titulo` VARCHAR(60) NOT NULL,
    `genero` VARCHAR(20) NOT NULL,
    `ano` SMALLINT NOT NULL,
    `duracao` SMALLINT NOT NULL,
    `sinopse` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
