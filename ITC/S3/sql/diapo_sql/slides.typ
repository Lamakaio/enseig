#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: diamond
#import metropolis: focus, new-section

#show: metropolis.setup





#let eleves = csv("Eleves.csv");
#let profs = csv("Profs.csv");



#slide[
  #set page(header: none, footer: none, margin: 3em)


  #text(size: 1.3em)[
    *Bases de données et SQL*
  ]

  #metropolis.divider

  #set text(size: .8em, weight: "light")
  Ambre Le Berre

  2025/2026
]

#slide[
  = Agenda

  #metropolis.outline
]

#new-section[Introduction et vocabulaire]
#slide[
  = Introduction
  Les bases de données servent à ... *stocker des données*.
  - Stocker beaucoup de données
  - Pouvoir y accéder et faire des opération dessus rapidement
]
#slide[
  = SGBD

  #diagram(
    node-stroke: 1pt,
    node((0, 0), [Utilisateur 1], corner-radius: 2pt),
    edge("dr", "-|>"),
    node((0, 1), [Utilisateur 2], corner-radius: 2pt),
    edge("r", "-|>"),
    node((0, 2), [Utilisateur 3], corner-radius: 2pt),
    edge("ur", "-|>"),
    node(
      (1, 1),
      [SGBD \
        (Système de Gestion \
        de Base de Donnée)],
    ),
    edge("r", "-|>", label-pos: 0.1),
    node(
      (2, 1),
      [Base de donnée "Classe.db"\
        (souvent un fichier) \

        #diagram(
          node-stroke: 1pt,
          node((0, 0), [Table "Eleves"], corner-radius: 2pt),
          edge("<->"),
          node((0, 0.7), [Table "Profs"], corner-radius: 2pt),
        )],
    ),
  )
]

