/* Exercice 1 création d'une procédure stockée sans paramètre*/
/*Créez la procédure stockée Lst_fournis correspondant à la requête n°2 afficher le code des fournisseurs pour lesquels une commande a été passée*/

DROP PROCEDURE IF EXISTS `Lst_fournis`;
DELIMITER |

CREATE PROCEDURE Lst_fournis()
BEGIN
    SELECT distinct entcom_numfou as 'Numéro fournisseur ayant eu une commande ' FROM entcom;
END |

DELIMITER ;

Call Lst_fournis();

SHOW CREATE PROCEDURE Lst_fournis;


/* Exercice 2 création d'une procédure stockée avec un paramètre en entrée*/
/*Créer la procédure stockée Lst_Commandes, qui liste les commandes ayant un libellé particulier dans le champ obscom (cette requête sera construite à partir de la requête n°11)*/

DROP PROCEDURE IF EXISTS `Lst_Commandes`;

DELIMITER |

CREATE PROCEDURE Lst_Commandes(IN p_obscom VARCHAR(100))
BEGIN
    select entcom_numcom AS 'Numero commande', nomfou AS 'Nom Fournisseur', libart AS 'Libellé produit', qtecde*priuni AS 'Prix total'
    FROM entcom
    JOIN fournis ON fournis_numfou = entcom_numfou
    JOIN ligcom ON ligcom_numcom = entcom_numcom
    JOIN produit ON produit_codart = ligcom_codart
    WHERE obscom = p_obscom ;
END |

DELIMITER ;

Call Lst_Commandes('Commande urgente');

SHOW CREATE PROCEDURE Lst_Commandes;

/* Exercice 3 création d'une procédure stockée avec plusieurs paramètres*/
/*Créer la procédure stockée CA_Fournisseur, qui pour un code fournisseur et une année entrée en paramètre, calcule et restitue le CA potentiel de ce fournisseur pour l'année souhaitée (cette requête sera construite à partir de la requête n°19)*/

DROP PROCEDURE IF EXISTS `CA_Fournisseur`;
DELIMITER |

CREATE PROCEDURE CA_Fournisseur(IN p_numfou int(10),IN p_datcom int(10))
BEGIN
    if p_numfou in (select fournis_numfou from fournis) then
        SELECT nomfou as 'Nom fournisseur', sum(qtecde*priuni*1.2) as 'Chiffre Affaire'
        from fournis
        join entcom on entcom_numfou = fournis_numfou
        join ligcom on ligcom_numcom = entcom_numcom
        where substring(datcom,1,4) = p_datcom and entcom_numfou = p_numfou
        group by fournis_numfou;
    else select 'Le fournisseur n existe pas';      
    end if;
     
END |

DELIMITER ;

/*Fournisseur existe*/

call CA_Fournisseur(120,1993);

/*Fournisseur existe mais n'a rien vendu en 2004*/

call CA_Fournisseur(540,2004);


/*Fournisseur n'existe pas */

call CA_Fournisseur(300,2004);



