#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: focus, new-section

#show: metropolis.setup

#slide[
  #set page(header: none, footer: none, margin: 3em)


  #text(size: 1.3em)[
    *Présentation du code, preuve de programme, tests*
  ]

  #metropolis.divider

  #set text(size: .8em, weight: "light")
  Ambre Le Berre

  2025/2026

  MP
]

#slide[
  = Agenda

  #metropolis.outline
]

#new-section[Présentation du code]

#slide[
  = Nommer ses variables

  - Il est important de _donner des noms explicites_ à ses variables : sauf dans les cas vraiment "standard" (`L`, `i`, `j`, ...), on utilise un ou deux mots. C'est d'autant plus vrai pour les fonctions.
  #show: later

  - Les noms des variables et fonctions sont en _`snake_case`_ en Python :
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

  Il est important de _commenter votre code_ dès qu'il n'est pas évident !
  - commentaire inutile
  ```Python
  a = 3 # assigne 3 à la variable a
  ```
  - commentaire utile :
  ```Python
  cpt = 0 # la variable cpt compte le nombre de bouteilles dans la mer
  ```
]

#slide[
  = Documenter ses fonctions
  On peut (et on doit) ajouter une _chaine de documentation_ à ses fonctions.

  ```Python
  def salue(personne):
    """
    Prend en argument une personne (chaine de caractère) et la salue.
    Renvoie un booléen, `true` si la salutation a été retournée.
    """
    # code pour saluer une personne
  ```

  #show: later
  Ensuite, on peut accéder à cette chaine avec
  ```Python
  help(salue)
  ```
]

#slide[
  = Indentation

  L'_indentation_ de votre programme doit être parfaitement claire.

  À l'écrit, on trace des lignes !
]

#new-section[Programmation défensive]

#slide[
  = Pré-conditions, post-conditions, invariant

  Comment faire pour être certain qu'une boucle, ou qu'un bloc d'instruction, est correct ?

  #show: later

  On écrit des conditions de la forme suivante :
  - une _pré-condition_ est respectée avant l'entrée dans la boucle.
  - pendant toute l'execution de la boucle, un _invariant_ reste vrai.
  - si c'est deux propriétés sont respectées, on en déduit une _post-condition_ qui sera vrai à la sortie de la bouvle.
]

#slide[
  = Exemple

  ```python
  def somme(L):
      """
      Cette fonction prend en argument une liste d'entier, et calcule et renvoie sa somme.
      """
      S = 0
      # pré-condition
      for i in range(len(L)):
          # invariant
          S += L[i]
      # post-condition
      return S
  ```
]


#slide[
  = Exemple 2

  ```python
  def insere(L_triee, x):
      """ Cette fonction prend en argument une liste triée d'entiers, et un élément x, et l'insère en place dans la liste. """
      ...

  def tri_insertion(L):
      """Cette fonction prend en argument une liste d'entier, et renvoie une nouvelle liste triée avec l'algorithme du tri par insertion."""
      L_triee = []
      # pré-condition
      for i in range(len(L)):
          # invariant
          insere(L_triee, L[i])
      # post-condition
      return L_triee
  ```
]

#slide[
  = Assertions

  Les _assertions_ permettent de tester les conditions et invariants pendant l'execution du code.

  ```python
  # pre-condition : la liste n'est pas vide
  assert len(L) > 0
  ```

  Si la condition est fausse, une _erreur_ est levée.
]


#slide[
  = Exemple

  ```python
  def somme(L):
      """
      Cette fonction prend en argument une liste d'entier, et calcule et renvoie sa somme.
      """
      S = 0
      #pre-condition : L est une liste d'entiers
      assert type(L) == list
      for i in range(len(L)):
          # invariant : L[i] est un entier et S contient la somme de L[0:i+1].
          assert type(L[i]) == int
          S += L[i]
      # post-condition : S contient la somme de L.
      return S
  ```
]

#slide[
  = Tests

  On appelle _jeu de test_ l'ensemble des tests d'un programme. Comment écrire des tests ?
  #show: later

  - _Partitionner l'espace d'entrée_ en catégories, et faire un test par catégorie.

  #show: later

  - Tester les _cas limites_.
]

#new-section[Preuves de programme]

#slide[
  = Pourquoi les preuves de programmes ?

  Lorsqu'on ne veut pas dépendre d'un test, on peut prouver mathématiquement que notre programme est juste.
]

#slide[
  = Définitions

  _Terminaison_ : On dit qu'un programme *termine* si son execution ne boucle *jamais* à l'infini, quelle que soit l'entrée.

  #show: later

  ```python
  def exp(x, n):
      resultat = 1
      while n != 0:
          resultat *= x
          n -= 1
      return resultat
  ```
]


#slide[
  = Prouver la terminaison

  ```python
  def exp(x, n):
      """ Prend en entrée un entier x et un entier positif n et renvoie x^n. """
      resultat = 1
      assert n >= 0
      while n != 0:
          resultat *= x
          n -= 1
      return resultat
  ```

  #show: later

  _variant de boucle_ : quantité positive et strictement décroissante entre chaque tour de boucle.
]