#slide[
  = Exemple de table (ou entité)
  Entité "Eleves"\

  #diagram(
    node((0, 0), table(
      columns: eleves.first().len(),
      fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
      stroke: none,
      table.header(..eleves.first().map(s => [*#s*])),
      table.hline(stroke: rgb("4D4C5B")),
      ..eleves.slice(1).flatten(),
    )),
  )
]

#slide[
  = Exemple de table (ou entité)

  #diagram(
    node((0, 0), table(
      columns: eleves.first().len(),
      fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
      stroke: none,
      table.header(..eleves.first().map(s => [*#s*])),
      table.hline(stroke: rgb("4D4C5B")),
      ..eleves.slice(1).flatten(),
    )),
    node((1, -0.4), [Enregistrement (n-uplet)]),
    edge("->"),
    node((0, -0.35), ellipse(width: 510%, stroke: stroke(paint: red, thickness: 2pt)), width: 100pt),
  )
]

#slide[
  = Exemple de table (ou entité)

  #diagram(
    node((0, 0), table(
      columns: eleves.first().len(),
      fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
      stroke: none,
      table.header(..eleves.first().map(s => [*#s*])),
      table.hline(stroke: rgb("4D4C5B")),
      ..eleves.slice(1).flatten(),
    )),
    node((1, -0.4), [Enregistrement (n-uplet)]),
    edge("->"),
    node((0, -0.35), ellipse(width: 510%, stroke: stroke(paint: red, thickness: 2pt)), width: 100pt),

    node((1, -0.6), [Attribut
    ]),
    edge("->"),
    node((0.4, -0.57), ellipse(width: 110%, stroke: stroke(paint: red, thickness: 2pt)), width: 100pt),
  )
]
_Domaine d'un Attribut_ : valeurs possibles qu'il peut prendre. Dans notre cas, ce sera entier, flottant, ou chaine de caractères.

#slide[
  = Exemple de table (ou entité)

  #diagram(
    node((0, 0), table(
      columns: eleves.first().len(),
      fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
      stroke: none,
      table.header(
        ..eleves.first().slice(0, 2).map(s => underline([*#s*])),
        ..eleves.first().slice(2).map(s => [*#s*]),
      ),
      table.hline(stroke: rgb("4D4C5B")),
      ..eleves.slice(1).flatten(),
    )),
    node((1, -0.4), [Enregistrement (n-uplet)]),
    edge("->"),
    node((0, -0.35), ellipse(width: 510%, stroke: stroke(paint: red, thickness: 2pt)), width: 100pt),

    node((1, -0.6), [Attribut]),
    edge("->"),
    node((0.4, -0.57), ellipse(width: 110%, stroke: stroke(paint: red, thickness: 2pt)), width: 100pt),

    node((0.3, 0.8), [Clé Primaire = identifiant unique d'un enregistrement]),
    edge("->"),
    node((-0.4, 0.57), ellipse(width: 210%, stroke: stroke(paint: green, thickness: 2pt)), width: 100pt),
  )

]

#slide[
  = Clé étrangére

  #diagram(
    node((0.8, -0.9), [Clé étrangére], stroke: 0pt),
    edge("->"),
    node(
      (0.03, -0.3),
      ellipse(width: 110%, stroke: stroke(paint: blue, thickness: 2pt)),
      width: 100pt,
      stroke: 0pt,
    ),
    node(name: <E>, (0, 0), [
      #table(
        columns: eleves.first().len(),
        fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
        stroke: none,
        table.header(
          ..eleves.first().slice(0, 2).map(s => underline([*#s*])),
          underline(stroke: stroke(dash: "dashed"))[*Classe*],
          ..eleves.first().slice(3).map(s => [*#s*]),
        ),
        table.hline(stroke: rgb("4D4C5B")),
        ..eleves.slice(8).flatten()
      )]),
    edge((0, 0), (0, 0.7), (0.5, 0.7), "->"),
    node(name: <P>, (0.9, 0.6), [
      #table(
        columns: profs.first().len(),
        fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
        stroke: none,
        table.header(..profs.first().map(s => if s == "Classe" { underline([*#s*]) } else [*#s*])),
        table.hline(stroke: rgb("4D4C5B")),
        ..profs.slice(3).flatten()
      )]),
  )
]

#slide[
  = Modèle Entité-Association
  Permet de reprénter un _schéma de base de donnée_.
  #diagram(
    node-stroke: 2pt,
    node-inset: 20pt,
    node((0, 0), name: <E>)[Eleves],
    node((0, 2), name: <P>)[Profs],
    node((2, 2), name: <C>)[Cours],
    node((2, 0), name: <Pa>)[Parents],
    node((3, 1), name: <S>)[Salle],

    node((1, 2), shape: diamond, inset: 10pt, name: <ens>)[enseigne],
    node((1, 0), shape: diamond, inset: 10pt, name: <aPa>)[a pour \ parents],
    node((1, 1), shape: diamond, inset: 10pt, name: <ass>)[assiste à],
    node((3, 2), shape: diamond, inset: 10pt, name: <aLi>)[à lieu dans],

    edge(<E>, <aPa>)[0-\*],
    edge(<aPa>, <Pa>)[1-\*],
    edge(<E>, <ass>)[1-\*],
    edge(<ass>, <C>)[1-\*],
    edge(<P>, <ens>)[1-\*],
    edge(<ens>, <C>)[1-1],
    edge(<C>, <aLi>)[1-1],
    edge(<aLi>, <S>)[_?_],
  )
]

#new-section[Requêtes simples sur les bases de données]

#slide[
  = Le language SQL
  #grid(
    columns: (1fr, 1fr),
    image("logo.png"),
    [
      - Language simple mais puissant
      - Permet d'accéder, de trier, de regrouper, de croiser ... Les données dans une base de donnée
    ],
  )
]

#slide[
  = Projection

  La première opération sur les bases de données est la *projection*. \
  Cela permet de séléctionner seulement certains attributs (colonnes) d'une table.

  #show: later

  ```SQL
  SELECT * FROM Eleves
  ```

  #show: later
  ```SQL
  SELECT Prenom, Nom FROM Eleves
  ```

]

#slide[
  = Projection : options
  On peut ajouter plusieurs options aux projections :
  #show: later
  - Renommer des colonnes
  ```SQL
  SELECT Prenom AS P FROM Eleves
  ```
  #show: later
  - Trier les données
  ```SQL
  SELECT * FROM Eleves ORDER BY Age DESC
  ```
  #show: later
  - Afficher seulement certaines donénes
  ```SQL
  SELECT * FROM Eleves LIMIT 3 OFFSET 2
  ```
  #show: later
  - Supprimer les doublons
  ```SQL
  SELECT DISTINCT Age FROM Eleves
  ```
]

#slide[
  = Séléction
  Si la projection permettait de séléctionner des colonnes, la séléction, elle, permet de séléctionner des enregistrements, soit des lignes.

  ```SQL
  SELECT * FROM Eleves WHERE Age = 19
  ```
]


#slide[
  = Opérateurs de séléction
  Les opérateurs de séléction sont les suivants :
  - `=` et `! =` pour l'égalité
  - `>`, `<`, `>=`, `<=` pour les comparaisons
  - `AND`, `OR` et `NOT` pour combiner des opérateurs
]

#new-section[Opérations sur plusieurs tables]

#slide[
  = Jointures
  Les jointures permettent de croiser les données de plusieurs table, en général en fonction d'une clé étrangére.
  #diagram(
    node-stroke: 2pt,
    node(name: <E>, (0, 0), [
      Entité "Eleves"
      #table(
        columns: eleves.first().len(),
        fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
        stroke: none,
        table.header(
          ..eleves.first().slice(0, 2).map(s => underline([*#s*])),
          ..eleves.first().slice(2).map(s => [*#s*]),
        ),
        table.hline(stroke: rgb("4D4C5B")),
        ..eleves.slice(8).flatten()
      )]),
    edge((0, 0), (0, 0.7), (0.5, 0.7), "<->", [$star$-1]),
    node(name: <P>, (0.9, 0.6), [
      Entité "Profs"
      #table(
        columns: profs.first().len(),
        fill: (_, y) => if calc.odd(y) { rgb("D7D9E0") },
        stroke: none,
        table.header(..profs.first().map(s => if s == "Classe" { underline([*#s*]) } else [*#s*])),
        table.hline(stroke: rgb("4D4C5B")),
        ..profs.slice(3).flatten()
      )]),
  )
]

#slide[
  = Opérateur JOIN ON

  ```SQL
    SELECT Eleves.Prenom, Eleves.Nom, Profs.Salle FROM Eleves
    JOIN Profs ON
    Eleves.Classe = Profs.Classe
  ```

  Que fait cette requète à votre avis ?
]


#slide[
  = Opérateur JOIN ON

  ```SQL
    SELECT Eleves.Prenom, Eleves.Nom, Profs.Salle FROM Eleves
    JOIN Profs ON
    Eleves.Classe = Profs.Classe
  ```
  #align(center)[$arrow.b.double$]
  ```SQL
    SELECT E.Prenom, E.Nom, P.Salle FROM Eleves AS E
    JOIN Profs AS P ON
    E.Classe = P.Classe
  ```
]
