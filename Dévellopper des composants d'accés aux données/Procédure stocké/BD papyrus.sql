DROP DATABASE if exists papyrus;

CREATE DATABASE papyrus;

USE papyrus;

CREATE TABLE `fournis` (
  `fournis_numfou` int NOT NULL,
  `nomfou` varchar(25) NOT NULL,
  `ruefou` varchar(50) NOT NULL,
  `posfou` char(5) NOT NULL,
  `vilfou` varchar(30) NOT NULL,
  `confou` varchar(15) NOT NULL,
  `satisf` tinyint(4) DEFAULT NULL, 
  CHECK (`satisf` >=0 AND `satisf` <=10),
  PRIMARY KEY (`fournis_numfou`)
);

INSERT INTO `fournis` (`fournis_numfou`, `nomfou`, `ruefou`, `posfou`, `vilfou`, `confou`, `satisf`) VALUES
	(200, 'SOSArnaque', '5 rue voiture', '75000', 'Paris', 'Cabar',6),
	(120, 'GROBRIGAN', '20 rue du papier', '92200', 'papercity', 'Georges', 8),
	(540, 'ECLIPSE', '53 rue laisse flotter les rubans', '78250', 'Bugbugville', 'Nestor', 7),
	(8700, 'MEDICIS', '120 rue des plantes', '75014', 'Paris', 'Lison', 0),
	(9120, 'DISCOBOL', '11 rue des sports', '85100', 'La Roche sur Yon', 'Hercule', 8),
	(9150, 'DEPANPAP', '26 avenue des locomotives', '59987', 'Coroncountry', 'Pollux', 5),
	(9180, 'HURRYTAPE', '68 boulevard des octets', '40440', 'Dumpville', 'Track', 0);

CREATE TABLE `produit` (
  `produit_codart` char(4) NOT NULL,
  `libart` varchar(30) NOT NULL,
  `stkale` int(11) NOT NULL,
  `stkphy` int(11) NOT NULL,
  `qteann` int(11) NOT NULL,
  `unimes` char(5) NOT NULL,
  PRIMARY KEY (`produit_codart`)
) ;


INSERT INTO `produit` (`produit_codart`, `libart`, `stkale`, `stkphy`, `qteann`, `unimes`) VALUES
	('B001', 'Bande magnétique 1200', 20, 87, 240, 'unite'),
	('B002', 'Bande magnétique 6250', 20, 12, 410, 'unite'),
	('D035', 'CD R slim 80 mm', 40, 42, 150, 'B010'),
	('D050', 'CD R-W 80mm', 50, 4, 0, 'B010'),
	('I100', 'Papier 1 ex continu', 100, 557, 3500, 'B1000'),
	('I105', 'Papier 2 ex continu', 75, 5, 2300, 'B1000'),
	('I108', 'Papier 3 ex continu', 200, 557, 3500, 'B500'),
	('I110', 'Papier 4 ex continu', 10, 12, 63, 'B400'),
	('P220', 'Pré-imprimé commande', 500, 2500, 24500, 'B500'),
	('P230', 'Pré-imprimé facture', 500, 250, 12500, 'B500'),
	('P240', 'Pré-imprimé bulletin paie', 500, 3000, 6250, 'B500'),
	('P250', 'Pré-imprimé bon livraison', 500, 2500, 24500, 'B500'),
	('P270', 'Pré-imprimé bon fabrication', 500, 2500, 24500, 'B500'),
	('R080', 'ruban Epson 850', 10, 2, 120, 'unite'),
	('R132', 'ruban impl 1200 lignes', 25, 200, 182, 'unite');



CREATE TABLE `entcom` (
  `entcom_numcom` int(11) NOT NULL AUTO_INCREMENT,
  `obscom` varchar(50) DEFAULT NULL,
  `datcom` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `entcom_numfou` int(11) DEFAULT NULL,
  PRIMARY KEY (`entcom_numcom`),
  KEY `numfou` (`entcom_numfou`),
  CONSTRAINT `entcom_ibfk_1` FOREIGN KEY (`entcom_numfou`) REFERENCES `fournis` (`fournis_numfou`)
);


