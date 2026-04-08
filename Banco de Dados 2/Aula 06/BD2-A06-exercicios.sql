-- EXERCÍCIOS

-- 1 - Crie o banco a seguir

-- MySQL & PostgreSQL
DROP DATABASE IF EXISTS aula06;
CREATE DATABASE aula06;
USE aula06;

-- MySQL
CREATE TABLE cliente (
  id      MEDIUMINT UNSIGNED AUTO_INCREMENT,
  nome    VARCHAR(255),
  email   VARCHAR(255),
  cidade  VARCHAR(255),
  estado  CHAR(2),
  PRIMARY KEY(id)
) ENGINE=InnoDB;

-- PostgreSQL
CREATE TABLE cliente (
  id      SERIAL,
  nome    VARCHAR(255),
  email   VARCHAR(255),
  cidade  VARCHAR(255),
  estado  CHAR(2),
  PRIMARY KEY(id)
);

-- MySQL & PostgreSQL
INSERT INTO cliente (nome, email, cidade, estado) VALUES
('Sophie Peixoto', 'daniela76@rocha.br', 'Santos', 'BA'),
('Daniel Castro', 'pedro-henriquecastro@ig.com.br', 'Melo', 'PR'),
('Ana Luiza Moraes', 'larissa38@uol.com.br', 'Silveira de Ferreira', 'AL'),
('Alana Carvalho', 'salesraul@hotmail.com', 'Campos do Oeste', 'RJ'),
('Erick da Conceição', 'cardosopedro-miguel@bol.com.br', 'Cavalcanti de Jesus', 'PI'),
('Thales Costa', 'kamillyvieira@bol.com.br', 'Pires de Minas', 'RN'),
('Gabrielly Duarte', 'joao-miguelda-mata@gmail.com', 'Ribeiro de Minas', 'AP'),
('Sophia Costela', 'cardosomariana@souza.org', 'da Rosa', 'RO'),
('Kamilly Freitas', 'fmoraes@yahoo.com.br', 'Rodrigues', 'RJ'),
('Helena da Mota', 'fogacaenzo@moura.br', 'Castro', 'SE');

-- Gere mais dados 

-- 2. CRIE UM ÍNDICE SIMPLES NO CAMPO EMAIL
CREATE INDEX idx_email ON cliente (email(50));

-- 3. EXECUTE UMA CONSULTA COM FILTRO E ANALISE COM EXPLAIN
EXPLAIN SELECT * FROM cliente WHERE email LIKE "$br" 

-- 4. REMOVA O ÍNDICE CRIADO E COMPARE OS TEMPOS DE EXECUÇÃO
DROP INDEX idx_email ON cliente;

-- 5. CRIE UM ÍNDICE COMPOSTO PARA CIDADE E ESTADO
CREATE INDEX idx_cidade_estado ON cliente (cidade, estado);

-- 6. USE EXPLAIN ANALYZE PARA CONSULTAS COM O ÍNDICE
