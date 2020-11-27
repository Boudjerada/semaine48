/* Exercice 1 */

/* Vue 1 : Afficher la liste des hôtels avec leur station*/

DROP VIEW IF EXISTS v_hotels_station; 
CREATE VIEW v_hotels_station
AS
SELECT `hot_nom` as 'Nom Hotel', `sta_nom` as 'Nom Station' 
FROM `hotel` join `station` on `sta_id` = `hot_sta_id`;

/* Vue 2 : Afficher la liste des chambres et leur hôtel*/

DROP VIEW IF EXISTS v_chambre_hotel;
CREATE VIEW v_chambre_hotel
as 
select `cha_id` as 'Identifiant Chambre',`cha_numero` as 'Numéro chambre', `cha_capacite` as 'Capacité chambre', `cha_type` as 'Type chambre',`hot_id` as 'Identifiant Hotel',`hot_nom` as 'Nom Hotel' 
from `chambre` join `hotel` on `cha_hot_id` = `hot_id`; 


/* Vue 3 : Afficher la liste des réservations avec le nom des clients */

DROP VIEW IF EXISTS v_client_reservation;
CREATE VIEW v_client_reservation
as 
select  `cli_nom` as 'Nom client', `cli_prenom` as 'Prénom client', `res_id` as 'Identifiant Réservation', `res_cha_id` as 'Identifiant chambre', `res_date` as 'Date réservation', `res_date_debut` as 'Début séjour', `res_date_fin` as 'Fin séjour', `res_prix` as 'Prix séjour', `res_arrhes` as 'Montant versé'
from `client`
join `reservation` on `cli_id` = `res_cli_id`;

/* Vue 4 Afficher la liste des chambres avec le nom de l'hôtel et le nom de la station*/

DROP VIEW IF EXISTS v_chambre_hotel_station;
CREATE VIEW v_chambre_hotel_station
as 
select `cha_id` as 'Identifiant Chambre',`cha_numero` as 'Numéro chambre', `cha_capacite` as 'Capacité chambre', `cha_type` as 'Type chambre', `hot_nom` as 'Nom Hotel', `sta_nom` as 'Nom station' 
from `chambre` 
join `hotel` on `cha_hot_id` = `hot_id`
join `station` on `sta_id` = `hot_sta_id`;

/* Vue 5 : Afficher les réservations avec le nom du client et le nom de l'hôtel*/

DROP VIEW IF EXISTS v_client_reservation_hotel;
CREATE VIEW v_client_reservation_hotel
as 
select  `cli_nom` as 'Nom client', `cli_prenom` as 'Prénom client',`hot_nom` as 'Nom Hotel', `res_id` as 'Identifiant Réservation', `res_cha_id` as 'Identifiant chambre', `res_date` as 'Date réservation', `res_date_debut` as 'Début séjour', `res_date_fin` as 'Fin séjour', `res_prix` as 'Prix séjour', `res_arrhes` as 'Montant versé'
from `client`
join `reservation` on `cli_id` = `res_cli_id`
join `chambre` on `cha_id` = `res_cha_id`
join `hotel` on `cha_hot_id` = `hot_id`;


/* Exercice 2*/

 /* vue 1 : afficher par code produit, la somme des quantités commandées et le prix total correspondant : on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot */

DROP VIEW IF EXISTS v_Details;
CREATE VIEW v_Details
as 
select `pro_ref` as 'Code Produit', sum(`ode_quantity`) as 'QteTot', round(sum( `ode_quantity` * (`ode_unit_price` - ((`ode_unit_price`* `ode_discount`)/100) ) ),2) as 'PrixTot' 
from `orders_details`
join `products` on `pro_id` = `ode_pro_id`
group by `pro_ref`;


/* vue 2 : Afficher les ventes dont le code produit est ZOOM (affichage de toutes les colonnes de la table orders_details)*/

DROP VIEW IF EXISTS v_Ventes_Zoom;
CREATE VIEW v_Ventes_Zoom
as 
select `ode_id` as 'Identifiant ligne commande', `ode_unit_price` as 'Prix produit ZOOM', `ode_discount` as 'Réduction', `ode_quantity` as 'Quantié commandé', `ode_ord_id` as 'Identifiant commande', 'ode_pro_id' as 'Identifiant produit'
from `products`
join  `orders_details` on `pro_id` = `ode_pro_id`
where `pro_ref` = "ZOOM";

/*aucun produit zoom vendu */




