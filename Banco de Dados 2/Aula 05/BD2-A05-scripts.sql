/* CRIAÇÃO DE SCHEMA / DEFINIÇÃO*/

DROP SCHEMA IF EXISTS aula05;
CREATE SCHEMA aula05;
USE aula05;

-- PAIS
CREATE TABLE pais (
  id INT NOT NULL AUTO_INCREMENT, 
  nome VARCHAR(45) NOT NULL, 
  PRIMARY KEY (id)
);

-- CIDADE
CREATE TABLE cidade (
  id INT NOT NULL AUTO_INCREMENT, 
  nome VARCHAR(45) NULL, 
  uf CHAR(2) NULL, 
  PRIMARY KEY (id)
);

-- CINEMA
CREATE TABLE cinema (
  id INT NOT NULL AUTO_INCREMENT, 
  nomeFantasia VARCHAR(45) NOT NULL, 
  endereco VARCHAR(45) NOT NULL, 
  bairro VARCHAR(45) NOT NULL, 
  idCidade INT NOT NULL, 
  capacidade INT NOT NULL, 
  PRIMARY KEY (id),
  CONSTRAINT fk_cinema_cidade FOREIGN KEY (idCidade) REFERENCES cidade (id)
);

-- GENERO
CREATE TABLE genero (
  id INT NOT NULL AUTO_INCREMENT, 
  nome VARCHAR(45) NOT NULL, 
  PRIMARY KEY (id)
);

-- ATOR (contém atores e diretores)
CREATE TABLE ator (
  id INT NOT NULL AUTO_INCREMENT, 
  nome VARCHAR(45) NOT NULL, 
  PRIMARY KEY (id)
);

-- FILME
CREATE TABLE filme (
  id INT NOT NULL AUTO_INCREMENT, 
  idGenero INT NOT NULL, 
  idPais INT NOT NULL, 
  idDiretor INT NOT NULL, 
  tituloOriginal VARCHAR(100) NOT NULL, 
  tituloPortugues VARCHAR(100) NULL, 
  duracao INT NULL, 
  PRIMARY KEY (id), 
  CONSTRAINT fk_filme_genero FOREIGN KEY (idGenero) REFERENCES genero (id), 
  CONSTRAINT fk_filme_pais FOREIGN KEY (idPais) REFERENCES pais (id), 
  CONSTRAINT fk_filme_ator FOREIGN KEY (idDiretor) REFERENCES ator (id)
);

-- ELENCO
CREATE TABLE elenco (
  idFilme INT NOT NULL, 
  idAtor INT NOT NULL, 
  PRIMARY KEY (idFilme, idAtor), 
  CONSTRAINT fk_elenco_filme FOREIGN KEY (idFilme) REFERENCES filme (id), 
  CONSTRAINT fk_elenco_ator FOREIGN KEY (idAtor) REFERENCES ator (id)
);

-- SESSAO
CREATE TABLE sessao (
  id INT NOT NULL AUTO_INCREMENT, 
  idCinema INT NOT NULL, 
  idFilme INT NOT NULL, 
  data DATE NOT NULL, 
  horaInicio TIME NOT NULL, 
  publico INT, 
  PRIMARY KEY (id), 
  CONSTRAINT fk_sessao_cinema FOREIGN KEY (idCinema) REFERENCES cinema (id), 
  CONSTRAINT fk_sessao_filme FOREIGN KEY (idFilme) REFERENCES filme (id)
);

-- USUARIO
CREATE TABLE usuario (
  id INT NOT NULL AUTO_INCREMENT, 
  idCidade INT NOT NULL, 
  nome VARCHAR(45) NULL, 
  email VARCHAR(100) NULL, 
  PRIMARY KEY (id), 
  CONSTRAINT fk_usuario_cidade FOREIGN KEY (idCidade) REFERENCES cidade (id)
);

-- TIPO PAGAMENTO
CREATE table tipoPagto (
  id INT NOT NULL AUTO_INCREMENT, 
  nome VARCHAR(45) NOT NULL, 
  PRIMARY KEY (id)
);

