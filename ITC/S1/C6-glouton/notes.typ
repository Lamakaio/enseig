#set page(paper: "a4", numbering: "1")
#set document(title: "Cours glouton")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *ITC MPSI* \
    *Notes de cours algorithmes gloutons*
])


Ressources :

https://eduscol.education.fr/document/30067/download
https://clogique.fr/nsi/premiere/gloutons/

= Introduction

Les algorithmes _gloutons_ sont des algorithmes souvent simples, qui donnent une solution pas forcément exacte à un problème. C'est un peu "la solution évidente qui en fait ne fonctionne pas" dans la plupart des cas.

Pour certaines applications, on va se satisfaire d'un tel algorithmes.

On va présenter deux exemples d'algorithmes gloutons.

= Problème du rendu de monnaie

== Présentation
#ex[
    Vous souhaitez rendre (ou payer) 34€ pour un achat. Quelles pièces et billets utilisez-vous ? Attention, on demande d'utiliser le moins de coupures possibles !

    Instinctivement, quelle méthode utilisez-vous ? Essayez de la transposer en un algorithme.
]


Idée : toujours rendre la plus grande pièce possible d'abord. C'est un algorithme "glouton", car il essaye de prendre "le plus possible" à chaque moment, sans anticiper la suite ni revenir en arrière.

#blk1[Problème][du rendu de monnaie][
    On a $n$ pièces $v_1 < v_2 < dots < v_n in NN$, et une somme à rendre $S in NN$. On pose $v_1 = 1$.

    On cherche un n-uplet $T = (x_1, x_2, dots, x_n)$ tel que $S = sum_(i=1)^n x_i v_i$, et qui minimise $sum_(i=1)^n x_i$.
]

On cherche à écrire une fonction Python qui prend en argument
- une liste d'entiers `[v1, ..., vn]`
- un entier S

Et qui renvoie la liste d'entiers `[x1, ..., xn]` obtenue par la méthode gloutonne.

#link(
    "https://notebook.basthon.fr/?kernel=python3&ipynb=eJy1U0tu2zAQvcqA3TSogsr5bASkqx6gqDcGbEFgqIlNlBoq_CQxDN2nOYcv1qFo2S7cdldRAubzZuaRfNoJhcZ4US13osMgWxmkqHbCG92i39jXo9OEbY-iyo4YChFc9AFbUbGB7KdGE0hZxhTC2-hU8nuNCj08wHJWwE0B9wXMSrb4uy-TPRplvaI5g27vVpRWi0-wNjYGSx9zhwLmV9WKgJ9ees8j8A1VDNpSo2ykIKpZIbiijyFtqh6K_7qvfzJciXGN9nekF6sRIiEYzf2hZUPCc5QUdNi_J19t5HNE6PX-p2Jo0Izcv3OAx4FDah3CHHJD-YIqNej272HDrCYahJfDF-ngS3iyDhrQBJlpnZOakwYn-ldwDTP4oKnVauLYoiOm5C6Z5Q6vG20SsS9QVgd2p3Buu9Q1p-fn6Tz7-gFmp9g8-ceKU3yR6j8doQ5DdASLpJHL0_-TKO7ORbE72NOlZjQ2Dn004S_lk4ACvoXPvZGauHJZjmpOCh7fMr91ktGZ6oahHurfIuIHnyka36NKHslu_Eu2fJV0ywxa7XnGtjkkvo0JSBkjaR3l-gQXB4kGa82jdBz_qmVvnexkStEjX3sn8yYmp-k0WYbeDL8AIGxOqA",
    text(fill: blue)[lien vers un notebook contenant le code],
)

== Non optimalité

Sur notre exemple des €, il se trouve que l'algorithme glouton donne toujours la solution optimale. On dit que c'est un système monétaire _canonique_. Mais ce n'est pas toujours le cas !

#ex[
    On prend le système monétaire qui a des pièces de 1, 3, et 4. Si on essaie de rendre 6, que donne l'algorithme glouton ? Est-ce optimal ?
]

L'exemple a peut-être l'air un petit peu "construit", mais des systèmes non canoniques ont bien été en circulation dans l'histoire.

#ex[
    Avant 1971, le système britannique avait des pièces de [1, 2, 6, 12, 24, 30, 60, 240]. Pouvez-vous trouver un exemple où le glouton n'est pas optimal ?
]

Réponse : 48

On ne connait de condition nécessaire et suffisante pour qu'un système soit canonique.


= Construction d'emploi du temps

Vous allez dans une convention / séminaire / etc, où un certain nombre d'événements et de conférences se produisent. Vous souhaitez assister a un maximum de conférences.

#image("edt1.png")

Par exemple, ici, on peut assister à 2 conférences maximum.

Comment choisir à quelles conférences assister ?


== Première solution : on les prend dans l'ordre de _début_

== Deuxième solution : on prend les plus courtes d'abord

== Troisième solution : on les prend dans l'ordre de _fin_
