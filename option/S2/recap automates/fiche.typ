#set page(paper: "a4", numbering: "1")
#set document(title: "Algorithme polynomial pour le problème 2-SAT")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.6": *

#align(center, text(17pt)[
    *Fiche récap automates et expressions régulières *
])

#outline(indent: auto)

= Expressions régulières / rationnelles

On se donne un alphabet $Sigma$.

#def[Expression régulière][
    On défini inductivement une expression régulière comme :
    - $emptyset$ l'expression vide
    - $epsilon$ le mot vide
    - $x, x in Sigma$ une lettre

    Pour $e_1$, $e_2$ deux expressions régulières, on ajoute :
    - $e_1 + e_2$ ou $e_1 | e_2$ l'union
    - $e_1 e_2$ ou $e_1 dot e_2$ la concaténation
    - $e_1^star$ l'étoile
]

#def[Language associé à une expression][
    On défini le language associé à une expression régulière inductivement
    - $L(emptyset) = emptyset$
    - $L(epsilon) = {epsilon}$
    - $forall x in Sigma, L(x) = {x}$
    Pour $e_1$, $e_2$ deux expressions régulières,
    - $L(e_1 | e_2) = L(e_1) union L(e_2)$
    - $L(e_1 e_2) = {m_1 m_2 | m_1 in L(e_1), m_2 in L(e_2)}$
    - $L(e_1^star) = {m_1 m_2 dots m_n | m_1, dots, m_n in L(e_1)}$ (à noter que $epsilon in L(e_1^star)$)
]

On appelle language _régulier_ un language reconnu par une expression régulière.

= Automates
== Déterministes

#def[Automate déterministe][
    Un automate A est un quintuplet $(Q, Sigma, q_0, F, delta)$, où :
    - $Q$ est un ensemble fini d'_états_
    - $Sigma$ est un alphabet
    - $q_0 in Q$ est l'_état initial_ de l'automate
    - $F subset Q$ est l'ensemble des _états acceptants_ de l'automate
    - $delta : Q times Sigma -> Q union {emptyset}$ est l'ensemble des transitions
]


#def[$delta^star$][
    On défini inductivement la fonction $delta^star : Q times Sigma^star -> Q$ de la manière suivante :
    - $forall q in Q, delta^star (q, epsilon) = q$
    - $forall q in Q, x u in Sigma^+, delta^star (q, x u) = delta^star (delta (q, x), u)$
]

#def[Language reconnu par un automate][
    On défini le language reconnu par un automate $A = (Q, Sigma, q_0, F, delta)$ comme :
    $ L(A) = {u in Sigma^star | delta^star (q_0, u) in F} $
]

== Automates non déterministes

#def[Automate non déterministe][
    Un automate A est un quintuplet $(Q, Sigma, Q_0, F, delta)$, où :
    - $Q$ est un ensemble fini d'_états_
    - $Sigma$ est un alphabet
    - #text(fill: red)[$Q_0 subset Q$ est l'ensemble des _états initiaux_ de l'automate]
    - $F subset Q$ est l'ensemble des _états acceptants_ de l'automate
    - #text(fill: red)[$delta : Q times Sigma -> scr(P)(Q)$ est l'ensemble des transitions]
]


#def[$delta^star$][
    On défini inductivement la fonction $delta^star : #text(fill: red)[$scr(P)(Q)$] times Sigma^star -> #text(fill: red)[$scr(P)(Q)$]$ de la manière suivante :
    - $forall E subset Q, delta^star (E, epsilon) = E$
    - $forall E subset Q, x u in Sigma^+, delta^star (E, x u) = delta^star (delta (E, x), u)$
]

#def[Language reconnu par un automate][
    On défini le language reconnu par un automate $A = (Q, Sigma, q_0, F, delta)$ comme :
    $ L(A) = {u in Sigma^star | #text(fill: red)[$delta^star (Q_0, u) inter F != emptyset$]} $
]

== Propriétés
#blk1[Propriété][Determination][
    Soit $scr(L)_"dfa"$ l'ensemble des languages reconnaissables par un automate déterministe. \
    Soit $scr(L)_"nfa"$ l'ensemble des languages reconnaissables par un automate non-déterministe.

    Alors : $scr(L)_"dfa" = scr(L)_"nfa"$
]

#def[Language rationnel][
    On appelle language rationnel tout language $L$ tel que $exists A$ un automate, $L = L(A)$
]

