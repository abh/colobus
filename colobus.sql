
DROP TABLE IF EXISTS groups;
CREATE TABLE groups (
   id    smallint unsigned not null primary key,
   name  varchar(255) not null,
   description varchar(255) not null,
   unique key (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
  group_id smallint(5) unsigned NOT NULL default '0',
  id int(10) unsigned NOT NULL default '0',
  msgid varchar(32) NOT NULL default '',
  subjhash varchar(32) NOT NULL default '',
  fromhash varchar(32) NOT NULL default '',
  thread_id int(10) unsigned NOT NULL default '0',
  parent int(10) unsigned NOT NULL default '0',
  received datetime NOT NULL default '0000-00-00 00:00:00',
  h_date varchar(255) NOT NULL default '',
  h_messageid varchar(255) NOT NULL default '',
  h_from varchar(255) NOT NULL default '',
  h_subject varchar(255) NOT NULL default '',
  h_references varchar(8192) NOT NULL default '',
  h_lines mediumint(8) unsigned NOT NULL default '0',
  h_bytes int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (group_id,id),
  KEY msgid (msgid),
  KEY fromhash (fromhash),
  KEY grp (group_id,received),
  KEY grp_2 (group_id,thread_id,parent),
  KEY grp_3 (group_id,subjhash),
  KEY subjhash ( subjhash, received ),
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

