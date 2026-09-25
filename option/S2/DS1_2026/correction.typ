#set page(paper: "a4", numbering: "1")
#set document(title: "Correction du Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.6": *

#align(center, text(17pt)[
    *Option Informatique MP, DS n°1*
])
Dans ce sujet, $Sigma = {a, b}$.

= Quelques exercices

#question[Quels sont les langages reconnus par ces automates ? Déterminisez-les, et donnez une expression régulière correspondante.]

a)
#figure(caption: [$A_1$])[
    #raw-render(
        ```dot
        digraph {
          rankdir=LR
          node [shape=circle]
          2 [shape=doublecircle]
          "" [shape=none]
          "" -> 0
          0 -> 0 [label="a, b"]
          0 -> 1 [label="b"]
          1 -> 2 [label="a, b"]
        }
        ```,
    )
]

b)
#figure(caption: [$A_2$])[
    #raw-render(
        ```dot
        digraph {
          rankdir=LR
          node [shape=circle]
          2 [shape=doublecircle]
          "" [shape=none]
          "" -> 0
          0 -> 1 [label=a]
          0 -> 3 [label="b"]
          0 -> 0 [label="a, b"]
          1 -> 1 [label="a, b"]
          3 -> 3 [label="a, b"]
          3 -> 2 [label="b"]
          1 -> 2 [label="a"]
          
          
        }
        ```,
    )
]

#correction[
    *a)* $A_1$ reconnaît les mots dont l'avant-dernière lettre est un $b$ : $L(A_1) = (a|b)^star b (a|b)$.

    Déterminisation (automate des parties) :

    #figure(
        table(
            columns: 3,
            align: center,
            [], $a$, $b$,
            [$->$ ${0}$], ${0}$, ${0,1}$,
            [${0,1}$], ${0,2}$, ${0,1,2}$,
            [$*$ ${0,2}$], ${0}$, ${0,1}$,
            [$*$ ${0,1,2}$], ${0,2}$, ${0,1,2}$,
        ),
    )

    #figure(
        raw-render(
            ```dot
            digraph {
              rankdir=LR
              node [shape=circle]
              "02" [shape=doublecircle]
              "012" [shape=doublecircle]
              "" [shape=none]
              "" -> "0"
              "0" -> "0" [label=a]
              "0" -> "01" [label=b]
              "01" -> "02" [label=a]
              "01" -> "012" [label=b]
              "02" -> "0" [label=a]
              "02" -> "01" [label=b]
              "012" -> "02" [label=a]
              "012" -> "012" [label=b]
            }
            ```,
        ),
    )

    *b)* Le langage est donc celui des mots dont la dernière lettre apparaît au moins deux fois :
    $ L(A_2) = (a|b)^star a (a|b)^star a | (a|b)^star b (a|b)^star b. $

    Déterminisation :

    #figure(
        table(
            columns: 3,
            align: center,
            [], $a$, $b$,
            [$->$ ${0}$], ${0,1}$, ${0,3}$,
            [${0,1}$], ${0,1,2}$, ${0,1,3}$,
            [${0,3}$], ${0,1,3}$, ${0,2,3}$,
            [$*$ ${0,1,2}$], ${0,1,2}$, ${0,1,3}$,
            [${0,1,3}$], ${0,1,2,3}$, ${0,1,2,3}$,
            [$*$ ${0,2,3}$], ${0,1,3}$, ${0,2,3}$,
            [$*$ ${0,1,2,3}$], ${0,1,2,3}$, ${0,1,2,3}$,
        ),
    )
]

#question[Donnez un automate déterministe correspondant aux langages suivants : ]
a) Le langage des mots contenant le facteur `aba`.

b) Le langage des mots avec un nombre pair de `a` et un nombre multiple de 3 de `b`.