INSERT INTO `entcom` (`entcom_numcom`, `obscom`, `datcom`, `entcom_numfou`) VALUES
	(70010, '', '1993-04-23 15:59:51', 120),
	(70011, 'Commande urgente', '2018-04-23 15:59:51', 540),
	(70020, '', '2018-04-23 15:59:51', 9120),
	(70025, 'Commande urgente', '1993-04-23 15:59:51', 9150),
	(70210, 'Commande cadencée', '2018-04-23 15:59:51', 120),
	(70250, 'Commande cadencée', '2018-04-23 15:59:51', 8700),
	(70300, '', '2018-04-23 15:59:51', 9120),
	(70620, '', '2018-04-23 15:59:51', 540),
	(70625, '', '1993-04-23 15:59:51', 120),
	(70629, '', '2018-04-23 15:59:51', 9180),
	(70400,'Commande ajoutée','1993-09-24 15:59:51',540),
	(70600,'Commande ajoutée','2018-03-23 15:59:51',120),
	(70800,'','2020-09-24 15:59:51',8700),
	(70900,'Commande ajoutée',CURRENT_TIMESTAMP,9150);



CREATE TABLE `ligcom` (
  `ligcom_numcom` int(11) NOT NULL,
  `numlig` tinyint(4) NOT NULL,
  `ligcom_codart` char(4) NOT NULL,
  `qtecde` int(11) NOT NULL,
  `priuni` decimal(5,0) NOT NULL,
  `qteliv` int(11) DEFAULT NULL,
  `derliv` date NOT NULL,
  PRIMARY KEY (`ligcom_numcom`,`numlig`),
  KEY `codart` (`ligcom_codart`),
  CONSTRAINT `ligcom_ibfk_1` FOREIGN KEY (`ligcom_numcom`) REFERENCES `entcom` (`entcom_numcom`),
  CONSTRAINT `ligcom_ibfk_2` FOREIGN KEY (`ligcom_codart`) REFERENCES `produit` (`produit_codart`)
);


INSERT INTO `ligcom` (`ligcom_numcom`, `numlig`, `ligcom_codart`, `qtecde`, `priuni`, `qteliv`, `derliv`) VALUES
	(70010, 1, 'I100', 3000, 470, 3000, '2007-03-15'),
	(70010, 2, 'I105', 2000, 485, 2000, '2007-07-05'),
	(70010, 3, 'I108', 1000, 680, 1000, '2007-08-20'),
	(70010, 4, 'D035', 200, 40, 250, '2007-02-20'),
	(70010, 5, 'P220', 6000, 3500, 6000, '2007-03-31'),
	(70010, 6, 'P240', 6000, 2000, 2000, '2007-03-31'),
	(70011, 1, 'I105', 1000, 600, 1000, '2007-05-16'),
	(70011, 2, 'P220', 10000, 3500, 10000, '2007-08-31'),
	(70020, 1, 'B001', 200, 140, 0, '2007-12-31'),
	(70020, 2, 'B002', 200, 140, 0, '2007-12-31'),
	(70025, 1, 'I100', 1000, 590, 1000, '2007-05-15'),
	(70025, 2, 'I105', 500, 590, 500, '2007-03-15'),
	(70210, 1, 'I100', 1000, 470, 1000, '2007-07-15'),
	(70250, 1, 'P230', 15000, 4900, 12000, '2007-12-15'),
	(70250, 2, 'P220', 10000, 3350, 10000, '2007-11-10'),
	(70300, 1, 'I100', 50, 790, 50, '2007-10-31'),
	(70620, 1, 'I105', 200, 600, 200, '2007-11-01'),
	(70625, 1, 'I100', 1000, 470, 1000, '2007-10-15'),
	(70625, 2, 'P220', 10000, 3500, 10000, '2007-10-31'),
	(70629, 1, 'B001', 200, 140, 0, '2007-12-31'),
	(70629, 2, 'B002', 200, 140, 0, '2007-12-31');



