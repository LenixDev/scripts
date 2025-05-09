CREATE TABLE IF NOT EXISTS `pawnshop_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
);
