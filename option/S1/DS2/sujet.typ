#set page(paper: "a4", numbering: "1")
#set document(title: "DS2 option info MPSI")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.7": *

#show raw.where(lang: "dot-render"): it => raw-render(it)


#align(center, text(17pt)[
    *DS2 option info MPSI* \
    *Algorithme polynomial pour le problème 2-SAT*
])


Ce sujet vise a pour objectif d'arriver à un algorithme polynomial pour résoudre le problème 2-SAT. Même si c'est l'objet d'étude du sujet, aucune connaissance n'est requise sur le problème SAT ici : on va simplement manipuler des formules logiques et des graphes.

= Formules en 2-CNF
#def[Formule sous forme 2-FNC][
    Une formule logique est dites en 2-FNC si elle est de la forme :

    $ phi = and.big_(i=1)^n p_i or q_i $

    où $p_i$ et $q_i$ sont des littéraux, c'est-à-dire soit des variables $x$, soit des négations de variables $not x$.

    Les $p_i or q_i$ sont appelés les clauses.
]

#ex[
    La formule
    $phi = (a or b) and (not a or not b) and (c or not c)$ est en 2-FNC.
]

Les formules en 2-FNC seront représentées en OCaml par le type suivant :

```OCaml
type litteral = Var of int | Not of int;;
type formule = (litteral * litteral) list;;
```

On va considérer que les variables d'une formule sont numérotées par des entiers _consécutifs_ entre $0$ et $n-1$, où $n$ est le nombre de variables distinctes de la formule.

Par exemple, en numérotant a, b et c par 0, 1 et 2, la formule $phi$ est représentée par la liste :

```ocaml
let phi: formule = [(Var 0, Var 1); (Not 0, Not 1); (Var 2, Not 2)];;
```

On va s’intéresser à la résolution de formules en 2-FNC, c'est à dire de trouver une valuation telles que la formule soit vrai, si c'est possible.

On dit qu'une formule est _satisfiable_ si une telle valuation existe.

#question[
    La formule $phi$ de l'exemple 2 est-elle satisfiable ? Si oui, donnez une valuation des variables telle qu'elle s'évalue à Vrai.
]

#question[
    Toutes les formules peuvent-elles être mises sous la forme 2-FNC ? Vous pouvez par exemple étudier la formule $a or b or c$ pour répondre.
]

#question[
    Écrivez une fonction `neg : litteral -> litteral` qui renvoie la négation d'un littéral (c'est à dire qu'elle transforme $a$ en $not a$ et $not a$ en $a$).
]

#question[
    Écrivez une fonction `nb_litteraux : formule -> int` qui calcule le nombre de littéraux dans une `formule` (en 2-FNC toujours, comme sur tout le reste du sujet).
]

#question[
    Écrivez une fonction `nb_variables : formule -> int` qui calcule le nombre de variables différentes dans une `formule`.

    _Ne cherchez pas trop loin ! En particulier, les variables sont des entiers *consécutifs*..._
]

Pour représenter une valuation, on va utiliser un tableau. Comme on a déjà numéroté les variables entre $0$ et $n-1$, on peut utiliser cette même numérotation pour la valuation, et placer à l'emplacement $i$ du tableau la valeur de la variable $i$.

```ocaml
type valuation = bool array;;
```

Ainsi, pour la formule $phi$, la valuation :
#table(
    columns: 2,
    [a], [Vrai],
    [b], [Vrai],
    [c], [Faux],
)

s'écrit en OCaml :
```ocaml
let val: valuation = [|true; true; false|]
```

#question[
    Écrivez une fonction `eval: formule -> valuation -> bool` qui évalue une formule avec une valuation.

    _On supposera que la valuation contiens bien toutes les variables de la formule._
]




= Graphe d'implication

Pour résoudre de telles formules, on va utiliser une construction appelée _graphe d'implication_.

== Définition

#def[Graphe d'implication][
    Pour une formule $phi$ en 2-FNC, on appelle *graphe d'implication* le graphe orienté $G = (S, A)$ dont :
    - les sommet $S$ sont les littéraux de _phi_ (c'est à dire, toutes les variables de $phi$ et leurs négations)
    - pour chaque clause $p or q$, on place les arrêtes $not p -> q$ et $not q -> p$

    _nb : en fait, on peut voir la clause $p or q$ comme l'implication "non p implique q", et donc les arrêtes de graphe sont des implications._
]

#pagebreak()

Par exemple, le graphe correspondant à la formule $phi$ est :

```dot-render
digraph {
  "¬a" -> b;
  "¬b" -> a;
  a -> "¬b";
  b -> "¬a";
  "¬c" -> "¬c"
  "c" -> "c"
}```

