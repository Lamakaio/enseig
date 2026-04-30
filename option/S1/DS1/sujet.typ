#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°2")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/cetz:0.4.2": canvas, draw, tree


#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *Option Informatique MPSI, DS n°1*
])

Les questions de code devront être traitées en language OCaml. Les noms de variables doivent être suffisamment clairs, et le code compréhensible.

Si vous définissez une fonction auxiliaire, précisez le type des arguments et l'objectif de la fonction.

Les questions difficiles sont notées d'une étoile \*. N'hésitez pas à les sauter.

= Autour des polynômes

Dans cette partie, on va étudier une représentation des polynômes d'entiers en OCaml.

On prend un polynôme P :

$ P(X) = sum_(k=0)^n a_k X^k "   pour " a_0, ..., a_n in NN $

On représente les polynômes en OCaml par la liste contenant $a_0, ..., a_n$. On se donne donc le type suivant :

```OCaml
type polynome = int list;;
```

Par exemple, le polynôme $X^3 + 1$ sera représenté par la valeur OCaml suivante :

```OCaml
let cube = [1; 0; 0; 1];;
```

#question[
    Écrire une fonction `degres: polynomes -> int` qui renvoie le degrés d'un polynôme (c'est-à-dire $n$).
]

#question[
    Écrire une fonction `dominant: polynomes -> int` qui renvoie le coefficient dominant d'un polynôme (c'est-à-dire $a_n$).
]

#question[
    Écrire une fonction `xn: int -> polynome` qui prend en argument un entier $n$ et renvoie le polynôme $X^n$
]

#question[
    Écrire une fonction `mul_scalaire: polynomes -> int -> polynome` qui multiplie un polynôme par un entier.
]

#question[
    Écrire une fonction `add: polynomes -> polynome -> polynome` qui réalise la somme de deux polynômes.
]

```ocaml
let rec eval (p: polynome) (x: int): int = match p with
    |[] -> 0
    |a::q -> a + x * (eval q x);;
```

#question[
    Que fait la fonction `eval` ? Quelle est sa complexité ?
]

#question[
    \* Écrire une fonction `mul: polynomes -> polynome -> polynome` qui multiplie deux polynômes.
]

= Arbres binaires de recherche
== Généralités

On étudie des arbres binaires de recherche, définis par induction de la manière suivante :

#def[Arbre binaire de recherche][
    Un arbre binaire de recherche est :
    - Soit une feuille $F$ ne stockant rien
    - Soit un noeud interne $N$ stockant un entier $x$, et deux sous arbres $G$ et $D$, tels que :
        - $G$ et $D$ sont des arbres binaires de recherche
        - $G$ stocke uniquement des éléments plus petits que $x$, et $D$ stocke uniquement des éléments plus grands que $x$ (strictement).
]

On utilise le type OCaml suivant pour stocker les arbres binaires de recherche :

```ocaml
type abr =
    | F
    | N of abr * int * abr;;
```


#question[
    Écrire une fonction `hauteur: abr -> int` qui calcule la hauteur d'un arbre binaire de recherche.
]

#question[
    Écrire une fonction `min: abr -> int` qui renvoie la valeur minimum stockée.
]

#question[
    Écrire une fonction `recherche: abr -> int -> bool` qui prend en argument un arbre et un entier, et renvoie un booléen indiquant si l'entier est présent dans l'arbre. Quelle est sa complexité en fonction de $h$ la hauteur de l'arbre ?
]

#question[
    Expliquer comment on peut procéder pour insérer un élément dans l'arbre, et avec quelle complexité en fonction de $h$.
]

#question[
    De même pour supprimer un élément.
]

#question[
    Soit un arbre de taille $n$. Indiquer le meilleur et le pire cas pour la complexité des opérations en fonction de $n$, par rapport à la forme de l'arbre.
]

== Arbres Bicolores

On va introduire une méthode pour garder les arbres équilibrés, et donc toujours avoir une bonne complexité pour nos opérations. Habituellement on utilise des couleur, mais pour des raisons de photocopie en noir et blanc, on utilisera des formes ici.



