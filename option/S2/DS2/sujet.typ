#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°2")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *


#align(center, text(17pt)[
    *Option Informatique MP, DS n°2*
])


= Racine carré d'un language (CCP 2019)

== Définitions

#def[Carré d'un language][
    Soit $L$ un language. On note $L^2$ l'ensemble ${u u| u in L}$
]


#def[Racine carré d'un language][
    Soit $L$ un language. On note $sqrt(L)$ l'ensemble ${u | u u in L}$
]


#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $a^star b^star$
]


#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $b^star a^star b^star$
]

==
#def[Automates][
    Soient $A = (Q, Sigma, q_0, F, delta)$ un automate fini déterministe, $q'$ un élément de $Q$ et $F'$ une
    partie de Q. L'automate $(Q, Sigma, q', F', delta)$ est noté $A_(q',F')$ . Si on note $L$ le langage reconnu par $A$, $L_(q',F')$
    désigne le langage reconnu par $A_(q',F')$
]


Ici, $L$ désigne le language reconnu par l'automate $A$ suivant :

#image("a1.png")


#question[
    Construire un automate reconnaissant $L_(3, {1})$ en modifiant légèrement $A$.
]

#question[
    On veut construire l'automate de Glushkov de $L$ décrit par $(a + b a^star b)^star b a^star$.
    + Décrire $L'$, le linéarisé de $L$.
    + Déterminer les préfixes de $L'$ de longueur 1, les suffixes de $L'$ de longueur 1 et les facteurs de $L'$ de longueur 2.
    + En déduire l'automate de Glushkov $G$ de $L$.
]

#question[
    Déterminiser l'automate G.
]

== Propriétés de la racine carré d'un language

Ici, on fixe $L$ un langage rationnel sur un alphabet $Sigma$ et $A = (Q, Sigma, q_0, F, delta)$ un automate fini reconnaissant celui-ci.

#question[
    Soit $u in Sigma^star$. Montrez que $u in sqrt(L)$ si et seulement si il existe $q in Q$ tel que $u in L_(q_0, {q})$ et $u in L_(q, F)$.
]

#question[
    En déduire que $sqrt(L)$ est un language rationnel.
]

#question[
    Montrer qu'on a $sqrt(L)^2 subset L$.
]

== Automates en language OCaml

On se donne le type OCaml suivant pour les automates déterministes :


```ocaml
type automate = {
  n: int;
  q0: int;
  F: bool array;
  delta: int -> char -> int
}
```

Ici, `delta` est une fonction.

#question[
    Écrivez une fonction `change: automate -> int -> int array -> automate` qui calcule l'automate $A_(q', F')$ à partie de $A$, $q'$ et $F'$.
]

#question[
    Écrivez une fonction `intersection: automate -> automate -> automate` qui, pour $A_1, A_2$ des automates, calcule un automate reconnaissant $scr(L)(A_1) inter scr(L)(A_2)$.
]

#question[
    Écrivez une fonction `sqrt: automate -> automate` qui calcule un automate reconnaissant la racine carré du language de l'automate donné en argument.
]


= Expression rationnelle associée à un automate (Centrale 2022)

Dans cette partie, on introduit un algorithme, dû à Conway, pour le calcul de l'expression rationnelle associée
au langage d'un automate, via l'utilisation de matrices dont les coefficients sont des expressions rationnelles

#pagebreak()
== Simplification d'expressions rationnelles équivalentes

On se donne en Caml le type `exprat` des expressions rationnelles
```ocaml
type exprat = Vide
            | Epsilon
            | Lettre of char
            | Union of exprat * exprat
            | Concat of exprat * exprat
            | Etoile of exprat ;;```

À noter qu'on a le symbole `Vide`, qui correspond à $emptyset$, dans ces expressions. Celui-ci dénote l'ensemble vide (donc un language qui ne reconnait aucun mot).
===

#question[
    Écrire une fonction lettre de signature `exprat -> int` qui renvoie le nombre de lettres présentes dans l'expression rationnelle en argument. Par exemple, si $E = (a^star b) + a b b a (a + epsilon)^star + epsilon$, `lettre e` doit renvoyer 7. (Le symbole $+$ dénote de l'union)
]

#question[
    Écrire une fonction est_vide de signature `exprat -> bool` qui teste si le langage rationnel représenté par l'expression rationnelle en argument est vide.
]