#question[
    Représentez le graphe d'implication correspondant à la formule
    $ psi = (a or a) and (not a or b) and (not b or c) and (not c or d) and (not d or not a) $
]

#question[
    Que peut-on en déduire sur la formule si, pour une variable $x$, le graphe contient une arrête $x -> not x$ et une arrête $not x -> x$ ? La formule est-elle alors satisfiable ?
]

#question[
    Montrer que, pour $x$ une variable, si le graphe contient un chemin entre $x$ et $not x$ et un chemin entre $not x$ et $x$, alors la formule n'est pas satisfiable.
]

On admet dans un premier temps que la réciproque est également vraie.

== Implémentation en OCaml

On choisi de représenter les graphes par liste d'adjacence.

Les sommets correspondant aux variables sont numérotés de $0$ à $n - 1$, et ceux correspondant à leurs négations de $n$ à $2n - 1$.

On peut alors utiliser le type suivant pour représenter les graphes :

```ocaml
type graphe = int list array
```

où l'élément d'indice $i$ du tableau contiens la listes des voisins de $i$, c'est à dire les sommets $v$ tels que $i -> v$.

#question[
    Écrivez une fonction `index: litteral -> int` qui renvoie l'indice du sommet correspondant à un littéral dans le graphe.
]

#question[
    Écrivez une fonction `f2g : formule -> graphe` qui calcule et renvoie le graphe d'implication d'une formule.
]

#def[Composantes fortement connexes][
    Pour $G = (S, A)$ un graphe orienté, on appelle _composante fortement connexe_ de G tout sous-ensembles des sommets $C in S$ tel que, pour tout $p, q in C$, il existe un chemin de $p$ à $q$ et de $q$ à $p$.
]

#question[
    Montrez que la condition énoncée à la question 9 est équivalente à "pour toute variable $x$, $x$ et $not x$ ne sont pas dans la même composante fortement connexe.
]

On va donc calculer les composantes fortement connexes de notre graphe.

On donne la fonction suivante :

```ocaml
let rec parcours (g: graphe) (s: int) (visite: bool array): int list =
    if visite.(s) then [] else
    let rec parcours_voisins (l: int list): int list = match l with
        |[] -> []
        |v::q -> (parcours g v visite) @ (parcours_voisins q)
    in
    visite.(s) <- true;
    s::(parcours_voisins g.(s))
```

#question[
    Que-fait cette fonction ? Donnez son résultat sur le graphe suivant, en partant de 0, avec le tableau `visite` rempli de `false` au début.
]

```dot-render
digraph {
    layout = "neato"
    0 -> 1
    1 -> 2
    1 -> 3
    3 -> 7
    5 -> 6
    6 -> 1
    6 -> 3
    5 -> 2
    2 -> 0
}
```

#question[\*
    Cette fonction ne parcours pas le graphe dans son intégralité. Écrivez une fonction `parcours_total: graphe -> int list` qui parcours l'intégralité du graphe avec la fonction parcours (en l'appelant plusieurs fois).

    La fonction `parcours_total` doit renvoyer la concaténation des résultats de tous les appels à `parcours`.
]

On va utiliser un algorithme classique (enfin, "classique", c'est relatif) pour calculer les composantes fortement connexes de notre graphe :

#blk1[Algorithme][de Kosaraju][
    - Appeler la fonction `parcours_total` et noter l'ordre renvoyé $omega$, c'est à dire l'ordre de remontée du parcours.
    - Transposer le graphe $G$ en $G^T$ (c'est à dire inverser toutes ses arrêtes).
    - Parcourir $G^T$, en suivant l'ordre indiqué par $omega$, c'est-à-dire que, lorsqu'un appel à `parcours` est terminé, on reprend depuis le premier sommet de $omega$ non visité.

    Chaque appel à `parcours` renvoie alors une composante connexe.
]

#question[
    Écrivez une fonction `transpose: graphe -> graphe` qui renvoie la transposée d'un graphe, c'est-à-dire que toutes ses arrêtes sont inversées.
]

#question[\*
    Écrivez une fonction `kosaraju: graphe -> int list list` qui prend en argument un graphe et renvoie la liste de ses composantes connexes (donc une liste de listes de sommets).
]

#question[\*
    En combinant les différentes fonctions du sujet, écrivez une fonction `satisfiable: formule -> bool` qui détermine si une formule sous forme 2-FNC est satisfiable. Quelle-est sa complexité ?
]

#question[
    Comment peut-on attribuer des valeurs au variables qui satisfont la formule à l'aide du graphe d'implication ?
]

