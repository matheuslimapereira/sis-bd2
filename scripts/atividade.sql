CREATE TABLE autor( nome VARCHAR(50) PRIMARY KEY,
					nascimento DATE,
                    livro VARCHAR(80)
                    );


CREATE TABLE livros( livro_id int auto_increment primary key,
					nome_livro VARCHAR(80),
					autor_livro VARCHAR(50) NOT NULL,
                    categoria_livro VARCHAR(50),
                    data_livro DATE,
                    CONSTRAINT autor_fk FOREIGN KEY(autor_livro) REFERENCES autor (nome)
                    );
        
        SELECT *
FROM livros;
                    
                    
INSERT INTO autor VALUES( 'Antoine de Saint-Exupéry',
						   STR_TO_DATE('29/06/1900', '%d/%m/%Y'),
                           'O Pequeno Príncipe'
                           );
                           
INSERT INTO autor VALUES( 'Teste do autor',
						   STR_TO_DATE('31/07/1988', '%d/%m/%Y'),
                           'O Lendário'
                           );

INSERT INTO livros VALUES( 1,
							'Teste do livro',
						   'Antoine de Saint-Exupéry',
                           'Suspense',
                           STR_TO_DATE('10/12/2001', '%d/%m/%Y')
                           );

INSERT INTO livros VALUES( 2,
							'Três porquinhos',
						   'Teste do autor',
                           'Infantil',
                           STR_TO_DATE('17/05/1998', '%d/%m/%Y')
                           );     
                           

                           
CREATE TABLE leitor( leitor_id int auto_increment primary key,
					leitor_nome VARCHAR(50) NOT NULL,
                    leitor_local VARCHAR(50)
                    );
                    
CREATE TABLE leitura( quemleu INT NOT NULL,
					CONSTRAINT quemleu_fk FOREIGN KEY(quemleu) REFERENCES leitor(leitor_id),
                     quallivro INT NOT NULL,
					CONSTRAINT quallivro_fk FOREIGN KEY(quallivro) REFERENCES livros (livro_id),
					 inicio_leitura DATE,
                     fim_leitura DATE,
                     classificacao INT,
                     comentario VARCHAR(100)
                    );
                    
CREATE TABLE amizade (leitor_id INT,
					  amigo_id INT,
                      CONSTRAINT leitor_id_amizade_fk foreign key (leitor_id) references leitor (leitor_id),
                      CONSTRAINT amigo_id_amizade_fk foreign key (amigo_id) references leitor (leitor_id)
                      );


INSERT INTO leitor VALUES( 1,
						   'Juca',
                           'Farroupilha'
                           );  
                           
INSERT INTO leitor VALUES( 2,
						   'Cesar',
                           'Caxias do Sul'
                           ); 
                           
INSERT INTO leitor VALUES( 3,
						   'Carlos',
                           'Bento Gonçalvez'
                           ); 
                           
INSERT INTO leitura VALUES( 1,
						    2,
                           STR_TO_DATE('31/07/2021', '%d/%m/%Y'),
                           STR_TO_DATE('15/08/2021', '%d/%m/%Y'),
                           5,
                           'Livro legal, recomendo!'
                           );  
                           
INSERT INTO leitura VALUES( 2,
						    1,
                           STR_TO_DATE('21/02/2022', '%d/%m/%Y'),
                           STR_TO_DATE('08/03/2022', '%d/%m/%Y'),
                           5,
                           'Um livro bom para ler antes de dormir'
                           );
				
INSERT INTO amizade VALUES( 1,
						    2
                           );
                           
INSERT INTO amizade VALUES( 1,
						    3
                           );
                           
                           select * from leitura;
                           select * from leitor;
                           select * from amizade;
                           
                           
#Criando uma view com group by

CREATE VIEW livro_view AS
SELECT *
  FROM livros
 WHERE nome_livro = 'Três porquinhos'
 GROUP BY nome_livro;
                           
#Função para retornar nome do livro com o id

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION RETORNA_LIVROS_ID(id INT)
RETURNS VARCHAR(80) 
BEGIN
   RETURN (SELECT nome_livro FROM livros WHERE livro_id = id);
END//
DELIMITER ;

DROP FUNCTION RETORNA_LIVROS_ID;

SELECT RETORNA_LIVROS_ID(1);


#Criando uma trigger - OBS: Criei novas tabelas pois não consegui achar funcionalidade nas tabelas do projeto original

CREATE TABLE Produtos
(
	Referencia	VARCHAR(3) PRIMARY KEY,
	Descricao	VARCHAR(50) UNIQUE,
	Estoque	INT NOT NULL DEFAULT 0
);

INSERT INTO Produtos VALUES ('001', 'Leite', 10);
INSERT INTO Produtos VALUES ('002', 'Feijão', 5);
INSERT INTO Produtos VALUES ('003', 'Açucar', 15);

CREATE TABLE ItensVenda
(
	Venda		INT,
	Produto	VARCHAR(3),
	Quantidade	INT
);

DELIMITER $

CREATE TRIGGER Tgr_Livros_Insert AFTER INSERT
ON ItensVenda
FOR EACH ROW
BEGIN
	UPDATE livros SET Estoque = Estoque - NEW.Quantidade
WHERE nome_livro = NEW.livros;
END$

CREATE TRIGGER Tgr_ItensVenda_Delete AFTER DELETE
ON ItensVenda
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Estoque = Estoque + OLD.Quantidade
WHERE Referencia = OLD.Produto;
END$

DELIMITER ;

#Criando EVENT
                           
SET GLOBAL event_scheduler = ON;

CREATE EVENT id_livros_event
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 10 SECOND
    DO
      UPDATE euk_event SET status=2 WHERE livro_id=1;     
      

#CRIANDO UM PROCEDURE - Sem usabilidade no projeto :(
   
DELIMITER //                           

CREATE PROCEDURE REPETIR( limite INT)
BEGIN
   SET @x = 0;
   
   REPEAT 
      SET @x = @x + 1;
   
   UNTIL @x > limite
   END REPEAT;
END//

CALL REPETIR( 10 )//

SELECT @x//

DROP PROCEDURE REPETIR//




CREATE PROCEDURE REPETIR( limite INT )
BEGIN
   SET @x = 0;
   REPEAT SET @x = @x + 1;
   UNTIL @x > limite END REPEAT;
   
   SELECT @x;
END//


CALL REPETIR(10)//

DROP PROCEDURE REPETIR//

CREATE PROCEDURE REPETIR( limite INT )
BEGIN
   SET @x = 0;
   REPEAT SET @x = @x + 1;
   UNTIL @x > limite END REPEAT;
   
   SELECT @x;
   
   SELECT 'BANCO DE DADOS II';
   
END//

CALL REPETIR(10)//

SELECT @x//
                           