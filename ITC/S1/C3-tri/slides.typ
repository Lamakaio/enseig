#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import "@preview/lovelace:0.3.0": *
#import "../../../utils.typtp": *
#import metropolis: focus, new-section

#show: metropolis.setup

#slide[
    #set page(header: none, footer: none, margin: 3em)


    #text(size: 1.3em)[
        *Tri d'une liste*
    ]

    #metropolis.divider

    #set text(size: .8em, weight: "light")
    Ambre Le Berre

    MPSI

    2025/2026
]

#slide[
    = Plan du cours

    #metropolis.outline
]

#new-section[C'est quoi un tri ? ]

#slide[
    = C'est quoi un tri ?

    _Trier_ une liste ou une collection d'éléments, ça consiste à les réordonner pour qu'ils soient en ordre croissant ou décroissant.

    On peut écrire une condition nécéssaire et suffisante pour qu'une liste $l_0, ..., l_n$ soit triée dansl'ordre croissant :
    $ forall i in [|0, n-1|] l_i <= l_(i+1) $

]

#slide[
    = Fonction de tri

    On va en général définir des fonctions de tri, qui prennent en argument une liste et la trie. On distingue deux sortes de fonction :
    - les tris _in-place_ qui modifient la liste originale en réordonnant les éléments, afin qu'elle soit triée
    - les tris qui renvoient une nouvelle liste, triée, qui contient exactement les mêmes éléments que la liste originale.

]

#new-section[Pourquoi trier ? ]

#slide[
    = Raisons de présentation

    Dans une table, une liste, ou d'autres données destinées à un affichage, il est souvent utile de trier les éléments. Imaginez un dictionnaire où les mots sont dans un ordre aléatoire ?

]

#slide[
    = Raisons informatiques

    En informatique, on se retrouve souvent dans une situation où il est plus rapide de trier une liste avant de l'utiliser.

    - Recherche d'éléments : à la manière d'un dictionnaire, il est beaucoup plus rapide de chercher un élément dans une liste triée, que dans une liste dans le désordre.

    #show: later

    - Ordonnancement

    #show: later

    - Et bien plus ...

]

#new-section[Comment trier ? ]

#slide[
    = Le tri à bulle

    https://www.youtube.com/watch?v=Cq7SMsQBEUw
]

#slide[
    = Le tri à bulle

    Idée : à chaque étape, on compare deux éléments adjacents. Si ils sont dans le bon ordre, on les laisse. Sinon, on les échange.

    ```python
      def tri_bulle(L):
          """Trie la liste L "in place" avec l'algorithme du tri à bulle"""
          for i range(len(L) - 1):
              for j in range(len(L) - 1 - i):
                  if L[j] > L[j+1]:
                      L[j], L[j+1] = L[j+1], L[j]
    ```

    #text(fill: green)[Quelle est la complexité du tri à bulle ? Avec n = len(L).]
]


#slide[
    = Autres tris ?

    #text(
        fill: green,
    )[Réfléchisser à d'autres manières de trier une liste. Comment procédez-vous, naturellement, si on vous demande de trier la liste [4, 1, 2, 8, 3, 1, 9] ? ]
]


#slide[
    = Tri par séléction

    Idée : On prend d'abord le minimum de la liste, et on le place au début. Puis on répète sur le reste de la liste.

    ```python
      def tri_selection(L):
          """Trie la liste L "in place" avec l'algorithme du tri par séléction"""
          for i range(len(L) - 1):
              el_min = L[i]
              for j in range(i + 1, len(L) - 1):
                  if L[j] < el_min:
                      el_min, L[j] = L[j], el_min
              L[i] = el_min
    ```

    #text(fill: green)[Quelle est la complexité du tri par séléction ? Avec n = len(L).]
]




#slide[
    = Tri par insertion

    Idée : On insère, un par un, chaque élément à sa place dans une nouvelle liste triée

    ```python
      def insere(L_triee, x):
          """Insère l'élément x à sa place dans la liste triée L_triee in-place"""
          for i in range(len(L)):
              if L_triee[i] > x:
                  L_triee.insert(i, x)
                  return
    ```

    #text(fill: green)[Quelle est la complexité de la fonction insere ? Avec n = len(L).]
]


#slide[
    = Tri par insertion

    Idée : On insère, un par un, chaque élément à sa place dans une nouvelle liste triée

    ```python
      def tri_insertion(L):
          """renvoie une nouvelle liste contenant les éléments de L, triée par insertion."""
          L_triee = []
          for x in L:
              insere(L_triee, x)
          return L_triee
    ```

    #text(fill: green)[Quelle est la complexité de la fonction tri_insertion ? Avec n = len(L).]
]

#slide[
    = Tri par insertion


    ```python

      def insere(L_triee, x):
          for i in range(len(L)):
              if L_triee[i] > x:
                  L_triee.insert(i, x)
                  return

      def tri_insertion(L):
          L_triee = []
          for x in L:
              insere(L_triee, x)
          return L_triee
    ```

    #text(fill: green)[Pouvez-vous écrire une version in-place du tri par insertion ? ]
]


#slide[
    = Tri par insertion in-place

    On va faire une fonction `insere` qui prend en argument une liste L dont les k premiers éléments (0, 1, ..., k-1) sont triés dans l'ordre croissant, et un indice k.

    La fonction insère alors l'élément x dans les k premiers éléments de L, en écrasant l'élément d'indice k.

]
#slide[
    = Tri par insertion in-place
    ```python
      def insere(L, k, x):
          #boucle sur (k-1), (k-2), ..., 1, 0
          for i in range(k-1, -1, -1):
              #Si x est plus grand que l'élément actuel, on le range juste après, et on s'arrête
              if x > L[i]:
                  L[i+1] = x
                  return
              #sinon, on décale l'élément d'un cran pour laisser de la place à x
              else:
                  L[i+1] = L[i]
          #si on arrive au bout, c'est que x est le plus petit élément
          L[0] = x
    ```
]

#slide[
    = Tri par insertion in-place
    On utilise ensuite cette fonction pour réaliser le tri :
    ```python
      def tri_insertion(L):
          """Trie L en ordre croissant, par insertion, in-place"""
          #On insère le (k+1)ème élément dans les k premiers.
          for k in range(len(L)):
              insere(L, k, L[k])
    ```
]

#slide[
    = Propriétés

    Que se passe-il dans chacun des algorithmes si la liste est déjà triée ? Si elle est "presque" triée ?

    #show: later

    En fait, si on regarde la fonction du tri par insertion _in-place_, en particulier l'insertion, elle qu'une seule itération si l'élément est à sa place. Donc tout se passe comme si la liste était simplement parcouru une fois, pour une complexité _dans le meilleur cas_ en O(n).
]