#def[Automate des parties][
    Soit $A_n = (Q_n, Sigma, Q_0^n, F_n, delta_n)$ un automate non deterministe.

    On défini $A_p$ l'automate des parties correspondant à $A_n$, de la manière suivante :

    - $Q_p = scr(P)(Q_n)$ (les parties de $Q_n$)
    - $Sigma = Sigma$
    - $q_0^p = Q_0^n$
    - $F_p = {E | E subset Q_n "et" E inter F_n != emptyset}$
    - $delta_p(E, x) = union.big_(q in E) delta_n(q, x)$
]

#blk1[Propriété][][
    $A_n$ et $A_p$ reconnaissent le même language.
]

#blk1[Opération sur les languages rationnels][][
    Soit $L_1, L_2$ deux languages rationnels. Alors $L_1 union L_2, L_1 L_2, L_1 inter L_2, L_2 \\ L_2 "et" L_1^star$ le sont aussi.
]

On le montre en construisant les automates correspondants, par exemple à l'aide de l'automate des parties.

= Lien entre les deux

#blk1[Théorème][De Kleene][
    Les languages rationnels sont exactement les mêmes que les languages réguliers.
]


== Passage automate -> expression régulière

On étiquette les transitions par des expressions régulières plutôt que des lettres, et on supprime les sommets un à un.


== Passage expression régulière -> automate

Exemple : $(a + b a^star b)^star b a^star$

On construit l'automate de Glushkov :
+ On _linéarise_ l'expression régulière, c'est à dire qu'on numérote chaque lettre. On note $Sigma' = {a_1, a_2, a_3, b_1, b_2, b_3}$ le nouvel alphabet.

    $ (a_1 + b_1 a_2^star b_2)^star b_3 a_3^star $

+ On trouve l'ensemble des préfixes et suffixes de 1 lettre, et des facteurs de 2 lettres, possibles.

    $ "premiers :" a_1, b_1, b_3 $
    $ "derniers :" a_3, b_3 $
    $
        "facteurs :" a_1 a_1, a_1 b_1, a_1 b_3, b_1 a_2, b_1 b_2, a_2 a_2, a_2 b_2, b_2 a_1, b_2 b_1, b_2 b_3, b_3 a_3, a_3 a_3
    $


+ On construit l'automate correspondant au language linéarisé $A = (Q = Sigma union {epsilon}, Sigma, epsilon, "derniers", delta)$, où :
    - $forall x in "premiers", delta(epsilon, x) = x$
    - $forall x y in "facteurs", delta(x, y) = y$
    - $delta$ n'est pas définie sinon.
+ On supprime la numérotation dans les transitions du graphe pour avoir l'automate final.

#figure(caption: [Automate de l'étape 3])[
    #raw-render(
        ```dot
        digraph {
          node [shape=circle]
          a_3 [shape=doublecircle]
          b_3 [shape=doublecircle]
          "" [shape=none]
          "" -> epsilon
          epsilon -> a_1 [label=a_1]
          epsilon -> b_1 [label=b_1]
          epsilon -> b_3 [label=b_3]
          a_1 -> a_1 [label=a_1]
          a_1 -> b_1 [label=b_1]
          a_1 -> b_3 [label=b_3]
          b_1 -> a_2 [label=a_2]
          b_1 -> b_2 [label=b_2]
          a_2 -> a_2 [label=a_2]
          b_2 -> a_1 [label=a_1]
          b_2 -> b_1 [label=b_1]
          b_2 -> b_3 [label=b_3]
          b_3 -> a_3 [label=a_3]
          a_3 -> a_3 [label=a_3]
        }
        ```,
    )
]
#figure(caption: [Automate de l'étape 4])[
    #raw-render(
        ```dot
        digraph {
          node [shape=circle]
          a_3 [shape=doublecircle]
          b_3 [shape=doublecircle]
          "" [shape=none]
          "" -> epsilon
          epsilon -> a_1 [label=a]
          epsilon -> b_1 [label=b]
          epsilon -> b_3 [label=b]
          a_1 -> a_1 [label=a]
          a_1 -> b_1 [label=b]
          a_1 -> b_3 [label=b]
          b_1 -> a_2 [label=a]
          b_1 -> b_2 [label=b]
          a_2 -> a_2 [label=a]
          b_2 -> a_1 [label=a]
          b_2 -> b_1 [label=b]
          b_2 -> b_3 [label=b]
          b_3 -> a_3 [label=a]
          a_3 -> a_3 [label=a]
        }
        ```,
    )
]

À noter qu'on obtient un automate non-déterministe, qui contient autant d'état que la taille de l'expression régulière source.