CREATE TABLE `vente` (
  `vente_codart` char(4) NOT NULL,
  `vente_numfou` int(11) NOT NULL,
  `delliv` smallint(6) NOT NULL,
  `qte1` int(11) NOT NULL,
  `prix1` decimal(5,0) NOT NULL,
  `qte2` int(11) DEFAULT NULL,
  `prix2` decimal(5,0) DEFAULT NULL,
  `qte3` int(11) DEFAULT NULL,
  `prix3` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`vente_codart`,`vente_numfou`),
  KEY `numfou` (`vente_numfou`),
  CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`vente_numfou`) REFERENCES `fournis` (`fournis_numfou`),
  CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`vente_codart`) REFERENCES `produit` (`produit_codart`)
) ;


INSERT INTO `vente` (`vente_codart`, `vente_numfou`, `delliv`, `qte1`, `prix1`, `qte2`, `prix2`, `qte3`, `prix3`) VALUES
	('B001', 8700, 15, 0, 150, 50, 145, 100, 140),
	('B002', 8700, 15, 0, 210, 50, 200, 100, 185),
	('D035', 120, 0, 0, 40, 0, 0, 0, 0),
	('D035', 9120, 5, 0, 40, 100, 30, 0, 0),
	('I100', 120, 90, 0, 700, 50, 600, 120, 500),
	('I100', 540, 70, 0, 710, 60, 630, 100, 600),
	('I100', 9120, 60, 0, 800, 70, 600, 90, 500),
	('I100', 9150, 90, 0, 650, 90, 600, 200, 590),
	('I100', 9180, 30, 0, 720, 50, 670, 100, 490),
	('I105', 120, 90, 10, 705, 50, 630, 120, 500),
	('I105', 540, 70, 0, 810, 60, 645, 100, 600),
	('I105', 8700, 30, 0, 720, 50, 670, 100, 510),
	('I105', 9120, 60, 0, 920, 70, 800, 90, 700),
	('I105', 9150, 90, 0, 685, 90, 600, 200, 590),
	('I108', 120, 90, 5, 795, 30, 720, 100, 680),
	('I108', 9120, 60, 0, 920, 70, 820, 100, 780),
	('I110', 9120, 60, 0, 950, 70, 850, 90, 790),
	('I110', 9180, 90, 0, 900, 70, 870, 90, 835),
	('P220', 120, 15, 0, 3700, 100, 3500, 0, 0),
	('P220', 8700, 20, 50, 3500, 100, 3350, 0, 0),
	('P230', 120, 30, 0, 5200, 100, 5000, 0, 0),
	('P230', 8700, 60, 0, 5000, 50, 4900, 0, 0),
	('P240', 120, 15, 0, 2200, 100, 2000, 0, 0),
	('P250', 120, 30, 0, 1500, 100, 1400, 500, 1200),
	('P250', 9120, 30, 0, 1500, 100, 1400, 500, 1200),
	('R080', 9120, 10, 0, 120, 100, 100, 0, 0),
	('R132', 9120, 5, 0, 275, 0, 0, 0, 0);


/* BESOIN AFFICHAGE */

/*1 Commandes du fournisseur 91120 */
/*
SELECT entcom_numcom AS 'Numéro commande', obscom AS 'Observation', datcom AS 'Date commande', entcom_numfou AS 'Numéro Fournisseur'
FROM entcom
WHERE entcom_numfou = 9120;
*/

/* 2 Code Fournisseur pour lequels des commandes ont été passées*/
/*
SELECT distinct(entcom_numfou) AS 'Numero fournisseur ayant reçu commande'
FROM entcom;

*/

/*3 Nombre commande avec nombre fournisseurs distincts*/
/*SELECT COUNT(entcom_numcom) AS 'Nombre commande', COUNT(DISTINCT(entcom_numfou)) AS 'Nombre de fournisseur concernés'
from entcom;*/

