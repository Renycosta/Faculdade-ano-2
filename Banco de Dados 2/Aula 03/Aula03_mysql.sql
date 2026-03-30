-- MySQL 
CREATE DATABASE aula03m;
USE aula03m;

-- Clientes
CREATE TABLE clientes ( 
    id  INT AUTO_INCREMENT, 
    nome    VARCHAR(100), 
    email   VARCHAR(100), 
    PRIMARY KEY(id) 
);

-- Pedidos
CREATE TABLE pedidos ( 
    id  INT AUTO_INCREMENT, 
    cliente_id  INT, 
    valor   DECIMAL(10,2), 
    data_pedido DATE, 
    PRIMARY KEY (id), 
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) 
);

-- Log pedidos
CREATE TABLE log_pedidos ( 
    id  INT AUTO_INCREMENT, 
    mensagem TEXT, 
    data_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY(id) 
);

-- Inserindo clientes
INSERT INTO clientes (nome, email) VALUES 
    ('João Silva', 'joao@email.com'), 
    ('Maria Souza', 'maria@email.com');

-- Inserindo pedidos
INSERT INTO pedidos (cliente_id, valor, data_pedido) VALUES 
    (1, 199.90, '2025-03-01'), 
    (1, 49.90, '2025-03-10'), 
    (2, 99.90, '2025-03-15');

-- TRIGGER AFTER INSERT
DELIMITER $$ 

CREATE TRIGGER trg_pedidos_AI 
AFTER INSERT ON pedidos 
FOR EACH ROW 
BEGIN 
    INSERT INTO log_pedidos (mensagem) 
    VALUES ( 
        CONCAT('Novo pedido inserido para o cliente ID ', NEW.cliente_id) 
    ); 
END $$ 

DELIMITER ;

-- TRIGGER BEFORE DELETE 
DELIMITER $$

CREATE TRIGGER trg_clientes_BD 
BEFORE DELETE ON clientes 
FOR EACH ROW 
BEGIN 
    INSERT INTO log_pedidos (mensagem) 
    VALUES (
        CONCAT('Cliente ID ', OLD.id, ' será removido: ', OLD.nome)
    ); 
END$$

-- TRIGGER AFTER UPDATE
DELIMITER $$ 

CREATE TRIGGER trg_pedidos_AU 
AFTER UPDATE ON pedidos 
FOR EACH ROW 
BEGIN 
    INSERT INTO log_pedidos (mensagem) 
    VALUES ( 
        CONCAT('Pedido ID ', OLD.id, ' atualizado. Valor anterior: ', OLD.valor, ', novo valor: ', NEW.valor) 
    ); 
END $$ 

DELIMITER ;

-- PROCEDURE para inserir novo cliente 
DELIMITER $$ 
CREATE PROCEDURE inserir_cliente(IN nome_cli VARCHAR(100), IN email_cli VARCHAR(100)) BEGIN 
    INSERT INTO clientes (nome, email) 
    VALUES (nome_cli, email_cli); 
END $$ 
DELIMITER;

    -- Chamando a procedure 
    CALL inserir_cliente('Carlos Mendes', 'carlos@email.com');

-- FUNÇÃO para verificar total de pedidos por cliente
DELIMITER $$ 
CREATE FUNCTION total_pedidos(id_cliente INT) 
RETURNS INT 
DETERMINISTIC 
BEGIN 
    DECLARE total INT; 
    SELECT COUNT(*) INTO total 
    FROM pedidos 
    WHERE cliente_id = id_cliente; 
    RETURN total; 
END$$ 
DELIMITER ;

    -- Chamando a função 
    SELECT total_pedidos(1);

-- VIEW que retorna nome, email e total de pedidos por cliente
CREATE VIEW dados_cliente_view AS 
SELECT 
    c.id, 
    c.nome, 
    c.email, 
    COUNT(p.id) AS total_pedidos 
FROM 
    clientes c 
LEFT JOIN 
    pedidos p ON c.id = p.cliente_id 
GROUP BY 
    c.id, c.nome, c.email;

    -- Consultando a VIEW 
    SELECT * FROM dados_cliente_view WHERE id = 1;

-- Habilitando agendador de eventos (se não estiver ativo) 
SET GLOBAL event_scheduler = ON;

-- EVENTO DIÁRIO - EXECUTA NA HORA EM QUE FOI CRIADO
-- Evento que limpa pedidos antigos
DELIMITER $$ 
CREATE EVENT IF NOT EXISTS limpa_pedidos_antigos 
ON SCHEDULE EVERY 1 DAY 
DO 
BEGIN 
    DELETE FROM pedidos WHERE data_pedido < CURDATE() - INTERVAL 365 DAY; 
END $$ 
DELIMITER ;

-- EVENTO DIÁRIO EM HORÁRIO ESPECÍFICO
CREATE EVENT limpa_pedidos_antigos 
ON SCHEDULE 
    EVERY 1 DAY 
    STARTS TIMESTAMP(CURDATE() + INTERVAL 2 HOUR) -- exemplo: todos os dias às 2h 
DO 
BEGIN 
    DELETE FROM pedidos WHERE data_pedido < CURDATE() - INTERVAL 365 DAY; 
END;

-- Visão (VIEW) simples com JOIN