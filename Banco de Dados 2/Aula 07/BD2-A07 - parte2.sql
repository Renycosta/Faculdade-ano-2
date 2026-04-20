-- PARTE 2 ======================================================
-- Execute o script seguindo as orientações do Professor Rimidalg

DROP DATABASE IF EXISTS aula07b;
CREATE DATABASE aula07b;
USE aula07b;

SET @@autocommit = ON;

DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
  id       INT NOT NULL AUTO_INCREMENT, 
  nome     CHAR(20), 
  endereco CHAR(20), 
  PRIMARY KEY (id)
);

CREATE TABLE pedido(
  id         INT NOT NULL AUTO_INCREMENT, 
  total      INT, 
  cliente_id INT, 
  PRIMARY KEY (id), 
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

SELECT * FROM cliente;
SELECT * FROM pedido;

START TRANSACTION;
INSERT INTO cliente(nome, endereco) VALUES('GladiDecio', 'Gonçalves Chaves');

SELECT last_insert_id();
/*
+------------------+
| last_insert_id() |
+------------------+
|                1 |
+------------------+
1 row in set (0.00 sec) */

INSERT INTO pedido(total, cliente_id) values(200, 1);

COMMIT;

-- Sair da conexão com o comando EXIT
EXIT

-- Conectar ao MySQL novamente
-- mysql -u root -p

USE aula08b;

SELECT * FROM cliente;
/*
+----+------------+------------------+
| id | nome       | endereco         |
+----+------------+------------------+
|  1 | GladiDecio | Gonçalves Chaves |
+----+------------+------------------+
1 row in set (0.00 sec) */

SELECT * FROM pedido;
/*
+----+-------+------------+
| id | total | cliente_id |
+----+-------+------------+
|  1 |   200 |          1 |
+----+-------+------------+
1 row in set (0.00 sec) */

-- O cliente e o pedido foram inseridos

-- Iniciar outra transação

START TRANSACTION;

INSERT INTO cliente(nome, endereco) values('EdecioMir', 'Satolep');

SELECT last_insert_id();
/*
+------------------+
| last_insert_id() |
+------------------+
|                2 |
+------------------+
1 row in set (0.00 sec) */

/* Vamos supor que neste momento houve uma falha no banco de dados. 
Vamos simular isso saindo do banco. */

-- Sair da conexão com o comando EXIT
EXIT

-- Conectar ao MySQL novamente
-- mysql -u root -p

USE aula08b;

-- Tentando iserir um pedido para o cliente_id 2
INSERT INTO pedido(total, cliente_id) VALUES(300, 2);

/* ERROR 1452 (23000): Cannot add or update a child row: 
a foreign key constraint fails (`aula11`.`pedido`, CONSTRAINT `pedido_ibfk_1` 
FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)) */

SELECT * FROM cliente;
/*
+----+------------+------------------+
| id | nome       | endereco         |
+----+------------+------------------+
|  1 | GladiDecio | Gonçalves Chaves |
+----+------------+------------------+
1 row in set (0.00 sec) */

/* Como houve uma "falha" no banco de dados 
as informações do cliente foram revertidas. 
A atomicidade foi aplicada. */

/* Outro exemplo de restrição de banco de dados
Uma tabela referenciada não pode ser eliminada 
até que a tabela de referência seja eliminada.
Tente excluir a tabela do cliente.
*/

DROP TABLE cliente;
/* ERROR 3730 (HY000): Cannot drop table 'cliente' referenced by a 
foreign key constraint 'pedido_ibfk_1' on table 'pedido'. */

-- TERMINAL B
/* Inicie outra conexão MySQL (a partir de outro terminal)
Chamaremos de TERMINAL B. */

-- mysql -u root -p

USE aula08b;

SELECT * FROM cliente;
/*
+----+------------+------------------+
| id | nome       | endereco         |
+----+------------+------------------+
|  1 | GladiDecio | Gonçalves Chaves |
+----+------------+------------------+
1 row in set (0.00 sec) */

-- TERMINAL A
/* Retorne ao TERMINAL A e insira um cliente e um pedido. */

INSERT INTO cliente(nome, endereco) VALUES('EdecioMir', 'Satolep');

SELECT last_insert_id();
/*
+------------------+
| last_insert_id() |
+------------------+
|                3 |
+------------------+
1 row in set (0.00 sec) */

SELECT * FROM cliente;
/*
+----+------------+------------------+
| id | nome       | endereco         |
+----+------------+------------------+
|  1 | GladiDecio | Gonçalves Chaves |
|  3 | EdecioMir  | Satolep          |
+----+------------+------------------+
2 rows in set (0.00 sec) */

INSERT INTO pedido(total, cliente_id) values(350, 3);

-- TERMINAL B
/* No TERMINAL B, liste/consulte a tabela cliente. */

SELECT * FROM cliente;
/*
+----+------------+------------------+
| id | nome       | endereco         |
+----+------------+------------------+
|  1 | GladiDecio | Gonçalves Chaves |
|  3 | EdecioMir  | Satolep          |
+----+------------+------------------+
2 rows in set (0.00 sec) */

/* Desta forma todo terminal MySQL obtém uma visão dos dados, 
independentemente de onde ocorre a inserção ou atualização. */

-- ISOLAMENTO

-- TERMINAL A
START TRANSACTION;

INSERT INTO cliente(nome, endereco) VALUES('Angelo Monks', 'Gonçalves Chaves');

SELECT last_insert_id();
/*
+------------------+
| last_insert_id() |
+------------------+
|                4 |
+------------------+
1 row in set (0.00 sec) */

-- TERMINAL B
SELECT * FROM cliente;
/*
+----+------------+------------------+
| id | nome       | endereco         |
+----+------------+------------------+
|  1 | GladiDecio | Gonçalves Chaves |
|  3 | EdecioMir  | Satolep          |
+----+------------+------------------+
2 rows in set (0.00 sec) */

/*
O terminal B não está vendo a transação não confirmada do terminal A. 
O terminal B está isolado do terminal A.

O terminal B só verá as alterações depois que 
elas forem confirmadas pelo outro terminal.

Esse comportamento pode ser alterado.
Conforme visto em aula, o MySQL e outros SGBDs 
fornecem diferentes níveis de isolamento de transação. 
Se definirmos o nível de isolamento como: 
READ UNCOMMITTED, um cliente também verá as transações não confirmadas 
de outros clientes.*/

-- TERMINAL A
COMMIT;

-- TERMINAL B
SELECT * FROM cliente;
/*
+----+--------------+------------------+
| id | nome         | endereco         |
+----+--------------+------------------+
|  1 | GladiDecio   | Gonçalves Chaves |
|  3 | EdecioMir    | Satolep          |
|  4 | Angelo Monks | Gonçalves Chaves |
+----+--------------+------------------+
3 rows in set (0.00 sec) */

