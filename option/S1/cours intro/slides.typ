#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import "@preview/lovelace:0.3.0": *
#import "../../../utils.typtp": *
#import metropolis: focus, new-section

#show: metropolis.setup

#slide[
    #set page(header: none, footer: none, margin: 3em)


    #text(size: 1.3em)[
        *Cours d'introduction - OCaml et induction structurelle*
    ]

    #metropolis.divider

    #set text(size: .8em, weight: "light")
    Ambre Le Berre

    MPSI - option info

    2025/2026
]

#new-section[Le language OCaml]
#slide[
    = Présentation générale

    #image("ocaml_logo.png", height: 20%)

    OCaml est un language *fonctionnel*, basé en partie sur la récursivité, qui est utilisé en option informatique en prépa.

]

#slide[
    = Syntaxe de base du language
    Capytale avec le code 1aed-9321855
]


#slide[
    = Etude de cas : les formules

    On étudie des _formules_  limitées :
    - des variables (qui sont des lettres)
    - 3 opérations (addition, multiplication, et négation)


    #show: later

    ex : $(a + b) * (a + (-b))$ est une formule.
]


#slide[
    = Définition par induction

    On tente de définir les formules.

    Une addition entre deux "trucs", $(...) + (...)$ est une formule. Que peuvent être ces "trucs" ?

    #show: later

    Ils peuvent être n'importe quelle formule !

]


#slide[
    = Définition par induction (pour de vrai)


    On se donne un ensemble de variables $V$. Une formule est
    - soit une variable $v in V$
    - soit si $f_1$ est une formule
        - $-f_1$ la négation de $f_1$
        - $f_1 + f_2$ l'addition
        - $f_1 * f_2$ la multiplication
]


#slide[
    = Et en OCaml ?

    retour sur Capytale.
]
