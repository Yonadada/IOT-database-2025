-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema madangUni
-- -----------------------------------------------------
-- 마당대학교 모델링 

-- -----------------------------------------------------
-- Schema madangUni
--
-- 마당대학교 모델링 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `madangUni` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `madangUni` ;

-- -----------------------------------------------------
-- Table `madangUni`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUni`.`Professor` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `age` INT NULL,
  `rank` VARCHAR(20) NOT NULL,
  `speciality` VARCHAR(40) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUni`.`Dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUni`.`Dept` (
  `dno` INT NOT NULL,
  `dname` VARCHAR(45) NOT NULL,
  `office` VARCHAR(45) NULL,
  `runprofessorssn` INT NOT NULL,
  PRIMARY KEY (`dno`),
  INDEX `fk_Dept_Professor_idx` (`runprofessorssn` ASC) VISIBLE,
  CONSTRAINT `fk_Dept_Professor`
    FOREIGN KEY (`runprofessorssn`)
    REFERENCES `madangUni`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUni`.`Graduate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUni`.`Graduate` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `deg_prog` VARCHAR(45) NULL,
  `dno` INT NOT NULL,
  `graduatessn` INT NOT NULL,
  PRIMARY KEY (`ssn`),
  INDEX `fk_Graduate_Dept1_idx` (`dno` ASC) VISIBLE,
  INDEX `fk_Graduate_Graduate1_idx` (`graduatessn` ASC) VISIBLE,
  CONSTRAINT `fk_Graduate_Dept1`
    FOREIGN KEY (`dno`)
    REFERENCES `madangUni`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Graduate_Graduate1`
    FOREIGN KEY (`graduatessn`)
    REFERENCES `madangUni`.`Graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUni`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUni`.`Project` (
  `pid` INT NOT NULL,
  `pname` VARCHAR(50) NOT NULL,
  `sponsor` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `budget` INT NULL,
  `managessn` INT NOT NULL,
  PRIMARY KEY (`pid`),
  INDEX `fk_Project_Professor1_idx` (`managessn` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Professor1`
    FOREIGN KEY (`managessn`)
    REFERENCES `madangUni`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUni`.`work_dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUni`.`work_dept` (
  `professorssn` INT NOT NULL,
  `dno` INT NOT NULL,
  `pct_time` INT NOT NULL COMMENT '교수참여백분율',
  PRIMARY KEY (`professorssn`, `dno`),
  INDEX `fk_work_dept_Dept1_idx` (`dno` ASC) VISIBLE,
  CONSTRAINT `fk_work_dept_Professor1`
    FOREIGN KEY (`professorssn`)
    REFERENCES `madangUni`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_dept_Dept1`
    FOREIGN KEY (`dno`)
    REFERENCES `madangUni`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUni`.`work_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUni`.`work_in` (
  `Professorssn` INT NOT NULL,
  `pid` INT NOT NULL,
  PRIMARY KEY (`Professorssn`, `pid`),
  INDEX `fk_work_in_Project1_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_work_in_Professor1`
    FOREIGN KEY (`Professorssn`)
    REFERENCES `madangUni`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_in_Project1`
    FOREIGN KEY (`pid`)
    REFERENCES `madangUni`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUni`.`work_prog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUni`.`work_prog` (
  `pid` INT NOT NULL,
  `graduatessn` INT NOT NULL,
  PRIMARY KEY (`pid`, `graduatessn`),
  INDEX `fk_work_prog_Graduate1_idx` (`graduatessn` ASC) VISIBLE,
  CONSTRAINT `fk_work_prog_Project1`
    FOREIGN KEY (`pid`)
    REFERENCES `madangUni`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_prog_Graduate1`
    FOREIGN KEY (`graduatessn`)
    REFERENCES `madangUni`.`Graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
