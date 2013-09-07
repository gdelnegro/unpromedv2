-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.1.33-community - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-08-31 11:44:48
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for desenvolvimento_prog
CREATE DATABASE IF NOT EXISTS `desenvolvimento_prog` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `desenvolvimento_prog`;


-- Dumping structure for procedure desenvolvimento_prog.prc_cl_grupo_acesso
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_cl_grupo_acesso`(
                                      p_acao                   int    (10),
                                      p_id_grupo	        int    (10),
                                      p_desc_grupo   		varchar (50),
                                      p_id_usu_sis		int    (10),
                                      p_dt_inclusao		date,
                                      p_dt_alteracao		date,
                                      p_flg_status_grupo_acesso	boolean,
                                      p_desc_nome		varchar (50),
                                      p_flg_tipo_usuario	boolean
                                      )
begin
        if (p_acao = 0) THEN     
        begin
                if     (SELECT @a:=(SELECT MAX(id_grupo)+1 FROM tb_grupo_acesso)) THEN
				INSERT INTO tb_grupo_acesso
				(								
				id_grupo,
				desc_grupo,
				id_usu_sis,
				dt_inclusao,
				dt_alteracao,
				flg_status_grupo_acesso,
				desc_nome,
				flg_tipo_usuario
				)
				VALUES
				(
				@a,
				p_desc_grupo,
				p_id_usu_sis,
				p_dt_inclusao,
				p_dt_alteracao,
				p_flg_status_grupo_acesso,
				p_desc_nome,
				p_flg_tipo_usuario				
			        );   
			       
	       ELSE	
	                       (SELECT @a:=(IFNULL(MAX(id_grupo),1))FROM tb_grupo_acesso);
				INSERT INTO tb_grupo_acesso
				(
				id_grupo,
				desc_grupo,
				id_usu_sis,
				dt_inclusao,
				dt_alteracao,
				flg_status_grupo_acesso,
				desc_nome,
				flg_tipo_usuario
				)
				VALUES
				(
				@a,                                 
				p_desc_grupo,
				p_id_usu_sis,
				p_dt_inclusao,
				p_dt_alteracao,
				p_flg_status_grupo_acesso,
				p_desc_nome,
				p_flg_tipo_usuario
				);
				
			END IF;
		END;
	ELSEIF (p_acao=1) THEN	
	        BEGIN 	
	                  UPDATE tb_grupo_acesso
	                  SET     
	                                                
				desc_grupo=                     p_desc_grupo,
				id_usu_sis=                     p_id_usu_sis,
				dt_inclusao=                    p_dt_inclusao,
				dt_alteracao=                   p_dt_alteracao,
				desc_nome=                      p_desc_nome
			WHERE   id_grupo=                	p_id_grupo;
			
			END;	
	             ELSEIF (p_acao=2) THEN         
                             BEGIN
                                       UPDATE tb_grupo_acesso
                                       SET    flg_status_grupo_acesso=	p_flg_status_grupo_acesso,
						flg_tipo_usuario=	p_flg_tipo_usuario
                                       WHERE  id_grupo   = p_id_grupo;
                             END;
       ELSE 
                             BEGIN
                                       SELECT     
                                       
                                                         
                                      id_grupo,		
                                      desc_grupo,   		
                                      id_usu_sis,		
                                      dt_inclusao,		
                                      dt_alteracao,		
                                      flg_status_grupo_acesso,	
                                      desc_nome,
		                      flg_tipo_usuario
		                 from tb_grupo_acesso
		                 where id_grupo= p_id_grupo;
                       
                       
                       END;
                       
                END IF;
                
END//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_acesso_operacao
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_acesso_operacao`(
					p_acao						INT(10),
					p_id_perfil					INT(10),
					p_tb_operacao_sistema_id_operacao_sistema	INT(10),
					p_tb_acao_id_acao				INT(10),
					p_tb_perfil_acesso_id_perfil			INT(10),
					p_dt_inclusao					DATE,
					p_dt_alteracao					DATE,
					p_flg_status_acesso_operacao			BOOLEAN
					)
BEGIN
	IF	(p_acao = 0) THEN 
		BEGIN
			IF	(SELECT @a:=(SELECT MAX(id_perfil)+1 FROM tb_acesso_operacao)) THEN
				INSERT INTO tb_acesso_operacao
				(
				id_perfil,
				tb_operacao_sistema_id_operacao_sistema,
				tb_acao_id_acao,
				tb_perfil_acesso_id_perfil,
				dt_inclusao,
				dt_alteracao,
				flg_status_acesso_operacao
				)
				VALUES
				(
				@a,
				p_tb_operacao_sistema_id_operacao_sistema,
				p_tb_acao_id_acao,
				p_tb_perfil_acesso_id_perfil,			
				p_dt_inclusao,
				p_dt_alteracao,	
				p_flg_status_acesso_operacao
				);
			ELSE
				(SELECT @a:=(IFNULL(MAX(id_perfil),1))FROM tb_acesso_operacao);
				INSERT INTO tb_acesso_operacao
				(
				id_perfil,
				tb_operacao_sistema_id_operacao_sistema,
				tb_acao_id_acao,
				tb_perfil_acesso_id_perfil,
				dt_inclusao,
				dt_alteracao,
				flg_status_acesso_operacao
				)
				VALUES
				(
				@a,
				p_tb_operacao_sistema_id_operacao_sistema,
				p_tb_acao_id_acao,
				p_tb_perfil_acesso_id_perfil,			
				p_dt_inclusao,
				p_dt_alteracao,	
				p_flg_status_acesso_operacao
				);
			END IF;
		END;
	ELSEIF (p_acao=1) THEN
		BEGIN 
			UPDATE tb_acesso_operacao
			SET
				tb_operacao_sistema_id_operacao_sistema	=	p_tb_operacao_sistema_id_operacao_sistema,
				tb_acao_id_acao				=	p_tb_acao_id_acao,
				tb_perfil_acesso_id_perfil		=	p_tb_perfil_acesso_id_perfil,	
				dt_inclusao				=	p_dt_inclusao,
				dt_alteracao				=	p_dt_alteracao
			WHERE 	id_perfil	= p_id_perfil;
			END;
	ELSEIF (p_acao=2) THEN
		BEGIN
			UPDATE tb_acesso_operacao
			SET flg_status_acesso_operacao		=	p_flg_status_acesso_operacao
			WHERE id_perfil 			= p_id_perfil;
		END;
	ELSE 
		BEGIN
			SELECT 	id_perfil,
				tb_operacao_sistema_id_operacao_sistema,
				tb_acao_id_acao,
				tb_perfil_acesso_id_perfil,
				dt_inclusao,
				dt_alteracao,
				flg_status_acesso_operacao
			FROM 	tb_acesso_operacao
			WHERE 	id_perfil = p_id_perfil;
		END;
	END IF;
