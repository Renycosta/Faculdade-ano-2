DROP DATABASE IF EXISTS aula08; 
CREATE DATABASE aula08; 
USE aula08;

CREATE TABLE departamento ( 
    id  INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(50) NOT NULL 
) ENGINE=InnoDB;

CREATE TABLE funcionario ( 
    id  INT AUTO_INCREMENT PRIMARY KEY, 
    nome    VARCHAR(100),
    email   VARCHAR(100),
    salario DECIMAL(10,2), 
    departamento_id INT, 
    FOREIGN KEY (departamento_id) REFERENCES departamento(id) 
) ENGINE=InnoDB;

INSERT INTO departamento (nome) VALUES 
('TI'), 
('RH'), 
('Financeiro');

INSERT INTO funcionario (nome, email, salario, departamento_id) VALUES 
('João Silva', 'joao@empresa.com', 4500.00, 1), 
('Maria Souza', 'maria@empresa.com', 5200.00, 2), 
('Carlos Lima', 'carlos@empresa.com', 6100.00, 1), 
('Ana Paula', 'ana@empresa.com', 4000.00, 3);

-- Criação de Usuários
CREATE USER 'consultor'@'localhost' IDENTIFIED BY '1234'; 
CREATE USER 'gerente'@'localhost' IDENTIFIED BY '1234';

-- Concedendo Privilégios
GRANT SELECT ON aula08.* TO 'consultor'@'localhost'; 
GRANT ALL PRIVILEGES ON aula10.* TO 'gerente'@'localhost';

-- Criação de ROLES (Grupos de Permissões)
CREATE ROLE analista; 
GRANT SELECT, INSERT ON aula08.funcionario TO analista; 
GRANT analista TO 'consultor'@'localhost';

REVOKE analista FROM 'consultor'@'localhost';

-- Após login como consultor
SET ROLE analista;

-- Concedendo privilégios por campos
    -- Sintaxe básica: 
    GRANT <ação> (<colunas>) ON <banco>.<tabela> TO '<usuario>'@'<host>';
    
    -- Exemplo 1: Acesso somente à coluna "nome" 
    GRANT SELECT (nome) ON aula08.departamento TO 'gerente'@'localhost';
    
    -- Exemplo 2: Acesso às colunas "nome" e "email" da tabela "usuario" 
    GRANT SELECT (nome, email) ON aula08.funcionario TO 'consultor'@'localhost';
    
    -- Exemplo 3: Permitir UPDATE apenas nas colunas "email" e "fone" 
    GRANT UPDATE (email, fone) ON aula08.funcionario TO 'gerente'@'localhost';

-- Testes de Permissão (como consultor)
    -- Esperado: sucesso 
    SELECT * FROM funcionario; 
    INSERT INTO funcionario (nome, email, salario, departamento_id) 
    VALUES ('Novo Nome', 'teste@empresa.com', 3900.00, 2);
    
    -- Esperado: erro 
    DELETE FROM funcionario WHERE id = 1;

-- Visualização de Usuários
SELECT user FROM mysql.user;

-- Visualização de Permissões
SHOW GRANTS FOR 'consultor'@'localhost'; 
SELECT CURRENT_ROLE(); 
SELECT CURRENT_USER();

-- Revogando Privilégios
REVOKE SELECT ON aula10.* FROM 'consultor'@'localhost'; 
REVOKE ALL PRIVILEGES ON aula10.* FROM 'gerente'@'localhost';

-- ALTERANDO NOME E SENHA DE USUÁRIO
    -- Alterando a senha do usuário 'joao': 
    ALTER USER 'gerente'@'localhost' IDENTIFIED BY 'nova_senha123';
    
    -- Alterando o nome do usuário 'joao' para 'novo_joao': 
    RENAME USER 'gerente'@'localhost' TO 'chefe'@'localhost';

-- Remoção de Usuários e Roles
DROP USER 'consultor'@'localhost'; 
DROP USER 'chefe'@'localhost'; 
DROP ROLE analista;