-- VENDA
CREATE TABLE venda (
  id INT NOT NULL AUTO_INCREMENT, 
  idSessao INT NOT NULL, 
  idTipoPagto INT NOT NULL, 
  idUsuario INT NOT NULL, 
  data DATE NULL, 
  hora TIME NULL, 
  valorIngresso DOUBLE NULL, 
  PRIMARY KEY (id), 
  CONSTRAINT fk_venda_sessao FOREIGN KEY (idSessao) REFERENCES sessao (id), 
  CONSTRAINT fk_venda_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (id), 
  CONSTRAINT fk_venda_tipoPagto FOREIGN KEY (idTipoPagto) REFERENCES tipoPagto (id)
);

-- PARCELA
CREATE table parcela (
  id INT NOT NULL AUTO_INCREMENT, 
  idVenda INT NOT NULL, 
  valor DOUBLE, 
  vencimento DATE, 
  situacao VARCHAR(45), 
  PRIMARY KEY (id), 
  CONSTRAINT fk_venda_parcela FOREIGN KEY (idVenda) REFERENCES venda (id)
);

-- -------

USE aula05;
-- -------

-- Inserts com múltiplos valores

-- Ator
INSERT INTO ator (nome) VALUES
('Adam Sandler'),
('Al Pacino'),
('Angelina Jolie'),
('Anne Hathaway'),
('Ben Stiller'),
('Brad Pitt'),
('Charlize Theron'),
('Chris Hemsworth'),
('Chris Pratt'),
('Christian Bale'),
('Denzel Washington'),
('Dwayne Johnson'),
('Emily Blunt'),
('Emma Stone'),
('Emmanuelle Riva'),
('Ewan McGregor'),
('Gal Gadot'),
('Gladimau Ceroni'),
('Helen Hunt'),
('Hugh Jackman'),
('Jamie Foxx'),
('Jason Clarke'),
('Jennifer Aniston'),
('Joaquin Phoenix'),
('John Hawkes'),
('Jude Law'),
('Keanu Reeves'),
('Keira Knightley'),
('Kristen Connolly'),
('Kristen Stewart'),
('Leonardo DiCaprio'),
('Margot Robbie'),
('Mark Ruffalo'),
('Matthew McConaughey'),
('Meryl Streep'),
('Michael Douglas'),
('Morgan Freeman'),
('Natalie Portman'),
('Paul Rudd'),
('Robert De Niro'),
('Robert Downey Jr.'),
('Ryan Gosling'),
('Ryan Reynolds'),
('Samuel L. Jackson'),
('Scarlett Johansson'),
('Tom Cruise'),
('Tom Hanks'),
('Tom Hardy'),
('Viola Davis'),
('Will Smith'),
('Zendaya');

-- Diretor
INSERT INTO ator (nome) VALUES
('Martin Scorsese'),
('Quentin Tarantino'),
('Roman Polanski'),
('Steven Spilberg'),
('Robert Zemeckis'),
('Joe Wright'),
('Ben Lewin'),
('Paul Thomas Anderson'),
('William Friedkin'),
('Kathryn Bigelow'),
('Michael Haneke'),
('Drew Goddard');

-- País
INSERT INTO pais (nome) VALUES
('Brasil'),
('Estados Unidos'),
('Inglaterra'),
('França'),
('Argentina');

-- Cidade
INSERT INTO cidade (nome, uf) VALUES
('Pelotas', 'RS'),
('Arroio Grande', 'RS'),
('Campinas', 'SP'),
('Herval', 'RS'),
('Jaguarão', 'RS'),
('São Paulo', 'SP');

-- Gênero
INSERT INTO genero (nome) VALUES
('Comédia'),
('Ficção'),
('Drama'),
('Aventura'),
('Suspense'),
('Terror'),
('Policial'),
('Faroeste');

