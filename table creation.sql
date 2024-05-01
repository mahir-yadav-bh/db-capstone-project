-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8 ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menu` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Price` DECIMAL(8,3) NULL,
  `Course` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customers` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Phone_Number` VARCHAR(10) NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb`.`Delivery_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`Delivery_Status` (
  `ID` INT NOT NULL,
  `Delivery_Date` DATE NULL,
  `Status` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `ID` INT NOT NULL,
  `Total_Amount` DECIMAL(8,3) NULL,
  `Quantity` INT NULL,
  `Date` DATE NULL,
  `Menu_ID` INT NOT NULL,
  `Delivery_Status_ID` INT NOT NULL,
  `Customer_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Menu_ID_idx` (`Menu_ID` ASC) VISIBLE,
  INDEX `Customer_ID_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `Delivery_Status_ID_idx` (`Delivery_Status_ID` ASC) VISIBLE,
  CONSTRAINT `Menu_ID`
    FOREIGN KEY (`Menu_ID`)
    REFERENCES `littlelemondb`.`menu` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `littlelemondb`.`customers` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Delivery_Status_ID`
    FOREIGN KEY (`Delivery_Status_ID`)
    REFERENCES `littlelemondb`.`Delivery_Status` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`booking` (
  `ID` INT NOT NULL,
  `Date` DATE NULL,
  `Table_Number` INT NULL,
  `customer_id1` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Customer_ID_idx` (`customer_id1` ASC) VISIBLE,
  CONSTRAINT `customer_id1`
    FOREIGN KEY (`customer_id1`)
    REFERENCES `littlelemondb`.`customers` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staff` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Role` VARCHAR(45) NULL,
  `Salary` DECIMAL(10,3) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
