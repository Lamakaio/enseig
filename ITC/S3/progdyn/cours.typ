#import "@preview/lovelace:0.3.0": *
#import "../../../utils.typtp": *
#set page(paper: "a4", numbering: "I.1.a")
#set heading(numbering: "I.1.a)")

= Programmation dynamique


Dans les grandes lignes, la programmation dynamique est une méthode de programmation qui permet d'éviter de répéter certain calculs en stockant les résultats intermédiaires.

Les étapes pour résoudre un problème à l'aide de la programmation dynamique sont :
- décomposer le problèmes en sous-problèmes
- établir une relation de récurrence entre ces sous-problèmes
- résoudre les sous-problèmes dans l'ordre en utilisant la relation de récurrence, et en stockant le résultat de chaque sous problème pour une potentielle utilisation future.

== Exemple "simpliste" : suite de Fibonacci

La suite de Fibonacci est définie par :

$ #math.cases([$"fib"(0) = 1$], [$"fib"(1) = 1$], [$"fib"(n) = "fib"(n-1) + "fib"(n-2) " pour" n >= 2$]) $

Si on utilise une fonction récursive simple pour calculer une telle suite, on tombe vite sur un problème.

```py
def fib(n):
    if n <= 1:
        return 0
    else:
        return fib(n - 1) + fib(n - 2)
```

Cette fonction va faire $2^(n-1)$ appels récursifs !


La version en programmation dynamique consiste à calculer non plus $"fib" (n)$ directement, mais toute la suite en partant de 0, en stockant les résultats dans un tableau (une liste).

```py
def fib(n):
    resultats = [1, 1]
    for i in range(2, n + 1):
        resultats.append(resultats[-1] + resultats[-2])
    return resultats[-1]
```

Cette fois, la complexité est en $O(n)$. C'est bien mieux !


== Un vrai problème à résoudre en programmation dynamique : le rendu de monnaie
=== Exemples
#ex[
    On a un système monétaire qui contient des coupure de 1, 2, 5 et 10. Combien de coupure, au minimum, pour rendre 17 ?


    Réponse : on peut appliquer un algorithme "glouton" : on prend toujours la plus grande coupure qui ne dépasse pas le total. Ici, cela donne 10, 5, 2.

    Il se trouve que c'est optimal.
]

#ex[
    On prend un autre système monétaire, beaucoup moins pratique, avec des coupures de 1, 3 et 4, et on essaie de rendre 6. Cette fois, l'algorithme glouton renvoie 4, 1, 1. Ce n'est pas optimal ! On aurait pu utiliser 3 et 3.
]


=== Définition formelle et résolution de problème

#blk2[Problème][
    On a $n$ pièces $v_1 < v_2 < dots < v_n in NN$, et une somme à rendre $S in NN$. On pose $v_1 = 1$.

    On cherche un n-uplet $T = (x_1, x_2, dots, x_n)$ tel que $S = sum_(i=1)^n x_i v_i$, et qui minimise $sum_(i=1)^n x_i$.
]

#blk2[Solution en programmation dynamique][
    + *sous-problèmes* : pour $1 <= i <= n, 1 <= sigma <= S$ on prend $m_i (s)$ le nombre minimal de coupures parmi $v_1, ..., v_i$ pour arriver à une somme de $s$.
    + *relation de récurrence* :
        - $forall i in [|1, n|], m_i (1) = 1$
        - $forall s in [|0, S|], m_1 (s) = s$
        - $
                "sinon", m_i (s) = min cases(
                    1 + m_i (s - v_i) "si" v_i < s "      " & "On utilise la pièce i",
                    m_(i-1)(s) & "On n'utilise pas la pièce i"
                )
            $
]


```py

def rendu_monnaie(pieces, S):
    #initialisation du tableau résultat
    resultat = [[0]*S for _ in pieces]
    for i in range(len(pieces)):
        resultat[i][0] = 1

    for s in range(S):
        resultat[0][s] = s + 1

    #remplissage du tableau par s et i croissants
    for s in range(1, S):
        for i in range(1, len(pieces)):
            #cas ou la dernière pièce est trop grande
            if pieces[i] > s+1:
                resultat[i][s] = resultat[i-1][s]
            #cas général : on prend la dernière pièce ou non
            else:
                resultat[i][s] = min(1 + resultat[i][s - pieces[i]],
                                     resultat[i-1][s])
    return resultat[-1][-1]
```


Cette fonction a une complexité $O(n S)$ (la taille du tableau).


#link(
    "https://notebook.basthon.fr/?kernel=python&ipynb=eJytVV1um0AQvspo84Ib0hjbyQNqc4ZKfsQIbWDirLosaH_aRJbvk5zDF-usAQMOiaqmlh925_-b_WbYsRylNCxOdqxEywtuOYt3zGpnLBYspgPuw6NVZp9rZDHLqwJZyEzldO7vBT6ARlW4rKyU4gKDWmCOJoT1LN4ooN-FUMIKLoXhVlQKCgeW30vkDvTh1ThpuW0sNTY3-A5JMk-_rOGh0pCBUNBETRs7LxVeqrnaYiBRtVlnXc5htESkFIxiRhvV-5vefz3pNU8T470MXPaeFxrLmpAYvsUhkJr7iGiprFxXXq-smUwWDTozgYXU78A5ps-5gcqB5FCgVuLwopFac3jJEdBYsLqqYUuRChw7ioe2g9QMuANzGZ1FPm_YEXovuIq8aKKY7eFVHV41lxADvW3tuTBZHlWtKjWOgNLg39RRChVE9AwjBVz1kNLwbZTJ3zmiWUc867Q6aYng-IS583TN8sopy-JlyCpna2f9vKT78N9HZsDy8eQk9PjLEFZpCLczz7iNqrVQNtgwcW0AIoAFwBJgBXADcLthZOX5EwhizcyTCJUrUXOLQZelo1ATiQw3jP7efgrlaohy1547IMZq5CW5WXwi23eKUnPK5qEsGjQh3BAe4k7Uy0_aBckXI3lz8HJKpHjZJC6oErb_VNubTUUT4n6hzrr2nPoUwpvFZeiF1kSzqLkKug5ms1fwzL8jUZ3WVjsjvx-FRPK4gznQNFIoOg2o_nYegd7xnJ3wDT6m_dnw-ArJtRceBwzGRua40wZRxuoOzFde13QITmbjUenMpkh08x9H5YP3Go3LVB23H5G5scY28Dvup5qJ8Ne15EKRZ0JJlymj0gew9p8j51R-5aQcdzIdpWQ_acfSC9eY-1s7K_WzfazUkgIWwlDJz1mr-HFUgNdI-tQ4-oKdzNme6lP3tEtK3myB7pLR7q00ixf7P6Wukys",
    text(fill: blue)[lien vers un notebook pour executer ce code],
)

