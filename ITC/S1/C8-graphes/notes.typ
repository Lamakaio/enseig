#set page(paper: "a4", numbering: "1")
#set document(title: "Cours glouton")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

#import "@preview/gviz:0.1.0": *

#show raw.where(lang: "dot-render"): it => render-image(it.text)

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *ITC MPSI* \
    *Notes de cours sur les graphes*
])

Les _graphes_ sont une manière, en informatique, de représenter des données avec des liens.

#ex[
    ```dot-render
    graph {
      A -- B;
      A -- C;
      B -- C;
      B -- D;
      D -- E;
      A -- E;
    }```
]
= Présentation générale
== Définitions et vocabulaire

#def[Graphes][
    Un _graphe_ est un couple $G = (S, A)$, où $S$ est un ensemble fini de _sommets_ (ou _noeuds_) et $A in S times S$ est l'ensemble des _arrêtes_. Chaque arrête relie deux sommets _distincts_.

    On dit que le graphe est _orienté_ si les arrêtes ont un sens ("que ce sont des flèches"). On les appelles alors souvent _arcs_.
]

#def[Voisin][
    Si on a une arrête $(s, s')$, on dit que $s'$ est un voisin de $s$.
]

#ex[
    ```dot-render
    digraph {
      G -> H;
      G -> I;
      H -> I;
      H -> J;
      J -> K;
      G -> K;
      J -> H;
      K -> H;
      I -> G;
      L
    }```

    Ici, les voisins de `H` sont `J` et `I`.
]

#def[Degrés d'un sommet][
    Dans un graphe non orienté, le degrés d'un sommet $s$, noté $d(s)$, est le nombre d'arrêtes qui le touchent.

    Dans un graphe orienté, on note $d_+(s)$ le degrés entrant et $d_-(s)$ le degrés sortant, qui sont respectivement le nombre d'arcs qui arrivent et qui partent de $s$.
]

#ex[
    - $d(B) = 3, d(D) = 2$
    - $d_+(G) = 1, d_-(G) = 3, d_+(L) = 0$
]


= Chemins, cycles et connexité

#def[Chemin][
    Un _chemin_ dans un graphe est une suite finie d'arrêtes consécutives $(s_1, s_2), (s_2, s_3), ..., (s_(n-1), s_n)$.

    On parle de chemin _élémentaire_ lorsque les sommets $s_1, ..., s_n$ sont distincts, et de chemin _simple_ lorsque les arrêtes sont distinctes (ces mots de vocabulaire ne sont pas au exigibles).
]

#ex[
    ```dot-render
    graph {
      A -- B [color=red];
      A -- C;
      B -- C;
      B -- D [color=red];
      D -- E [color=red];
      A -- E;
    }```

    AB, BD, DE est un chemin.
]

#def[Cycle][
    Un _cycle_ est un chemin simple dont le premier et le dernier sommet sont les mêmes.
]

#ex[
    ```dot-render
    digraph {
      G -> H;
      G -> I;
      H -> I [color=red];
      H -> J;
      J -> K;
      G -> K [color=red];
      J -> H;
      K -> H [color=red];
      I -> G [color=red];
      L
    }```

    HI, IG, GK, KH est un cycle.
]

#def[Connexité][
    Un graphe non orienté est _connexe_ si, pour tout sommets $s_1, s_2$, il existe un chemin de $s_1$ à $s_2$.
]

#ex[
    L'exemple 1 est connexe.

    ```dot-render
    graph {
        A -- B;
        C;
    }
    ```
    Ce graphe n'est pas connexe.
]
#rq[
    La notion de connexité est hors-programme pour les graphes orientés. Pour donner une idée, on parlera de graphe _fortement connexe_ si il existe un chemin de $s_1$ à $s_2$ et de $s_2$ à $s_1$.
]

= Représentation informatique

Il y a plusieurs manières de représenter les graphes en Python. On va en voir deux principales.

== Représentation par liste d'adjacence

