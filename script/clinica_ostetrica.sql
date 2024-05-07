CREATE DATABASE IF NOT EXISTS clinica_ostetrica;

USE clinica_ostetrica;

CREATE TABLE reparto (
  codID int NOT NULL AUTO_INCREMENT,
  nome varchar(50),
  numeroPersonale int,
  PRIMARY KEY (codID)
) ENGINE = InnoDB;

CREATE TABLE specializzazione (
  descrizione varchar(50) NOT NULL,
  PRIMARY KEY (descrizione)
) ENGINE = InnoDB;

CREATE TABLE personale (
  matricola varchar(50) NOT NULL,
  nome varchar(50),
  tipoPersonale varchar(50),
  codID int,
  descrizione varchar(50),
  PRIMARY KEY (matricola),
  FOREIGN KEY (codID) REFERENCES reparto(codID),
  FOREIGN KEY (descrizione) REFERENCES specializzazione(descrizione)
) ENGINE = InnoDB;

CREATE TABLE camera (
  numero int NOT NULL,
  piano int NOT NULL,
  postiLetto int NOT NULL,
  PRIMARY KEY (numero)
) ENGINE = InnoDB;

CREATE TABLE sesso (
  genere varchar(50) NOT NULL,
  PRIMARY KEY (genere)
) ENGINE = InnoDB;

CREATE TABLE neonato (
  codiceN int NOT NULL AUTO_INCREMENT,
  nome varchar(50),
  dieta varchar(50),
  dataNascita date,
  tipoParto varchar(50),
  genere varchar(50),
  PRIMARY KEY (codiceN),
  FOREIGN KEY (genere) REFERENCES sesso(genere)
) ENGINE = InnoDB;

CREATE TABLE donna (
  codiceM int NOT NULL AUTO_INCREMENT,
  cognome varchar(50) NOT NULL,
  nome varchar(50) NOT NULL,
  data_ricovero date,
  data_dimissione date,
  numero int,
  codiceN int,
  eta int,
  malattie varchar(50),
  PRIMARY KEY (codiceM),
  FOREIGN KEY (numero) REFERENCES camera(numero),
  FOREIGN KEY (codiceN) REFERENCES neonato(codiceN)
) ENGINE = InnoDB;

CREATE TABLE assiste (
  matricola varchar(50),
  codiceM int,
  PRIMARY KEY (matricola,codiceM),
  FOREIGN KEY (matricola) REFERENCES personale(matricola),
  FOREIGN KEY (codiceM) REFERENCES donna(codiceM)
) ENGINE = InnoDB;

insert into reparto values(1,'chirurgia',30);
insert into reparto values(2,'ginecologia',15);
insert into reparto values(3,'cardiologia',2);
insert into reparto values(4,'patologia delle gravidanze',8);
insert into reparto values(5,'neonatologia',15);
insert into reparto values(6,'ostetricia',20);
insert into reparto values(7,'neurologia',2);
insert into reparto values(8,'intensivo',10);
insert into reparto values(9,'primo intervento',6);
insert into reparto values(10,'psicologia',4);

insert into sesso values('maschio');
insert into sesso values('femmina');

insert into specializzazione values('cardiologo');
insert into specializzazione values('chirurgo');
insert into specializzazione values('endocrinologo');
insert into specializzazione values('ginecologo');
insert into specializzazione values('neonatologo');
insert into specializzazione values('neurologo');
insert into specializzazione values('nessuna');
insert into specializzazione values('operatore socio sanitario');
insert into specializzazione values('patologo');
insert into specializzazione values('pediatra');
insert into specializzazione values('psichiatra');
insert into specializzazione values('psicologo');
insert into specializzazione values('puericultrice');

insert into personale values('AS9662','Nino','infermiere',3,NULL);
insert into personale values('AS9863','Lucas','infermiere',5,NULL);
insert into personale values('AS9963','Andrea','infermiere',10,NULL);
insert into personale values('MD2023','Adele','medico',4,'patologo');
insert into personale values('MD5652','Giovanni','medico',2,'ginecologo');
insert into personale values('MD7412','Leonardo','medico',8,'neurologo');
insert into personale values('MD8574','Alice','medico',1,'chirurgo');
insert into personale values('MD8741','Bibi','medico',4,'patologo');
insert into personale values('PK2103','Lily','ostetrica',7,'neonatologo');
insert into personale values('PK2610','Luana','ostetrica',9,'puericultrice');
insert into personale values('PK5689','Stefania','ostetrica',6,'puericultrice');

insert into camera values(100,1,4);
insert into camera values(102,1,4);
insert into camera values(104,1,4);
insert into camera values(106,1,4);
insert into camera values(108,1,4);
insert into camera values(110,1,4);
insert into camera values(112,1,4);
insert into camera values(114,1,4);
insert into camera values(116,1,4);
insert into camera values(118,1,4);
insert into camera values(120,1,4);
insert into camera values(200,2,4);
insert into camera values(202,2,4);
insert into camera values(204,2,4);
insert into camera values(206,2,4);
insert into camera values(208,2,4);
insert into camera values(210,2,4);
insert into camera values(212,2,4);
insert into camera values(214,2,4);
insert into camera values(216,2,4);
insert into camera values(220,2,4);