/*Produit avec un stock inférieur ou egal au stock d'alerte avec une quantité annuelle inf a 10000 */
/*
SELECT produit_codart AS 'N° Produit', libart AS 'Libellé', stkphy AS 'Stock', stkale AS 'Sock alerte', qteann AS 'Quantité annuelle'
FROM produit
WHERE (stkphy <= stkale) AND (qteann < 1000);
*/

/*Fournisseurs dans départements 75 78 92 77 , ordre alphabétique fournisseur se fait par défaut */
/*
SELECT SUBSTRING(posfou,1,2) AS 'Département', nomfou AS 'NOM Fournisseur'
FROM fournis
WHERE SUBSTRING(posfou,1,2) = '75' OR SUBSTRING(posfou,1,2) = '78' OR SUBSTRING(posfou,1,2) = '92' OR SUBSTRING(posfou,1,2) = '77'
ORDER BY posfou DESC;
*/

/* Commande Passéés en mars et avril*/
/*	
SELECT entcom_numcom AS 'Numero de commande', obscom AS 'Observation commande', datcom AS 'Date de commande', entcom_numfou AS 'Numero Fournisseur'
FROM entcom
WHERE MONTH(datcom) = 4 OR MONTH(datcom) = 3;
*/

/* Commande du jour qui ont une obervation*/
/*
SELECT entcom_numcom AS 'Numero de commande', datcom AS 'Commande du jour'
FROM entcom
WHERE SUBSTRING(CURRENT_TIMESTAMP,1,10) = SUBSTRING(datcom,1,10) and obscom is null;
*/

/*Liste de chaque commande avec total en ordre decroissant*/
/*
SELECT ligcom_numcom AS 'Numero de commande', sum(qtecde*priuni)  AS 'Somme total de la commande' 
FROM ligcom
GROUP BY ligcom_numcom
ORDER by 2 desc ;
*/

/* Commande dont le total est sup a 10000 en excluant les articles dont le prix >= 1000*/
/*
SELECT ligcom_numcom AS 'Numero de commande', sum(qtecde*priuni)  AS 'Somme total de la commande' 
FROM ligcom
WHERE qtecde < 1000
GROUP BY ligcom_numcom
HAVING sum(qtecde*priuni) > 10000
ORDER by 2 desc ;
*/

/*Commande par nom de fournisseur*/
/*
SELECT entcom_numfou AS 'Nom Fournisseur', entcom_numcom AS 'Numero commande', datcom AS 'Date de la commande'
FROM entcom
ORDER BY entcom_numfou;
*/

/* Sortir les produits des commandes ayant le mot "urgent' en observation?(Afficher le numéro de commande, le nom du fournisseur, le libellé du produit et le sous total= quantité commandée * Prix unitaire) */
/*
select entcom_numcom AS 'Numero commande', nomfou AS 'Nom Fournisseur', libart AS 'Libellé produit', qtecde*priuni AS 'Prix total'
FROM entcom
JOIN fournis ON fournis_numfou = entcom_numfou
JOIN ligcom ON ligcom_numcom = entcom_numcom
JOIN produit ON produit_codart = ligcom_codart
WHERE obscom = 'Commande urgente';
*/

/* Fournisseur suceptible de livrer au moins 1 article */
/*
SELECT nomfou AS 'Nom Fournisseur'
FROM fournis
JOIN entcom on entcom_numfou = fournis_numfou
JOIN ligcom ON ligcom_numcom = entcom_numcom
WHERE qteliv < qtecde
GROUP BY nomfou;
*/
/*
SELECT nomfou AS 'Nom Fournisseur'
FROM fournis, entcom,ligcom
WHERE fournis_numfou  = entcom_numfou AND entcom_numcom = ligcom_numcom and qteliv < qtecde
GROUP BY nomfou;
*/

