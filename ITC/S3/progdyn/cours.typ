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


== Dernier problème : algorithme de Floyd-Warshall

Petit retour sur nos amis les graphes !

On va utiliser la programmation dynamique pour calculer le plus court chemin entre deux sommets d'un graphe.

On va prendre des contraintes un peu différentes (par rapport à Dijkstra) :

On cherche le  plus court chemin entre chaque paire de sommets pour *tous* les sommets du graphe.

On se donne un graphe dirigé pondéré $G$ avec un ensemble de sommets $S = [|1, n|]$ et un ensemble d'arrêtes $A subset S times S times ZZ$ (les arrêtes peuvent avoir un poids négatif !). On suppose que G n'a pas de cycles de poids négatif.

Soit la fonction $d(x, y)$ qui renvoie
- 0 si $x = y$
- $w$ si $x$ et $y$ sont reliés par une arrête de poids $w$
- $+infinity$ sinon

(cela correspond à la matrice d'adjacence)

#blk2[Solution en programmation dynamique][
    + *découpage en sous-problèmes* : on note $scr(C)(x, y, k)$ la taille du plus court chemin entre $x$ et $y$ deux sommets, en ne passant que par des sommets de $[|1, k|]$
    + *relation de récurrence*
        - $scr(C)(x, y, 0) = d(x, y)$
        - $
                scr(C)(x, y, k) = min cases(
                    scr(C)(x, y, k-1) & "on ne passe pas par k",
                    scr(C)(x, k, k-1) + scr(C)(k, y, k-1) & "on passe par k"
                )
            $

]


