#set page(paper: "a4", numbering: "1")
#set document(title: "Cours logique")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *
#import "@preview/cetz:0.4.2": canvas, draw, tree


#align(center, text(17pt)[
    *TD Logique et formules propositionnelles*
])

= Quelques calculs

Donnez la valeur de vérité des formules suivantes, avec la valuation définie sur ce tableau :

#table(
    columns: 2,
    "Variable", "Valeur",
    "a", "V",
    "b", "F",
    "c", "V",
)

+ $a or b or c$

+ $(a or b) and (not a or not c)$

+ $not (not a or (a and not ((not c or c) and (not b or b))))$


= Modélisation

Donnez des formules correspondant aux affirmations suivantes (en nommant les différentes thèses) :

+ "La Terre est ronde et le ciel est bleu"
+ "Si une planète est ronde, alors son ciel est bleu"
+ "Si la Terre est plate, alors son ciel est rouge"
+ "Si une fonction est continue, alors elle est dérivable"
+ "Si une fonction non continue est dérivable, alors elle admet une dérivée seconde"

Lesquelles de ces affirmations sont des tautologie (c'est à dire qu'elles sont toujours vraies) ?

= Opérateur universel

Pour deux formules $f_1, f_2$ définie l'opérateur "nand" $arrow.b$ par la table de vérité suivante :


#table(
    columns: 3,
    $f_1$, $f_2$, $f_1 arrow.b f_2$,
    "F", "F", "V",
    "F", "V", "V",
    "V", "F", "V",
    "V", "V", "F",
)

+ Montrer que $f_1 arrow.b f_2$ peut s'exprimer à l'aide de $and$ et $not$
+ Montrer que $not f_1$ peut s'exprimer à l'aide de $arrow.b$ uniquement
+ Montrer que $f_1 and f_2$ peut s'exprimer à l'aide de $arrow.b$ uniquement
+ Montrer que toute formule peut s'exprimer à l'aide de $arrow.b$ uniquement

"nand" est ce qu'on appelle un opérateur universel. Il en existe d'autres : par exemple, le "nor".


= Lemme de substitution

Soit $f$ une formule. Pour $x in X$ une variable, et $g$ une autre formule, on note $f[x -> g]$ la formule $f$ dans laquelle on a substitué $x$ par $g$.

On peut définir cette opération par induction :
- $x[x -> g] = g$
- si $y in X, y != x$, $y[x -> g] = y$

- Pour deux formules $f_1$ et $f_2$, on a :
    - $(not f_1)[x -> g] = not f_1[x -> g]$
    - $(f_1 and f_2)[x -> g] = f_1[x -> g] and f_2[x -> g]$, et idem pour $or$



Soit $nu$ une valuation. On note $nu[x->g]$ la valuation telle que $nu[x->g](x) = [g]_nu$, et pour $y != x$, $nu[x->g](y) = nu(y)$.

Montrer que $[f[x -> g]]_nu = [f]_(nu[x -> g])$.