L'idée ici, est de stocker, pour chaque sommet, l'ensemble de ses voisins. Dans le cas des graphes non-orienté, on stockera en général les connections dans les deux sens.

Par exemple, pour le graphe de l'ex 1, la liste d'adjacence du sommet `A` est :
```python
['B', 'C', 'E']
```

Ensuite, on va regrouper toutes ces listes d'adjacence dans un dictionnaire, pour avoir la représentation suivante :

```python
g = {
    'A': ['B', 'C', 'E'],
    'B': ['A', 'C', 'D'],
    'C': ['A', 'B'],
    'D': ['B', 'E'],
    'E': ['A', 'D']
}
```



Exercice : faire la même chose avec l'exemple 2.


#rq[
    Dans le cas où les sommets sont numérotés de 0 à n-1, on peut utiliser une liste à la place d'un dictionnaire.
]

#rq[
    La représentation par liste d'adjacence est très adaptée lorsqu'on veut souvent accéder aux voisins d'un sommet particulier, par exemple lors d'une exploration du graphe.
]

== Matrice d'adjacence

Dans le cas de la matrice d'adjacence, on va toujours numéroter les sommets de $0$ à $n-1$.

On va alors se donner une matrice de taille $n times n$, et à la position $(i, j)$, on va placer 1 si l'arrête $i -> j$ si elle existe, et $0$ sinon.

Dans le cas de l'exemple 1 :

```python
g = [[0, 1, 1, 0, 1],
     [1, 0, 1, 1, 0],
     [1, 1, 0, 0, 0],
     [0, 1, 0, 0, 1],
     [1, 0, 0, 1, 0]]
```

#rq[
    La matrice d'adjacence d'un graphe non-orienté est symétrique.
]

Exercice : faire la même chose avec l'exemple 2.

#rq[
    La représentation par matrice d'adjacence est adaptée lorsqu'on a souvent besoin de tester si deux sommets sont adjacents.
]

= Pondération

== Applications

Les graphes se retrouvent un peu partout en informatique :
- Pour tout ce qui est carte. Une carte de transports en commun est un graphe par exemple.
- Internet, à deux niveaux :
    - l'architecture physique d'internet est un grand graphe, avec des serveurs, des routeurs et des terminaux reliés par de la fibre optique, des ondes, etc
    - le web : les pages webs, et les liens entre elles, sont bien représentées par des graphes.

Dans tous ces exemples, des algorithmes sur les graphes (on en étudiera quelques uns) sont utilisés. Par exemple, la recherche d'itinéraire de votre appli de carte préférée, le programme qui décide comment acheminer votre message whatsapp, ou encore les moteurs de recherche (Google).


Dans beaucoup de ces applications, toutes les arrêtes ne sont pas égales. Par exemple, un trajet en train peut prendre deux fois plus longtemps qu'un autre.


== Graphes pondérés

Pour représenter ces différences, on va introduire la _pondération_.

#def[Graphe pondéré][
    Un graphe pondéré est un graphe $G = (S, A)$, orienté ou non, auquel on associe une fonction de pondération $omega: A -> E$ qui associe un _poids_ (ou étiquette) à chaque arrête.

    $E$ est ici un ensemble quelconque, mais en pratique, ce sera souvent $NN$ ou $RR^+$.
]

#ex[
    ```dot-render
    graph {
      Caen -- Paris [label=2];
      Caen -- Rennes [label=3.5];
      Rennes -- Paris [label=2];
      Paris -- Tours [label=1.3];
      Caen -- Tours [label=3];
      Tours -- Lyon [label=3];
      Paris -- Lyon [label=2];
    }```

    Exemple de quelques villes et le temps de trajet en train entre elles. Quels sont les chemins possibles entre Caen et Lyon ? Quel est leur poids ?
]

#rq[
    On peut alors parler du poids d'un chemin, d'un cycle, ...
]



== Implémentation des graphes pondérés

=== Liste d'adjacence
On peut stocker les poids directement dans la liste d'adjacence, en mettant des couples (voisin, poids) au lieu des simples voisins :

