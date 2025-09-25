#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import "@preview/lovelace:0.3.0": *
#import "../../../utils.typtp": *
#import metropolis: focus, new-section

#show: metropolis.setup

#slide[
  #set page(header: none, footer: none, margin: 3em)


  #text(size: 1.3em)[
    *Algorithme et complexité*
  ]

  #metropolis.divider

  #set text(size: .8em, weight: "light")
  Ambre Le Berre

  MPSI

  2025/2026
]

#slide[
  = Plan du cours

  #metropolis.outline
]

#new-section[Programme vs Algorithme]

#slide[
  = Un algorithme ?

  En programmation, on parle souvent _d'algorithme_. C'est une sorte de programme abstrait.
  #show: later

  #pseudocode-list(hooks: .5em, title: smallcaps[Recherche linéaire( L, x )], booktabs: true)[
    #underline()[Entrée] : L une liste, x un élément.

    #underline()[Sortie] : true si x est dans le liste, false sinon.

    + *Pour chaque* élément y dans la liste L
    + *Si* x = y
      + *Renvoyer* true

    + *Renvoyer* faux
  ]
]


#slide[
  = Implémentation d'un algorithme

  Une _implémentation_ d'un algorithme est une traduction de l'algorithme dans un language de programmation. Cela peut impliquer une réfléxion et des choix supplémentaires.

  #show: later

  #text(fill: green.darken(30%))[
    Écrivez une implémentation en Python de l'algorithme de recherche linéaire.
  ]

]

#slide[
  = Correction

  ```python
  def recherche_lineaire(L, x):
      """Cherche un élément x dans une liste L. Renvoie True si l'élément est présent, False sinon."""
      for y in L:
          if x = = y:
              return True
      return False

  ```
]


#new-section[Complexité d'un algorithme]

#slide[
  = Introduction

  La _complexité_ d'un algorithme est une estimation du temps qu'il faut pour qu'il s'execute.

  #show: later

  #def[Opération élémentaire][
    On appelle _opération élémentaire_ toute opération "de base" d'un language : addition, multiplication, division, comparaisons, modulo ...
  ]

  On va compter les opérations élémentaires dans un programme ou un algorithme.
]

#slide[
  = Exemple

  #pseudocode-list(hooks: .5em, title: smallcaps[Recherche linéaire( L, x )], booktabs: true)[
    #underline()[Entrée] : L une liste, x un élément.

    #underline()[Sortie] : true si x est dans le liste, false sinon.

    + *Pour chaque* élément y dans la liste L
    + *Si* x = y
      + *Renvoyer* true

    + *Renvoyer* faux
  ]

  #show: later
  Est ce qu'on compte la boucle elle-même ? Et les retours ?
]


#slide[
  = Comparaison des opérations

  #table(
    columns: (1fr, 1fr),
    align: center,
    [_Opération_], [_Cycles d'execution_],
    [Addition, soustraction], [1],
    [Multiplication], [5],
    [If], [1 - 20],
    [Division / Modulo], [30],
    [Accès mémoire], [1 - 150],
    [Lecture sur le disque], [\~10000],
  )

  Est ce que ça a du sens de compter toutes les opérations une par une ?
]

#slide[
  = Complexité asymptotique

  On va seulement prendre l'ordre de grandeur du nombre d'opérations élémentaire, en fonction de la taille de l'entrée (en général nommée `n`).

  On utilise la notation _$O(...)$_, pour dire "au plus de l'ordre de ..."
]

#slide[
  = Exemples
  On peut avoir par exemple :
  - $O(1)$ : signifie que le nombre d'opérations *ne dépend pas* de la taille de l'entrée.
  - $O(n)$ : signifie que le nombre d'opérations est proportionnel à la taille de l'entrée.
  - $O(n²)$ : signifie que le nombre d'opérations est proportionnel au carré de la taille de l'entrée.
  ...

  #show: later
  #text(fill: green.darken(30%))[
    Laquelle de ces options correspond à l'algorithme de recherche linéaire ?
  ]
]


#slide[
  = Définition formelle
  #def[Notation $O()$][
    On dit qu'une fonction $f$ est un "grand $O$" d'une fonction $g$ lorsque, si \
    $exists C in NN, N_0 in NN "   tels que   " forall n >= N_0, " " f(n) < C dot g(n)$ \

    Soit : Il existe une constante $C$, telle que, pour $n$ suffisemment grand, $g(n)$ soit majorée par $C dot g(n)$
  ]
]

#slide[
  = Exemples :
  - $5n + 3$ est un $O( #text(fill: green)[...])$
  - $6n² + n + 100000000$ est un $O(#text(fill: green)[...])$

  - $n/(n+1)$ est un $O(#text(fill: green)[...])$

  - $(3n² - 5n + 20) / (3n - 1)$ est un $O(#text(fill: green)[...])$
]

#slide[
  = Exemples :
  - $5n + 3$ est un $O(n)$
  - $6n² + n + 100000000$ est un $O(n²)$

  - $n/(n+1)$ est un $O(1)$

  - $(3n² - 5n + 20) / (3n - 1)$ est un $O(n)$
]


#slide[
  = Comment calculer la complexité d'un algorithme ?

  Dans votre cas :
  + Sauf exception, toutes les opérations et fonctions fournies sont en temps constant, soit `O(1)`.
  + _Cas des boucles_ : Si une boucle fait $n$ itérations, et que chaque itération est, dans le pire cas, en $O(p)$, alors le total est en $O(n p)$
]

#slide[
  = Exemple

  ```python
  def recherche_lineaire(L, x):
      """Cherche un élément x dans une liste L. Renvoie True si l'élément est présent, False sinon."""
      for y in L:
          if x == y:
              return True
      return False

  ```
  #show: later

  On a `len(L)` itéations de la boucle, et chaque itération est en $O(1)$. Donc $O("len(L)")$ au total.
]
