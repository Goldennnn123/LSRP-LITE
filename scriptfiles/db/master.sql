CREATE TABLE IF NOT EXISTS `masters` (
  `acc_dbid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `acc_name` varchar(64) NOT NULL,
  `forum_name` varchar(255) NOT NULL,
  `acc_pass` varchar(129) NOT NULL,
  `acc_email` varchar(255) NOT NULL,
  `admin` int(11) NOT NULL,
  `active_ip` varchar(255) NOT NULL,
  PRIMARY KEY
    (acc_dbid),
  UNIQUE KEY
    acc_name (acc_name)
);