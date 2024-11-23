CREATE TABLE `karma_clothing` (
    `id` INT(25) NOT NULL AUTO_INCREMENT,
    `cid` INT(11) NULL DEFAULT '0',
    `model` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `drawables_texture` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `props_texture` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `hairColor` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `fadeLayer` TEXT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `customHeadModel` TEXT NOT NULL DEFAULT 'false',
    `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=28
;

CREATE TABLE `karma_head_clothing` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`cid` INT(11) NOT NULL,
	`model` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`head_blend` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`head_features` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`head_overlays` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`fade` LONGTEXT NULL DEFAULT '""' COLLATE 'utf8mb4_general_ci',
	`eye_color` INT(11) NOT NULL DEFAULT '0',
	`created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	`updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE,
	CONSTRAINT `head_blend` CHECK (json_valid(`head_blend`)),
	CONSTRAINT `head_features` CHECK (json_valid(`head_features`)),
	CONSTRAINT `head_overlays` CHECK (json_valid(`head_overlays`))
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=10
;

CREATE TABLE `karma_outfits` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`cid` INT(11) NULL DEFAULT NULL,
	`name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`tags` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`slot` INT(11) NULL DEFAULT NULL,
	`model` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`drawables_texture` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`props_texture` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`hairColor` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`fadeLayer` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`customHeadModel` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	`updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `unique_cid_slot` (`cid`, `slot`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=31
;
