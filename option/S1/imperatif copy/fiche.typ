#set page(paper: "a4", numbering: "1")
#set document(title: "Cours arbres")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.6": *
#import "@preview/cetz:0.4.2": canvas, draw, tree


#align(center, text(17pt)[
    *Programmation impérative en OCaml*
])

#outline(indent: auto)


= Principes de base : référence vs valeur, mutable vs immutable

Ces principes sont valables autant en Python que en OCaml.

== Valeurs

On va voir un ordinateur comme un _processeur_ accompagné d'une _mémoire_.

La mémoire, c'est genre une grande armoire, ou sont rangées toutes les valeurs de vos variables.

Quand le processeur a besoin de faire un calcul sur une valeur, il la sort de l'armoire, fait ce qu'il a à faire, et la remet.

```python
a = 3 + 4
c = a
```

Mais le processeur par défaut il est pas très organisé ! Donc il ne retiens pas où sont rangés les objets. Donc si on change de "contexte", il oublie tout ! Par exemple, en entrant dans une fonction ...

```python
def plop(a):
    a = 9

a = 3
plop(a)
print(a)
```
#link(
    "https://notebook.basthon.fr/?kernel=python&ipynb=eJydT0FqxDAM_ErQqYVc2u1lDf1D700Iqq3dhjqysWXYEPz3Kpss20JP1WmGGWlGC1jyPoN5X2AiQYeCYBaQVLKQA6OAant1DTJHAgM2OIIWcijJrtzRqYk-xAd8NB03Oti8NseOO17BoeNdVZBGFkW6TheyRcbAgw2FBcxTC6FILLK12fAtM0sinHRN6KJe0KNKGKdNdOqG2tf2_1_8VYmL9z9b9bVvfwV8UWLyOZJd2V4nzvIZ-KAH3Zijx3nYhber0KyKRz4XPN_tULUff5xCmlCTX-5kmEYOCcxz_QanopME",
)[lien notebook]


Il se souviens que il a un 3 sur lui en entrant, mais il a complètement oublié où allait le 3 original ! Et donc il est incapable de le modifier.

En OCaml, on interdit au processeur d'écrire dans les variables directement : comme ça, pas d'ambiguïté.

== Références

Maintenant, parfois on aimerait bien modifier des variables même dans des fonctions... Et donc il y a des mécanismes pour ça : les références.

Le principe, c'est qu'au lieu de donner la valeur directement, on donne sa localisation dans la mémoire. Comme ça, même si le processeur la prend pour faire des calculs avec, il saura où la ranger ensuite !

Des objets fonctionnant sur ce principe, vous en connaissez : les listes et les dictionnaires en python, les tableaux et les tables de hashage en OCaml.

Comme c'est des objets très gros, le processeur peux pas prendre toute la valeur de l'objet d'un coup, donc il retiens juste où sont stockés les éléments !


En python, les références sont implicites. C'est un peu confus, mais globalement, il n'y a que les listes et les dictionnaire qu'on peut modifier depuis une autre fonction. En particulier, les tuples ne sont pas passés par référence !

En OCaml, on peut faire des références _explicites_, c'est à dire qu'on dit à OCaml "ceci est une référence, laisse moi la modifier stp" et il est d'accord.
#link(
    "https://notebook.basthon.fr/?kernel=ocaml&ipynb=eJy9kc9OwzAMxl_F82kTnbTx55JqXHgAHgCmyqTeVpE4VeoIptF3Jx2DiRtCWn3y59j-Rf4OaNm5Ds3TAT0r1aSE5oAaU6dco8kJ98Wxq9J9y2jQhpqxwC6kaAftWIFgBZE3sCjL_MTvbJM2QSobkigaSc4VGJK2SQfYui_-zyMwK7gZA3RxwuTyiMGdyBZs8K1yBMlOeVK7y9lbozt4FsjxsYD5PUxnJyWDOh56QnAFy_Jnfirz5WyE43_z7kZgjWDD3wDr4hfglaOw61q2gxLyw6Zgybu8rm661tG-OpUfH77KjmSbaHvu7PPP5GUTYnYdze1ZVL6RENFc95-xT2Ey",
)[lien notebook]

On peut :
- créer une référence en ajoutant juste `ref` devant une valeur
- modifier la valeur dans une référence avec `:=` (et non simplement `=` ! )
- accéder à la valeur dans une référence avec `!`

