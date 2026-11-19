#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

// Numérotation des lignes pour les codes à compléter
#let numerote(body) = {
    show raw.line: l => box(width: 1.5em, align(right, text(fill: luma(50%), str(l.number)))) + h(0.8em) + l.body
    block(breakable: false, body)
}

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *Interro programation dynamique : plus longue sous-séquence croissante* \
])


Dans ce sujet, nous allons nous intéresser au problème de la plus longue sous-séquence croissante. 

On se donne une séquence $x_1, dots, x_N$ d'entiers. On cherche $i_1 < i_2 < dots < i_p (p <= N)$  une suite strictement croissante d'indices tels que $x_i_1 <= x_i_2 <= dots <= x_i_p$.

Par exemple :\ $[1, 3, 4]$ est une sous-séquence croissante de $S=[1, 1, 9, 2, 3, 12, 1, 3, 5, 4, 8]$.

Une plus longue sous-séquence croissante (abrégée PLSC dans la suite du sujet) est une sous-séquence croissante _de taille maximale_. 

#question[Donnez une PLSSSC de S.]

#question[On propose l'algorithme glouton suivant pour trouver la PLSC. Quelle est sa complexité en fonction de $n = "len"(S)$? Expliquer pourquoi il ne donne pas la solution optimale. ]

#pseudocode-list(hooks: .5em, title: smallcaps[GLOUTON ( S )], booktabs: true)[
    + SC = [ ]
    + *Pour chaque* élément x dans la liste S
      + *Si* x >= SC[-1]
        + Ajouter x à la fin de SC

    + *Renvoyer* SC
  ]

On va donc résoudre le problème de la PLSC en utilisant la programmation dynamique. 

Pour `S` une liste de taille $n$, et $i <= n$, on va poser $"Pl"(k)$ la taille de la plus longue sous-séquence croissante qui se termine en `S[k]` (elle doit utiliser `S[k]` !).

#question[Que vaut $"Pl"(0)$ ?]

#question[Montrer que, dans le cas général, $"Pl"(k) = 1 + max_(1<=i<=k-1 | S[i] <= S[k]) "Pl"(i)$. ]

#question[Remplir le tableau $"Pl"$ pour la suite S de l'exemple de début de sujet.]

#question[Écrire une fonction `recherche(S, Pl, k)` qui renvoie $max_(1<=i<=k-1 | S[i] <= S[k]) "Pl"(i)$]

#question[Écrire une fonction `calcul_pl(S)` qui calcule et renvoie le tableau `Pl`.]

#question[En déduire une fontion `PLSC(S)` qui renvoie la taille des PLSC de S. Quelle est sa complexité ? ]

*Bonus : Théorème d'Erdős-Szekeres*

Si $n$ est la taille de $S$, montrer que $S$ contient soit une sous-suite croissante de longueur $floor.l sqrt(n) floor.r$, soit une sous-suite décroissante de longueur $floor.l sqrt(n) floor.r$.

On pourra procéder en dénombrant les couples $(a_i, b_i)$, où $a_i$ est la longueur de la PLSC se terminant en $S[i]$, et $b_i$ idem avec la suite décroissante.