-- Filme
INSERT INTO filme (tituloOriginal, tituloPortugues, duracao, idDiretor, idGenero, idPais) VALUES
('Flight', 'O Voo', 138, 5, 3, 2),
('Anna Karenina', 'Anna Karenina', 131, 6, 3, 3),
('The Sessions', 'As Sessões', 98, 7, 1, 2),
('Django Unchained', 'Django Livre', 164, 2, 8, 2),
('The Master', 'O Mestre', 144, 8, 3, 2),
('Killer Joe', 'Killer Joe - Matador de Aluguel', 102, 9, 5, 2),
('Zero Dark Thirty', 'A Hora Mais Escura', 157, 10, 5, 2),
('Amour', 'Amor', 127, 11, 3, 4),
('The Cabin in The Woods', 'O Segredo da Cabana', 105, 12, 6, 2),
('La Murga Loca', 'Don Angelus Pax de volta ao lar', 90, 28, 1, 5),
('Cucarachas Assassinas', 'Hey! Hey! Hey! Hey Decio é nosso... Rei', 90, 29, 1, 5),
('The Incredible Case of the DELETE Without WHERE', 'O incrível caso do DELETE sem WHERE', 120, 7, 1, 2);

-- Elenco
INSERT INTO elenco (idFilme, idAtor) VALUES
(1,12), (1,26),
(2,13), (2,14),
(3,15), (3,16),
(4, 4), (4,17),
(5,18), (6,19),
(7,20), (7,21),
(8,22), (8,23),
(9,24), (9,25);

-- Cinema
INSERT INTO cinema (nomeFantasia, endereco, bairro, idCidade, capacidade) VALUES
('Cine Art Pelotas', 'Rua Andrade Neves, 1510', 'Centro', 1, 400),
('Cine Mart Pelotas', 'Rua Andrade Neves, 1511', 'Centro', 1, 300),
('Cine Part Pelotas', 'Rua Andrade Neves, 1512', 'Centro', 1, 250),
('Cineart', 'Avenida Edméia Matos Lazzarotti, 1655', 'Centro', 2, 400),
('Cine Art RG', 'Av Oswaldo Barros, 251', 'Centro', 3, 400),
('Cine Art PoA', 'Av das Nações, 665', 'Centro', 4, 700),
('Cine Freak PoA', 'Av das Monções, 667', 'Centro', 4, 500),
('Cine SP Center', 'Av Paulista, 1000', 'Paulista', 6, 500);

-- Sessao
INSERT INTO sessao (idCinema, idFilme, data, horaInicio, publico) VALUES
(1, 2, '2024-08-01', '16:00:00', 45),
(1, 2, '2024-08-01', '19:00:00', 80),
(1, 9, '2024-08-01', '21:30:00', 95),
(2, 1, '2024-08-01', '16:00:00', 38),
(2, 1, '2024-08-01', '19:00:00', 55),
(2, 8, '2024-08-01', '21:30:00', 110);

-- Usuario
INSERT INTO usuario (idCidade, nome, email) VALUES
(3, 'Edecius', 'compreolivro@javascript.com'),
(3, 'Mussum', 'cacildis@senacrs.com.br'),
(2, 'Angelis', 'angel@hotwheels.com'),
(1, 'Satolepis', 'pelotis@docis.com'),
(5, 'Senaquius', 'senaquinho@meuprecioso.com'),
(4, 'Gladimiris', 'ouniconormal@minecraft.com');

-- Tipo Pagamento
INSERT INTO tipoPagto (nome) VALUES
('A Vista'),
('Parcelado');

-- Venda
INSERT INTO venda (idSessao, idUsuario, data, hora, valorIngresso, idTipoPagto) VALUES
(2, 1, '2024-08-01', '16:00:00', 15.00, 1),
(4, 2, '2024-08-01', '16:00:00', 10.00, 2),
(4, 3, '2024-04-01', '16:00:00', 10.00, 2);
-- nova Venda ex2
(6, 1, '2024-08-01', '21:30:00', 10.00, 2),
(6, 2, '2024-08-01', '21:30:00', 10.00, 2),
(6, 3, '2024-08-01', '21:30:00', 10.00, 2),
(6, 4, '2024-08-01', '21:30:00', 10.00, 2);
-- nova Venda ex3
(5, 1, '2024-08-01', '19:00:00', 20.00, 1),
(5, 2, '2024-08-01', '19:00:00', 20.00, 1),
(5, 3, '2024-08-01', '19:00:00', 20.00, 1);