Globalement, il suffit de retenir ces deux lignes :
```ocaml
let a = ref 0;;
a := !a + 1;;
```

Au passage, on a deux fonctions `incr` et `decr` qui permettent d'ajouter et d'enlever 1 à une référence d'entier.

Ainsi, `a := !a + 1` devient `incr a`.


On peut faire une référence de n'importe quoi ! Par exemple, une référence de liste, d'arbre, etc.


== Instruction vs expression

En informatique, on distingue souvent les _expressions_ des _instructions_. En python, la distinction est assez clair : une instruction, c'est une ligne entière. Une expression, c'est un truc qui a une valeur.

```python
a = 1 + max(2, 3)
```
Ici, on a une instruction, et `1 + max(2, 3)` est une expression.

Une instruction peut être simplement composé d'une expression : par exemple, un appel de fonction.

En OCaml, c'est un petit peu plus compliqué : en vérité, on a uniquement des expressions, mais on appelle _instruction_ les expressions qui renvoient `()` c'est à dire le type `unit` (en gros, rien).

Par exemple :
- `tableau.(i) <- 3` mettre une valeur dans un tableau
- `print_string "bonjour"` les fonctions d'impression
- `a := 8` les assignations de références
- et toute les fonctions qui renvoient `unit`

La particulier des instructions, c'est qu'on peut mettre un `;` après, ce qui permet d'enchainer sur d'autres instructions. Tout à la fin de la suite d'instruction, on peut mettre une expression, qui sera "renvoyée" en quelque sorte.


Par exemple :

```ocaml
let b = (a := 3; 3);;
```
On a une instruction `a := 3` à l’intérieur d'une expression, et la valeur de cette expression est "3". Cette expression a des effets sur la variable `a`, elle la modifie. On dira que c'est une expression avec des _effets de bords_.

== Boucles en OCaml

Tout ça pour arriver au point intéressant : oui, on peut faire des boucles en OCaml. Sans récursion.


#link(
    "https://notebook.basthon.fr/?kernel=ocaml&ipynb=eJzNkt1qwzAMhV9F8eUW2Jr1yqFXfYA9wFKC5qitmSMHx6YrJe8-uS39YTdjMFhIiHUsS59OclCGnBuVfjuoniJ2GFHpg4ohjZE6pWVBU3nMauN-IKWV8R2pUo0-BZNjRxEQFhBoDbO6brjhtQ9gRZpB9DCroPPQMMhl2QTA-hwh6AUUCA9QNdx5pjrvNFyg1KdPMilaz63xiaPSnJwrlU9xSDETr6by99AXwgy344x5pRyC5djKA7a-k8Yorw00Su4L8Z-z3ho8r8TDo0m7rXWU3SsWt-x2nbXed1DJkWeIW-KL0U_Z6JxFbqST-iLuy86jfLpv0xf4H8b_WYNVedfggwLLkAOZHDH2uZI32Dsp19lxcLhvz_Lr8iQ75E3CzTVzEjJ-l1-lR-k5vwZtb9kHpavpC608D0o",
)[lien notebook]


== Fonctions anonymes et d'ordre supérieur

On peut faire ce qu'on appelle des _fonction anonymes_ en ocaml, c'est à dire des fonctions qui n'ont pas de nom.
Par exemple :
```ocaml

fun x y -> x + y

```

L'avantage principale est lorsque'on a besoin de fonctions très simples pour les placer dans des _fonctions d'ordre supérieur_, c'est à dire des fonctions qui prennent en argument des fonctions.

Celles que vous pouvez utiliser sont principalement les fonctions `init`, `map` et `iter` sur les listes et array.

Par exemple :

```ocaml
List.init len f (* renvoie [f 0; f 1; f 2; ...; f (len - 1)]*)
let l = List.init 10 (fun i -> 2 * i) (*renvoie [0; 2; 4; ...; 18]*)


List.iter (fun i -> print_int i) l (*print la liste l*)

List.map (fun i -> Array.make i 0) l (*renvoie une liste contenant des tableaux de taille 0, 2, 4, ..., 18, en suivant la liste l*)
```

Quasiment toutes les collections OCaml ont ces fonctions quasiment à l'identique !


