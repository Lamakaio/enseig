#import "@preview/lovelace:0.3.0": *
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *
#set page(paper: "a4", numbering: "I.1.a")
#set heading(numbering: "I.1.a)")

= Introduction

Le cours d'ITC présente de manière assez rapide plusieurs concepts d'apprentissages et de jeux. Les détails des algorithmes ne sont pas au programme.

= Apprentissage

== Apprentissage supervisé

=== K plus proches voisins

#def[Jeu de données][
    On appelle _jeu de données étiquetés_ un ensemble d'objets, associés à des _classes_.
    En général, les objets sont ramenés a des éléments de $RR^n$, et les classes à des entiers de $[|0, C-1|]$.
]

#def[Apprentissage supervisé][
    Un algorithmes d'_apprentissage supervisé_ prend en entrée un jeu de données, et l'utilise pour classifier de nouveaux objets inconnus.
]

Première idée : On a des points de $RR^n$ rangés dans des classes (=des catégories). On veut ranger un nouveau point de $RR^n$ dans ces classes.
On peut simplement regarder la classe de l'objet le plus proche (ou des K objets les plus proches) et classifier notre objet en conséquence !

C'est l'algorithme des K plus proches voisins (aussi appelés k-NN).

#link("http://vision.stanford.edu/teaching/cs231n-demos/knn/")
=== Test et validation

Si on utilise tous nos exemple pour l'algorithme, comment évaluer ses performances ? On ne peux pas le tester sur un objet qu'on lui a fourni à l'entrainement, ce serait de la triche !

#def[données de validation][
    Lorsqu'on a un jeu de données, on va garder (aléatoirement) un certain pourcentage d'entre elles, en général réparti uniformément entre les classes, pour la validation.
    Souvent, ce pourcentage est au alentours de ~1-10%, mais cela va beaucoup varier en fonction des données.

    On va ensuite tester notre algorithme sur ce jeu de données de validation, et mesurer les erreurs.
]

#def[matrice de confusion][
    On peut ensuite écrire la _matrice de confusion_ associée : il s'agit d'un tableau où, pour chaque classe, on indique le pourcentage d'objet de cette classe qui ont été placé dans chaque classe par l'algorithme.

    #table(
        columns: (1fr, 1fr, 1fr),
        "", "A", "B",
        "A", "95%", "5%",
        "B", "1%", "99%",
    )

    Ce tableau indique que, parmi les objets réellement de classe A, 95% ont été bien classifiés et 5% mal classifiés.
]

== Apprentissage non supervisé

On a maintenant un problème différent : on dispose toujours d'un jeu de données, mais cette fois il n'est pas _étiqueté_, c'est à dire qu'on ne connait pas la classification des objets.

On aimerait automatiquement déduire une classification des objets en $C$ classes, en fonction de leur complexité.

Plus précisément, on cherche à minimiser la quantité $sum_(S "une classe") sum_(x in S) ||x - mu_S||_2$ où $mu_S = 1 / |S| sum_(x in S) x$ le barycentre de la classe S.

Pour cela, on va utiliser une méthode _itérative_.

#link("https://hckr.pl/k-means-visualization/")

#pseudocode-list(hooks: .5em, title: smallcaps[Algorithme des k-moyennes], booktabs: true)[
    + *Entrées : *
        + un ensemble de données D (des vecteurs de flottants)
        + un entier C le nombre de classes
    + *Sortie : * une association de D à $[|1, C|]$

    + Placer $u_1, ..., u_C$ des centres. _(On peut tirer les positions aléatoirement, ou bien utiliser des méthodes pour les répartir équitablement dans $D$)_

    + *Tant que* on n'a pas convergé _en général, on s'arrête quand l'attribution ne change plus_
        + *Pour* i de 1 à C
            + $S_i$ $<-$ l'ensemble des points pour lesquels $u_i$ est le centre le plus proche.

        + *Pour* i de 1 à C
            + $u_i <-$ le barycentre de $S_i$
    + *Renvoyer* $u_1, ..., u_n$
]


La preuve n'est pas au programme, mais l'algorithme de k-moyennes converge toujours. En revanche, il peut converger vers un minimum _local_ de la fonction de coût, ce qui peut donner des résultats absurdes.

Le placement de départ des points a une influence importante sur la qualité de la solution obtenue.

= Modélisation des jeux

On va, durant toute cette partie, utiliser l'exemple du jeu de *Chomp*.

#image("Chomp_gameplay.png")

C'est un jeu à deux joueurs, qui se joue avec une tablette de chocolat. Le carré en haut à droite est empoisonné, et donc, le/la joueur.euse qui la mange a perdu.

Chacun leur tours, les joueurs doivent manger un rectangle de carrés en bas à droite de la tablette.

#def[jeu de Chomp][
    On prend un rectangle (la tablette de chocolat) de taille $n times m$.

    Le carré en position $1 times 1$ est empoisonné.

    Chacun leur tours, les joueurs choisissent une case non mangée $i times j$ et mangent tous les carrés situés dans le rectangle en bas à droite de cette case (la case inclue).

    Un joueur perds si il est obligé de manger la case $1 times 1$, et, dans ce cas, l'autre joueur gagne.
]


== Graphe d'accessibilité