=== Retrouver la répartition

Comment peut-on alors retrouver la répartition des pièces ?

On peut suivre en remontant le chemin qu'a pris le résultat : si `1 + resultat[i][s - pieces[i]]` < `resultat[i-1][s]`, c'est qu'on a pris la pièce i, et inversement, jusqu'à arriver à un bord du tableau.

== Un autre problème : la distance d'édition

Lorsqu'on veut mesurer la différence entre deux chaines de caractères, il n'est pas toujours adapté de simplement comparer les lettres une à une : par exemple, "bonjour" et "onjour" sont des chaines proches, mais n'ont aucune lettre en commun (et à la même position).

La distance d'édition est une solution à ce problème.


#blk2[Problème][
    On défini trois opérations d'éditions :
    - *suppression* : on supprime un caractère dans la chaine
    - *ajout* : on ajoute un caractère dans la chaine
    - *modification* : on remplace un caractère par un autre

    La distance d'édition entre deux chaines $s_1$ et $s_2$ est le nombre minimal d'opérations d'édition pour passer de $s_1$ à $s_2$.
]



#blk2[Solution en programmation dynamique][
    + *sous-problèmes* pour $0 <= i <= |s_1|, 0 <= j <= |s_2|$, on note $d(i, j)$ la distance d'édition entre $s_1[0:i]$ et $s_2[0:j]$

    + *relation de récurrence*
        - $d(0, k) = d(k, 0) = k$
        - $
                d(i, j) = min cases(
                    1 + d(i-1, j) & "(suppression)",
                    1 + d(i, j-1) & "(ajout)",
                    d(i-1, j-1) + II_(s_1[i] != s_2[j]) & "(modification)"
                )
            $
]


```py

def distance_edition(s1, s2):
    """calcule la distance d'édition entre deux chaines de caractère s1 et s2, par la méthode de la programmation dynamique."""
    #initialisation du tableau résultat
    resultat = [[0]*(len(s2) + 1) for _ in range(len(s1) + 1)]
    for k in range(len(s2) + 1):
        resultat[0][k] = k
    for k in range(len(s1) + 1):
        resultat[k][0] = k

    for i in range(1, len(s1) + 1):
        for j in range(1, len(s2) + 1):
            #calcul des trois cas
            supp = resultat[i-1][j] + 1
            ajout = resultat[i][j-1] + 1

            if s1[i-1] != s2[j-1]:
                modif = resultat[i-1][j-1] + 1
            else:
                modif = resultat[i-1][j-1]
            resultat[i][j] = min(supp, ajout, modif)

    return resultat[-1][-1]

```


#link(
    "https://notebook.basthon.fr/?kernel=python3&ipynb=eJytVNtu2zAM_RVOe1jTaUOdNBtgoP-wd8cIFJttlciyp8uQIMj_rN-RHxsluUncJMButh9MnUPyiCK1ZRUqZVlebFmDTtTCCZZvmTPeOqxZTj-445E1d5sOWc6qtkbGmW29qYJd4yPU0jqhK5xjLZ1s9Y3NONjxKJ9poGfGwlsJVXmFoMSBD_WH_UtyAdTO0AL6NVTPQmq0ZEAljKjc_idBNgN0FJVDJ0yI0uxf3DOpCTwyO9M-GdE0IoarN1o08rvHzyl7UvJeasomlLQ9y4MTC4XCg9m_WK-ccIlpMFnwAEVxV97eKKRtjUfwEbIRPLYG5iA1GKGfMGFZwsrkHxirN4zeu6_KaRbKUKxKyrW67p1d916VFCB5H_3l0Z9O40qIQFyeE8-VxuqlI6R6W3CmlZaOxw4p1ncdCTkok5-ysliWIdqQKJatdwMm8YicmEOufKTDj6Hg3QN1QCS-0Raepq2Jepb9EPWUi8riH4UYcgeyQ-kbSWWjzfO0M54ijV63YtB5ow9uNEC4xsqHJpxXrdeO5feckWPnXZjHcsf_fiRPevdsMmdsoZc_zIxxGstFq0ksGaQzdIKKndB755Ckd0Zqd6NGlzRPTzVv-_9XWZYGWjTk5nBNXFbccaAGowGecLjnMOXwhcNXqmxByxfAgIzjcvYGDMgkLqTvCAbkPv6mbzxAptE9fQfKhBBSSfdFUl3TNtjun07gUq20V-q_HfHvJSj5IMEKjaa-77AKVr_fbkOXqJ5QQOqVTonNvAe-RQACouhy8OLpSGc70qcX1DN03cbWfTXmNAitYfl49wu8P_gH",
)[#text(fill: blue)[lien vers un notebook contenant le code]]