END//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_campus
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_campus`(
				p_acao		INT(10),
				p_id_campus	INT(10),
				p_nom_campus	VARCHAR(45)
				)
BEGIN
	IF (p_acao = 0) THEN
		BEGIN
			IF (SELECT @a:=(SELECT MAX(id_campus)+1 FROM tb_campus)) THEN
			INSERT INTO tb_campus
			(
			id_campus,
			nom_campus
			)
			VALUES
			(
			@a,
			p_nom_campus
			);
			ELSE (SELECT @a:=(IFNULL (MAX(id_campus),1) ) FROM tb_campus);
			INSERT INTO tb_campus
			(
			id_campus,
			nom_campus
			)
			VALUES
			(
			@a,
			p_nom_campus
			);
			END IF;
		END;
	ELSeIF (p_acao = 1) THEN
		BEGIN
			UPDATE tb_campus
			SET 
			nom_campus =	p_nom_campus
			WHERE id_campus = p_id_campus;
		END;
	ELSE
		BEGIN
			DELETE FROM tb_campus
			WHERE id_campus = p_id_campus;
		END;
	END IF;
END//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_contato
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_contato`(
					p_acao		int(10),					
					p_id_contato	int(10),
					p_nome_recado	varchar(45),
					p_email		varchar(45)
					)
begin
	if (p_acao = 0) then
		begin
			if (select @a:=(SELECT MAX (id_contato)+1 FROM tb_contato)) THEN
				insert into tb_contato
				(
				id_contato,
				nome_recado,
				email
				)
				values
				(
				@a,
				p_nome_recado,
				p_email
				);
			else (SELECT @a:=(IFNULL (MAX(id_contato),1) ) FROM tb_contato);
				INSERT INTO tb_contato
				(
				id_contato,
				nome_recado,
				email
				)
				VALUES
				(
				@a,
				p_nome_recado,
				p_email
				);
			end if;
		end;
	elseif (p_acao = 1) then
		begin
			UPDATE tb_contato
			SET 
			nome_recado =	p_nome_recado,
			email	=	p_email
			where id_contato = p_id_contato;
		end;
	else
		begin 
			delete from tb_contato
			where id_contato =	p_id_contato;
		end;
	end if;
end//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_pais
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_pais`(
 p_acao                  INT(10),
 p_id_pais		 INT(10),
 p_nom_pais              VARCHAR(75),
 p_abv_pais              char(4)
 )
BEGIN
IF    	(p_acao = 0) THEN
BEGIN
  if (select @a:=(select max(id_pais)+1 from tb_pais)) then
  INSERT INTO tb_pais(
  id_pais,
  nom_pais,
  abv_pais
  )
VALUES
  (
  @a,
  p_nom_pais,
  p_abv_pais
  );
end if;
END;
           ELSEIF (p_acao = 1) THEN
   BEGIN
  UPDATE tb_pais
  SET
  id_pais    =    p_id_pais,
  nom_pais   =    p_nom_pais,
  abv_pais   =	  p_abv_pais;
END;
  ELSE
BEGIN
			DELETE FROM  tb_pais
			WHERE id_pais   =      p_id_pais;
		END;
     END IF;
 END//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_perfil_acesso
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_perfil_acesso`(
				p_acao				int(10),
				p_id_perfil_acesso		int(10),
				p_desc_perfil			varchar(50), 
				p_dt_inclusao	        	date,
				p_dt_alteracao	        	date,
				p_flg_status_perfil_acess0	boolean
				)
BEGIN

if       (p_acao = 1) then
	begin
		if      (select @a:=(select max(id_perfil_acesso)+1 from tb_perfil_acesso)) then
			insert into tb_perfil_acesso
			(
			id_perfil_acesso,
			desc_perfil,
			dt_inclusao,
			dt_alteracao,
			flg_status_perfil_acesso    
			)
			values
			(
			@a,	
			p_id_perfil_acesso,
                        p_desc_perfil,
			p_dt_inclusao,
			p_dt_alteracao,
			p_flg_status_perfil_acesso
			);

		else    (select @a=(ifnull(max(id_perfil_acesso),1))from tb_perfil_acesso);
			insert into tb_perfil_acesso
			(
			id_perfil_acesso,
			desc_perfil,
			dt_inclusao,
			dt_alteracao,
			flg_status_perfil_acesso
			)
			values
			(
			@a,
			p_id_perfil_acesso,
                        p_desc_perfil,
			p_dt_inclusao,
			p_dt_alteracao,
			p_flg_status_perfil_acesso
			);
		end if;
		end;
	elseif   (p_acao = 2) then
		begin
			update tb_perfil_acesso
                        set     
                        desc_perfil                =      p_desc_perfil,
                        dt_inclusao                =      p_dt_inclusao,
                        dt_alteracao               =      p_dt_alteracao,
                        flg_status_perfil_acesso   =      p_flg_status_perfil_acesso
                        where id_perfil_acesso     =      p_id_perfil_acesso;
		end;
	else
		begin
			delete from tb_perfil_acesso 
			where id_perfil_acesso    =      p_id_perfil_acesso;
		end;
	end if;
end//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_perfil_grupo
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_perfil_grupo`(
 p_acao                         int,
 p_grupo_acesso_id_grupo        int,
 p_tb_perfil_acesso_id_perfil   int,
 p_dt_inclusao                  date,
 p_dt_alteracao                 date,
 p_status                       boolean
 )
BEGIN
IF       (p_acao = 1) THEN
BEGIN
   insert into tb_perfil_grupo(
  grupo_acesso_id_grupo,  
  tb_perfil_acesso_id_perfil,
  dt_inclusao,
  dt_alteracao,
  status  
  )
  values   
  (
  @a,
  p_grupo_acesso_id_grupo,  
  p_tb_perfil_acesso_id_perfil,
  p_dt_inclusao,
  p_dt_alteracao,
  p_status      
 );
		END;
	ELSEIF   (p_acao = 2) THEN
begin 
   update tb_perfil_grupo
     set
        grupo_acesso_id_grupo           =   p_grupo_acesso_id_grupo,
        tb_perfil_acesso_id_perfil      =   p_tb_perfil_acesso_id_perfil,
	dt_inclusao                     =   p_dt_inclusao,
	dt_alteracao                    =   p_dt_alteracao,
	status                          =   p_status;
  end;
	END IF;
END//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_profissao
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_profissao`(
 p_acao                  INT(10),
 p_id_profissao		 INT(10),
 p_nom_profissao         VARCHAR(45)
 )