insert into neonato values(23687,'Vincent','latte 200ml','1998-12-16','naturale','maschio');
insert into neonato values(129857,'Eleonora','latte 110ml','2002-06-05','cesario','femmina');
insert into neonato values(250719,'Domenico','latte 180ml','2019-07-25','naturale','maschio');
insert into neonato values(261098,'Federica','latte 100ml','1998-10-26','cesario','femmina');
insert into neonato values(424541,'Jessica','latte 120ml','2005-04-18','cesario','femmina');
insert into neonato values(547869,'Leopoldo','latte 120ml','2010-02-14','naturale','maschio');
insert into neonato values(547878,'Andrea','latte 150ml','2000-08-17','cesario','maschio');
insert into neonato values(698741,'Olmo','latte 140ml','2019-10-17','cesario','maschio');
insert into neonato values(785412,'Filiberto','latte 130ml','2017-12-15','naturale','maschio');
insert into neonato values(852013,'Giuseppina','latte 180ml','2019-10-13','naturale','femmina');
insert into neonato values(859630,'Teresa','latte 180ml','1997-10-21','naturale','femmina');
insert into neonato values(895210,'Stefano','latte 130ml','2019-10-17','cesario','maschio');
insert into neonato values(963021,'PerlaMaria','latte 160ml','2019-01-01','naturale','femmina');

insert into donna values(NULL,'Rossi','Anna','2018-12-31','2019-01-03',202,963021,30,'ipertensione');
insert into donna values(NULL,'Bianchi','Lidia','2018-10-16','2018-10-22',204,895210,25,'diabete');
insert into donna values(NULL,'Boldi','Paola','2019-10-12','2019-10-16',206,852013,45,'gestosi');
insert into donna values(NULL,'Pecoraro','Giada','1997-10-20','1997-10-24',102,859630,18,'diabet gravidico');
insert into donna values(NULL,'Ranucci','Anna','1997-10-25','1997-10-30',216,261098,32,'nessuna');
insert into donna values(NULL,'Ranucci','Anna','2000-08-17','2000-08-22',206,547878,34,'nessuna');
insert into donna values(NULL,'Vitale','Rosaria','2002-06-04','2002-06-08',112,129857,21,'ipertensione');
insert into donna values(NULL,'Perrotta','Rosa','2019-07-24','2019-07-28',100,250719,28,'nessuna');
insert into donna values(NULL,'Vitale','Rosaria','2017-12-14','2017-12-18',112,785412,36,'ipertensione');
insert into donna values(NULL,'Rossi','Anna','2012-02-13','2010-02-17',116,547869,22,'ipertensione');
insert into donna values(NULL,'Berardi','Giovanna','2005-04-17','2005-04-22',120,424541,17,'gestosi');
insert into donna values(NULL,'Berardi','Giovanna','2019-10-16','2019-10-20',208,698741,31,'nessuna');
insert into donna values(NULL,'Limberti','Dora','2018-02-03','2018-02-06',208,23687,45,'nessuna');

insert into assiste values('AS9662',1);
insert into assiste values('MD5652',1);
insert into assiste values('PK2103',1);
insert into assiste values('AS9963',2);
insert into assiste values('MD7412',2);
insert into assiste values('PK5689',2);
insert into assiste values('MD7412',3);
insert into assiste values('PK2610',3);
insert into assiste values('PK5689',3);
insert into assiste values('AS9863',4);
insert into assiste values('MD2023',4);
insert into assiste values('PK5689',4);
insert into assiste values('AS9963',5);
insert into assiste values('MD8574',5);
insert into assiste values('PK2610',5);
insert into assiste values('AS9662',6);
insert into assiste values('MD8574',6);
insert into assiste values('PK2610',6);
insert into assiste values('AS9662',7);
insert into assiste values('MD5652',7);
insert into assiste values('PK5689',7);
insert into assiste values('AS9863',8);
insert into assiste values('MD7412',8);
insert into assiste values('PK5689',8);
insert into assiste values('AS9863',9);
insert into assiste values('MD8574',9);
insert into assiste values('PK2610',9);
insert into assiste values('AS9662',10);
insert into assiste values('MD8574',10);
insert into assiste values('PK5689',10);
insert into assiste values('AS9963',11);
insert into assiste values('MD8574',11);
insert into assiste values('PK5689',11);
insert into assiste values('AS9863',12);
insert into assiste values('MD5652',12);
insert into assiste values('PK2103',12);
insert into assiste values('MD8741',13);
insert into assiste values('AS9662',13);
insert into assiste values('PK2610',13);
