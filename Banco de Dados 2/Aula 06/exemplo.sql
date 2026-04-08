DROP DATABASE IF EXISTS aula07; 
CREATE DATABASE aula07; 
USE aula07;

CREATE TABLE cliente ( 
    id   MEDIUMINT UNSIGNED AUTO_INCREMENT, 
    nome  VARCHAR(255) NOT NULL, 
    email  VARCHAR(255) DEFAULT NULL, 
    cidade VARCHAR(255), 
    PRIMARY KEY (id) 
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO cliente (nome, email, cidade) VALUES 
('Ruth Boyd', 'elit.erat@aol.org', 'Sarpsborg'), 
('Nayda T. Baker', 'adipiscing.elit.etiam@google.net', 'Orenburg');

SELECT SQL_NO_CACHE * 
FROM cliente 
WHERE email LIKE "%_it.e%" AND cidade LIKE "%rg%";

ALTER TABLE cliente ADD INDEX (email(50));

EXPLAIN SELECT * 
FROM cliente 
WHERE email LIKE "%_it.e%" AND cidade LIKE "%rg%";

-- Índice BTREE (padrão) 
CREATE INDEX idx_nome ON cliente (nome);

-- Índice composto 
CREATE INDEX idx_nome_cidade ON cliente (nome, cidade);

-- FULLTEXT (para textos longos – InnoDB ou MyISAM) 
CREATE FULLTEXT INDEX idx_texto_full ON cliente (nome, email);

-- HASH só é usado automaticamente em MEMORY engine 
CREATE TABLE temp_mem ( 
    id INT, 
    valor VARCHAR(100), 
    INDEX idx_hash (valor) 
) ENGINE=MEMORY;

CREATE TABLE exemplo_innodb ( 
    id INT AUTO_INCREMENT, 
    nome VARCHAR(100), 
    PRIMARY KEY (id) 
) ENGINE=InnoDB; 

CREATE TABLE exemplo_myisam ( 
    id INT AUTO_INCREMENT, 
    nome VARCHAR(100), 
    PRIMARY KEY (id) 
) ENGINE=MyISAM;

DROP TABLE IF EXISTS usuario; 
CREATE TABLE usuario ( 
    id INT AUTO_INCREMENT, 
    nome VARCHAR(255), 
    email VARCHAR(255), 
    senha VARCHAR(255), 
    PRIMARY KEY (id) 
) ENGINE=InnoDB;

DROP TABLE IF EXISTS atividade; 
CREATE TABLE atividade ( 
    id INT AUTO_INCREMENT, 
    idUsuario INT, 
    dataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (id) 
) ENGINE=InnoDB;

DELIMITER $$ 
CREATE PROCEDURE insereUsuario(qtd INT) 
BEGIN 
    DECLARE v_contador INT DEFAULT 0; 
    START TRANSACTION; 
        WHILE v_contador < qtd DO 
            INSERT INTO usuario (nome, email, senha) 
            VALUES ( 
                CONCAT('usuario', v_contador), 
                CONCAT('email', v_contador, '@exemplo.com'), 
                MD5(RAND()) 
            ); 
            SET v_contador = v_contador + 1; 
        END WHILE; 
    COMMIT; 
END $$

CREATE PROCEDURE insereAtividade(qtd INT) 
BEGIN 
    DECLARE v_contador INT DEFAULT 0; 
    SELECT MAX(id) INTO @max_id FROM usuario; 
    START TRANSACTION; 
        WHILE v_contador < qtd DO 
            INSERT INTO atividade (idUsuario) 
            VALUES (1 + FLOOR(RAND() * @max_id)); 
            SET v_contador = v_contador + 1; 
        END WHILE; 
    COMMIT; 
END $$ 
DELIMITER ;

CALL insereUsuario(5000); 
CALL insereAtividade(1000);

CREATE INDEX idx_idUsuario ON atividade(idUsuario);

EXPLAIN SELECT u.nome, COUNT(*) 
FROM usuario u 
JOIN atividade a ON a.idUsuario = u.id 
GROUP BY u.nome;

EXPLAIN FORMAT=JSON 
SELECT u.nome, COUNT(*) 
FROM usuario u 
JOIN atividade a ON a.idUsuario = u.id 
GROUP BY u.nome;