#correction[
    *a)* 

    #figure(
        raw-render(
            ```dot
            digraph {
              rankdir=LR
              node [shape=circle]
              3 [shape=doublecircle]
              "" [shape=none]
              "" -> 0
              0 -> 1 [label=a]
              0 -> 0 [label=b]
              1 -> 1 [label=a]
              1 -> 2 [label=b]
              2 -> 3 [label=a]
              2 -> 0 [label=b]
              3 -> 3 [label="a, b"]
            }
            ```,
        ),
    )

    *b)* Automate : on retient $(|w|_a mod 2, |w|_b mod 3)$, soit 6 états $(i,j)$ ; $a$ envoie $(i,j)$ sur $(i+1 mod 2, j)$ et $b$ sur $(i, j+1 mod 3)$.

    #figure(
        raw-render(
            ```dot
            digraph {
              rankdir=LR
              node [shape=circle]
              "00" [shape=doublecircle]
              "" [shape=none]
              "" -> "00"
              "00" -> "10" [label=a]
              "10" -> "00" [label=a]
              "01" -> "11" [label=a]
              "11" -> "01" [label=a]
              "02" -> "12" [label=a]
              "12" -> "02" [label=a]
              "00" -> "01" [label=b]
              "01" -> "02" [label=b]
              "02" -> "00" [label=b]
              "10" -> "11" [label=b]
              "11" -> "12" [label=b]
              "12" -> "10" [label=b]
            }
            ```,
        ),
    )

]



= Racine carrée d'un langage (CCP 2019)

== Définitions

#def[Carré d'un langage][
    Soit $L$ un langage. On note $L^2$ l'ensemble ${u u| u in L}$
]


#def[Racine carrée d'un langage][
    Soit $L$ un langage. On note $sqrt(L)$ l'ensemble ${u | u u in L}$
]


#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $a^star b^star$
]

#correction[
    Je note $~$ pour "est décrit par l'expression rationnelle".

    $sqrt(L) ~ a^star | b^star$
]


#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $b^star a^star b^star$
]

#correction[
    $sqrt(L) ~ a^star | b^star$
]

#def[Automates][
    Soient $A = (Q, Sigma, q_0, F, delta)$ un automate fini déterministe, $q'$ un élément de $Q$ et $F'$ une
    partie de Q. L'automate $(Q, Sigma, q', F', delta)$ est noté $A_(q',F')$ . Si on note $L$ le langage reconnu par $A$, $L_(q',F')$
    désigne le langage reconnu par $A_(q',F')$
]


Ici, $L$ désigne le langage reconnu par l'automate $A$ suivant :

#image("a1.png")


#question[
    Construire un automate reconnaissant $L_(3, {1})$ en modifiant légèrement $A$.
]

#correction[
    - l'état initial est 3
    - le seul état acceptant est 1
]


== Propriétés de la racine carrée d'un langage

Ici, on fixe $L$ un langage rationnel sur un alphabet $Sigma$ et $A = (Q, Sigma, q_0, F, delta)$ un automate fini reconnaissant celui-ci.

#question[
    Soit $u in Sigma^star$. Montrez que $u in sqrt(L)$ si et seulement s'il existe $q in Q$ tel que $u in L_(q_0, {q})$ et $u in L_(q, F)$.
]

#correction[
    ($arrow.l.double$) Si $u in L_(q_0, {q}) inter L_(q, F)$, alors $delta^star (q_0, u) = q$ et $delta^star (q, u) in F$.

    Donc $delta^star (q_0, u^2) in F$, et $u in sqrt(L)$.


    ($arrow.r.double$) Si $u in sqrt(L)$, alors $u^2 in L$. Soit $q_0 -> q_1 -> dots -> q_(2|u|) in F$ un chemin acceptant pour $u^2$.

    Alors, avec $q = q_(|u|)$, $u in L_(q_0, {q})$, et $u in L_(q, {q_(2|u|)}) subset L_(q, F)$.
]

#question[
    En déduire que $sqrt(L)$ est un langage rationnel.
]

#correction[
    Par définition, les langages $L_(q', F')$ sont rationnels.

    Or, on a montré que $u in sqrt(L) <=> exists q, u in L_(q_0, {q}) inter L_(q, F)$.

    Donc $sqrt(L) = union.big_(q in Q) (L_(q_0, {q}) inter L_(q, F))$ : c'est une union finie d'intersections de langages rationnels, donc un langage rationnel.

]
#question[
    Montrer qu'on a $sqrt(L)^2 subset L$.
]

