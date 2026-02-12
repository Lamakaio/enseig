#set page(paper: "a4", numbering: "1")
#set document(title: "Cours logique")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *
#import "@preview/cetz:0.4.2": canvas, draw, tree


#align(center, text(17pt)[
    *Logique et formules propositionnelles*
])

= Formules propositionnelles

== Syntaxe

#def[Formule propositionnelle][
    On se donne $X$ un ensemble de _variables_. On défini inductivement les _formules propositionnelles_ comme :
    - (cas de base) $v$ pour $v in X$
    - (induction) si $f_1$ et $f_2$ sont des formules,
        - $not f_1$ la négation de $f_1$
        - $f_1 and f_2$ la conjonction
        - $f_1 or f_2$ la disjonction

    $not, and "et" or$ sont des _connecteurs logiques_ d'_arité_ 1, 2 et 2 respectivement.
]

#def[][
    On utilises parfois des connecteurs logiques supplémentaires :
    - $<=>$ ou $<->$ pour l'équivalence
    - $=>$ ou $->$ pour l'implication
    - $tack.t, "ou" F$ pour le "faux"
    - $tack.b$, ou $V$ pour le "vrai"

    Ces symboles pourront être exprimés à partir des symboles de base.
]


#ex[
    $(a or b) and (not a or c)$ est une formule propositionnelle.
]


Les formules peuvent être représentées sour forme d'arbre :

#canvas({
    import draw: *
    let encircle(i) = {
        std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .5em)[#move(dx: -0.36em, dy: -0.5em, $#i$)])
    }

    set-style(content: (padding: 0.5em))
    tree.tree(
        (
            [$and$],
            (
                [$or$],
                $a$,
                $b$,
            ),
            ([$or$], ([$not$], $a$), $b$),
        ),
    )
})

#def[hauteur et taille][
    On défini
    - la _taille_ d'une formule comme le nombre de symbole nécessaires pour l'écrire.
    - la _hauteur_ d'une formule comme la hauteur de l'arbre correspondant.
]

#ex[
    $(a or b) and (not a or c)$ est de taille 8 et de hauteur 3.
]


== Sémantique

On va maintenant donner un _sens_ à nos formules.

#def[valuation][
    On appelle _valuation_ une application $nu: X -> {F, V}$.
]

#def[valeur de vérité][
    Pour _nu_ une valuation, on défini par induction la valeur de vérité $[f]_nu$ d'une formule $f$:
    - pour $x in X, [x]_nu = nu(x)$
    - si $f_1$, $f_2$ sont des formules avec une valeur de vérité $[f_1]_nu$ et $[f_2]_nu$, alors
        $
                [not f_1]_nu & = &          not [f_1]_nu \
            [f_1 and f_2]_nu & = & [f_1]_nu and [f_2]_nu \
             [f_1 or f_2]_nu & = &  [f_1]_nu or [f_2]_nu
        $
        avec le "non", "et" et "ou" usuels.

    Si $[f]_nu = V$, on dit que $nu$ est un _modèle_ de $f$.
]

#def[Satisfiabilité][
    On dit que une formules $f$ est :
    - satisfiable si elle a un modèle.
    - une tautologie si $forall nu : X -> BB, nu$est un modèle de f.
]

#def[Equivalence de deux formules][
    Deux formules $f_1$ et $f_2$ sont _équivalentes_ si
    $ forall nu : X -> BB, [f_1]_nu = [f_2]_nu $

    On note alors $f_1 eq.triple f_2$.
]

== Simplification de formules


Grâce à la notion d'équivalence, on peut simplifier ou reformuler les formules, à l'aide d'opérations.


