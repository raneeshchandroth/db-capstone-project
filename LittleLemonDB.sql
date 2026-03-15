-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customer_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer_Details` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(45) NULL,
  `CustomerPhone` VARCHAR(45) NULL,
  `CustomerEmail` VARCHAR(45) NULL,
  `CustomerAddress` VARCHAR(45) NULL,
  `CustomerType` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Booking` (
  `BookingID` INT NOT NULL,
  `CustomerID` INT NULL,
  `TableNumber` INT NULL,
  `BookingDate` DATETIME NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `Customer_ID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer_Details` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL,
  `MenuType` VARCHAR(45) NULL,
  `Price` DECIMAL(4,2) NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff_Information` (
  `StaffID` INT NOT NULL,
  `StaffName` VARCHAR(45) NULL,
  `StaffRole` VARCHAR(45) NULL,
  `StaffSalary` DECIMAL(5,2) NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `CustomerID` INT NULL,
  `MenuID` INT NULL,
  `StaffID` INT NULL,
  `OrderDate` DATETIME NULL,
  `Quantity` INT NULL,
  `TotalCost` DECIMAL(4,2) NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `Customer_ID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `Menu_ID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `Staff_ID_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `Customer_ID1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer_Details` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Menu_ID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Staff_ID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemonDB`.`Staff_Information` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `DeliveryStatusID` INT NOT NULL,
  `OrderID` INT NULL,
  `DeliveryStatus` VARCHAR(45) NULL,
  `DeliveryDate` DATETIME NULL,
  PRIMARY KEY (`DeliveryStatusID`),
  INDEX `Order_ID_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `Order_ID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