BEGIN
IF    	(p_acao = 0) THEN
BEGIN
  if (select @a:=(select max(id_profissao)+1 from tb_profissao)) then
  INSERT INTO tb_profissao(
  id_profissao,
  nom_profissao
  )
  VALUES
  (
  @a,
  p_nom_profissao
  );
end if;
END;
           ELSEIF (p_acao = 1) THEN
   BEGIN
  UPDATE tb_profissao
  SET
  id_profissao    =    p_id_profissao,
  nom_profissao   =    p_nom_profissao;
END;
  ELSE
		BEGIN
			DELETE FROM  tb_profissao 
			WHERE id_profissao    =      p_id_profissao;
		END;
     END IF;
 END//
DELIMITER ;


-- Dumping structure for procedure desenvolvimento_prog.prc_tb_veiculo
DELIMITER //
CREATE DEFINER=`unpromed`@`%` PROCEDURE `prc_tb_veiculo`(
 p_acao				INT(10),
 p_id_veiculo			INT(10),
 p_des_placa_veiculo		VARCHAR(7),
 p_desc_tipo			VARCHAR(75),
 p_flg_veiculo_adaptado		BOOLEAN
 )
BEGIN
  IF      (p_acao = 0) THEN
BEGIN
  IF (SELECT @a:=(SELECT MAX(id_veiculo)+1 FROM tb_veiculo)) THEN
  INSERT INTO tb_veiculo(
  id_veiculo,
  des_placa_veiculo,
  desc_tipo,
  flg_veiculo_adaptado
  )
  VALUES
  (
  @a,
  p_des_placa_veiculo,		
  p_desc_tipo,			
  p_flg_veiculo_adaptado	
  );
  END IF;
END;
  ELSEIF (p_acao = 1) THEN
BEGIN
  UPDATE tb_veiculo
  SET
  id_veiculo           =     p_id_veiculo,
  des_placa_veiculo    =     p_placa_veiculo,
  des_tipo             =     p_desc_tipo,
  flg_veiculo_adaptado =     p_flg_veiculo_adaptado
  WHERE id_veiculo     =     p_id_veiculo;
END;
  ELSE
BEGIN
  DELETE FROM tb_veiculo
  WHERE id_veiculo;
END;
END IF;
END//
DELIMITER ;


