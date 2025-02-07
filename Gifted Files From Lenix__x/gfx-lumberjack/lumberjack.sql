CREATE TABLE IF NOT EXISTS `gfx_lumberjack`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) DEFAULT NULL,
    `lumberjackName` varchar(50) DEFAULT NULL,
    `cuttingTrees` int(11) DEFAULT 0,
    `level` int(11) DEFAULT 0,
    `total_money` int(11) DEFAULT 0,
    `profile_photo` varchar(250) DEFAULT "",
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;