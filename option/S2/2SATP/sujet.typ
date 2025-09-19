#set page(paper: "a4", numbering: "1")
#set document(title: "Algorithme polynomial pour le problème 2-SAT")
#set heading(numbering: "I.1)")
#import "utils.typtp": *


#align(center, text(17pt)[
  *Algorithme polynomial pour le problème 2-SAT*
])

#outline(indent: auto)


= Préliminaires

Ceci est un exercice (très) difficile. Faites des dessins de graphes pour bien comprendre les constructions et algorithmes définis, et étudiez des exemples avant de vous lancer dans le cas général !

== Formules en 2-CNF
#def[Formule sous forme 2-CNF][
  Une formule logique est dites en 2-CNF si elle est de la forme :

  $phi = and.big_i p_i or q_i$

  où $p_i$ et $q_i$ sont des littéraux, c'est-à-dire soit des variables $x$, soit des négations de variables $not x$.

  Les $p_i or q_i$ sont appelés les clauses.
]

#ex[
  La formule
  $phi = (a or b) and (not a or not b) and (c or not c)$ est en 2-CNF.
]

Les formules en 2-CNF seront représentées en OCaml par le type suivant :

```OCaml
type litteral = Var of int | Not of int;;
type formule_2cnf = (litteral * litteral) list;;
```


On va s'intérésser à la résolution de formules en 2-CNF, c'est à dire de trouver des valeurs des variables telles que la formule soit vrai, si c'est possible.

On dit qu'une formule est _satisfiable_ si une telle solution existe.

== Graphe d'implication

Pour cela, on va utiliser une construction appelée _graphe d'implication_.

#def[Graphe d'implication][
  Pour une formule $phi$ en 2-CNF, on appelle *graphe d'implication* le graphe orienté dont :
  - les sommet $S$ sont les littéraux de _phi_ (c'est à dire, toutes les variables de $phi$ et leurs négations)
  - pour chaque clause $p or q$, on place les arrêtes $not p -> q$ et $not q -> p$

  _nb : en fait, on peut voir la clause $p or q$ comme l'implication "non p implique q", et donc les arrêtes de graphe sont bien les implications._
]

Les graphes en OCaml seront représentés par liste d'adjacence, en utilisant le type suivant :

```OCaml
type graphe = int list array
```

Si la formule contient $n$ variables, les sommets de $0$ à $n - 1$ sont les variables, et ceux de $n$ à $2n - 1$ leur négation.

Le tableau contient $2n$ valeurs : l'élément d'indice $i$ correspond aux sommets voisins du sommet $i$.

= Résolution

== Utilisation du graphe pour la satisfiabilité

*Q1)* _Que peut-on en déduire sur la formule si, pour une variable $x$, le graphe contient une arrête $x -> not x$ ? La formule est-elle alors satisfiable ?_


*Q2)* _Que peut-on alors en déduire sur la formule si, pour une variable $x$, le graphe contient un chemin entre $x$ et $not x$ ?_


*Q3)* _En déduire une condition nécéssaire sur le graphe pour que la formule associée soit satisfiable._

On admet dans un premier temps que cette condition est également suffisante.

== Graphe en OCaml

*Q4)* _Écrire un code OCaml pour créer le graphe d'implication correspondant à une formule en 2-CNF._

*Q5)* _Écrire un code OCaml pour créer le graphe d'implication correspondant à une formule en 2-CNF._

== Résolution sur le graphe

#def[Composantes fortement connexes][
  Pour G un graphe, on appelle _composante fortement connexe_ de G tout sous-ensembles des sommets $C in S$ tel que, pour tout $p, q in C$, il existe un chemin de $p$ à $q$.
]

*Q6)* _Montrez que la condition énoncée en *II.1)* est équivalente à "pour toute variable $x$, $x$ et $not x$ ne sont pas dans la même composante fortement connexe._

On va utiliser un algorithme classique pour calculer les composantes fortement connexes de notre graphe :
#blk1[Algorithme][de Kosaraju][
  - Effectuer un parcours en profondeur sur G, et noter le post-ordre $omega$, c'est à dire l'ordre de remontée du parcours.  À noter que, lorsqu'on termine un parcours, si on a pas visité tous les sommets, il faudra reprendre depuis un sommet non-visité arbitraire.
  - Transposer le graphe $G$ en $G^T$ (c'est à dire inverser toutes ses arrêtes), et inverser le post-ordre $omega$ en $omega^T$.
  - Effectuer un parcours en profondeur sur $G^T$, en suivant l'ordre indiqué par $omega^T$, c'est-à-dire que, lorsqu'un parcours est terminé, on reprend depuis le premier sommet de $omega^T$ non visité.
]


*Q7)* _Écrire une fonction qui permet de faire un parcours en profondeur d'un graphe, en notant l'ordre de remontée. Vous pouvez vous aider d'un nouveau tableau de booléen pour identifier les sommets déjà visités. _

*Q8)* _Écrire des fonctions permettant d'inverser une liste, et de transposer un graphe._

*Q9)* _En déduire une fonction qui execute l'algorithme de Kosaraju._

*Q10)* _En déduire une fonction qui permet de determiner si une formule en 2-CNF est satisfiable._

*Q11)* _Comment retrouver une valuation des variables telle que la formule soit vraie ? _