#blk1[Propriétés][Opérations sur les formules][
    + _distributivité_ $or$ et $and$ sont distributives l'une sur l'autre
        - $f_1 and (f_2 or f_3) eq.triple (f_1 and f_2) or (f_2 and f_3)$
        - $f_1 or (f_2 and f_3) eq.triple (f_1 or f_2) and (f_2 or f_3)$
    + _tiers exclu_
        - $f or (not f) eq.triple tack.b$ (c'est une tautologie).
    + _lois de De Morgan_ :
        - $not (f_1 or f_2) eq.triple not f_1 and not f_2$
        - $not (f_1 and f_2) eq.triple not f_1 or not f_2$
]


#blk1[Propriétés][Réécriture de l'implication et de l'équivalence][
    On peut réécrire l'implication et l'équivalence avec les autres opérateurs :
    - $f_1 -> f_2 eq.triple not f_1 or f_2$
    - $f_1 <-> f_2 eq.triple (f_1 and f_2) or (not f_1 and not f_2)$
]


#ex[
    Simplifier au maximum la formule suivante :
    $ not a or not b or (b and not a) $
    $ (a and b) or (b and not a) $
    $ (a or not a) and b $
    $ b $
]

== Conséquence logique

#def[Ensemble de formule][
    Soit $Gamma$ un ensemble de formule. On dit qu'une valuation $nu$ est un modèle de $Gamma$ si elle est un modèle de chacune de ses formules.
]

#def[Conséquence logique d'un ensemble de formules][
    Soit $Gamma$ un ensemble de formules. Une formule $f$ est une _conséquence logique_ de $Gamma$ si toute modèle de $Gamma$ est un modèle de $f$.
]

== Formes normales
#def[Littéral][
    Un littéral est soit une variable, soit la négation d'une variable.
]

#def[Clause][
    Une clause conjonctive (resp disjonctive) est une conjonction (resp disjonction) de littéraux.

    Conjonction = "et", Disjonction = "ou"
]

#def[Formes normales][
    Une formule $f$ est :
    + en _forme normale conjonctive_ est une conjonction de clauses disjonctives, c'est à dire qu'elle est de la forme :
    $ and.big_i C_i = and.big_i or.big_j l_(i j) $
    + en _forme normale disjonctive_ est une disjonction de clauses conjonctive, c'est à dire qu'elle est de la forme :
    $ or.big_i C_i = or.big_i and.big_j l_(i j) $

    La forme la plus courante est la forme normale conjonctive, et donc on dit parfois simplement "clause" au lieu de "clause disjonctive".
]


#blk1[Propriétés][Lien avec la table de vérité][
    Une formule est en _forme normale disjonctive complète_ si chaque clause contient toutes les variables.

    Dans ce cas, pour remplir la table de vérité, il suffit de mettre un "1" correspondant à chaque clause, et un 0 sur le reste.
]

#ex[
    $(a and b) or (not a and not b)$
]


== Le problème SAT


On a plusieurs problèmes très célèbres en informatique : la famille des problèmes SAT.


#def[Problèmes SAT][
    - _SAT_ : étant donné une formule, est-elle satisfiable ?
    - _CNF-SAT_ : étant donné une formule en forme normale conjonctive, est-elle satisfiable ?
    - _k-SAT_ : étant donné une formule en forme normale conjonctive avec au plus $k$ littéraux par clause, est-elle satisfiable ?
]

#ex[
    Exemple d'instances de ces problèmes :
    - _SAT_ : $a or (b and (c and not d and d))$ est-elle satisfiable ?
    - _2-SAT_ : $(a or not b) and (not a or b)$ est-elle satisfiable ?
]


#blk1[Théorème][hors programme][
    3-SAT est NP-complet. Il en découle que SAT, CNF-SAT, et k-SAT pour $k >= 3$ le sont aussi.
]

#blk2[Remarque][
    Globalement, un problème NP-complet est un problème qui ne peut à priori pas être résolu en temps polynomial, donc c'est un problème (très) difficile.

    Cela vaut si $"P" != "NP"$, ce qui n'a pas été démontré.

    Le problème SAT est important car il est assez facile d'"encoder" plein d'autres problèmes avec, et de montrer que ceux-ci sont également NP-complets.
]