#ex[
    ```python
    g = {
        'Caen': [('Rennes', 3.5), ('Tours', 3.0), ('Paris', 2.0)],
        'Rennes': [('Caen', 3.5), ('Paris', 2.0)],
        'Paris': [('Caen', 2.0), ('Rennes', 2.0), ('Tours', 1.3), ('Lyon', 2.0)],
        'Tours': [('Caen', 3.0), ('Paris', 1.3), ('Lyon', 3.0)],
        'Lyon': [('Paris', 2.0), ('Tours', 3.0)]
    }
    ```
]


=== Matrice d'adjacence
On peut mettre le poids de l'arrête à la place de "1", et utiliser une valeur qui n'est pas dans les poids à la place de "0" (par exemple $+ infinity$, où, si ce n'est pas une option, $-1$).

#ex[
    ```python
    g = [[ 0.0, 3.5, 2.0, 3.0,-1.0],
         [ 3.5, 0.0, 2.0,-1.0,-1.0],
         [ 2.0, 2.0, 0.0, 1.3, 2.0],
         [ 3.0,-1.0, 1.3, 0.0, 3.0],
         [-1.0,-1.0, 2.0, 3.0, 0.0]]
    ```
]

= Parenthèse : structures de données, pile, file, file de priorité

== Structure de données abstraite
Une structure de donnée est un objet informatique permettant de stocker une collection d'objets. Vous en connaissez déjà deux : les listes et les dictionnaires.

On distingue la _structure de donnée_ de son _implémentation_ : lorsque vous utilisez une liste ou un dictionnaire en python, vous utilisez par exemple la méthode `.append(...)`, ou bien l'opérateur `d[obj]`. En revanche, vous ne vous intéressez pas à ce qu'il se passe, concrètement, quand vous les utilisez : ils fonctionnent et c'est ce qui compte.

Dans ce cas, vous utilisez la structure de donnée, sans vous soucier de son implémentation.

#def[Structure de donnée abstraite][
    Une structure de donnée (abstraite) est une collection d'éléments munie d'opérations.
]

#ex[
    Par exemple, on peut définir la _liste_ comme une collection d'éléments munies des opérations suivantes :
    - accéder et modifier un élément par son indice
    - ajouter un élément à la fin
    - retirer un élément à la fin
    - connaitre la longueur de la liste
]

#ex[
    Par exemple, on peut définir le _dictionnaire_ comme une collection d'éléments munies des opérations suivantes :
    - accéder, modifier ou insérer une valeur par sa clé
    - itérer sur toutes les clés
    - connaitre le nombre d'éléments dans le dictionnaire
]

#rq[
    La _complexité_ des opérations dépends de l'_implémentation_ de la structure de donnée. Par exemple, la librairie standard de python propose des implémentation de listes et dictionnaires dont toutes les opérations sont en $O(1)$. (en vérité, en O(1) en moyenne, mais ce n'est pas important ici.)

    #link(
        "https://notebook.basthon.fr/?kernel=python3&ipynb=eJy1ks9qwzAMxl9F6JRAVtpuJ8PeoIfe0xDcxG3N_A9bZgsl7z6ryyjbLmMwXSz5-1n6EL7ioIxJKNorWkVylCRRXJFiTqRGFCVRc3OjepqCQoGDHxU2mHyOA9faBh8JrKRgPBl9XIWJM5AJgqGDO0VvgbRVsKCclw7qTQ2ZtHf94LMjFC4b06DPFDKxp25u_m5rB8_Qth2cfAQN2kGU7qyqzZqj7g6OGChn8bgazKmqi9OfbC0ODkrQpuBsnDm-YNYwu1sIDrOSISg3VnqhaPvtGX0SRXkoXesPA7ywateuuwZouUoX_1rV_76n3w3omi8DXlR0yqSgBq6ctNwpTHTx7rE0HHUKRk79IuxvArBiymKzPN9xnIs_dyzbLB8IxdO96K12PqLYzu_u4OQ2",
    )[#text(fill: blue)[demo]]
]

