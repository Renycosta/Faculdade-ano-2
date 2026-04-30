DROP SCHEMA IF EXISTS aula09;
CREATE SCHEMA aula09;
USE aula09;

CREATE TABLE aluno (
    id INT NOT NULL AUTO_INCREMENT, 
    nome_aluno VARCHAR(150) NOT NULL, 
    email VARCHAR(150) NOT NULL, 
    data_cadastro DATE,
    PRIMARY KEY (id)
);

CREATE TABLE curso (
    id INT NOT NULL AUTO_INCREMENT, 
    nome_curso VARCHAR(150) NOT NULL, 
    instrutor VARCHAR(100), 
    carga_horaria INT,
    PRIMARY KEY (id)
);

CREATE TABLE inscricao (
    id INT NOT NULL AUTO_INCREMENT, 
    data_inscricao TIMESTAMP, 
    status VARCHAR(20),  
    id_aluno INT,  
    id_curso INT,  
    PRIMARY KEY (id),
    CONSTRAINT fk_inscricao_aluno FOREIGN KEY (id_aluno) REFERENCES aluno (id),
    CONSTRAINT fk_inscricao_curso FOREIGN KEY (id_curso) REFERENCES curso (id)
);

CREATE TABLE log_inscricao (
    id INT NOT NULL AUTO_INCREMENT,
    id_inscricao_ref INT,
    acao_realizada VARCHAR(45),
    data_log TIMESTAMP,
    PRIMARY KEY (id)
);

-- 1.
-- a. Insira pelo menos 8 novos cursos na tabela curso. 
INSERT INTO curso (nome_curso, instrutor, carga_horaria) VALUES
('Fundamentos de SQL', 'Renato Garcia', 40),
('Desenvolvimento Web Moderno', 'Ana Clara Silva', 120),
('Python para Ciência de Dados', 'Marcos Oliveira', 80),
('Segurança da Informação', 'Patrícia Souza', 60),
('UX/UI Design na Prática', 'Beatriz Mello', 45),
('Arquitetura de Microserviços', 'Jorge Henrique', 90),
('Gestão de Projetos Ágeis', 'Mariana Freitas', 30),
('Inteligência Artificial e Machine Learning', 'Ricardo Santos', 150);

-- b. Insira pelo menos 15 novos alunos na tabela aluno
INSERT INTO aluno (nome_aluno, email, data_cadastro) VALUES
('Ana Beatriz Silva', 'ana.beatriz@email.com', '2026-01-15'),
('Lucas Henrique Oliveira', 'lucas.oliveira@provedor.com', '2026-01-20'),
('Mariana Costa Souza', 'mari.costa@email.com', '2026-02-05'),
('Gabriel Santos Lima', 'gabriel.slima@servidor.net', '2026-02-12'),
('Juliana Paiva Rocha', 'ju.paiva@email.com', '2026-02-28'),
('Ricardo Augusto Pereira', 'ricardo.augusto@webmail.com', '2026-03-02'),
('Camila Fernanda Melo', 'camila.melo@email.com', '2026-03-10'),
('Felipe Dantas Borges', 'felipe.dantas@provedor.com', '2026-03-15'),
('Beatriz Martins Fachini', 'bea.martins@email.com', '2026-03-22'),
('Thiago de Almeida Portos', 'thiago.portos@servidor.net', '2026-04-01'),
('Larissa Vieira Gomes', 'larissa.gomes@email.com', '2026-04-05'),
('Rodrigo Mendes Carvalho', 'rodrigo.mendes@webmail.com', '2026-04-12'),
('Letícia Barbosa Freitas', 'leticia.freitas@email.com', '2026-04-18'),
('Bruno Eduardo Xavier', 'bruno.xavier@provedor.com', '2026-04-25'),
('Isabela Cristina Nucci', 'isabela.nucci@email.com', '2026-04-29');

INSERT INTO inscricao (data_inscricao, status, id_aluno, id_curso) VALUES 
(CURRENT_TIMESTAMP, 'Ativo', 1, 1),
(CURRENT_TIMESTAMP, 'Ativo', 2, 1),
(CURRENT_TIMESTAMP, 'Concluído', 3, 2),
(CURRENT_TIMESTAMP, 'Ativo', 4, 3),
(CURRENT_TIMESTAMP, 'Cancelado', 5, 2),
(CURRENT_TIMESTAMP, 'Ativo', 6, 8),
(CURRENT_TIMESTAMP, 'Pendente', 7, 4),
(CURRENT_TIMESTAMP, 'Ativo', 8, 5),
(CURRENT_TIMESTAMP, 'Concluído', 9, 7),
(CURRENT_TIMESTAMP, 'Ativo', 10, 6);

-- 2.
-- a. Escreva um comando para atualizar o instrutor do curso com id = 1 para "Prof. Gladimir"
UPDATE curso SET instrutor='Prof. Gladimir' WHERE id=1;

-- b. Selecione o nome dos alunos (nome_aluno) e o nome dos cursos em que eles estão inscritos, mostrando apenas as inscrições da tabela inscricao com status 'ativa'.
SELECT nome_aluno, nome_curso
FROM inscricao i 
JOIN aluno a ON i.id_aluno = a.id
JOIN curso c ON i.id_curso = c.id
WHERE status = 'Ativo';