/*Commande du fourniseur ayant la commande 70210*/
/*
SELECT entcom_numcom AS 'Numero de commande', datcom AS 'Date commande'
FROM entcom
WHERE entcom_numfou = (SELECT entcom_numfou FROM entcom WHERE entcom_numcom = 70210);
*/

/* Libellé article et prix (1) des articles en stock et moins cher des ruban (codart commence par R) */
/*
SELECT  prix1 , libart AS 'Libellé'
FROM vente
JOIN produit ON produit_codart = vente_codart
WHERE (prix1 < (SELECT min(prix1) FROM vente WHERE SUBSTRING(vente_codart,1,1) = 'R')) AND stkphy <> 0;
*/

/*Liste des fournisseurs susceptibles de livrer les produits dont stocks <= 150% stocks alerte trié par produit puis fournisseur */ 
/*
SELECT  produit_codart as 'Référence produit', nomfou AS ' fournisseur' 
FROM fournis
JOIN vente ON vente_numfou = fournis_numfou
JOIN produit ON produit_codart = vente_codart
WHERE stkphy <= (stkale * 150) / 100
ORDER BY nomfou;
*/

/* Même qu'avant avec delai de livraison <= 30 et trié d'abaort par fournisseur puis produit */
/*
SELECT nomfou AS 'Fournisseur', produit_codart as 'Référence produit'
FROM fournis
JOIN vente ON vente_numfou = fournis_numfou
JOIN produit ON produit_codart = vente_codart
WHERE stkphy <= (stkale * 150) / 100 AND delliv <= 30
ORDER BY nomfou, produit_codart;
*/

/* Total des stocks par fournisseur trié décroissant */
/*
SELECT nomfou AS 'Fournisseur', produit_codart as 'Référence produit', stkphy AS 'Total des stocks'
FROM fournis
JOIN vente ON vente_numfou = fournis_numfou
JOIN produit ON produit_codart = vente_codart
WHERE stkphy <= (stkale * 150) / 100 AND delliv <= 30
ORDER BY nomfou, stkphy DESC;
*/

/*liste des produit dont la quantité commandée dépasse > 90% quantité annuelle prévu*/
/*
SELECT produit_codart AS 'Référence de produit commandée dont nbre commande dépasse 90% stock annuel'
FROM produit
JOIN ligcom ON ligcom_codart = produit_codart
GROUP BY produit_codart
HAVING sum(qtecde) > 0.9 * (sum(qteann) / COUNT(qteann));
*/

/* Chiffre d'affaire par fournisseur pour l'année 93*/
/*
SELECT nomfou as 'Nom fournisseur', sum(qtecde*priuni*1.2) as 'Chiffre Affaire'
from fournis
join entcom on entcom_numfou = fournis_numfou
join ligcom on ligcom_numcom = entcom_numcom
where substring(datcom,3,4) = 93
group by fournis_numfou;
*/

/* Mise à jour */

/* Augmentation 4% prix1 et 2% prix2 pour fournisseur 9180*/
/*
Update vente
set prix1=prix1*1.04 , prix2=prix2*1.02
where vente_numfou = 9180;
*/
/*prix2 devient prix1 quand prix2 = 0*/ 
/*
update vente
set prix2=prix1
where prix2=0;
*/
/*obs = ***** quand indice du fournisseur < 5 */
/*
update entcom
set obscom='*****'
where entcom_numfou in (select fournis_numfou from fournis where satisf < 5);
*/

/*Suppression produit I110, partir des tables qui se référe*/
/*
delete from vente 
where vente_codart = 'I110';


delete from ligcom
where ligcom_codart = 'I110';


delete from produit
where produit_codart = 'I110';
*/

/* suppression de commande  sans ligne de commande, cette requete est directement relié a une suppression de produit comme ci-dessus*/
/*
delete from entcom
where entcom_numcom not in (select ligcom_numcom from ligcom);
*/

/* suppression ligne de commande quand obs nul dans entcom*/
/*
delete from ligcom
where ligcom_numcom in (select entcom_numcom from entcom where obscom ="");

*/








