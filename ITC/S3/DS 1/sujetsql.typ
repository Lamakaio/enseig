#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
#set heading(numbering: none)
#import "../../../utils.typtp": *

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
  *ITC MP\* interro SQL* \
])

Ce sujet est un extrait modifié du sujet des Mines 2022.

= Recherche dans une base de données de matériaux magnétiques

Il existe des bases de données contenant les propriétés de nombreux matériaux, dont des propriétés magnétiques. Dans cette partie, on donne un modèle simplifié d'une telle base, et on souhaite effectuer quelques requêtes sur celle-ci.

La base de données possède la structure suivante :
- La table `materiaux` contient un champ `id_materiau`, clé primaire de la table de valeur entière, un champ `nom` de type chaîne de caractères pour le nom du matériau et un champ `t_curie` de valeur entière pour la température de Curie du matériau en kelvin.

#align(center)[#image("materiaux.png", width: 60%)]

- La table `fournisseurs`, contenant un champ `id_fournisseur`, clé primaire de type entier qui précise le code de chaque fournisseur, et un champ `nom_fournisseur` de type chaîne de caractères pour le nom du fournisseur.

#align(center)[#image("fournisseurs.png", width: 50%)]

- La table `prix` qui contient un champ `id_prix`, clef primaire de type entier, un champ `id_mat` qui est une clé étrangère pointant vers le champ `id_materiau` de la table `materiaux`, un champ `id_four` qui est une clé étrangère pointant sur le champ `id_fournisseur` de la table `fournisseurs`, et un champ `prix_kg` de type flottant qui précise le prix au kg que ce fournisseur propose pour ce matériau, en euros. Un fournisseur qui ne propose pas un matériau donné n'a pas d'entrée correspondante dans cette table.

#align(center)[#image("prix.png", width: 50%)]

Les requêtes demandées dans cette partie sont à écrire en langage SQL.

6. Écrire une requête permettant d'obtenir le nom de tous les matériaux qui ont une température de Curie strictement inférieure à 500 kelvins.

Un client potentiel souhaite acheter 4,5 kilogrammes de nickel et sélectionner le fournisseur le moins cher.


7. Écrire une requête permettant d'obtenir l'identifiant du nickel.

Par la suite, on pourra utiliser cet identifiant, `8713`, dans les requêtes.

8. Écrire une requête permettant d'obtenir les noms de tous les fournisseurs proposant du nickel et le prix proposé par chacun pour 4,5 kilogrammes de nickel.

9. Modifier ou compléter la requête précédente afin d'obtenir le nom du fournisseur de nickel le moins cher ainsi que le prix à payer chez ce fournisseur pour ces 4,5 kilogrammes de nickel.

10. Écrire une requête permettant d'obtenir le nom de tous les matériaux et le prix moyen pour un kilogramme de chacun de ces matériaux (la moyenne étant calculée pour tous les fournisseurs proposant ce matériau), en se limitant aux prix moyens strictement inférieurs à 50 euros par kilogramme.
