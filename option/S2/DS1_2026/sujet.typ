#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
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

#question[Donnez un automate déterministe correspondant aux langages suivants : ]
a) Le langage des mots contenant le facteur `aba`.

b) Le langage des mots avec un nombre pair de `a` et un nombre multiple de 3 de `b`.



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


#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $b^star a^star b^star$
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


== Propriétés de la racine carrée d'un langage

Ici, on fixe $L$ un langage rationnel sur un alphabet $Sigma$ et $A = (Q, Sigma, q_0, F, delta)$ un automate fini reconnaissant celui-ci.

#question[
    Soit $u in Sigma^star$. Montrez que $u in sqrt(L)$ si et seulement s'il existe $q in Q$ tel que $u in L_(q_0, {q})$ et $u in L_(q, F)$.
]

#question[
    En déduire que $sqrt(L)$ est un langage rationnel.
]

#question[
    Montrer qu'on a $sqrt(L)^2 subset L$.
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

#question[Donner, en justifiant votre réponse, $L_2 (cal(A)_{q_1})$.]

#question[
    Soit $s in NN$. Donner, en justifiant votre réponse, le cardinal de $L_s (cal(A)_emptyset)$, où $emptyset$ est l'ensemble vide.
]

#question[
    Donner, sans justification, un majorant des calculs réussis au seuil $s$ ne passant par aucun état de $O$.
]

#question[
    Soit maintenant un calcul réussi au seuil $s$ qui passe au moins par un état de $O$. On note $tilde(q) = q_0 dots.c q_l$ la suite des états correspondants et $i_0 dots.c i_k in [|0, l|]$ la suite des indices dans $tilde(q)$ correspondant aux états de $O$. Donner, sans justification, en fonction de $s$ :
    + une majoration de $i_0$ ;
    + un encadrement de $i_k$ ;
    + une majoration de $i_(j+1) - i_j$ pour $j in [|0, k-1|]$.
]

#question[
    Soit $cal(A)_O$ un automate augmenté, avec $|Q| = p$, où $Q$ est l'ensemble des états de l'automate. Pour $s in NN$, construire, en justifiant votre construction, un automate fini à $(s+1) p$ états reconnaissant $L_s (cal(A)_O)$.
]
