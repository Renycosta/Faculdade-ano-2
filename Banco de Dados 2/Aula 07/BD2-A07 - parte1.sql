-- PARTE 1 ==================================================

DROP DATABASE IF EXISTS aula07a;
CREATE DATABASE aula07a;
USE aula07a;

CREATE TABLE ator (
  id   INT AUTO_INCREMENT, 
  nome VARCHAR(45) NOT NULL, 
  PRIMARY KEY (id)
);

INSERT INTO ator (nome) VALUES('Adam Sandler');
INSERT INTO ator (nome) VALUES('Hey Decio');
INSERT INTO ator (nome) VALUES('Jamie Foxx');
INSERT INTO ator (nome) VALUES('Joaquim Phoenix');
INSERT INTO ator (nome) VALUES('Jude Law');
INSERT INTO ator (nome) VALUES('Meryl Streep');
INSERT INTO ator (nome) VALUES('Michael Douglas');
INSERT INTO ator (nome) VALUES('Tom Cruise');

SELECT * FROM ator;

SET @@autocommit = OFF;

-- Transação com rollback
START TRANSACTION;
  DELETE FROM ator; -- Apaga todos os registros da tabela ator
  SELECT * FROM ator; -- Observe que a tabela está vazia
  INSERT INTO ator (nome) VALUES('Will Smith');
  SELECT * FROM ator; -- Observe que agora só exibe o ator Will Smith
ROLLBACK; -- Desfaz a transação

SELECT * FROM ator; -- Exibe os dados iniciais pois nada foi "commitado".

-- Transação com commit
START TRANSACTION;
  DELETE FROM ator; -- Apaga todos os registros da tabela ator
  SELECT * FROM ator; -- Observe que a tabela está vazia
  INSERT INTO ator (nome) VALUES('Will Smith');
  SELECT * FROM ator; -- Observe que agora só exibe o ator Will Smith
COMMIT; -- Confirma a transação

SELECT * FROM ator; 
/* Observe que agora os dados iniciais
foram excluídos e somente o ator "Will Smith" é exibido (transação foi confirmada) */

-- Transação em Stored Procedure
DELIMITER $$
CREATE PROCEDURE insere_ator()
BEGIN
DECLARE sql_erro TINYINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_erro = TRUE;
START TRANSACTION;
  INSERT INTO ator (nome) VALUES('Angelo Luz');
  INSERT INTO ator (nome) VALUES('Pablo Escobar');
  INSERT INTO ator (nome) VALUES(NULL);
  -- Na última inserção há um erro que impedirá o COMMIT e provocará o ROLLBACK.
  IF sql_erro = FALSE THEN
    COMMIT;
    SELECT 'Transação OK' AS Situação;
  ELSE
    ROLLBACK;
    SELECT 'Erro na transação' AS Situação;
  END IF;
END$$
DELIMITER ;

CALL insere_ator();

SELECT * FROM ator;
-- Nenhum dado foi inserido pois o último INSERT causa um erro.

SET @@autocommit = ON;


-- SIGNAL SQLSTATE no MySQL (usando PRODECURE)
DELIMITER $$
CREATE PROCEDURE inserir_ator(IN nome_ator VARCHAR(100))
BEGIN
 IF nome_ator IS NULL OR LENGTH(TRIM(nome_ator)) = 0 THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Nome do ator não pode ser vazio';
 END IF;
 INSERT INTO ator (nome) VALUES (nome_ator);
END$$
DELIMITER ;

CALL inserir_ator('Tom Hanks'); -- Funciona
CALL inserir_ator('');          -- Erro: Nome do ator não pode ser vazio


-- SIGNAL SQLSTATE no MySQL (usando FUNCTION)
DELIMITER $$
CREATE FUNCTION inserir_ator(nome_ator VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
 IF nome_ator IS NULL OR LENGTH(TRIM(nome_ator)) = 0 THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Nome do ator não pode ser vazio';
 END IF;
 INSERT INTO ator (nome) VALUES (nome_ator);
 RETURN 'Ator inserido com sucesso';
END$$
DELIMITER ;

SELECT inserir_ator('Tom Hanks'); -- Funciona
SELECT inserir_ator('');          -- Erro: Nome do ator não pode ser vazio


-- SIGNAL no PostgreSQL (RAISE EXCEPTION) - (usando PROCEDURE)
CREATE OR REPLACE PROCEDURE inserir_ator(nome_ator TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
 IF nome_ator IS NULL OR LENGTH(TRIM(nome_ator)) = 0 THEN
  RAISE EXCEPTION USING
   MESSAGE = 'Nome do ator não pode ser vazio',
   ERRCODE = 'P2001';
 END IF;
 INSERT INTO ator (nome) VALUES (nome_ator);
END;
$$;

CALL inserir_ator('Tom Hanks'); -- Funciona
CALL inserir_ator('');          -- ERRO: Nome do ator não pode ser vazio


-- SIGNAL no PostgreSQL (RAISE EXCEPTION) - (usando FUNCTION)
CREATE OR REPLACE FUNCTION inserir_ator(nome_ator TEXT) RETURNS VOID AS $$
BEGIN
 IF nome_ator IS NULL OR LENGTH(TRIM(nome_ator)) = 0 THEN
  RAISE EXCEPTION USING
   MESSAGE = 'Nome do ator não pode ser vazio',
   ERRCODE = 'P2001'; -- Código personalizado de erro (usuário)
 END IF;
 INSERT INTO ator (nome) VALUES (nome_ator);
END;
$$ LANGUAGE plpgsql;

SELECT inserir_ator('Tom Hanks'); -- Funciona
SELECT inserir_ator('');          -- Erro: Nome do ator não pode ser vazio