== Pile

Image : une pile d'assiettes. On peut en poser une par dessus, ou enlever celle du dessus, mais c'est tout !

#def[Pile][
    Une _pile_ est une structure de donnée munie des opérations suivantes :
    - empiler un élément (l'ajouter en haut de la pile)
    - dépiler un élément (prendre l'élément en haut de la pile et le renvoyer)
    - (optionnel) regarder l'élément en haut de la pile
    - (optionnel) connaitre la hauteur de la pile
]

Pour implémenter une pile de manière efficace, on peut simplement utiliser... une liste ! Avec la correspondance suivante :
- empiler : `P.append(...)` en O(1)
- dépiler : `P.pop()` en O(1)
- regarder l'élément en haut de la pile : `P[-1]` en O(1)
- connaitre la hauteur de la pile : `len(P)` en O(1)


#rq[
    En anglais, pile se dit "stack" ou bien "LIFO" pour "Last In First Out", ce qu'on pourrait traduire par "dernier arrivé premier servi".
]

== File

Image : Une file d'attente. On peut ajouter un élément au début de la file, et enlever un élément à la fin de la file (mais on ne double pas !).

#def[File][
    Une _file_ est une structure de donnée munie des opérations suivantes :
    - enfiler un élément (l'ajouter au début de la file)
    - défiler un élément (prendre l'élément à la fin de la file et le renvoyer)
    - (optionnel) regarder l'élément à la fin de la file
    - (optionnel) connaitre la taille de la file
]

On peut à nouveau utiliser les listes pour implémenter une file, mais ça ne sera pas très efficace ...
- enfiler : `F.append(...)` en O(1)
- défiler : `F.pop(0)` en O(n) (!)
- regarder l'élément à la fin de la file: `F[0]` en O(1)
- connaitre la hauteur de la file : `len(F)` en O(1)

Il est possible d'implémenter une file avec toutes ses opérations en $O(1)$. Cela est par exemple fait dans la structure `deque` de Python : #link("https://notebook.basthon.fr/?kernel=python3&ipynb=eJzNlNtqwzAMhl9F6CoFM9bzFtg77L4twXPUzsynOTa0hLz77KajK5QV2g2aK8v67U-_hdKiIKUaLBctagq85oFj2WLwsQlUY5kW1LG9qgo7R1iisDUhw8ZGL3K89laDsEqRCNKaBqR21geo6TNmIW1JxJyphI0mYDlkaGNwMWTuqmM3oKUieOlJxeAca_RnLOelCUUmngWNf4Law_r7riZ44jodC7RNWuwLXqwGS5M2Dde9qE6nsLvtRawHCdKA52ZDxfBxUC4NpC8X_sCdI1MXMnEv2JleYeeRwZDBiMGYwYTBlMGMwZzBE4NnBr9l_-Mhsl9nnaJ1KC77nV3h987M9s3d-01tv-h4fo3ju2rxOVcmKnU68it2Avggb0g1jkSODuW4XXi3ZpwurGXjFN9Vh8TrPgE5o9JARb45yrFL9Zm3NHGaJ_LkGFRaGuvTz6f7AvXCv8A", text(fill: blue)[demo]) (Si on attend que vous utilisiez `deque`, tout vous sera rappelé dans le sujet).

#rq[
    En anglais, on parle de `queue` ou de `FIFO`, "First In First Out", soit "Premier arrivé premier servi".

    D'ailleurs, `deque` signifie `double-ended queue`.
]
== File de priorité

Image : L'attente à l’hôpital : le plus urgent est traité en premier.

Dans cette collection, on va associer à chaque élément une _priorité_ (en général un nombre).

#def[Pile][
    Une _file de priorité_ est une structure de donnée munie des opérations suivantes :
    - ajouter un élément
    - supprimer et renvoyer l'élément de priorité maximale
    - (optionnel) regarder l'élément de priorité maximale
    - (optionnel) connaitre la taille de la file de priorité
]


Il y a deux implémentations "naives" de files de priorité au programme :

