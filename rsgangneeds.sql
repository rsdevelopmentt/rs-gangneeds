CREATE TABLE IF NOT EXISTS `gangstash` (
  `gangname` varchar(50) NOT NULL DEFAULT '''''',
  `pass` int(4) NOT NULL DEFAULT 1234,
  PRIMARY KEY (`gangname`),
  UNIQUE KEY `gangname` (`gangname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;