#set page(paper: "a4", numbering: "1")
#set document(title: "Algorithme polynomial pour le problème 2-SAT")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.6": *

#align(center, text(17pt)[
    *Cours types récursifs et arbres*
])

#outline(indent: auto)

== Définition inductive d'un ensemble

Idée : définir un ensemble d'objets "par récurrence".

#def[Ensemble inductif][
    Un ensemble inductif E est défini par :
    - Un ensemble K de _cas de bases_.
    - Un ensemble $C$ de constructeurs, qui sont des fonctions $c: E^(k_c) -> E$ où $k_c in NN$.


    On pose
    - $E_0 = K$
    - $forall n in NN^*, E_n = E_(n-1) union union.big_(c in C) c(E_(n-1)^(k_c))$

    Alors, on a $E = union.big_(n in NN) E_n$.
]

En français : on peut appliquer les constructeurs autant de fois que nécessaires (en se limitant à un nombre fini) à partir des cas de base, pour obtenir tous les éléments de E.


#ex[
    On peut définir les listes d'entiers inductivement comme :
    - soit la liste vide `[]`
    - soit `x::q`, où `x` est un entier et `q` une liste.
]

#ex[
    On peut définir les arbres comme :
    - soit une feuille `F`
    - soit un noeud, composé de deux ou plus arbres !
]


== L'équivalent OCaml : Les types récursifs

=== Types énumération
On peut écrire des types énumération en OCaml :

```OCaml
type classe =
    | MPSI_1
    | MPSI_2
    | MP_1
    | MP_2
    | MP_ET;;
```

Une valeur de type "classe" peut alors prendre une des 5 valeurs définies (et rien d'autre !).

#ex[
    ```ocaml
        let ma_classe: classe = MPSI;;
    ```
]

On peut également stocker des données arbitraires dans une des options :

```OCaml
type classe =
    | MPSI_1
    | MPSI_2
    | MP_1
    | MP_2
    | MP_ET
    | Autre of str
```

#ex[
    ```ocaml
        let ma_classe: classe = Autre "BCPST";;
    ```
]


La construction `match` est alors très utile, car elle permet de traiter séparément chaque cas du type énumération.

#ex[
    ```ocaml
    let nb_eleves (c: classe): int = match c with
        | MPSI_1 -> 49
        | MPSI_2 -> 43
        | MP_1 -> 38
        | MP_2 -> 36
        | MP_ET -> 40
        | Autre nom -> (failwith "classe inconnue !" ^ nom)
    ```
]

=== Types récursifs

On peut également faire des types récursifs, c'est à dire, utiliser le type "classe" dans sa propre définition !

Bien sûr, il faut que certains variants n'utilisent pas de type récursif, pour qu'on puisse "s'arrêter".

```ocaml

type classe = MP | MPSI | PCSI | PC | Autre of string | DoubleNiveau of classe * classe;;


let classe4 = DoubleNiveau (MP, PC);;

let classe5 = DoubleNiveau (DoubleNiveau (MP, PC), Autre "MPI");;

```

== Petit point sur les listes


En OCaml, on pourrait définir nous même un type de liste : 

```ocaml
type liste = Vide | El of int * liste;;
```