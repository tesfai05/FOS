-- MySQL Script generated by MySQL Workbench
-- Mon Nov 18 18:52:32 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fos` DEFAULT CHARACTER SET utf8 ;
USE `fos` ;

-- -----------------------------------------------------
-- Table `fos`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fos`.`images` (
  `image_id` INT NOT NULL,
  `path` VARCHAR(100) NOT NULL,
  `created` DATETIME NOT NULL,
  PRIMARY KEY (`image_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fos`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fos`.`addresses` (
  `address_id` INT NOT NULL,
  `street` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `postal` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `created` DATETIME NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fos`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fos`.`users` (
  `user_id` INT NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `role` ENUM('admin', 'client') NOT NULL DEFAULT 'client',
  `created` DATETIME NOT NULL,
  `image_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_users_images_idx` (`image_id` ASC) VISIBLE,
  INDEX `fk_users_addresses1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_images`
    FOREIGN KEY (`image_id`)
    REFERENCES `fos`.`images` (`image_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `fos`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fos`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fos`.`orders` (
  `order_id` INT NOT NULL,
  `totalAmount` DOUBLE NOT NULL,
  `created` DATETIME NOT NULL,
  `status` ENUM('ordered', 'delivered', 'cancelled', 'shipping') NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fos`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fos`.`foods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fos`.`foods` (
  `food_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `created` DATETIME NOT NULL,
  `price` DOUBLE NOT NULL,
  `calories` INT NOT NULL,
  `image_id` INT NOT NULL,
  `order_count` INT NULL,
  PRIMARY KEY (`food_id`),
  INDEX `fk_foods_images1_idx` (`image_id` ASC) VISIBLE,
  CONSTRAINT `fk_foods_images1`
    FOREIGN KEY (`image_id`)
    REFERENCES `fos`.`images` (`image_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fos`.`orders_has_foods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fos`.`orders_has_foods` (
  `order_id` INT NOT NULL,
  `food_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `food_id`),
  INDEX `fk_orders_has_foods_foods1_idx` (`food_id` ASC) VISIBLE,
  INDEX `fk_orders_has_foods_orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_foods_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `fos`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_foods_foods1`
    FOREIGN KEY (`food_id`)
    REFERENCES `fos`.`foods` (`food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


CREATE USER 'fos'@'%' IDENTIFIED BY 'Fospassword123';

GRANT ALL PRIVILEGES ON fos.* TO 'fos'@'%';