#correction[
    Soit $w in sqrt(L)^2$ : il existe $u in sqrt(L)$ tel que $w = u u$. Par définition de $sqrt(L)$, $u u in L$, donc $w in L$.
]

= Automates augmentés (CCP 2022)

L'objectif de cette partie est de proposer quelques éléments autour d'un automate, dit augmenté, construit autour d'un automate fini non déterministe et d'un sous-ensemble d'états.

#def[Automate fini non déterministe][
    Un _automate fini non déterministe_ est un quintuplet $cal(A) = (Q, Sigma, I, delta, F)$ avec :
    - $Q$ un ensemble fini non vide d'états, de cardinal $|Q|$ ;
    - $Sigma$ un alphabet ;
    - $I subset Q$ l'ensemble des états initiaux ;
    - $delta : Q times Sigma -> cal(P)(Q)$ une fonction de transition : si $q in Q$ et $a in Sigma$, $delta(q, a)$ désigne l'ensemble des états $q'$ de $Q$ tels qu'il existe une transition étiquetée par $a$ de $q$ vers $q'$ ;
    - $F subset Q$ l'ensemble des états finaux.
]

#def[Automate augmenté][
    Soient $cal(A) = (Q, Sigma, I, delta, F)$ un automate fini non déterministe et $O subset Q$ un sous-ensemble d'états de $Q$. On appelle _automate augmenté_ par $O$ la paire $(cal(A), O)$, que l'on notera par la suite $cal(A)_O$.
]

La notion de calcul est la même entre $cal(A)$ et $cal(A)_O$ : un calcul dans $cal(A)$ est une séquence d'états $q_1 dots.c q_n$ de $Q$ telle qu'il existe toujours au moins une transition entre deux états successifs de cette séquence. Le mot construit par concaténation des étiquettes de chacune des transitions est alors reconnu par l'automate.

L'ensemble $O$ introduit la notion de _calcul réussi au seuil $s$_.

#def[Calcul réussi au seuil $s$][
    Soit $cal(A)_O$ un automate augmenté. Un calcul passant par les états $q_i in Q$, $i in [|0, n|]$ est dit _réussi au seuil_ $s in NN$ si :
    + $q_0 in I$ ;
    + $q_n in F$ ;
    + pour tout $i >= 0$ tel que $i + s <= n$, ${q_i, dots, q_(i+s)} inter O != emptyset$.
]

#def[Langage reconnu par un automate augmenté au seuil $s$][
    Soit $cal(A)_O$ un automate augmenté et $s in NN$. Le _langage reconnu par_ $cal(A)_O$ _au seuil_ $s$, noté $L_s (cal(A)_O)$, est l'ensemble des calculs réussis par $cal(A)_O$ au seuil $s$.
]

On considère, pour les questions 9 à 12, l'automate de la figure suivante, où $Q = {q_0, q_1, q_2}$, $Sigma = {a, b}$, $I = {q_0}$ et $F = {q_2}$.

#figure(caption: [Automate exemple])[
    #raw-render(
        ```dot
        digraph {
          rankdir=LR
          node [shape=circle]
          q2 [shape=doublecircle]
          "" [shape=none]
          "" -> q0
          q0 -> q0 [label=b]
          q0 -> q1 [label=a]
          q1 -> q2 [label=a]
          q2 -> q2 [label=b]
        }
        ```,
    )
]

#question[Donner sans justification $L_2 (cal(A)_{q_0})$.]

#correction[
    $ L_2 (cal(A)_{q_0}) = {b^k a a | k >= 0}. $
]

#question[Donner, en justifiant votre réponse, $L_2 (cal(A)_{q_1})$.]