- la liste non triée.
    - ajouter : `append` O(1)
    - supprimer : chercher l'élément de priorité minimale dans la liste, le supprimer. O(n)
    - regarder l'élément de priorité maximale : le chercher. O(n)

- la liste triée : on maintiens toujours les éléments triés par ordre de priorité croissant.
    - ajouter : insérer l'élément à sa place dans la liste. O(n)
    - supprimer : `.pop()`, O(1)
    - regarder l'élément de priorité maximale O(1)


En pratique, ce ne sont pas de très bonnes implémentations, mais on s'en contentera.

Il peut être utile de savoir qu'il est possible d'implémenter une file de priorité avec toutes les opérations en $O(log n)$. (Les options verront comment ! )


= Les parcours

== Anatomie d'un parcours

On a besoin :
- d'une structure de donnée pour stocker des noeuds

#pseudocode-list(hooks: .5em, title: smallcaps[Parcours d'un graphe], booktabs: true)[
    #underline()[Entrée] : G un graphe, s un élément de départ

    + Ajouter s dans la structure
    + *Tant que* la structure n'est pas vide
        + Prendre x un élément de la structure
        + (...)
        + Ajouter ses voisins non visités à la structure.

]

== Parcours en profondeur : la pile

Voici une implem en python, qui imprime simplement les sommets dans l'ordre. On suppose que le graphe est implémenté par liste d'adjacence :


```dot-render
    graph {
      a -- b
      b -- c
      c -- a
      d -- b
    }
```


```python

G = { "a": ["b", "d"],
      "b": ["d", "a", "c"],
      "d": ["b"],
      "c": ["b", "a"]}


def parcours_profondeur(G, d):
    pile = [d]
    while len(pile) > 0:
        ...
        ...
        x = pile.pop()
        print(x)
        for voisin in G[x]:
            pile.append(voisin)


def parcours_profondeur(G, d):
    pile = [d]
    deja_vu = {d: True}
    while len(pile) > 0:
        x = pile.pop()
        print(x)
        # On ajoute les voisins à la pile
        for voisin in G[x]:
            if voisin not in deja_vu:
                pile.append(voisin)
                #Evite d'ajouter les mêmes sommets à la pile plusieurs fois
                deja_vu[voisin] = True
```

```dot-render
    graph {
      a -- b
      b -- c [color=red]
      c -- a [color=red]
      d -- b [color=red]
    }
```

Version récursive
```python

def parcours_profondeur(G, d, deja_vu):
    for voisin in G[x]:
        if voisin not in deja_vu:
            deja_vu[voisin] = True
            parcours_profondeur(G, voisin, deja_vu)

```


== Parcours en largeur

```python

from collections import deque

def parcours_profondeur(G, d):
    file = deque()
    file.appendleft(d)
    deja_vu = {d: True}
    while len(pile) > 0:
        x = pile.pop()
        print(x)
        # On ajoute les voisins à la pile
        for voisin in G[x]:
            if voisin not in deja_vu:
                pile.appendleft(voisin)
                #Evite d'ajouter les mêmes sommets à la pile plusieurs fois
                deja_vu[voisin] = True

```

```dot-render
    graph {
      a -- b [color=red]
      b -- c [color=red]
      c -- a
      d -- b [color=red]
    }
```


Pour un crawler web, lequel utiliseriez-vous ? Et pour trouver la sortie d'un labyrinthe ?


= Plus court chemin

Sur un graphe non pondéré, pouvez-vous faire un parcours qui permet ça ?


```dot-render
    graph {
      e [color= red]
      c [color= blue]
      a -- b [label=1]
      b -- c [label=5]
      c -- a [label=7]
      d -- b [label=1]
      e -- a [label=2]
      d -- c [label=2]
      d -- a [label=3]
      e -- d [label=5]
    }
```

Plan, autoroutes, routes de campagnes, etc

BFS : on augmente la profondeur graduellement : d'abord 1 de distance, puis 2, etc.

Idée : plutôt que d'augmenter la profondeur, on augmente la pondération.


