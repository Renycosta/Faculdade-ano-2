-- Atividade

DROP DATABASE IF EXISTS aula07c;
CREATE DATABASE aula07c;
USE aula07c;

CREATE TABLE livro (
    id      INT AUTO_INCREMENT,
    titulo  VARCHAR(100),
    autor   VARCHAR(100),
    preco   DECIMAL(10,2),
    estoque INT,
    PRIMARY KEY (id)
);

CREATE TABLE cliente (
    id    INT AUTO_INCREMENT,
    nome  VARCHAR(50),
    email VARCHAR(50),
    saldo DECIMAL(10,2),
    PRIMARY KEY (id)
);

CREATE TABLE venda (
    id         INT AUTO_INCREMENT,
    livro_id   INT,
    cliente_id INT,
    quantidade INT,
    total      DECIMAL(10,2),
    PRIMARY KEY (id),
    FOREIGN KEY (livro_id)   REFERENCES livro(id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

INSERT INTO livro (titulo, autor, preco, estoque) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 120.00, 10),
('1984', 'George Orwell', 45.00, 15),
('Dom Casmurro', 'Machado de Assis', 30.00, 8);

INSERT INTO cliente (nome, email, saldo) VALUES
('Alice', 'alice@gmail.com', 200.00),
('Bob', 'bob@gmail.com', 100.00),
('Carlos', 'carlos@gmail.com', 150.00);


/* 01 - Faça uma transação que insira uma nova venda para um cliente 
e atualize o saldo e o estoque do livro. */
DELIMITER $$
CREATE PROCEDURE realizarVenda(IN lid INT, IN cid INT, IN qua INT, IN tot DECIMAL(10,2))
BEGIN
    INSERT INTO venda (livro_id, cliente_id, quantidade, total) VALUES
    (lid, cid, qua, tot);
    UPDATE cliente SET saldo = saldo - tot WHERE id = cid;
    UPDATE livro SET estoque = estoque - qua WHERE id = lid;
END $$
DELIMITER ; 

/* 02 - Usando transaction, tente realizar uma venda 
em que o cliente não tenha saldo suficiente e use rollback. */

/* 03 - Crie uma procedure chamada realizar_venda, que: 
verifique saldo, diminua estoque e registre a venda. */

/* 04 - Crie um trigger que dispare ao tentar realizar uma venda 
de um livro cujo estoque está abaixo de 5 unidades. */

/* 05 - Crie uma função que retorna o total gasto 
por um cliente com as vendas realizadas. */

/* 06 - Tente inserir uma venda de 10 unidades de 'Dom Casmurro' 
e aplique rollback se o estoque for insuficiente. */

/* 07 - Em uma transação, aumente o saldo de um cliente 
em 100 reais e depois faça rollback. */

/* 08 - Tente deletar um cliente que tenha realizado vendas 
e observe o erro de chave estrangeira. */

/* 09 - Altere o nível de isolamento para SERIALIZABLE e inicie uma transação. 
Insira uma venda e veja se outro terminal consegue visualizar a alteração antes do commit. */

/* 10 - Crie uma procedure que, 
ao realizar uma venda, atualize o estoque 
e utilize a função total_gasto_cliente para verificar 
se o cliente já gastou mais de 500 reais. 
Se sim, conceda um desconto de 10% no valor da compra. */