#correction[
    Si on boucle plus d'une fois sur les états $q_0$ ou $q_2$, alors le calcul commence par $q_0 q_0 q_0 q_1$, et avec $i = 0$, la condition n'est pas respectée (de même pour $q_2$).

    Donc $L_2 (cal(A)_{q_1}) = {a a, b a a, a a b, b a a b}$.
]

#question[
    Soit $s in NN$. Donner, en justifiant votre réponse, le cardinal de $L_s (cal(A)_emptyset)$, où $emptyset$ est l'ensemble vide.
]

#correction[
    Comme $O = emptyset$, aucune fenêtre ne rencontre $O$ : un calcul réussi ne doit donc contenir aucune fenêtre, c'est-à-dire aucun $i$ avec $i + s <= n$, soit $n < s$. Les calculs réussis sont donc les $q_0^(i+1) q_1 q_2^(j+1)$ avec $n = i + j + 2 <= s - 1$, soit $i + j <= s - 3$. Il y en a $sum_(i=0)^(s-3) (s - 2 - i) = (s-1)(s-2)/2$ pour $s >= 1$ (ce qui vaut bien $0$ si $s in {1, 2}$), et $0$ si $s = 0$.
]

#question[
    Donner, sans justification, un majorant des calculs réussis au seuil $s$ ne passant par aucun état de $O$.
]

#correction[
    Comme ci-dessus, un tel calcul ne contient aucune fenêtre, donc a au plus $s$ états. Il y en a au plus $sum_(k=1)^s |Q|^k <= s |Q|^s$.
]

#question[
    Soit maintenant un calcul réussi au seuil $s$ qui passe au moins par un état de $O$. On note $tilde(q) = q_0 dots.c q_l$ la suite des états correspondants et $i_0 dots.c i_k in [|0, l|]$ la suite des indices dans $tilde(q)$ correspondant aux états de $O$. Donner, sans justification, en fonction de $s$ :
    + une majoration de $i_0$ ;
    + un encadrement de $i_k$ ;
    + une majoration de $i_(j+1) - i_j$ pour $j in [|0, k-1|]$.
]

#correction[
    + $i_0 <= s$ (la première fenêtre, ou le calcul entier s'il est plus court, contient un état de $O$).
    + $l - s <= i_k <= l$ (la dernière fenêtre contient un état de $O$).
    + $i_(j+1) - i_j <= s + 1$ (la fenêtre de $s+1$ états qui suit $q_(i_j)$ contient un état de $O$).
]

#question[
    Soit $cal(A)_O$ un automate augmenté, avec $|Q| = p$, où $Q$ est l'ensemble des états de l'automate. Pour $s in NN$, construire, en justifiant votre construction, un automate fini à $(s+1) p$ états reconnaissant $L_s (cal(A)_O)$.
]

#correction[
    On retient dans l'état, en plus de l'état courant $q$ de $cal(A)$, le nombre $c in {0, dots, s}$ d'états consécutifs hors de $O$ qui terminent le calcul lu jusqu'ici. L'ensemble d'états est $Q times {0, dots, s}$, de cardinal $(s+1) p$.
    - États initiaux : $(q, 0)$ pour $q in I inter O$, et $(q, 1)$ pour $q in I without O$ (si $s >= 1$).
    - Transitions : $(q, c) ->^x (q', c')$ si $q' in delta(q, x)$, avec $c' = 0$ si $q' in O$, et $c' = c + 1$ si $q' in.not O$, cette transition n'existant que si $c + 1 <= s$.
    - États finaux : $(q, c)$ avec $q in F$.

    Justification : la condition iii) équivaut à ne jamais avoir $s + 1$ états consécutifs hors de $O$ (une fenêtre de $s+1$ états qui ne rencontre pas $O$ est exactement cela). Or le compteur $c$ dépasserait $s$ exactement dans ce cas, et la transition est alors bloquée. Les conditions i) et ii) sont vérifiées par le choix des états initiaux et finaux. Si le calcul a moins de $s+1$ états, il n'y a pas de fenêtre et le compteur ne peut pas dépasser $s$. Ainsi un calcul est accepté si et seulement s'il est réussi au seuil $s$.
]
