CREATE DATABASE projetoIndividual;
USE projetoIndividual;


CREATE TABLE tbUsuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(200)NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL
);

CREATE TABLE tbQuiz (
	idQuiz INT PRIMARY KEY AUTO_INCREMENT,
    dataInicio DATETIME NOT NULL
);

CREATE TABLE tbMetrica (
	idMetrica INT AUTO_INCREMENT, 
    fkUsuario INT NOT NULL, CONSTRAINT metricaUsuario FOREIGN KEY (fkUsuario) REFERENCES tbUsuario (idUsuario),
    fkQuiz INT NOT NULL, CONSTRAINT metricaQuiz FOREIGN KEY (fkQuiz) REFERENCES tbQuiz (idQuiz),
    acertos INT NOT NULL,
    erros INT NOT NULL,
    PRIMARY KEY (idMetrica, fkUsuario, fkQuiz)
);

-- -----------------------------------SELECT PADRÃO

SELECT * FROM tbUsuario;
SELECT * FROM tbQuiz;
SELECT * FROM tbMetrica;

-- -----------------------------------SELECTS DA API

-- RANKING
SELECT tbUsuario.nome, fkQuiz, DATE_FORMAT(dataInicio, '%d/%m/%Y %H:%i:%s') AS 'Data', acertos FROM tbMetrica 
	join tbUsuario 
	on idUsuario = fkUsuario
		join tbQuiz
        on idQuiz = fkQuiz
			ORDER BY acertos desc, Data DESC;
   
   
-- PROGRESSO            
            
SELECT acertos FROM tbMetrica WHERE fkUsuario = 1 ORDER BY acertos DESC LIMIT 7;


-- RESULTADO QUIZ
            
SELECT * FROM tbMetrica WHERE fkUsuario = 1 and fkQuiz = (SELECT MAX(fkQuiz) FROM tbMetrica WHERE fkUsuario = 1);