#link(
    "https://notebook.basthon.fr/?kernel=python&ipynb=eJztW3tv47gR_yqsF22Tni3zTSq9vaLNtYsCfRzabYvCCQKtrSTa2LJryXl0ke_Sf_s5-sX6G0ryI9b53NjbB9A9IBbJ4Qw58-NwhuR96gzT8bjonA0-dSZpmYySMumcfeqU80VRpqPOGT7S526guiqfZmnnrDOcjtJOt1NMF_MhlbPJbDov2c08md3eZ3-9yEfpNUuur7PhbTq_CtXpSfVzenaRM_wbTUv2dtkj-joLnydFOc-G5dv3kHlaEV5P56zosjHL8oo8jbIynRQnDaeG6OS-y2anRDZea6llRenoJiXuJ8Vpl9Hvff07O60FzdNyMc-JGFNLH9Phosym-dVwusjLzpnodqaLcrYoSVOXz93XK6uaBCb_qZLL2RkbnKgu6ykM6UR2mTu97FZtIrTxLhOC2kAklm0ytIkuM9Sk0X_VpkIbWMlllW5YyZqTCU3PbZOVR5vst4CgTahaF_qp_m74VtTp1TwtFuNWA6H7coDpY9mfjZMsR88vlxgjGNQ4Y9MPH9NhyZKS8UchRtep4l-BazZJbtJ-cX_zxeNkTJ1_gl92n84LSHp70RERv-iwNMc0s_wGFX94_4ueR1VRJvkoGU_zFJX59KLzk68u8i-_9_Vvz9__-ZufM3Bk3_zhZ7_65Tm76PT6_T-p837_6_dfs9__8R0Tkej3f_6biw4MddG5LcvZWb__8PAQPahoOr_pv6MRZ8OiD-I-EaMjjVGIaFSOLjpBUq_H3qV5Ok9gGfbhabmymsEzGWkeCeCLCyukNBFXXBP0e72GwfusHKdn7PucfQM1FGeAX9VIw3_IRuUtqcDzWYkZ36bZzW2JCiVCBTjdZ-nDz6aPqOMR5yz8ES6OrGYggnx0gz7z4m3bNCXnnKbVEJ09jrP8rpVUxHHcD83V7G9YNgJhmDMJGY6TomgqUC7nSV7AR0xQVwyTcXoisJDYfFpCXSf8tCIYUwFD5TaCYgLjkjTy1ff5l_3qC1Wz6fjpBvq8zsZjsHtzHf4FCMynd2T-wGyWzNOc9DSbZnlJg-nprmb40wsCoBgDxciXxUCiLzr9xii8tkE9xxwLTKxNkcrrY10fKtZlNivSZqg50Lk-zjc8_CNmZDMnaABUeqLRSq8jjIPNqU06-noK5q_HRouM0Z9ekg9vp3O0TbLRaEwiNtjV3HhEhetpXvauk0k2pur32SQtukU6z66btiL7K41N6CiMrNFyM9QwPwilEfRvGh2pbR3JHTpSr9ZRbDd0JGIY7QAdLdnV3ETQ-ME6Um064j94o82Pf3BT_viFtmhnXEcUlTcQteq4vgyS8va7lUb8f-1s5LgQ3Z60QLo6BxQwVSwEaTADJR0D1HzsDWqUi5RQzPvIW4WyVJFUQtb6fLn2lnJaRC_XXSwjqWMSJ3UkhLMMejYxpxqhIqMV5JnICBEEglpy0Lzsta9JYUMn1RL3ykT-GDYNRmg1rNwGv9oBfvlq8Cu_CX74LX8A-Jfsam4yLKWDFSV3g19ug1_uBX75OvAD8oY7V4PfC31uZWSsJ6wZwphwzLhIigB3JSJnvWFGVXsDAdQy7SOtiYfwDkvHOqZ1pIxHhcHact4zTR1jIgHgsJfoQ1aMNlgDMiZmGmONY4bQwXiP1SAocNDSMFhP1uKU54Zt9dkTBZi7-Awu0LVuE7tQ4HagQB2KAvgXp4K-HDxb7PS5o3kb0qhFm-GCWQrJtEWNBh64ZwYqrUhUcErqEJtCzzEXkiwYR95bwXQMZMpgUxVp6YBDCdtyGoFSkROabXXad--3G0bV7rMtbLHt_PQO5yeO5vyO6PnUcXYI0bo5LJErtiFvdkB-rePrIF9NstvDVq45t-dNGdiQsY5ZU7YIDDk25aas4SatO8x_SYKfCLy4k0vWqi6ajWashE36Pa1Y9WqsaPxx4lvTZkW9jXKzA-X61SgX2FiOBvMVs6PiXO_Gud7Gud0L5_p1OIeXto5cOyJGAx9_7lTEjSekw3tio2eCc3LfCG_Jo2PHZELEaBKoIWg64w5Bu6CQVRkwQxCglLVMSBdZo4g9NQkPgS5ymiPEAPhjxx3b6rWvUSlbXQtwj4X7YIZWFyaWFuLbplU7TLvW8XWmhRqVpTCLQhqn4nMBa3lHjsJHKhaSgSBGu_VRbJRlcunyPOuJiHtLmymnYC02rAfH5ilo43EkuFENuUCGARMRfAxFCBp7r4SDjJEKGUqbpI94TAEBVG80xZLQulPcHxQQYNPXlnIueGAjMRmL2EvpmGocQlWAxCBEUJyGgEgAoA6B6WavfWGzueUdJyIQ34GXlkRX74WXVya6UImLaeXDYMY5ee5Q4WNZAch6wbyIrLWwoIaTcEgzEdAHDBgNNwEdc4uAzMeRFjHVwF_YEGU75KeWagSlEwQT2Mhoe1BMGANXnLJeYqa0ioOr4pZSEQHv5eAfGME3ViFOBMzxIdlWv719x2awf6yUrxUGepfb8DtgoA91GwKRteZx5Wy9sPJcGE7xvwrO1jiN1W5EFHujgivhdCghjFxBgZaZIcvTmpQIUahGWDpEsQreROgVPUAGfmAjvPVV_uWUoC4xMGYIPmHfIUApuZ5XkuPhXnpKPOF9ODyY4PBdSAtoydMxDTK7GPmJ9iGDxRiMFwdBjqZBOQ35DwcF0FGP0g5-UjraJjGzGPtmHBJkpERex4pt9doXcEb_uxIRvcvrxHvB7ZVeBxMEpkg7iG-V9NimFG0wsQ1gcSbGbq84digKcYWwkVceVaI-fyacwPCYrlY-LGqJ4IQwJ-gjDs4GnOOYAhcEC2EHFDYGa2EPilwANviZuHYtmpODs2AbzhEoUyaXRAPDjKgGi4fO5rb77YsH9Xkc0FbQXv8t7um389xdvz97fj7oRu16Pp2wCcGjvnXN8uvqwvV6PH0aXT0k8-I2GY9P3jUXpG-G0xxmWAzpuoyNUjZOiME8G6Zs9MNk9DEZpvkwrYjRcIUq9pYNBuB8yX7ExmkOZuGO9YquV99drm5mT4ouu59mRZYX4er13Y7L2YdAUVO_uKKtxQ6Ky8H9JYQ_rJrXmgpq4lVTPbdxWrDhbToBS5bmbIZFluQlfucsWQwXOSumE6gaP6gdTfP8H38Pjbt0MMroOm8IztBCLb6e85s7dvZt8mgolbSC8S6LoqjL7laquqPZz5P8Jj2pNLquozx9uCKxQe-_wYLfpfiGY7aLY0P08buI1sUPssvBR1Iy5neyVMOgJy6rli7bqry7ZF-8qL0j0tOVlGVrlMxmaT46acSdrpuyuX9viNsuefXRLqbXbfxi4dR31Bd5vcBmszkc1kVe_Uaz2UozrRfZZtdFNhZimkzQjRwGyoPBAFjBSusyR08Awnd1Zz_Ads-aRrHeEGrMqhFKX2sIf2TTWrfIun7Z9TI0fLd04Y8nPCbqQ2QL24i2hwoWcinXtkoVbqdQonKNRLGSJ3SrOF1Vkbie3JSngjj5Kmk29N1HmG6T1YjqyTVZag9R8ETAcJ5MKkyPAPLOYftay-oiZ9K6wuy_tsJaNdKikFZ9tKhjSxtHV8abWYpQkGHik9k4Zcl9OmTYy4ZPQ5SwgyOEGhUMe9lNUiJMySuXJV8-KhIbj4KWj4mo7iJ_vsjbX-fIVp27w57nuNc_z4njNP3w_-c5-z3PsXLzdY5QasfrHIT69EYH2Z__33icIySygs_5OCcIYOFutfn6zz3JCYfux7ltD12Om_W0PsVpuZDb9RTn9Rdy67o5kmI-50Uc33URt9_zm1dexAkXeUMH0R55fuzsORJ_ySl79pgw3e4jz7eOTvgcXTwbyrkjpejxSzhbiiMv6FTTqkh7kC_LoBJcrKjp5Cocawl8c7rnFsQ7FpTPazpPVHQUEcFBoKwjq_RBh0mCTh9JsDaRhVS2nCpd8XFJxwmYIa_PW2liL3rse24Avor_t9x57HqvcoQ7j-ae9Jw-NaYqtWL0bXWkY-PDt_ORsgfdP0gVGU53Cy5cEJvAtr4sZopvNFr2knrfm3b5bzTcZzz0WQXHrbmqPG0N2fy_nohS0MsGTT7BXtQhdA6VITxWoZYCar1nPvBikpNkfjeaPuQbgS_7XfriuGp5vtM5KN9Pr2s-q_yiyx677KnL7pojEcRJ-O93aX4_zdIQcIceDEH3bLzAQMANUXkO1bFHlpbsic6AoPNxFk6B1k-APi6Kvyx--I-_sbuoPuD4aVmiKybVZXkK1M7BOqUTJFZkDFNNdoT4UTW0ilF2zU7u2Nu3FMivHea8Qcd6wGlRslE2pxh6fbQr2vqwZdAcaw0xiumiGgWN6ENaYKGy0aI5P7tbil6lZ3dfiMvB4-Xg6ZIGs1Zf155tyftWCzD4vPo0KB0XiHL363rXdGVfsOokapvsbk1C6__s4I92qLQtvMrwdbvg-LCUivq35lSUsmKF6svjOqG2MeSL8XhTfZcbIjt36TyHRWfpkEq1g5g9lbfTXIEhVIVRP13VDd-EBkYt4yS_WSDPWZJ3njG-_ANlCkl1FNgUrqD06RwKef4nPVVHFQ",
)[#text(fill: blue)[lien vers un notebook contenant le code]]


*Note :* on utilise uniquement la valeur de $scr(C)(dot.c, dot.c, k - 1)$ pour calculer $scr(C)(dot.c, dot.c, k)$. Cela signifie que l'on est pas obligé de stocker tous les tableaux, on peut se contenter seulement du tableau précédent.

En revanche, si on veut reconstruire les chemins, on a besoin de tous les tableaux.

== Retrouver le chemin avec le tableau des prédécesseurs

Utile dans le cas où le calcul de la relation de récurrence n'est pas rapide (par exemple un maximum sur n valeurs).

L'idée est de créer un tableau de même dimension que le tableau de stockage du résultat, qui, pour chaque case, indique quelle case a servi à la calculer.

#link(
    "https://notebook.basthon.fr/?kernel=python3&ipynb=eJytVktu2zAQvQrLLhK3bBHZSYMKyB26twWBlsaJbIpS-SliGN52nWx6huYcvklP0iEpf2TJzQeVBUvUvHnzhpyhtKIZCKFpPF7REgzPueE0XlGjrDaQ0xhvYM08KjXLGmhMsyoHyqiurMrcOIcZyQttuMwghbwwRSXPdcSIHg7iiSR4TKj7ZVxkVgARfIcn-dnmKbgQkEbhA7D3JLvjhQSNA5JxxTOz-Y0mHREwyMpIzZVjKTdP5g7VOBwOa1XdKl6W3NPlS8nL4ruFzyF6UPK-kBiNi0I3KEsMnwrglqjNk7bCcBOQCsKI3JDx-CL5cC4A0xoOyEcSDcisUiQlhSSKy1sItijYkuBfK8ghA63BKs8xoemEvp7HIRZHiMa7md1Dtah0vEgw3uK0d3Tae5EgQfDe-xd7f1zVExQOOO8Cu0r9KoRSwHXTxKiq0LjMug3Rtq5RyE5Z8SlKxvPEsbWBfF5Z00IiDsEB2cYWMywiT0Xe3WAleeCRNneUVY7QTvQd6yEWhIZXUbSxLdlu6ssCpw2TZyEzFpgGnUSOHW_8lMWkK-WwEndhJvTPz8dtV-xz6SX2QnpyPEn80CXGSXqNtF-OYduIxiq5k8VaTrgRwT1k1jVzmlVWGhpH14yi4Noat7Ela_b2va0_KGrsbHgTOpXzH2pCGeqfVhKnDAe4bK4xhG-Mhms7D7UqpDkXA5fnDnQYpgvcjwa9iX89THzV3G9z07i98hL9DNwjmI4vGME2xe10xMglI1eMfGHkGutzjI97jM4y9I-jI6OzjPyDcO6NznLpb8M5bFmuvHs4d5CRs5ylZ4w8-5e4uWuwWDPh8vCSS9vzsUXwb55ez8c-njd4niB4uedxJt4T1xzfhaEGciwKuj7dFDOOrfpMV_TVnrRCvKzt_l-EhLUiLEBJ3GhqyNyoybhe4ieCHCEhtmwt-DJtDN-8gTiLwFeW5bd7OF2jPjnFrsSPCRpf7gcpbs-VovFw_ReSx-MU",
)[#text(fill: blue)[lien vers un notebook]]

== Utiliser des dictionnaires pour la mémoïsation

Parfois, quand on ne rempli pas tout le tableau, et qu'on veut utiliser la méthode descendante (donc avec de la récursivité), on peut utiliser un dictionnaire pour stocker les valeurs intermédiaires à la place.

C'est un peu plus lent, mais ça peut simplifier le code.


#link(
    "https://notebook.basthon.fr/?kernel=python&ipynb=eJylUm1qGzEQvcqg_vFSBeIkFCpIz1DwT8csqjR2RbUjoQ-IWfY-zTl8sc56HduhmxZa6cdqdt7Me2-YXhj0Pgu17kWHRVtdtFC9KKnmglYofuAgj6i27CMKJUywKKTIoSYzxha3kJBsbbtApB0uokODWcJKgoNHuFlKsM4EfvZDo54I-LgteKQTtIGPI_IRbhVM6fEkLDURrM4FC8c9G3B0bDcDHX-vJ9RmSn4wOkOo4DVYTOQOPxNC5I9BwFygpBBhlzRZPNNMmtZuA19gpS4k193Zyx8838CyueLfHV7o8JK0BwWBII6Vs4pYKAWaKtFnfJ-8c7RY8tTeEcEKzi5YUCMvjWbPX7yczMxMmRcBn9HU4gK1JlQqQn2WItQSaxn3ajPIf1-thLn6ostv017zSt1LeGBzn1jceGNyVBavFc2csOXttbL-9H4lzyWh7riu4DODxd0TcUC6m5KW0WL4Lztzmqh6_3ZeG_mG4AcvCe9CRDNGJzlxX74HuueG1uXo9b49Jb4eEzBmvKZd1bsLXAysj75tQ-o0Mz9cgpbXKSSh7oZfFZ1SZw",
)[#text(fill: blue)[lien vers un notebook]]
