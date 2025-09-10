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

#slide[
  = Les commentaires

  Les commentaires n'ont aucun impact sur le programme : il sert simplement à comprendre le code plus simplement

  ```Python
  # Les commentaires commencent par "#"
  a = 3 # on peut les mettre à la suite d'une ligne
  ```

  #show: later

  Il est important de _commenter votre code_ dès qu'il n'est pas évident !
  - commentaire inutile
  ```Python
  a = 3 # assigne 3 à la variable a
  ```
  - commentaire utile :
  ```Python
  cpt = 0 # la variable cpt compte le nombre de bouteille dans la mer
  ```
]

#slide[
  = Affichage

  Pour _afficher une valeur_, on utilise la fonction `print`
  ```Python
  print("bonjour")

  a = 4
  print("la valeur de a est : ", a)
  ```
  #show: later
  Un `print` affiche autant de valeur que l'on veut (séparées par des virgules) sur la même ligne, puis reviens à la ligne.

]

#slide[
  = Conditions

  On peut faire certaines opérations seulement si une condition est respectée :
  ```Python
  if a == 4:
    print("'a' a la bonne valeur")
  elif a > 4:
    print("'a' est trop grand !")
  else:
    print("'a' est trop petit !")
  ```
]

#slide[
  = Boucles `for`

  #image("schema_for.png", width: 60%)

  La fonction range peut aussi s'écrire `range(start, end, step)`

]

#slide[
  = Boucles `while`
  #align(center)[
    #image("schema_while.png", width: 60%)
  ]

]


#slide[
  = Laquelle utiliser ?
  On utilise :
  - Une boucle _`for`_ quand on sait à l'avance combien de tour de boucles on va faire
  - Une boucle _`while`_ sinon
]

#slide[
  = Les fonctions
  Les fonctions sont des blocs de code réutilisable :
  ```Python
  def tape(personne):
    #code pour taper une personne
    return point_de_degats

  vie = tape("Mon voisin de table")
  vie = tape("La prof")
  vie = tape("La table")
  ```

  #show: later
  - `personne` est un _argument_ de `tape`. On peut en mettre autant qu'on veut.
  - La fonction _retourne_ une valeur (avec `return`), à laquelle on peut ensuite accéder.

]


#slide[
  = Documenter ses fonctions
  On peut (et on doit) ajouter une _chaine de documentation_ à ses fonctions.

  ```Python
  def tape(personne):
    """
    Prend en argument une personne et la tape.
    Renvoie la quantité de dégats effectuée.
    """
    # code pour taper une personne
  ```

  #show: later
  Ensuite, on peut accéder à cette chaine avec
  ```Python
  help(tape)
  ```
]


#new-section[Les listes]

#slide[
  = À quoi ça sert ?

  En informatique, on est souvent amené à représenter des listes de valeurs. Par exemple, la liste des élèves d'une classe.

  Le type `list` de `Python` sert justement à représenter de tels objets.

  ```Python
  fruits = ["Pomme", "Poire", "Fraise", "Tomate"]
  ```
]

#slide[
  = Comment on s'en sert ? L'indexation

  Pour _récupérer l'élément n° `i`_ d'une liste :
  ```Python
    fruits[i]
    fruits[0]
    fruits[-1]
  ```

  #image("schema_liste.png")
]

#slide[
  = Comment on s'en sert ? Les `slice`

  On peut aussi directement récupérer une _sous-liste_, avec ce qu'on appelle le _slicing_.

  ```Python
  trois_premiers = fruits[:3]
  trois_derniers = fruits[-3:]
  milieu = fruits[2:4]
  un_sur_deux = fruits[::2]
  ```

  En fait, le slicing s'écrit `liste[start:end:step]`, avec exactment les mêmes arguments que la fonction `range` !
]




#slide[
  = Comment on s'en sert ?

  Pour _connaitre la longueur_ d'une liste :
  ```Python
    nombre_fruits = len(fruits)
  ```

  Pour _itérer_ sur les éléments d'une liste

  ```Python
    for i in range(len(fruits)):
      print(fruits[i])


    for i in range(len(fruits)):
      print(fruits[i])
  ```
]


#slide[
  = Comment on s'en sert ?

  Pour _ajouter un élément à la fin_ d'une liste, on utilise la _méthode_ `append`.

  ```Python
  fruits.append("Pêche")
  ```

  Une méthode est une fonction d'un objet, qui s'utilise avec `objet.methode(arguments...)`.
]

#slide[
  = Comment on s'en sert ?

  Pour _tester si un élément est présent_ dans une liste, on utilise le mot-clé `in` :

  ```Python
  if "Tomate" in fruits:
    print("La tomate est bien un fruit !")
  ```
]


#new-section[Modules et graphes]

#slide[
  = Le module numpy : import

  Pour importer un module, on utilise
  ```Python
  import numpy as np
  ```
  au _début_ du programme.
]

#slide[
  = Le module numpy : tableau
  Le module numpy permet de gérer des _tableaux_ (_array_ en anglais). Ce sont des listes de taille fixée.

  Pour convertir une liste en tableau :
  ```Python
  tableau = np.array(liste)
  ```

]

#slide[
  = Le module numpy : matrices

  Les tableau peuvent avoir plusieurs dimensions (pensez aux matrices). On peut alors accéder à l'élément (i, j) avec
  ```Python
  element_ij = tableau[i, j]
  ```

  On peut récupérer la taille du tableau avec :
  ```Python
  tableau.shape
  ```
]


#slide[
  = Le module matplotlib : import

  On importe le module matplotlib avec :

  ```Python
  import matplotlib.pyplot as pyplot
  ```
]

#slide[
  = Le module matplotlib : une courbe de base

  Pour afficher une _courbe_ simple, on utilise les lignes suivantes :

  ```Python
  plt.plot(X, Y, "b-")
  plt.show()
  ```

  Le "b-" est optionnel. Il est constitué
  - de l'initial de la couleur souhaitée en anglais (b, r, g, etc)
  - du type de point (+, \*, ., -, etc)

  #show: later

  Si vous avez des probèmes de courbes qui se superposent, utilisez au début `plt.clf()`.
]


