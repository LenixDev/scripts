CREATE TABLE IF NOT EXISTS `gfx_lumberjack_contract`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) DEFAULT NULL,
    `contractOwner` varchar(50) DEFAULT NULL,
    `treeCount` varchar(50) DEFAULT NULL,
    `percent` int(11) DEFAULT 0,
    `numberOfUses` int(11) DEFAULT 0,
    `profile_photo` varchar(250) DEFAULT "",
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;