-- 3. Crie uma PROCEDURE chamada realizar_inscricao(aluno_id INT, curso_id INT) que receba o ID de um aluno e de um curso e insira um novo registro na tabela inscricao.
DELIMITER $$
CREATE PROCEDURE realizar_inscricao(IN aluno_id INT, IN curso_id INT)
BEGIN
    INSERT INTO inscricao (id_aluno, id_curso) VALUES
    (aluno_id, curso_id);
END $$
DELIMITER ;

CALL realizar_inscricao(5, 1);

-- 4. Crie um TRIGGER chamado log_nova_inscricao que, após cada INSERT na tabela inscricao, insira um registro na tabela log_inscricao. O log deve conter o ID da nova inscrição (no campo id_inscricao_ref) e a ação "NOVA INSCRIÇÃO REALIZADA".
DELIMITER $$
CREATE TRIGGER log_nova_inscrica
AFTER INSERT
ON inscricao
FOR EACH ROW
BEGIN
    INSERT INTO log_inscricao (id_inscricao_ref, acao_realizada)
    VALUES (NEW.id, 'NOVA INSCRIÇÃO REALIZADA');
END $$
DELIMITER ;

INSERT INTO inscricao (data_inscricao, status, id_aluno, id_curso) VALUES 
(CURRENT_TIMESTAMP, 'Ativo', 2, 2);

-- 5. Crie uma VIEW chamada v_inscricoes_detalhadas que exiba o nome do aluno (nome_aluno), o email, o nome do curso e a data da inscrição.
CREATE VIEW v_inscricoes_detalhadas AS
SELECT nome_aluno, email, nome_curso, data_inscricao
FROM inscricao i 
JOIN aluno a ON i.id_aluno = a.id
JOIN curso c ON i.id_curso = c.id;

SELECT * FROM v_inscricoes_detalhadas;

-- 6. Utilizando controle de transação (START TRANSACTION, COMMIT, ROLLBACK), execute os seguintes passos: 
-- a. Inicie uma transação
SET autocommit = 0;
START TRANSACTION;

-- b. Insira uma nova inscricao para o aluno de id = 2 no curso de id = 3.
INSERT INTO inscricao (data_inscricao, status, id_aluno, id_curso) VALUES 
(CURRENT_TIMESTAMP, 'Ativo', 2, 3);

-- c. Atualize o status dessa mesma inscricao para 'concluída'.
UPDATE inscricao SET status='concluída' WHERE id_aluno = 2 and id_curso = 3;

-- d. Se ambos os comandos forem bem-sucedidos, confirme a transação. Caso contrário, reverta todas as alterações.
COMMIT;

-- 7. Crie uma consulta que conte quantas inscrições cada curso possui. O resultado deve exibir o nome do curso e o total de alunos inscritos, ordenados do curso com mais alunos para o com menos.
SELECT nome_curso, COUNT(id_aluno)
FROM inscricao i 
JOIN aluno a ON i.id_aluno = a.id
JOIN curso c ON i.id_curso = c.id
GROUP BY nome_curso
ORDER BY COUNT(id_aluno);

-- 8. Crie uma consulta que liste todos os cursos e a quantidade de alunos inscritos em cada um. A consulta deve incluir também os cursos que não possuem nenhum aluno inscrito (mostrando o valor '0' como total). Utilize LEFT JOIN para garantir que todos os cursos da tabela curso apareçam no resultado
SELECT nome_curso, COUNT(id_aluno)
FROM inscricao i 
JOIN aluno a ON i.id_aluno = a.id
RIGHT JOIN curso c ON i.id_curso = c.id
GROUP BY nome_curso
ORDER BY COUNT(id_aluno);

-- 9. Crie um TRIGGER chamado log_alteracao_status que seja acionado após cada UPDATE na coluna status da tabela inscricao. Este TRIGGER deve registrar a mudança na tabela log_inscricao. O registro de log deve conter:
-- • O ID da inscrição afetada (no campo id_inscricao_ref).
-- • A descrição da ação "STATUS ALTERADO PARA [NOVO STATUS]", onde [NOVO STATUS] é o valor da coluna status após a atualização.
DELIMITER $$
CREATE TRIGGER log_alteracao_status
AFTER UPDATE
ON inscricao
FOR EACH ROW
BEGIN
    INSERT INTO log_inscricao (id_inscricao_ref, acao_realizada)
    VALUES (NEW.id, CONCAT('STATUS ALTERADO PARA ', NEW.status));
END $$
DELIMITER ;

INSERT INTO inscricao (data_inscricao, status, id_aluno, id_curso) VALUES 
(CURRENT_TIMESTAMP, 'a', 1, 3);
UPDATE inscricao SET status = 'Concluído' WHERE status = 'a';

-- 10. Crie um TRIGGER chamado definir_status_padrao que seja acionado ANTES de cada INSERT na tabela inscricao. A função deste TRIGGER é garantir que, se a coluna status não for fornecida (ou for NULL) durante a inserção, ela seja automaticamente preenchida com o valor padrão 'pendente'
DELIMITER $$
CREATE TRIGGER definir_status_padrao
BEFORE INSERT
ON inscricao
FOR EACH ROW
BEGIN
    IF NEW.status = '' OR NEW.status IS NULL THEN
        SET NEW.status = 'pendente';
    END IF;
END $$
DELIMITER ;

INSERT INTO inscricao (id_aluno, id_curso) VALUES 
(2, 7);