#set page(paper: "a4", numbering: "1")
#set document(title: "Exo automates")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.6": *

#align(center, text(17pt)[
    *Exercices sur les automates*
])

#outline(indent: auto)


=

==

Determiniser : 

#figure(caption: [A1])[
    #raw-render(
        ```dot
        digraph {
          node [shape=circle]
          2 [shape=doublecircle]
          "" [shape=none]
          "" -> 0
          0 -> 1 [label=a]
          0 -> 2 [label="a, b"]
          1 -> 3 [label="a, b"]
          3 -> 2 [label="a"]
          4 -> 4 [label="a, b"]
          3 -> 4 [label="a, b"]
          4 -> 2 [label="b"]
          
        }
        ```,
    )
]

0 \
1, 2 \
2 \
3 \
emptyset \
2, 4 \
4 \



#figure(caption: [A2])[
    #raw-render(
        ```dot
        digraph {
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

Quel langage reconnu ? Determiniser. 

0\
01\
012\
013\
0134\
03\
034



== 

D´eterminer un automate reconnaissant l’ensemble des mots ayant le mˆeme nombre de a et de b et tels que tout pr´efixe
a au plus un a de plus que de b.a.

== 

Soit X = {0, 1}. Un mot non vide u = apap1 . . . a1a0 sur X repr´esente un entier n =
pX
k=0
ak 2 k ´ecrit en binaire (le bit
de poids fort en tˆete).
1. Dessiner un AFD reconnaissant les multiples de 3.
2. En d´eduire un AFD reconnaissant les multiples de 6.

== 

Le code du digicode en bas de votre immeuble est 17B43. D´eterminer un automate d´eterminant si vous avez bien rentr´e
le bon code (la porte doit s’ouvrir si vous taper 123A17B43456 ou bien 11717B17B417B43)