-- MySQL dump 9.09
--
-- Host: localhost    Database: colobus
-- ------------------------------------------------------
-- Server version	4.0.16-standard-log

--
-- Table structure for table `header`
--

DROP TABLE IF EXISTS header;
CREATE TABLE header (
  grp smallint(5) unsigned NOT NULL default '0',
  art int(10) unsigned NOT NULL default '0',
  msgid varchar(32) NOT NULL default '',
  subjhash varchar(32) NOT NULL default '',
  fromhash varchar(32) NOT NULL default '',
  thread int(10) unsigned NOT NULL default '0',
  parent int(10) unsigned NOT NULL default '0',
  received datetime NOT NULL default '0000-00-00 00:00:00',
  h_date varchar(255) NOT NULL default '',
  h_messageid varchar(255) NOT NULL default '',
  h_from varchar(255) NOT NULL default '',
  h_subject varchar(255) NOT NULL default '',
  h_references varchar(255) NOT NULL default '',
  h_lines mediumint(8) unsigned NOT NULL default '0',
  h_bytes int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (grp,art),
  KEY msgid (msgid),
  KEY fromhash (fromhash),
  KEY grp (grp,received),
  KEY grp_2 (grp,thread,parent),
  KEY grp_3 (grp,subjhash)
) TYPE=MyISAM DELAY_KEY_WRITE=1;

