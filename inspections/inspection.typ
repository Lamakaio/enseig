#set page(paper: "a4", numbering: "1")
#set document(title: "Cours glouton")
#set heading(numbering: "1.a)")
#import "../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

#import "@preview/gviz:0.1.0": *

#show raw.where(lang: "dot-render"): it => render-image(it.text)

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *Contexte et documents en vue de l'inspection du 09/04/2026*
])

Le cours du jeudi 9 avril à 13h est un cours d'informatique tronc commun de MPSI. Je vois cette classe seulement 1h toutes les deux semaines.

Ils ont également 2h de TP une semaine sur deux, en groupes (la classe est coupée en 3). Les TPs sont encadrés par M. Marino, M. Caldara et M. Guillaume, des collègues de mathématiques et physique. Nous nous partageons la conception des sujets de TP : j'en adapte ou écris des nouveaux dans un peu plus de la moitié des cas, et le reste du temps mes collègues réutilisent des sujets qu'ils ont donné les années passées.

Nous travaillons actuellement sur les graphes. Un premier cours a eu lieu le 26 mars, dans lequel j'ai donné quelques définitions sur les graphes (non pondérés pour l'instant), et où j'ai abordé l'implémentation sous forme de liste / dictionnaire d'adjacence.

Vous pouvez retrouver


Au 9 avril, toute la classe aura fait le premier TP sur les graphes, que vous pouvez retrouver, avec sa correction, ici :

#link(
    "https://notebook.basthon.fr/?from=https://raw.githubusercontent.com/Lamakaio/enseig/main/inspections/TP%20graphe%20MPSI%20corrige%CC%81.ipynb&module=https://raw.githubusercontent.com/Lamakaio/enseig/main/inspections/lib.py&aux=https://raw.githubusercontent.com/Lamakaio/enseig/main/inspections/TrainNormandie.db",
)[#text(fill: blue)[Correction du TP sur les graphes (sur navigateur)]]


#link(
    "https://notebook.basthon.fr/?from=https://raw.githubusercontent.com/Lamakaio/enseig/main/inspections/TP%20graphe%20MPSI.ipynb&module=https://raw.githubusercontent.com/Lamakaio/enseig/main/inspections/lib.py&aux=https://raw.githubusercontent.com/Lamakaio/enseig/main/inspections/TrainNormandie.db",
)[#text(fill: blue)[TP sur les graphes (sur navigateur)]]

Les TPs sont partagés aux élèves avec l'application Capytale de l'ENT, mais, par facilité de partage, je vous les ai hébergé séparément.