#def[Arbre bicolore][
    Un arbre bicolore est un arbre binaire de recherche dans lequel on attribue une forme (carré ou rond) à chaque noeud, avec les contraintes suivantes :

    - La racine est *carré*
    - Les enfant d'un noeud *rond* sont *carré*
    - Tous les chemins de la racine à une feuille ont le même nombre de noeuds *carré*
    - Les feuilles sont *carré*
]
#pagebreak()
#question[
    Les arbres suivants sont-ils des arbres bicolores ?
]
#columns(2, gutter: 8pt)[
    (a)
    #canvas({
        import draw: *
        let encircle(i) = {
            std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .6em)[#move(dx: -0.30em, dy: -0.47em, $#i$)])
        }

        let ensquare(i) = {
            std.box(baseline: 2pt, std.square(stroke: .5pt, height: 1.2em)[#move(dx: -0.1em, dy: -0.27em, $#i$)])
        }

        set-style(content: (padding: 0.2em))


        tree.tree(grow: 0.3, spread: 0.3, (
            ensquare(4),
            (
                encircle(2),
                (ensquare(1), ensquare[], ensquare[]),
                (ensquare(3), ensquare[], ensquare[]),
            ),
            (
                encircle[8],
                (ensquare[5], ensquare[], (encircle[6], ensquare[], ensquare[])),
                (ensquare[9], ensquare[], ensquare[]),
            ),
        ))
    })

    (c)
    #canvas({
        import draw: *
        let encircle(i) = {
            std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .6em)[#move(dx: -0.30em, dy: -0.47em, $#i$)])
        }

        let ensquare(i) = {
            std.box(baseline: 2pt, std.square(stroke: .5pt, height: 1.2em)[#move(dx: -0.1em, dy: -0.27em, $#i$)])
        }

        set-style(content: (padding: 0.2em))

        tree.tree(grow: 0.3, spread: 0.3, (
            ensquare(4),
            (
                ensquare(2),
                (ensquare(1), ensquare[], ensquare[]),
                (ensquare(3), ensquare[], ensquare[]),
            ),
            (
                ensquare[8],
                (ensquare[5], ensquare[], (encircle[6], ensquare[], ensquare[])),
                (ensquare[9], ensquare[], ensquare[]),
            ),
        ))
    })


    #colbreak()

    (b)
    #canvas({
        import draw: *
        let encircle(i) = {
            std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .6em)[#move(dx: -0.30em, dy: -0.47em, $#i$)])
        }

        let ensquare(i) = {
            std.box(baseline: 2pt, std.square(stroke: .5pt, height: 1.2em)[#move(dx: -0.1em, dy: -0.27em, $#i$)])
        }

        set-style(content: (padding: 0.2em))

        tree.tree(grow: 0.3, spread: 0.3, (
            ensquare(4),
            (
                ensquare(2),
                ensquare[],
                ensquare[],
            ),
            (
                ensquare[8],
                (ensquare[5], ensquare[], (encircle[6], ensquare[], ensquare[])),
                (ensquare[9], ensquare[], ensquare[]),
            ),
        ))
    })

    (d)
    #canvas({
        import draw: *
        let encircle(i) = {
            std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .6em)[#move(dx: -0.30em, dy: -0.47em, $#i$)])
        }

        let ensquare(i) = {
            std.box(baseline: 2pt, std.square(stroke: .5pt, height: 1.2em)[#move(dx: -0.1em, dy: -0.27em, $#i$)])
        }

        set-style(content: (padding: 0.2em))

        tree.tree(grow: 0.3, spread: 0.3, (
            ensquare(4),
            (
                ensquare(2),
                ensquare[],
                ensquare[],
            ),
            (
                encircle[8],
                (ensquare[5], ensquare[], (encircle[6], ensquare[], ensquare[])),
                (ensquare[9], ensquare[], ensquare[]),
            ),
        ))
    })



]

#question[
    Quelle est la hauteur maximale possible pour un arbre bicolore de taille $5$ ? Et de taille $17$ ?
]

#question[ \*
    Généralisez avec un arbre de taille $2^n + 1$, et démontrez votre résultat.
]

#question[
    En déduire une borne sur la hauteur d'un arbre bicolore en fonction de sa taille.
]

#question[
    En supposant que l'on puisse maintenir la propriété bicolore lors des opérations de recherche, ajout et suppression, sans coût supplémentaire, quelle serait alors la complexité dans le pire des cas de ces opérations ?
]