===

Dans cette section, on travaille formellement sur la syntaxe des expressions rationnelles.
On utilise les équivalences évidentes suivantes

$ emptyset + E eq.triple E + emptyset eq.triple E $
$ epsilon dot E eq.triple E dot epsilon eq.triple E $
$ emptyset dot E eq.triple E dot emptyset eq.triple emptyset $
$ emptyset^star eq.triple epsilon $
$ epsilon^star eq.triple epsilon $
$ (E^star)^star eq.triple E^star $


où la notation $E eq.triple E'$ signifie que les langages représentés sont égaux : $scr(L)(E) = scr(L)(E ' )$.


La fonction suivante réalise une simplification à la racine sur une expression du type Union en suivant la règle donnée.


```ocaml
let su expr = match expr with
| Union( Vide , e ) -> e
| Union( e , Vide ) -> e
| _ -> expr;;
```


De même, on peut écrire une fonction `sc : exprat->exprat` qui simplifie à la racine une expression de type `Concat`. On suppose codées ces fonctions.

#question[
    Écrire une fonction `se : exprat -> exprat` qui simplifie à la racine une expression de type `Etoile` avec les règles données
]

Prenons par exemple $E_n = (a + (b dot.c (b dot.c (b dot.c (b dot.c dots emptyset)...)$, où $n$ lettres $b$ concaténées se succèdent.

#figure(caption: [Exemple de l'arbre syntaxique de $E_4$])[
    #image("asyn.png")
]

#question[
    Combien d'applications de règles décrites ci-dessus sont-elles nécessaires pour obtenir à partir de $E_n$ l'expression équivalente a ?
]

#question[
    Écrire une fonction `simplifie : exprat -> exprat` qui simplifie une expression rationnelle selon les règles données.
]

== Matrices d'expressions rationnelles

Dans la suite, on considère des matrices d'expressions rationnelles.

```ocaml
type mat = exprat array array;;
```

#def[matrice nulle][
    La matrice nulle de taille n est la matrice de taille n où chaque coefficient vaut $emptyset$.
]

#def[identité][
    La matrice identité de taille n est la matrice de taille n où chaque coefficient vaut $epsilon$ sur la diagonale et $emptyset$ en
    dehors de la diagonale.]


#def[somme][
    On définit la somme de deux matrices $A$ et $B$ de taille $(n times m)$ par la matrice $A + B$ de taille $(n times m)$ où

    $ [A + B]_(i,j) = A_(i,j) + B_(i,j) $

    où le + représente l'opération rationnelle d'union et $0 <= i <= n - 1, 0 <= j <= m - 1$.
]

#def[produit][
    On définit le produit de deux matrices $A$ et $B$ de taille $(n times p)$ et $(p times q)$ à la manière du produit matriciel usuel
    $A B$, de taille $(n times q)$, où la somme de coefficients est remplacée par l'union et où le produit de coefficients est
    remplacé par la concaténation des expressions rationnelles.
]

===
#question[
    Écrire une fonction somme de signature `mat -> mat -> mat` effectuant la somme de deux matrices d'expressions rationnelles de même taille $(n times p)$. Quelle est sa complexité ?
]

#question[
    Écrire une fonction produit de signature `mat -> mat -> mat` effectuant le produit de deux matrices d'expressions rationnelles, en supposant que les tailles sont bien compatibles (la première de taille $(n times p)$ et la seconde de taille $(p times q)$.) On ne vérifiera pas la compatibilité des tailles. Quelle est sa complexité ?
]

=== Étude de l'étoile d'une matrice de taille 2


Plaçons-nous dans le cas d'une matrice carrée de taille 2, $M = mat(a, b; c, d)$, où a, b, c et d sont quatre lettres.
On associe à cette matrice $M$ le graphe étiqueté à deux sommets de la figure 3.

#figure(caption: [représentation de la matrice sous forme de graphe])[#image("fig3.png")]

On note $L_i,j$ le langage de l'automate $scr(A)_(i, j) = (Q = {0, 1}, q_0 = {i}, F = {j}, delta)$ où $delta : (i, M_(i, j)) -> j | (i,j} in {0, 1}^2$.

#question[
    Donner une expression rationnelle sur l'alphabet {a, b, c, d} pour décrire chaque langage $L_(i, j)$.
]
