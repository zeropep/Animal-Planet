CREATE TABLE `board` (
  `bno` bigint NOT NULL AUTO_INCREMENT,
  `b_cate` varchar(100) NOT NULL,
  `b_tag` varchar(50) DEFAULT NULL,
  `species` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `nick_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text NOT NULL,
  `b_img` text,
  `reg_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `mod_at` datetime DEFAULT NULL,
  `read_count` int DEFAULT '0',
  `location` varchar(100) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `breed` varchar(100) DEFAULT NULL,
  `lost_date` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cart` (
  `cartno` bigint NOT NULL AUTO_INCREMENT,
  `owner` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `npno` bigint NOT NULL,
  `pname` varchar(100) NOT NULL,
  `cart_stock` int DEFAULT NULL,
  `price` int NOT NULL,
  `reg_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `image` text,
  PRIMARY KEY (`cartno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `comment` (
  `cno` bigint NOT NULL AUTO_INCREMENT,
  `npno` bigint DEFAULT NULL,
  `upno` bigint DEFAULT NULL,
  `bno` bigint DEFAULT NULL,
  `hno` bigint DEFAULT NULL,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nick_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text NOT NULL,
  `imges` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `reg_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `mod_at` datetime DEFAULT NULL,
  PRIMARY KEY (`cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hospital` (
  `IDX` bigint NOT NULL AUTO_INCREMENT,
  `OPNSFTEAMCODE` bigint NOT NULL,
  `MGTNO` varchar(100) NOT NULL,
  `TRDSTATEGBN` int DEFAULT NULL,
  `TRDSTATENM` varchar(50) DEFAULT NULL,
  `DCBYMD` date DEFAULT NULL,
  `CLGSTDT` date DEFAULT NULL,
  `CLGENDDT` date DEFAULT NULL,
  `ROPNYMD` date DEFAULT NULL,
  `SITETEL` varchar(100) DEFAULT NULL,
  `SITEWHLADDR` varchar(100) DEFAULT NULL,
  `RDNWHLADDR` varchar(200) DEFAULT NULL,
  `BPLCNM` varchar(100) DEFAULT NULL,
  `UPDATEDT` date DEFAULT NULL,
  `LAT` varchar(100) DEFAULT NULL,
  `LON` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IDX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member` (
  `mno` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `pwd` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(20) NOT NULL,
  `nick_name` varchar(100) NOT NULL,
  `phone_number` varchar(30) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `address_detail` varchar(50) DEFAULT NULL,
  `profile_image` text,
  `is_social` varchar(20) NOT NULL,
  `grade` int NOT NULL,
  `join_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `mod_date` datetime DEFAULT NULL,
  PRIMARY KEY (`mno`),
  UNIQUE KEY `member_un` (`nick_name`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `new_product` (
  `npno` bigint NOT NULL AUTO_INCREMENT,
  `category1` varchar(100) DEFAULT NULL,
  `category2` varchar(100) DEFAULT NULL,
  `pname` varchar(100) NOT NULL,
  `price` int NOT NULL,
  `stock` int DEFAULT NULL,
  `description` text,
  `reg_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `made_in` varchar(100) DEFAULT NULL,
  `imges` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`npno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `state_code` (
  `opnsfteamcode` bigint NOT NULL,
  `state_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`opnsfteamcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `used_product` (
  `upno` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(100) DEFAULT NULL,
  `pname` varchar(100) NOT NULL,
  `price` int NOT NULL,
  `description` text,
  `reg_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `mod_at` datetime DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `imges` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`upno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order` (
  `buyer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` int DEFAULT NULL,
  `pname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `npno` bigint NOT NULL,
  `upno` bigint DEFAULT NULL,
  `payment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `option` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `amount` int DEFAULT NULL,
  `reg_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `history` (
  `ohno` bigint NOT NULL,
  `buyer` varchar(100) NOT NULL,
  `npno` bigint NOT NULL,
  `pname` varchar(100) NOT NULL,
  `method` varchar(100) NOT NULL,
  `option` varchar(10) NOT NULL,
  `payment` varchar(100) NOT NULL,
  `amount` int DEFAULT NULL,
  `reg_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ohno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