-- Parcela
INSERT INTO parcela (idVenda, valor, vencimento, situacao) VALUES
(2, 5.00, '2024-08-01', 'ABERTO'),
(2, 5.00, '2024-08-02', 'ABERTO'),
(2, 5.00, '2024-08-03', 'ABERTO'),
(3, 5.00, '2024-08-01', 'ABERTO');

/*1) Crie uma consulta que liste o nome do filme e o somatório do valor dos ingressos vendidos, 
considerando apenas as vendas com pagamento parcelado. Agrupe os resultados por filme.*/
SELECT tituloOriginal, SUM(valorIngresso) 
FROM filme f 
JOIN sessao s ON f.id = s.idFilme
JOIN venda v ON s.id = v.idSessao
WHERE idTipoPagto = 2
GROUP BY tituloOriginal;

/*2) Modifique a consulta anterior para listar apenas os filmes com mais de 3 ingressos vendidos. 
Utilize a cláusula HAVING para realizar o filtro.*/
SELECT tituloOriginal, SUM(valorIngresso) 
FROM filme f 
JOIN sessao s ON f.id = s.idFilme
JOIN venda v ON s.id = v.idSessao
WHERE idTipoPagto = 2
GROUP BY tituloOriginal
HAVING COUNT(idFilme) > 3;

/*3) Crie uma consulta para listar a quantidade de usuários que efetuaram compras à vista.*/
SELECT COUNT(idUsuario)
FROM venda
WHERE idTipoPagto = 1;

/*4) Modifique a consulta anterior para exibir o nome dos usuários 
e a quantidade total de compras à vista feitas por cada um.*/
SELECT nome, COUNT(idUsuario)
FROM usuario u
JOIN venda v ON u.id = v.idUsuario
WHERE idTipoPagto = 1
GROUP BY nome;

/*5) Crie uma stored procedure chamada alteraValorIngresso(valor) 
que altere o valor de todos os ingressos vendidos para o valor fornecido como parâmetro. 
Após a atualização, a procedure deve listar os ingressos afetados.*/
DELIMITER $$
CREATE PROCEDURE alteraValorIngresso(IN valor DOUBLE)
BEGIN
  UPDATE venda SET valorIngresso=valor;
  SELECT * FROM venda WHERE valorIngresso=valor;
END $$
DELIMITER ;

CALL alteraValorIngresso(50.00);

/*6) Crie uma stored procedure alteraSituacaoParcelas(idUsuario) 
que atualize a situação de todas as parcelas de um determinado usuário para "pagas". 
O id do usuário será recebido como parâmetro.*/
DELIMITER $$
CREATE PROCEDURE alteraSituacaoParcelas(IN valor_id_usuario INT)
BEGIN
  UPDATE parcela p
  JOIN venda v ON p.idVenda = v.id 
  SET situacao="pagas" 
  WHERE v.idUsuario = valor_id_usuario;
END $$
DELIMITER ;

CALL alteraSituacaoParcelas(2);

/*7) Crie uma stored procedure relVendas(idUsuario) que receba o id de um usuário 
e liste todas as parcelas associadas, juntamente com a situação de pagamento de cada uma.*/
DELIMITER $$
CREATE PROCEDURE relVendas(IN valor_id_usuario INT)
BEGIN
  SELECT idVenda, situacao
  FROM parcela p
  JOIN venda v ON p.idVenda = v.id
  WHERE v.idUsuario = valor_id_usuario;
END $$
DELIMITER ;

CALL relVendas(2);

/*8) Crie uma stored procedure visualizaVendas(tipoVenda) 
que receba um parâmetro (1 para à vista, 2 para parcelado) 
e retorne o somatório do valor das vendas para o tipo de pagamento selecionado.*/
DELIMITER $$
CREATE PROCEDURE visualizaVendas(IN tipo INT)
BEGIN
  IF tipo = 1 THEN
    SELECT SUM(valorIngresso) FROM venda WHERE idTipoPagto = 1;
  ELSE
    SELECT SUM(valorIngresso) FROM venda WHERE idTipoPagto = 2;
  END IF;
