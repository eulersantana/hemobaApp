-- MySQL Script generated by MySQL Workbench
-- Fri Jun 17 21:27:39 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hemoba
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hemoba
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hemoba` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `hemoba` ;

-- -----------------------------------------------------
-- Table `hemoba`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`usuario` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`usuario` (
  `id` INT(11) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `passsword` VARCHAR(45) NOT NULL,
  `create` DATETIME NOT NULL,
  `updated` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`perfil` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`perfil` (
  `nome` INT NOT NULL,
  `sobrenome` VARCHAR(255) NOT NULL,
  `foto` VARCHAR(255) NULL DEFAULT '',
  `data_nascimento` DATETIME NOT NULL,
  `google` VARCHAR(45) NULL,
  `facebook` VARCHAR(255) NULL,
  `usuario_id` INT(11) NOT NULL,
  `t_saguineo` VARCHAR(45) NULL,
  `peso` FLOAT NULL,
  `sexo` INT NULL,
  `eh_doador` TINYINT(1) NULL,
  INDEX `fk_perfil_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_perfil_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `hemoba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`local` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`local` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logitude` VARCHAR(45) NOT NULL,
  `latitude` VARCHAR(45) NOT NULL,
  `create` DATETIME NOT NULL,
  `update` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_local_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_local_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `hemoba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`hemocentro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`hemocentro` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`hemocentro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`endereco` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`endereco` (
  `id` INT NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `cep` VARCHAR(15) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `complemento` VARCHAR(200) NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `longitude` VARCHAR(45) NULL,
  `latitude` VARCHAR(45) NULL,
  `hemocentro_id` INT NOT NULL,
  `create` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_hemocentro1_idx` (`hemocentro_id` ASC),
  CONSTRAINT `fk_endereco_hemocentro1`
    FOREIGN KEY (`hemocentro_id`)
    REFERENCES `hemoba`.`hemocentro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`telefone` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `celular` VARCHAR(45) NULL,
  `fixo` VARCHAR(45) NULL,
  `dd` INT(11) NULL,
  `ddi` INT(11) NULL,
  `hemocentro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_telefone_hemocentro_idx` (`hemocentro_id` ASC),
  CONSTRAINT `fk_telefone_hemocentro`
    FOREIGN KEY (`hemocentro_id`)
    REFERENCES `hemoba`.`hemocentro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`funcionamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`funcionamento` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`funcionamento` (
  `id` INT(11) NOT NULL,
  `dia_inicio` INT NOT NULL,
  `dia_fim` INT NULL,
  `hora_inicio` TIME NOT NULL,
  `horar_fim` TIME NOT NULL,
  `hemocentro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_funcionamento_hemocentro1_idx` (`hemocentro_id` ASC),
  CONSTRAINT `fk_funcionamento_hemocentro1`
    FOREIGN KEY (`hemocentro_id`)
    REFERENCES `hemoba`.`hemocentro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`doar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`doar` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`doar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hemocentro_id` INT NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  `create` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_doar_hemocentro1_idx` (`hemocentro_id` ASC),
  INDEX `fk_doar_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_doar_hemocentro1`
    FOREIGN KEY (`hemocentro_id`)
    REFERENCES `hemoba`.`hemocentro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doar_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `hemoba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`doar_proxima`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`doar_proxima` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`doar_proxima` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 0,
  `usuario_id` INT(11) NOT NULL,
  `alarme` INT NULL DEFAULT 3,
  PRIMARY KEY (`id`),
  INDEX `fk_doar_proxima_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_doar_proxima_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `hemoba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`status_doacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`status_doacao` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`status_doacao` (
  `usuario_id` INT(11) NOT NULL,
  `create` DATETIME NULL,
  `update` DATETIME NULL,
  `status` INT NOT NULL DEFAULT 0,
  INDEX `fk_status_doacao_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_status_doacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `hemoba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`album` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`album` (
  `id` INT NOT NULL,
  `foto` VARCHAR(500) NULL,
  `hemocentro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_hemocentro1_idx` (`hemocentro_id` ASC),
  CONSTRAINT `fk_album_hemocentro1`
    FOREIGN KEY (`hemocentro_id`)
    REFERENCES `hemoba`.`hemocentro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hemoba`.`foto_doacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hemoba`.`foto_doacao` ;

CREATE TABLE IF NOT EXISTS `hemoba`.`foto_doacao` (
  `id` INT NOT NULL,
  `foto` VARCHAR(500) NULL,
  `create` DATETIME NULL,
  `doar_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_foto_doacao_doar1_idx` (`doar_id` ASC),
  CONSTRAINT `fk_foto_doacao_doar1`
    FOREIGN KEY (`doar_id`)
    REFERENCES `hemoba`.`doar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
