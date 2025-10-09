#set page(height: auto, numbering: "1")
#set document(title: "Chemin dans les graphes")
#set heading(numbering: "I.1.a)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

#import "@preview/diagraph:0.3.6": *

= Pourquoi, comment ?


#def[Graphe][
  Un graphe simple est une paire $(S, E)$, avec $S$ l'ensemble des sommets, et $E$ l'ensemble des arrêtes.

  Un graphe est dit _orienté_ si les arrêtes ont une direction, et $E$ est alors un sous-ensemble des paires d'éléments de $S$.

  Sinon, le graphe est _non-orienté_, et $E subset P_2(S)$ les parties à deux éléments de $S$.
]


#raw-render(
  ```dot
  graph {
    a -- b
    b -- c
    c -- a
    d -- b
  }
  ```,
)


#raw-render(
  ```dot
  digraph {
    a -> b
    b -> a
    b -> c
    c -> a
    d -> b
    d -> c
  }
  ```,
)


Applications :

- plans : les routes sont des arrêtes, les intersection sont des sommets
- internet : les différents routeurs, serveurs, connexions forment un (très) grand graphe
- et les sites internet et les liens qui les relient aussi !
- et bien plus.



Dans tous ces cas, on aimerais pouvoir
- avoir accès aux composantes connexes du graphe (les parties reliées entre elles)
- avoir accès au plus cours chemin entre deux points
- explorer une partie du graphe (par exemple, un crawler web)

= Les parcours

== Anatomie d'un parcours

On a besoin :
- d'une structure de donnée pour stocker des noeuds

#pseudocode-list(hooks: .5em, title: smallcaps[Parcours d'un graphe], booktabs: true)[
  #underline()[Entrée] : G un graphe, d un élément de départ

  + Ajouter d dans la structure
  + *Tant que* la structure n'est pas vide
    + Prendre x un élément de la structure
    + (...)
    + Ajouter ses voisins non visités à la structure.

]

== Parcours en profondeur : la pile

Voici une implem en python, qui imprime simplement les sommets dans l'ordre. On suppose que le graphe est implémenté par un dictionnaire de listes d'adjacence :


#raw-render(
  ```dot
  graph {
    a -- b
    b -- c
    c -- a
    d -- b
  }
  ```,
)


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


#raw-render(
  ```dot
  graph {
    a -- b
    b -- c [color=red]
    c -- a [color=red]
    d -- b [color=red]
  }
  ```,
)

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


#raw-render(
  ```dot
  graph {
    a -- b [color=red]
    b -- c [color=red]
    c -- a
    d -- b [color=red]
  }
  ```,
)


Pour un crawler web, lequel utiliseriez-vous ? Et pour trouver la sortie d'un labyrinthe ?


= Plus court chemin

Sur un graphe non pondéré, pouvez-vous faire un parcours qui permet ça ?


#raw-render(
  ```dot
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
  ```,
)

Plan, autoroutes, routes de campagnes, etc

BFS : on augmente la profondeur graduellement : d'abord 1 de distance, puis 2, etc.

Idée : plutôt que d'augmenter la profondeur, on augmente la pondération.


Déroulement sur exemple

#raw-render(
  ```dot
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
  ```,
)


== Algorithme de Djikstra


#pseudocode-list(hooks: .5em, title: smallcaps[Algorithme de Djikstra], booktabs: true)[
  #underline()[Entrée] : G un graphe, d un sommet de départ


  #underline()[Sortie] : La distance de d à chaque sommet du graphe.
  + Soit F une file de priorité
  + Soit V un dictionnaire
  + Ajouter (d, 0) à F
  + *Tant que* F n'est pas vide
    + Prendre (x, l) le couple minimal de F
    + *Pour chaque* arrête (x, y, $rho$)
      + *Si* y n'est pas dans V
        + ajouter (y, l + $rho$) à V et F.
  + *Renvoyer* V

]


Dérouler sur l'exemple.

#raw-render(
  ```dot
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
  ```,
)


Quelle est la complexité ?