END $$
DELIMITER ;

CALL visualizaVendas(1);
CALL visualizaVendas(2);

/*9) Crie uma procedure que receba o nome de um ator 
e liste todos os filmes em que ele participou.*/
DELIMITER $$
CREATE PROCEDURE participacaoAtor(IN nome_Ator VARCHAR(45))
BEGIN
  SELECT tituloOriginal 
  FROM filme f
  JOIN elenco e ON f.id = e.idFilme
  JOIN ator a ON a.id = e.idAtor
  WHERE a.nome = nome_Ator;
END $$
DELIMITER ;

CALL participacaoAtor('Anne Hathaway');

/*10) Crie uma procedure que liste o nome dos atores 
que ainda não participaram de nenhum filme.*/
DELIMITER $$
CREATE PROCEDURE naoParticipacaoAtor()
BEGIN
  SELECT nome 
  FROM ator a
  LEFT JOIN elenco e ON a.id = e.idAtor
  WHERE e.idAtor IS NULL;
END $$
DELIMITER ;

CALL naoParticipacaoAtor()

/*11) Crie uma procedure que liste o título e o gênero de todos os filmes 
que ainda não foram exibidos em nenhuma sessão de cinema.*/
DELIMITER $$
CREATE PROCEDURE naoExibidos()
BEGIN
  SELECT tituloOriginal, nome
  FROM genero g
  JOIN filme f ON g.id = f.idGenero
  LEFT JOIN sessao s ON f.id = s.idFilme
  WHERE s.idFilme IS NULL;
END $$
DELIMITER ;

CALL naoExibidos();

/*12) Crie uma procedure que receba o nome de uma cidade como parâmetro 
e liste todos os cinemas localizados nesta cidade.*/
DELIMITER $$
CREATE PROCEDURE cidadeCinema(IN nome_Cidade VARCHAR(45))
BEGIN
  SELECT nomeFantasia 
  FROM cinema cin
  JOIN cidade cid ON cid.id = cin.idCidade
  WHERE nome = nome_Cidade;
END $$
DELIMITER ;

CALL cidadeCinema('Pelotas');

/*13) Crie uma procedure que receba dois parâmetros (gênero atual e gênero novo) 
e altere o gênero de todos os filmes que correspondam ao gênero atual para o novo gênero informado.*/
DELIMITER $$
CREATE PROCEDURE novoGenero(IN genero_Atual VARCHAR(45), IN genero_novo VARCHAR(45))
BEGIN
  UPDATE genero SET nome=genero_novo WHERE nome=genero_Atual;
END $$
DELIMITER ;

CALL novoGenero('Ficção', 'Ficção-Científica');

/*14) Crie uma consulta para listar o título e a duração dos filmes 
de um determinado gênero lançados após uma data específica. 
Receba o nome do gênero e a data como parâmetros.*/
DELIMITER $$
CREATE PROCEDURE específica(IN genero_Nome VARCHAR(45), IN data_Info DATE)
BEGIN
  SELECT DISTINCT tituloOriginal, duracao
  FROM filme f
  JOIN genero g ON f.idGenero = g.id
  JOIN sessao s ON f.id = s.idFilme
  WHERE nome = genero_Nome 
  AND data > data_Info;
END $$
DELIMITER ;

CALL específica('Drama', '2000-03-01');

/*15) Crie uma consulta que liste todas as sessões 
onde a ocupação do público foi superior a 80% da capacidade do cinema.*/
DELIMITER $$
CREATE PROCEDURE ocupaçãoPublico()
BEGIN
  SELECT * 
  FROM sessao s
  JOIN cinema c ON s.idCinema = c.id
  WHERE publico > (80 * capacidade) / 100;
END $$
DELIMITER ;

CALL ocupaçãoPublico()

-- Obs.: Se for necessário crie os registros de inserção para testar as consultas solicitadas.