Déroulement sur exemple

```dot-render
    graph {
      e [color= red]
      c [color= blue]
      a -- b [label=1, color=red]
      b -- c [label=5]
      c -- a [label=7]
      d -- b [label=1, color=red]
      e -- a [label=2, color=red]
      d -- c [label=2, color=red]
      d -- a [label=3]
      e -- d [label=5]
    }
```
#pagebreak()

== Algorithme de Djikstra


#pseudocode-list(hooks: .5em, title: smallcaps[Algorithme de Djikstra], booktabs: true)[
    #underline()[Entrée] : G un graphe connexe, d un sommet de départ


    #underline()[Sortie] : La distance de d à chaque sommet du graphe.
    + Soit F une file de priorité, avec tous les noeuds associé à un poids $+ infinity$
    + Soit V un dictionnaire
    + Ajouter (d, 0) à F
    + *Tant que* F n'est pas vide
        + Prendre (x, l) le couple minimal de F
        + Ajouter (x, l) à V
        + *Pour chaque* arrête (x, y, $rho$)
            + *Si* y n'est pas dans V
                + *Si* y n'est pas dans F
                    + ajouter (y, l + $rho$) F.
                + *Sinon*
                    + mettre à jour le poids de y dans F, au minimum entre le poids actuel et l + $rho$

    + *Renvoyer* V

]


Dérouler sur l'exemple.

```dot-render
    digraph {
      a [color= red]
      a -> b [label=1]
      a -> c [label=4]
      b -> c [label=2]
      b -> d [label=3]
      d -> e [label=5]
      e -> c [label=1]
      c -> e [label=2]
    }
```


Quelle est la complexité ? (O((|E| + |S|) log |S|))

#pagebreak()

En python :

```python
import math

def djikstra(G, d):
    """Implemente l'algorithme de Djikstra sur un graphe par liste d'adjacence.
    Renvoie un dictionnaire qui à chaque sommet associe sa distance à d.
    On utilise une implémentation naive de file de priorité.
    """
    noeuds = {s: math.inf for s in G.keys()}
    noeuds[d] = 0
    V = {}
    while len(noeuds) > 0:
        # On trouve le plus petit élément de noeuds
        sommet_min = None
        distance_min = math.inf
        for (sommet, distance) in noeuds.items():
            if distance < distance_min:
                distance_min = distance
                sommet_min = sommet
        # Si le sommet minimum est None, c'est qu'on a parcouru toute la composante connexe
        # On peut donc renvoyer le dictionnaire;
        if sommet_min is None:
            return V
        # On le supprime de la liste des noeuds et on l'ajoute au dictionnaire résultat.
        del noeuds[sommet_min]
        V[sommet_min] = distance_min

        # On met à jour la distance des voisins
        for (voisin, poids) in G[sommet_min]:
            if voisin not in V:
                noeuds[voisin] = min(noeuds[voisin], distance_min + poids)
    return V
```

Quelle est la complexité de cette implémentation ? -> O(|V|²)


https://visualgo.net/


== A\*

video

L'idée de l'algorithme A\* est d'utiliser une *heuristique*, c'est à dire une indication sur le résultat spécifique au problème traité, souvent facile à calculer mais imprécise.

En l'occurence, cette heuristique est une indication sur la distance minimum qu'il reste pour parvenir au résultat. Pour que notre algorithme reste correcte, l'heuristique doit toujours être plus petite que la vrai distance !

Exemple : cas d'une carte. On peut prendre la distance "à vol d'oiseau" ! Quelque soit le chemin emprunté, on ne pourra pas aller plus vite.

Supposons qu'on ai une fonction h qui code l'heuristique. Dans ce cas, on ne va plus prendre le sommet de distance à l'origine d minimale, mais celui qui minimise (d + h) ! C'est à dire celui qui a le potentiel d'être sur le chemin le plus court.

La complexité de A\* n'est pas meilleure que djikstra dans le pire cas. Mais dans la majorité des cas réels, cela va beaucoup plus vite !