-- Dumping structure for table desenvolvimento_prog.tb_acao
CREATE TABLE IF NOT EXISTS `tb_acao` (
  `id_acao` int(11) NOT NULL,
  `desc_acao` varchar(45) DEFAULT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `flg_status_acao` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_acao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_acao: ~0 rows (approximately)
DELETE FROM `tb_acao`;
/*!40000 ALTER TABLE `tb_acao` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_acao` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_acessa_log
CREATE TABLE IF NOT EXISTS `tb_acessa_log` (
  `dt_hora` date NOT NULL,
  `desc_acao` int(11) DEFAULT NULL,
  `id_usu_afetado` int(11) DEFAULT NULL,
  `id_log` int(11) DEFAULT NULL,
  PRIMARY KEY (`dt_hora`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_acessa_log: ~0 rows (approximately)
DELETE FROM `tb_acessa_log`;
/*!40000 ALTER TABLE `tb_acessa_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_acessa_log` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_acesso_operacao
CREATE TABLE IF NOT EXISTS `tb_acesso_operacao` (
  `id_perfil` int(11) NOT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `flg_status_acesso_operacao` tinyint(1) DEFAULT NULL,
  `tb_perfil_acesso_id_perfil` int(11) NOT NULL,
  `tb_operacao_sistema_id_operacao_sistema` int(11) NOT NULL,
  `tb_acao_id_acao` int(11) NOT NULL,
  PRIMARY KEY (`id_perfil`),
  KEY `fk_tb_acesso_operacao_tb_perfil_acesso1` (`tb_perfil_acesso_id_perfil`),
  KEY `fk_tb_acesso_operacao_tb_operacao_sistema1` (`tb_operacao_sistema_id_operacao_sistema`),
  KEY `fk_tb_acesso_operacao_tb_acao1` (`tb_acao_id_acao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_acesso_operacao: ~1 rows (approximately)
DELETE FROM `tb_acesso_operacao`;
/*!40000 ALTER TABLE `tb_acesso_operacao` DISABLE KEYS */;
INSERT INTO `tb_acesso_operacao` (`id_perfil`, `dt_inclusao`, `dt_alteracao`, `flg_status_acesso_operacao`, `tb_perfil_acesso_id_perfil`, `tb_operacao_sistema_id_operacao_sistema`, `tb_acao_id_acao`) VALUES
	(1, '0000-00-00', '0000-00-00', 0, 0, 0, 0);
/*!40000 ALTER TABLE `tb_acesso_operacao` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_bairro
CREATE TABLE IF NOT EXISTS `tb_bairro` (
  `id_bairro` int(11) NOT NULL,
  `nom_bairro` varchar(45) DEFAULT NULL,
  `tb_cidade_id_cidade` int(11) NOT NULL,
  PRIMARY KEY (`id_bairro`),
  KEY `fk_tb_bairro_tb_cidade1` (`tb_cidade_id_cidade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_bairro: ~0 rows (approximately)
DELETE FROM `tb_bairro`;
/*!40000 ALTER TABLE `tb_bairro` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_bairro` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_campus
CREATE TABLE IF NOT EXISTS `tb_campus` (
  `id_campus` int(11) NOT NULL,
  `nom_campus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_campus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_campus: ~0 rows (approximately)
DELETE FROM `tb_campus`;
/*!40000 ALTER TABLE `tb_campus` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_campus` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_cidade
CREATE TABLE IF NOT EXISTS `tb_cidade` (
  `tb_estado_id_estado` int(11) NOT NULL,
  `id_cidade` int(11) NOT NULL,
  `nom_cidade` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id_cidade`),
  KEY `fk_table1_tb_estado1` (`tb_estado_id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_cidade: ~0 rows (approximately)
DELETE FROM `tb_cidade`;
/*!40000 ALTER TABLE `tb_cidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cidade` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_consulta
CREATE TABLE IF NOT EXISTS `tb_consulta` (
  `id_log` int(11) NOT NULL,
  `TB_PACIENTE_num_prontuario` int(11) NOT NULL,
  `dt_consulta` date DEFAULT NULL,
  `num_prontuario` int(11) DEFAULT NULL,
  `desc_prescricao` varchar(500) DEFAULT NULL,
  `desc_comentario_consulta` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_log`),
  KEY `fk_tb_consulta_TB_PACIENTE1` (`TB_PACIENTE_num_prontuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_consulta: ~0 rows (approximately)
DELETE FROM `tb_consulta`;
/*!40000 ALTER TABLE `tb_consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_consulta` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_contato
CREATE TABLE IF NOT EXISTS `tb_contato` (
  `id_contato` int(11) NOT NULL,
  `nome_recado` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_contato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_contato: ~0 rows (approximately)
DELETE FROM `tb_contato`;
/*!40000 ALTER TABLE `tb_contato` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_contato` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_contato_has_tb_telefone
CREATE TABLE IF NOT EXISTS `tb_contato_has_tb_telefone` (
  `tb_contato_id_contato` int(11) NOT NULL,
  `TB_TELEFONE_ID_TELEFONE` int(11) NOT NULL,
  PRIMARY KEY (`tb_contato_id_contato`,`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_tb_contato_has_TB_TELEFONE_TB_TELEFONE1` (`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_tb_contato_has_TB_TELEFONE_tb_contato1` (`tb_contato_id_contato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_contato_has_tb_telefone: ~0 rows (approximately)
DELETE FROM `tb_contato_has_tb_telefone`;
/*!40000 ALTER TABLE `tb_contato_has_tb_telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_contato_has_tb_telefone` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_contato_tb_responsavel
CREATE TABLE IF NOT EXISTS `tb_contato_tb_responsavel` (
  `id_contato` int(11) NOT NULL,
  `tb_responsavel_id_responsavel` int(11) NOT NULL,
  PRIMARY KEY (`id_contato`,`tb_responsavel_id_responsavel`),
  KEY `fk_tb_contato_has_tb_responsavel_tb_responsavel1` (`tb_responsavel_id_responsavel`),
  KEY `fk_tb_contato_has_tb_responsavel_tb_contato1` (`id_contato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_contato_tb_responsavel: ~0 rows (approximately)
DELETE FROM `tb_contato_tb_responsavel`;
/*!40000 ALTER TABLE `tb_contato_tb_responsavel` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_contato_tb_responsavel` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_dados_prim_consulta
CREATE TABLE IF NOT EXISTS `tb_dados_prim_consulta` (
  `num_prontuario` int(11) NOT NULL,
  `tabag` int(11) DEFAULT NULL,
  `qt_tabag` int(11) DEFAULT NULL,
  `tmp_tabag` int(11) DEFAULT NULL,
  `dt_tabg_parou` int(11) DEFAULT NULL,
  `etilismo_usp` int(11) DEFAULT NULL,
  `qt_etilismo_cerveja` int(11) DEFAULT NULL,
  `qt_etilismo_vinho` int(11) DEFAULT NULL,
  `qt_etilismo_destilado` int(11) DEFAULT NULL,
  `dt_etilismo` int(11) DEFAULT NULL,
  `dt_etilismo_parou` int(11) DEFAULT NULL,
  `hist_tranf_sangue` int(11) DEFAULT NULL,
  `hist_tranf_sangue_reacao` int(11) DEFAULT NULL,
  `hist_tranf_sangue_reacao_qual` int(11) DEFAULT NULL,
  `sedentarismo` int(11) DEFAULT NULL,
  `diabetes` int(11) DEFAULT NULL,
  `ipertensao` int(11) DEFAULT NULL,
  `infarto_miocardio` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_prontuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_dados_prim_consulta: ~0 rows (approximately)
DELETE FROM `tb_dados_prim_consulta`;
/*!40000 ALTER TABLE `tb_dados_prim_consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_dados_prim_consulta` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_delega_poder
CREATE TABLE IF NOT EXISTS `tb_delega_poder` (
  `id_usu_siste` int(11) NOT NULL,
  `id_usu_delega` int(11) DEFAULT NULL,
  `id_usu_recebe` int(11) DEFAULT NULL,
  `desc_operacao` varchar(45) DEFAULT NULL,
  `num_acao` int(11) DEFAULT NULL,
  `desc_motivo` varchar(45) DEFAULT NULL,
  `dt_perio_inicio` date DEFAULT NULL,
  `dt_periodo_fim` date DEFAULT NULL,
  `dt_criacao` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `cod_poder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_usu_siste`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_delega_poder: ~0 rows (approximately)
DELETE FROM `tb_delega_poder`;
/*!40000 ALTER TABLE `tb_delega_poder` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_delega_poder` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_endereco
CREATE TABLE IF NOT EXISTS `tb_endereco` (
  `id_endereco` int(11) NOT NULL,
  `nom_logradouro` varchar(75) DEFAULT NULL,
  `desc_tipo_logradouro` varchar(20) DEFAULT NULL,
  `num_cep` decimal(9,0) DEFAULT NULL,
  `tb_bairro_id_bairro` int(11) NOT NULL,
  PRIMARY KEY (`id_endereco`),
  KEY `fk_tb_endereco_tb_bairro1` (`tb_bairro_id_bairro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_endereco: ~0 rows (approximately)
DELETE FROM `tb_endereco`;
/*!40000 ALTER TABLE `tb_endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_endereco` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_erro
CREATE TABLE IF NOT EXISTS `tb_erro` (
  `id_erro` int(11) NOT NULL,
  `desc_erro` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_erro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_erro: ~0 rows (approximately)
DELETE FROM `tb_erro`;
/*!40000 ALTER TABLE `tb_erro` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_erro` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_estado
CREATE TABLE IF NOT EXISTS `tb_estado` (
  `id_estado` int(11) NOT NULL,
  `nom_uf` varchar(2) DEFAULT NULL,
  `nom_estado` varchar(20) DEFAULT NULL,
  `tb_pais_id_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_estado`),
  KEY `fk_tb_estado_tb_pais1_idx` (`tb_pais_id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_estado: ~0 rows (approximately)
DELETE FROM `tb_estado`;
/*!40000 ALTER TABLE `tb_estado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_estado` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_grupo_acesso
CREATE TABLE IF NOT EXISTS `tb_grupo_acesso` (
  `id_grupo` int(10) NOT NULL,
  `desc_grupo` varchar(50) DEFAULT NULL,
  `id_usu_sis` int(11) DEFAULT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `flg_status_grupo_acesso` tinyint(1) DEFAULT NULL,
  `desc_nome` varchar(50) DEFAULT NULL,
  `flg_tipo_usuario` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_grupo_acesso: ~1 rows (approximately)
DELETE FROM `tb_grupo_acesso`;
/*!40000 ALTER TABLE `tb_grupo_acesso` DISABLE KEYS */;
INSERT INTO `tb_grupo_acesso` (`id_grupo`, `desc_grupo`, `id_usu_sis`, `dt_inclusao`, `dt_alteracao`, `flg_status_grupo_acesso`, `desc_nome`, `flg_tipo_usuario`) VALUES
	(1, 'senna', 5, '0000-00-00', '0000-00-00', 0, 'nemesis', 0);
/*!40000 ALTER TABLE `tb_grupo_acesso` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_imprime_paciente
CREATE TABLE IF NOT EXISTS `tb_imprime_paciente` (
  `id_log` int(11) DEFAULT NULL,
  `desc_especialidade` varchar(50) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `qt_impressao` int(11) DEFAULT NULL,
  `dt_impressao` datetime DEFAULT NULL,
  `TB_PACIENTE_num_prontuario` int(11) NOT NULL,
  PRIMARY KEY (`TB_PACIENTE_num_prontuario`),
  KEY `fk_tb_imprime_paciente_TB_PACIENTE1` (`TB_PACIENTE_num_prontuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_imprime_paciente: ~0 rows (approximately)
DELETE FROM `tb_imprime_paciente`;
/*!40000 ALTER TABLE `tb_imprime_paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_imprime_paciente` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_operacao_sistema
CREATE TABLE IF NOT EXISTS `tb_operacao_sistema` (
  `id_operacao_sistema` int(11) NOT NULL,
  `desc_operacao_sistema` varchar(45) DEFAULT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `flg_status_operacao_sistema` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_operacao_sistema`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_operacao_sistema: ~0 rows (approximately)
DELETE FROM `tb_operacao_sistema`;
/*!40000 ALTER TABLE `tb_operacao_sistema` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_operacao_sistema` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_paciente
CREATE TABLE IF NOT EXISTS `tb_paciente` (
  `num_prontuario` int(11) NOT NULL,
  `DT_cadastro` date NOT NULL,
  `DT_alteracao` date DEFAULT NULL,
  `NOM_paciente` varchar(70) NOT NULL,
  `NOM_pai` varchar(70) NOT NULL,
  `NOM_mae` varchar(70) NOT NULL,
  `DT_nasc` date NOT NULL,
  `sm_idade` int(11) DEFAULT NULL,
  `desc_naturalidade` int(11) NOT NULL,
  `desc_nacionalidade` varchar(30) NOT NULL,
  `desc_Genero` varchar(10) NOT NULL,
  `NOM_etnia` varchar(30) NOT NULL,
  `desc_estado_civil` varchar(30) NOT NULL,
  `desc_escolaridade` varchar(45) DEFAULT NULL,
  `desc_religiao` varchar(45) DEFAULT NULL,
  `desc_ocupacao` int(11) DEFAULT NULL,
  `VL_renda_familiar` decimal(8,2) DEFAULT NULL,
  `num_RG` varchar(10) DEFAULT NULL,
  `dt_RG_expedicao` date DEFAULT NULL,
  `desc_rg_orgao_emissor` varchar(45) DEFAULT NULL,
  `num_cpf` decimal(11,0) DEFAULT NULL,
  `sm_tempo_idade` char(5) DEFAULT NULL,
  `nom_apelido` varchar(45) DEFAULT NULL,
  `desc_origem` varchar(45) DEFAULT NULL,
  `sm_tempo_sp` varchar(45) DEFAULT NULL,
  `num_filho` int(11) DEFAULT NULL,
  `filhos` tinyint(1) DEFAULT NULL,
  `qt_filhos` decimal(2,0) DEFAULT NULL,
  `flg_necessita_acompanhate` tinyint(1) DEFAULT NULL,
  `num_cns` int(11) DEFAULT NULL,
  `num_cnh` int(11) DEFAULT NULL,
  `desc_veiculo` varchar(45) DEFAULT NULL,
  `flg_acompanhate` tinyint(1) DEFAULT NULL,
  `flg_vaiculo` tinyint(1) DEFAULT NULL,
  `flg_vaiculo_adaptado` tinyint(1) DEFAULT NULL,
  `num_placa_veiculo` varchar(45) DEFAULT NULL,
  `num_cn` decimal(20,0) DEFAULT NULL,
  `flg_menor_sem_documento` tinyint(1) DEFAULT NULL,
  `id_medico_especialidade` decimal(10,0) DEFAULT NULL,
  `desc_campus_atend` varchar(10) DEFAULT NULL,
  `tb_perfil_acesso_id_perfil` int(11) DEFAULT NULL,
  `tb_reg_nacio_estrangeiro_id_reg_nacio_estrangeiro` int(11) DEFAULT NULL,
  `tb_campus_id_campus` int(11) DEFAULT NULL,
  `tb_prifissao_id_prifissao` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_prontuario`),
  KEY `fk_TB_PACIENTE_tb_perfil_acesso1` (`tb_perfil_acesso_id_perfil`),
  KEY `fk_TB_PACIENTE_tb_reg_nacio_estrangeiro1` (`tb_reg_nacio_estrangeiro_id_reg_nacio_estrangeiro`),
  KEY `fk_TB_PACIENTE_tb_campus1` (`tb_campus_id_campus`),
  KEY `fk_TB_PACIENTE_tb_prifissao1` (`tb_prifissao_id_prifissao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabela armazena dados dos usuarios';

-- Dumping data for table desenvolvimento_prog.tb_paciente: ~0 rows (approximately)
DELETE FROM `tb_paciente`;
/*!40000 ALTER TABLE `tb_paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_paciente` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_paciente_has_tb_telefone
CREATE TABLE IF NOT EXISTS `tb_paciente_has_tb_telefone` (
  `TB_PACIENTE_ID_paciente` int(11) NOT NULL,
  `TB_TELEFONE_ID_TELEFONE` int(11) NOT NULL,
  PRIMARY KEY (`TB_PACIENTE_ID_paciente`,`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_TB_PACIENTE_has_TB_TELEFONE_TB_TELEFONE1` (`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_TB_PACIENTE_has_TB_TELEFONE_TB_PACIENTE1` (`TB_PACIENTE_ID_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_paciente_has_tb_telefone: ~0 rows (approximately)
DELETE FROM `tb_paciente_has_tb_telefone`;
/*!40000 ALTER TABLE `tb_paciente_has_tb_telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_paciente_has_tb_telefone` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_paciente_has_tb_veiculo
CREATE TABLE IF NOT EXISTS `tb_paciente_has_tb_veiculo` (
  `TB_PACIENTE_num_prontuario` int(11) NOT NULL,
  `tb_veiculo_id_veiculo` int(11) NOT NULL,
  PRIMARY KEY (`TB_PACIENTE_num_prontuario`,`tb_veiculo_id_veiculo`),
  KEY `fk_TB_PACIENTE_has_tb_veiculo_tb_veiculo1` (`tb_veiculo_id_veiculo`),
  KEY `fk_TB_PACIENTE_has_tb_veiculo_TB_PACIENTE1` (`TB_PACIENTE_num_prontuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_paciente_has_tb_veiculo: ~0 rows (approximately)
DELETE FROM `tb_paciente_has_tb_veiculo`;
/*!40000 ALTER TABLE `tb_paciente_has_tb_veiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_paciente_has_tb_veiculo` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_paciente_tb_contato
CREATE TABLE IF NOT EXISTS `tb_paciente_tb_contato` (
  `num_prontuario` int(11) NOT NULL,
  `id_contato` int(11) NOT NULL,
  PRIMARY KEY (`num_prontuario`,`id_contato`),
  KEY `fk_TB_PACIENTE_has_tb_contato_tb_contato1` (`id_contato`),
  KEY `fk_TB_PACIENTE_has_tb_contato_TB_PACIENTE1` (`num_prontuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_paciente_tb_contato: ~0 rows (approximately)
DELETE FROM `tb_paciente_tb_contato`;
/*!40000 ALTER TABLE `tb_paciente_tb_contato` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_paciente_tb_contato` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_paciente_tb_endereco
CREATE TABLE IF NOT EXISTS `tb_paciente_tb_endereco` (
  `TB_PACIENTE_num_prontuario` int(11) NOT NULL,
  `tb_endereco_id_endereco` int(11) NOT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `num_endereco` varchar(10) DEFAULT NULL,
  `desc_compl_endereco` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`TB_PACIENTE_num_prontuario`,`tb_endereco_id_endereco`),
  KEY `fk_TB_PACIENTE_has_tb_endereco_tb_endereco1` (`tb_endereco_id_endereco`),
  KEY `fk_TB_PACIENTE_has_tb_endereco_TB_PACIENTE1` (`TB_PACIENTE_num_prontuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_paciente_tb_endereco: ~0 rows (approximately)
DELETE FROM `tb_paciente_tb_endereco`;
/*!40000 ALTER TABLE `tb_paciente_tb_endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_paciente_tb_endereco` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_pais
CREATE TABLE IF NOT EXISTS `tb_pais` (
  `id_pais` int(11) NOT NULL,
  `nom_pais` varchar(75) NOT NULL,
  `abv_pais` char(4) NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_pais: ~0 rows (approximately)
DELETE FROM `tb_pais`;
/*!40000 ALTER TABLE `tb_pais` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_pais` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_papel
CREATE TABLE IF NOT EXISTS `tb_papel` (
  `id_cargo` int(11) NOT NULL,
  `desc_cargo` varchar(50) DEFAULT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `flg_status_papel` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id_cargo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_papel: ~0 rows (approximately)
DELETE FROM `tb_papel`;
/*!40000 ALTER TABLE `tb_papel` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_papel` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_papel_usuario
CREATE TABLE IF NOT EXISTS `tb_papel_usuario` (
  `id_usu_sist` int(11) DEFAULT NULL,
  `tb_usuario_id_usuario` int(11) NOT NULL,
  `tb_papel_id_cargo` int(11) NOT NULL,
  PRIMARY KEY (`tb_usuario_id_usuario`,`tb_papel_id_cargo`),
  KEY `fk_tb_papel_usuario_tb_usuario1` (`tb_usuario_id_usuario`),
  KEY `fk_tb_papel_usuario_tb_papel1` (`tb_papel_id_cargo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_papel_usuario: ~0 rows (approximately)
DELETE FROM `tb_papel_usuario`;
/*!40000 ALTER TABLE `tb_papel_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_papel_usuario` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_perfil_acesso
CREATE TABLE IF NOT EXISTS `tb_perfil_acesso` (
  `id_perfil` int(11) NOT NULL,
  `desc_perfil` varchar(50) DEFAULT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `flg_status_perfil_acesso` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_perfil_acesso: ~0 rows (approximately)
DELETE FROM `tb_perfil_acesso`;
/*!40000 ALTER TABLE `tb_perfil_acesso` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_perfil_acesso` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_perfil_grupo
CREATE TABLE IF NOT EXISTS `tb_perfil_grupo` (
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `grupo_acesso_id_grupo` int(11) NOT NULL,
  `tb_perfil_acesso_id_perfil` int(11) NOT NULL,
  PRIMARY KEY (`grupo_acesso_id_grupo`,`tb_perfil_acesso_id_perfil`),
  KEY `fk_tb_perfil_grupo_grupo_acesso1` (`grupo_acesso_id_grupo`),
  KEY `fk_tb_perfil_grupo_tb_perfil_acesso1` (`tb_perfil_acesso_id_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_perfil_grupo: ~0 rows (approximately)
DELETE FROM `tb_perfil_grupo`;
/*!40000 ALTER TABLE `tb_perfil_grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_perfil_grupo` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_profissao
CREATE TABLE IF NOT EXISTS `tb_profissao` (

  `id_prifissao` int(11) NOT NULL,
  `nom_profissao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_prifissao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_profissao: ~0 rows (approximately)
DELETE FROM `tb_profissao`;
/*!40000 ALTER TABLE `tb_profissao` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_profissao` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_registra_atividade
CREATE TABLE IF NOT EXISTS `tb_registra_atividade` (
  `id_usuario` int(11) NOT NULL,
  `num_prontuario` int(11) DEFAULT NULL,
  `id_oper_sistema` int(11) DEFAULT NULL,
  `id_acao` int(11) DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `id_log` int(11) DEFAULT NULL,
  `tb_acessa_log_dt_hora` date NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_tb_registra_atividade_tb_acessa_log1` (`tb_acessa_log_dt_hora`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_registra_atividade: ~0 rows (approximately)
DELETE FROM `tb_registra_atividade`;
/*!40000 ALTER TABLE `tb_registra_atividade` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_registra_atividade` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_registro
CREATE TABLE IF NOT EXISTS `tb_registro` (
  `id_registro` int(11) NOT NULL,
  `dt_nascimento` date DEFAULT NULL,
  `rg` varchar(9) DEFAULT NULL,
  `num_cpf` varchar(11) DEFAULT NULL,
  `rg_dt_expedissao` date DEFAULT NULL,
  `rg_orgao_emissor` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`id_registro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_registro: ~0 rows (approximately)
DELETE FROM `tb_registro`;
/*!40000 ALTER TABLE `tb_registro` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_registro` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_registro_critica_incidente
CREATE TABLE IF NOT EXISTS `tb_registro_critica_incidente` (
  `id_registro_critica_incidente` int(11) NOT NULL,
  `id_log` int(11) DEFAULT NULL,
  `des_registro` varchar(500) DEFAULT NULL,
  `tb_usuario_id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_registro_critica_incidente`),
  KEY `fk_tb_registro_critica_incidente_tb_usuario` (`tb_usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_registro_critica_incidente: ~0 rows (approximately)
DELETE FROM `tb_registro_critica_incidente`;
/*!40000 ALTER TABLE `tb_registro_critica_incidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_registro_critica_incidente` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_reg_nacio_estrangeiro
CREATE TABLE IF NOT EXISTS `tb_reg_nacio_estrangeiro` (
  `id_reg_nacio_estrangeiro` int(11) NOT NULL,
  `num_reg_nacio_estrangeiro` varchar(45) NOT NULL,
  `dt_emissao` date NOT NULL,
  `dt_entrada` date NOT NULL,
  `dt_validade` date NOT NULL,
  `nom_reg_nacio_estrangeiro` varchar(75) DEFAULT NULL,
  `tb_pais_id_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_reg_nacio_estrangeiro`),
  KEY `fk_tb_reg_nacio_estrangeiro_tb_pais1` (`tb_pais_id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_reg_nacio_estrangeiro: ~0 rows (approximately)
DELETE FROM `tb_reg_nacio_estrangeiro`;
/*!40000 ALTER TABLE `tb_reg_nacio_estrangeiro` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_reg_nacio_estrangeiro` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_responsavel
CREATE TABLE IF NOT EXISTS `tb_responsavel` (
  `id_responsavel` int(11) NOT NULL,
  `nom_responsavel` varchar(45) DEFAULT NULL,
  `grau_parentesco` varchar(45) DEFAULT NULL,
  `num_rg` varchar(9) DEFAULT NULL,
  `rg_orgao_emissor` varchar(50) DEFAULT NULL,
  `dt_rg_expedissao` date DEFAULT NULL,
  `num_cpf` int(11) DEFAULT NULL,
  `num_rne` varchar(50) DEFAULT NULL,
  `dt_rne_emissao` date DEFAULT NULL,
  `rne_orgao_emissor` varchar(50) DEFAULT NULL,
  `dt_rne_entrada` date DEFAULT NULL,
  `dt_rne_validade` date DEFAULT NULL,
  `rne_pais_origem` varchar(45) DEFAULT NULL,
  `flg_tipo_acompanhante` tinyint(1) DEFAULT NULL,
  `num_cnh` int(11) DEFAULT NULL,
  `desc_dados_veiculo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_responsavel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_responsavel: ~0 rows (approximately)
DELETE FROM `tb_responsavel`;
/*!40000 ALTER TABLE `tb_responsavel` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_responsavel` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_responsavel_has_tb_telefone
CREATE TABLE IF NOT EXISTS `tb_responsavel_has_tb_telefone` (
  `tb_responsavel_id_responsavel` int(11) NOT NULL,
  `TB_TELEFONE_ID_TELEFONE` int(11) NOT NULL,
  PRIMARY KEY (`tb_responsavel_id_responsavel`,`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_tb_responsavel_has_TB_TELEFONE_TB_TELEFONE1` (`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_tb_responsavel_has_TB_TELEFONE_tb_responsavel1` (`tb_responsavel_id_responsavel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_responsavel_has_tb_telefone: ~0 rows (approximately)
DELETE FROM `tb_responsavel_has_tb_telefone`;
/*!40000 ALTER TABLE `tb_responsavel_has_tb_telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_responsavel_has_tb_telefone` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_responsavel_paciente
CREATE TABLE IF NOT EXISTS `tb_responsavel_paciente` (
  `dt_inclusao` date DEFAULT NULL,
  `tb_responsavel_id_responsavel` int(11) NOT NULL,
  `TB_PACIENTE_num_prontuario` int(11) NOT NULL,
  KEY `fk_tb_responsavel_paciente_tb_responsavel1` (`tb_responsavel_id_responsavel`),
  KEY `fk_tb_responsavel_paciente_TB_PACIENTE1` (`TB_PACIENTE_num_prontuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_responsavel_paciente: ~0 rows (approximately)
DELETE FROM `tb_responsavel_paciente`;
/*!40000 ALTER TABLE `tb_responsavel_paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_responsavel_paciente` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_responsavel_tb_endereco
CREATE TABLE IF NOT EXISTS `tb_responsavel_tb_endereco` (
  `tb_responsavel_id_responsavel` int(11) NOT NULL,
  `tb_endereco_id_endereco` int(11) NOT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `num_end` varchar(10) DEFAULT NULL,
  `desc_compl_endereco` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tb_responsavel_id_responsavel`,`tb_endereco_id_endereco`),
  KEY `fk_tb_responsavel_has_tb_endereco_tb_endereco1` (`tb_endereco_id_endereco`),
  KEY `fk_tb_responsavel_has_tb_endereco_tb_responsavel1` (`tb_responsavel_id_responsavel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_responsavel_tb_endereco: ~0 rows (approximately)
DELETE FROM `tb_responsavel_tb_endereco`;
/*!40000 ALTER TABLE `tb_responsavel_tb_endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_responsavel_tb_endereco` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_telefone
CREATE TABLE IF NOT EXISTS `tb_telefone` (
  `ID_TELEFONE` int(11) NOT NULL,
  `num_telefone` decimal(11,0) NOT NULL,
  `desc_tipo_telefone` varchar(12) NOT NULL,
  PRIMARY KEY (`ID_TELEFONE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_telefone: ~0 rows (approximately)
DELETE FROM `tb_telefone`;
/*!40000 ALTER TABLE `tb_telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_telefone` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_usuario
CREATE TABLE IF NOT EXISTS `tb_usuario` (
  `id_usuario` int(11) NOT NULL,
  `nom_usuario` varchar(50) DEFAULT NULL,
  `num_matricola_ra` int(11) DEFAULT NULL,
  `num_rg` varchar(9) DEFAULT NULL,
  `num_cpf` decimal(11,0) DEFAULT NULL,
  `dt_nasc` date DEFAULT NULL,
  `nom_nome_mae` varchar(50) DEFAULT NULL,
  `desc_campus` varchar(10) DEFAULT NULL,
  `desc_email` varchar(50) DEFAULT NULL,
  `flg_status_usuario` tinyint(1) DEFAULT NULL,
  `desc_senha` varchar(50) DEFAULT NULL,
  `id_usu_sist` int(11) DEFAULT NULL,
  `flg_tipo_usuario` tinyint(1) DEFAULT NULL,
  `delega_poder` varchar(50) DEFAULT NULL,
  `dt_inclusao` date DEFAULT NULL,
  `dt_validade_senha` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `tb_campus_id_campus` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `num_matricola_ra_UNIQUE` (`num_matricola_ra`),
  KEY `fk_tb_usuario_tb_campus1` (`tb_campus_id_campus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_usuario: ~2 rows (approximately)
DELETE FROM `tb_usuario`;
/*!40000 ALTER TABLE `tb_usuario` DISABLE KEYS */;
INSERT INTO `tb_usuario` (`id_usuario`, `nom_usuario`, `num_matricola_ra`, `num_rg`, `num_cpf`, `dt_nasc`, `nom_nome_mae`, `desc_campus`, `desc_email`, `flg_status_usuario`, `desc_senha`, `id_usu_sist`, `flg_tipo_usuario`, `delega_poder`, `dt_inclusao`, `dt_validade_senha`, `dt_alteracao`, `tb_campus_id_campus`) VALUES
	(1, 'Joao Teste', 1010, '44222333X', 33344455566, '1987-02-22', 'Maria Teste', 'Vergueiro', 'joao.teste@provedor.com.br', 0, '202cb962ac59075b964b07152d234b70', 1, 1, 'Nao', '2012-05-25', '2012-05-26', '2012-05-25', 1),
	(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, 0);
/*!40000 ALTER TABLE `tb_usuario` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_usuario_grupo_acesso
CREATE TABLE IF NOT EXISTS `tb_usuario_grupo_acesso` (
  `dt_inclusao` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `grupo_acesso_id_grupo` int(11) NOT NULL,
  `tb_usuario_id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`grupo_acesso_id_grupo`,`tb_usuario_id_usuario`),
  KEY `fk_tb_usuario_grupo_acesso_grupo_acesso1` (`grupo_acesso_id_grupo`),
  KEY `fk_tb_usuario_grupo_acesso_tb_usuario1` (`tb_usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_usuario_grupo_acesso: ~0 rows (approximately)
DELETE FROM `tb_usuario_grupo_acesso`;
/*!40000 ALTER TABLE `tb_usuario_grupo_acesso` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_usuario_grupo_acesso` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_usuario_has_tb_delega_poder
CREATE TABLE IF NOT EXISTS `tb_usuario_has_tb_delega_poder` (
  `tb_usuario_id_usuario` int(11) NOT NULL,
  `tb_delega_poder_id_usu_siste` int(11) NOT NULL,
  PRIMARY KEY (`tb_usuario_id_usuario`,`tb_delega_poder_id_usu_siste`),
  KEY `fk_tb_usuario_has_tb_delega_poder_tb_delega_poder1` (`tb_delega_poder_id_usu_siste`),
  KEY `fk_tb_usuario_has_tb_delega_poder_tb_usuario1` (`tb_usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_usuario_has_tb_delega_poder: ~0 rows (approximately)
DELETE FROM `tb_usuario_has_tb_delega_poder`;
/*!40000 ALTER TABLE `tb_usuario_has_tb_delega_poder` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_usuario_has_tb_delega_poder` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_usuario_has_tb_telefone
CREATE TABLE IF NOT EXISTS `tb_usuario_has_tb_telefone` (
  `tb_usuario_id_usuario` int(11) NOT NULL,
  `TB_TELEFONE_ID_TELEFONE` int(11) NOT NULL,
  PRIMARY KEY (`tb_usuario_id_usuario`,`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_tb_usuario_has_TB_TELEFONE_TB_TELEFONE1` (`TB_TELEFONE_ID_TELEFONE`),
  KEY `fk_tb_usuario_has_TB_TELEFONE_tb_usuario1` (`tb_usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_usuario_has_tb_telefone: ~0 rows (approximately)
DELETE FROM `tb_usuario_has_tb_telefone`;
/*!40000 ALTER TABLE `tb_usuario_has_tb_telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_usuario_has_tb_telefone` ENABLE KEYS */;


-- Dumping structure for table desenvolvimento_prog.tb_veiculo
CREATE TABLE IF NOT EXISTS `tb_veiculo` (
  `id_veiculo` int(11) NOT NULL,
  `desc_placa_veiculo` varchar(7) DEFAULT NULL,

  `desc_tipo` varchar(75) DEFAULT NULL,
  `flg_veiculo_adaptado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_veiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table desenvolvimento_prog.tb_veiculo: ~0 rows (approximately)
DELETE FROM `tb_veiculo`;
/*!40000 ALTER TABLE `tb_veiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_veiculo` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
