use ohi0;

CREATE TABLE `alarms` (
  `alarm_seq` int unsigned NOT NULL AUTO_INCREMENT,
  `alarm_msg` varchar(255) DEFAULT NULL,
  `alarm_is_read` tinyint(1) DEFAULT '0',
  `alarm_crt_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `usr_seq` int unsigned DEFAULT NULL,
  PRIMARY KEY (`alarm_seq`),
  KEY `FK_user_alarm` (`usr_seq`),
  CONSTRAINT `FK_user_alarm` FOREIGN KEY (`usr_seq`) REFERENCES `users` (`usr_seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `auction_bids` (
  `bid_seq` int unsigned NOT NULL AUTO_INCREMENT COMMENT '입찰시퀀스',
  `acow_seq` int unsigned DEFAULT NULL COMMENT '경매소 시퀀스',
  `auc_seq` int unsigned DEFAULT NULL COMMENT '경매시퀀스',
  `bid_acc` int unsigned DEFAULT NULL COMMENT '입찰자',
  `bid_amt` int DEFAULT NULL COMMENT '입찰금',
  `bid_dt` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '입찰일',
  PRIMARY KEY (`bid_seq`),
  KEY `FK_auction_bids_auc_seq_auctions_auc_seq` (`auc_seq`),
  KEY `fk_auction_bids_acow_seq_idx` (`acow_seq`),
  KEY `FK_auction_bids_bid_acc_users_usr_seq` (`bid_acc`),
  CONSTRAINT `fk_auction_bids_acow_seq` FOREIGN KEY (`acow_seq`) REFERENCES `auction_cows` (`acow_seq`),
  CONSTRAINT `FK_auction_bids_auc_seq_auctions_auc_seq` FOREIGN KEY (`auc_seq`) REFERENCES `auctions` (`auc_seq`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_auction_bids_bid_acc_users_usr_seq` FOREIGN KEY (`bid_acc`) REFERENCES `users` (`usr_seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `auction_cows` (
  `acow_seq` int unsigned NOT NULL AUTO_INCREMENT,
  `cow_seq` int unsigned DEFAULT NULL,
  `auc_seq` int unsigned DEFAULT NULL,
  `acow_crt_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `acow_del_dt` datetime DEFAULT NULL,
  `acow_status` varchar(100) DEFAULT '진행중',
  `acow_final_bid` int DEFAULT '0',
  `acow_winner_seq` int unsigned DEFAULT NULL,
  `acow_bottom_price` int DEFAULT '0',
  `acow_predict_price` int DEFAULT '0',
  PRIMARY KEY (`acow_seq`),
  KEY `fk_cow_seq_idx` (`cow_seq`),
  KEY `fk_auc_seq_idx` (`auc_seq`),
  KEY `fk_winner_seq_idx` (`acow_winner_seq`),
  CONSTRAINT `fk_auc_seq` FOREIGN KEY (`auc_seq`) REFERENCES `auctions` (`auc_seq`),
  CONSTRAINT `fk_cow_seq` FOREIGN KEY (`cow_seq`) REFERENCES `cows` (`cow_seq`),
  CONSTRAINT `fk_winner_seq` FOREIGN KEY (`acow_winner_seq`) REFERENCES `users` (`usr_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `auctions` (
  `auc_seq` int unsigned NOT NULL AUTO_INCREMENT COMMENT '경매시퀀스',
  `usr_seq` int unsigned DEFAULT NULL COMMENT '사용자시퀀스',
  `auc_broadcast_title` varchar(100) DEFAULT NULL COMMENT '경매방송제목',
  `auc_status` varchar(100) DEFAULT '진행중' COMMENT '경매상태',
  `auc_crt_dt` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `auc_del_dt` datetime DEFAULT NULL,
  `auc_end_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`auc_seq`),
  KEY `FK_auctions_usr_seq_users_usr_seq` (`usr_seq`),
  CONSTRAINT `FK_auctions_usr_seq_users_usr_seq` FOREIGN KEY (`usr_seq`) REFERENCES `users` (`usr_seq`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `cows` (
  `cow_seq` int unsigned NOT NULL AUTO_INCREMENT COMMENT '소시퀀스',
  `usr_seq` int unsigned DEFAULT NULL COMMENT '사용자시퀀스',
  `usr_barn_seq` int unsigned DEFAULT NULL,
  `cow_no` varchar(100) DEFAULT NULL COMMENT '개체번호',
  `cow_bir_dt` date DEFAULT NULL COMMENT '출생일',
  `cow_region` varchar(100) DEFAULT NULL,
  `cow_jagigubun` varchar(100) DEFAULT NULL,
  `cow_eomigubun` varchar(100) DEFAULT NULL,
  `cow_kpn` decimal(10,1) DEFAULT NULL COMMENT 'KPN번호',
  `cow_prt` int DEFAULT NULL COMMENT '산차',
  `cow_gdr` varchar(100) DEFAULT NULL COMMENT '성별',
  `notes` varchar(255) DEFAULT NULL COMMENT '비고',
  `cow_family` decimal(10,1) DEFAULT NULL,
  `cow_weight` int DEFAULT NULL,
  `cow_img1` varchar(100) DEFAULT NULL,
  `cow_img2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cow_seq`),
  KEY `FK_cows_usr_seq_users_usr_seq` (`usr_seq`),
  KEY `fk_usr_barn_seq_idx` (`usr_barn_seq`),
  CONSTRAINT `FK_cows_usr_seq_users_usr_seq` FOREIGN KEY (`usr_seq`) REFERENCES `users` (`usr_seq`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_usr_barn_seq` FOREIGN KEY (`usr_barn_seq`) REFERENCES `user_barns` (`usr_barn_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `user_barns` (
  `usr_barn_seq` int unsigned NOT NULL AUTO_INCREMENT COMMENT '축사시퀀스',
  `usr_seq` int unsigned DEFAULT NULL COMMENT '사용자시퀀스',
  `usr_barn_name` varchar(100) DEFAULT NULL COMMENT '축사명',
  `usr_barn_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`usr_barn_seq`),
  KEY `FK_user_barns_usr_seq_users_usr_seq` (`usr_seq`),
  CONSTRAINT `FK_user_barns_usr_seq_users_usr_seq` FOREIGN KEY (`usr_seq`) REFERENCES `users` (`usr_seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `users` (
  `usr_seq` int unsigned NOT NULL AUTO_INCREMENT COMMENT '사용자시퀀스',
  `usr_typ` varchar(100) DEFAULT NULL COMMENT '사용자구분',
  `usr_acc` varchar(100) DEFAULT NULL COMMENT '아이디',
  `usr_pwd` varchar(100) DEFAULT NULL COMMENT '비밀번호',
  `usr_nm` varchar(100) DEFAULT NULL COMMENT '이름',
  `usr_phn` varchar(100) DEFAULT NULL COMMENT '전화번호',
  `usr_eml` varchar(100) DEFAULT NULL COMMENT '이메일',
  `usr_crt_dt` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
  PRIMARY KEY (`usr_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci




