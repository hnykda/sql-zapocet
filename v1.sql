-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `test_db`;
CREATE DATABASE test_db;
USE test_db;

-- ---
-- Table 'Recommendation'
-- 
-- ---

DROP TABLE IF EXISTS `Recommendation`;
		
CREATE TABLE `Recommendation` (
  `IDU` INTEGER NOT NULL,
  `IDP` INTEGER NOT NULL,
  `Score` FLOAT NOT NULL,
  PRIMARY KEY (`IDU`, `IDP`)
);

-- ---
-- Table 'Product'
-- 
-- ---

DROP TABLE IF EXISTS `Product`;
		
CREATE TABLE `Product` (
  `PID` INTEGER NOT NULL,
  `Price` FLOAT NULL,
  `PName` CHAR(30) NOT NULL,
  `Unit` CHAR(10) NOT NULL,
  PRIMARY KEY (`PID`),
  UNIQUE KEY (`PName`)
);

-- ---
-- Table 'Order'
-- 
-- ---

DROP TABLE IF EXISTS `Order`;
		
CREATE TABLE `Order` (
  `IDI` INTEGER NOT NULL,
  `DIP` INTEGER NOT NULL,
  `N` INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (`IDI`, `DIP`)
);

-- ---
-- Table 'Invoice'
-- 
-- ---

DROP TABLE IF EXISTS `Invoice`;
		
CREATE TABLE `Invoice` (
  `IID` INTEGER NOT NULL,
  `IDU` INTEGER NOT NULL,
  PRIMARY KEY (`IID`)
);

-- ---
-- Table 'User'
-- 
-- ---

DROP TABLE IF EXISTS `User`;
		
CREATE TABLE `User` (
  `UID` INTEGER NOT NULL,
  `UName` CHAR(30) NOT NULL,
  PRIMARY KEY (`UID`),
  UNIQUE KEY (`UName`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `Recommendation` ADD FOREIGN KEY (IDU) REFERENCES `User` (`UID`);
ALTER TABLE `Recommendation` ADD FOREIGN KEY (IDP) REFERENCES `Product` (`PID`);
ALTER TABLE `Order` ADD FOREIGN KEY (IDI) REFERENCES `Invoice` (`IID`);
ALTER TABLE `Order` ADD FOREIGN KEY (DIP) REFERENCES `Product` (`PID`);
ALTER TABLE `Invoice` ADD FOREIGN KEY (IDU) REFERENCES `User` (`UID`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Recommendation` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Product` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Order` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Invoice` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `User` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `Recommendation` (`IDU`,`IDP`,`Score`) VALUES
-- ('','','');
-- INSERT INTO `Product` (`PID`,`Price`,`PName`,`Unit`) VALUES
-- ('','','','');
-- INSERT INTO `Order` (`IDI`,`DIP`,`N`) VALUES
-- ('','','');
-- INSERT INTO `Invoice` (`IID`,`IDU`) VALUES
-- ('','');
-- INSERT INTO `User` (`UID`,`UName`) VALUES
-- ('','');
