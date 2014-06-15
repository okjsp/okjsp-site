GRANT ALL PRIVILEGES ON *.* TO kenu@localhost
IDENTIFIED BY 'okpass' WITH GRANT OPTION;

CREATE TABLE polllist
 (
  seq                        INT NOT NULL,
  question                   TEXT NOT NULL,
  sdate                      datetime,
  edate                      datetime,
  active                     CHAR(1) DEFAULT 1,
  vtype                      INT DEFAULT 1 NOT NULL,
  wtime                      datetime
 );

CREATE INDEX idx_polllist on polllist(seq);

CREATE TABLE pollitem
 (
  seq                        INT NOT NULL,
  itemseq                    INT,
  item                       VARCHAR(200),
  hit                        INT DEFAULT 0
 );

CREATE INDEX idx_pollitem on pollitem(seq);
