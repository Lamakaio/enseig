#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.6": *


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
