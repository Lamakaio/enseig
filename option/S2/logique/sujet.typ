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
]

