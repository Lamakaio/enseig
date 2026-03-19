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
    *Notes de cours graphes*
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

    On dit que le graphe est _orienté_ si les arrêtes ont un sens ("que ce sont des fleches"). On les appelles alors souvent _arcs_.
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
]

#def[Degrés d'un sommet][
    Dans un graphe non orienté, le degrés d'un sommet $s$, noté $d(s)$, est le nombre d'arrêtes qui le touchent.

    Dans un graphe orienté, on note $d_+(s)$ le degrés entrant et $d_-(s)$ le degrés sortant, qui sont respectivement le nombre d'arcs qui arrivent et qui partent de $s$.
]

#ex[
    - $d(B) = 3, d(D) = 2$
    - $d_+(G) = 1, d_-(G) = 3, d_+(L) = 0$
]


== Chemins, cycles et connexité

#def[Chemin][
    Un _chemin_ dans un graphe est une suite finie d'arrêtes consécutives $a_1, ..., a_n$, telles que si $a_i = (s, s')$, alors $a_(i+1) = (s', s'')$.
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
    Un _cycle_ est un chemin dont le premier et le dernier sommet sont les mêmes.
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
]arrête

#ex[
    ```dot-render
    graph {
      A -- B [label=3];
      A -- C [label=1];
      B -- C [label=8];
      B -- D [label=0];
      D -- E [label=5];
      A -- E [label=1];
    }```
]

#rq[
    On peut alors parler du poids d'un chemin, d'un cycle, ...
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

Pour les graphes pondérés, on peut stocker les poids directement dans la liste d'adjacence :

```python
g = {
    'A': [('B', 3), ('C', 1), ('E', 1)],
    'B': [('A', 3), ('C', 8), ('D', 0)],
    'C': [('A', 1), ('B', 8)],
    'D': [('B', 0), ('E', 5)],
    'E': [('A', 1), ('D', 5)]
}
```

Exercice : faire la même chose avec l'exemple 2.


#rq[
    Dans le cas où les sommets sont numérotés de 0 à n-1, on peut utiliser une liste à la place d'un dictionnaire.
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

Pour les graphes pondérés, on peut mettre le poids de l'arrête à la place de "1", et utiliser une valeur qui n'est pas dans les poids à la place de "0" (par exemple "-1").

```python
g = [[-1, 3, 1,-1, 1],
     [ 3,-1, 8, 0,-1],
     [ 1, 8,-1,-1,-1],
     [-1, 0,-1,-1, 5],
     [ 1,-1,-1, 5,-1]]
```
