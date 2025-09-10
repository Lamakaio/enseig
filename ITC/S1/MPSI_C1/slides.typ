#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: focus, new-section

#show: metropolis.setup

#slide[
  #set page(header: none, footer: none, margin: 3em)


  #text(size: 1.3em)[
    *Le language Python*
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

#new-section[Rappels du TP]

#slide[
  = Les variables

  On peut stocker des données sous un nom : c'est une _variable_.
  ```Python
  je_suis_une_variable = 3
  s = "bonjour"
  ```

  #show: later

  On écrit toujours les noms de variables en _`snake_case`_ :
  - tout en minuscule (sauf les acronymes)
  - un underscore `_` entre les mots
  - soit tout en français _sans accent_, soit tout en anglais, pas de mélange
]

#slide[
  = Opérateurs de calculs

  On peut faire des calculs entre des valeurs ou des variables.

  ```Python
  a = 3 + je_suis_une_variable
  b = 13039 % 12
  ```

  #show: later
  On met toujours des _espaces_ avant et après un opérateurs binaire. Pour un opérateurs unaire on ne met pas d'espace.
  ```Python
  calcul = 3 * 5
  nombre_negatif = -7
  ```

]

#new-section[Faire du code "propre"]
