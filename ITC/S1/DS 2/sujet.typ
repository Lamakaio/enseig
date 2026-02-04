#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *ITC MP, DS n°1*
])

#align(center, text(17pt)[
    *Questions de cours*
])

*1.* Quelle méthode utilise-on pour ajouter un élément à la fin d'une liste ?

*2.* Si $L$ est une liste (avec `len(L) > 11`), que représentent les expressions suivantes ?
- `L[10]`
- `L[0:10]`
- `L[::-1]`

*3.* On suppose que l'on dispose d'une fonction `fusion(L1, L2)` qui renvoie la fusion de deux listes triées. Écrire une fonction `tri_fusion(L)` qui prend une liste en argument et la renvoie triée, en utilisant l'algorithme du tri fusion.

*4.* Quelle est la complexité de cette fonction ?


#align(center, text(17pt)[
    *Modélisation numérique d'un matériau magnétique*
])

Ce sujet est un extrait modifié du sujet des Mines 2022.

Certains matériaux particuliers peuvent acquérir des états magnétiques qualifiés de paramagnétique et ferromagnétique. Le matériau est dit *paramagnétique* lorsqu'il ne possède pas d'aimantation spontanée, mais acquiert une aimantation sous l'effet d'un champ magnétique extérieur. Il est dit *ferromagnétique* lorsqu'il possède une aimantation même en l'absence de champ magnétique extérieur. Dans ces matériaux, la température $T$ joue un rôle crucial : si $T$ est supérieure à une température particulière $T_C$ , nommée température de Curie, le matériau adopte un état paramagnétique. Dans le cas contraire ($T < T_C$), il adopte un état ferromagnétique. C'est par exemple le cas du fer, pour lequel la transition entre les deux états se produit à $T_C = 1043 "kelvin"$.



Dans un matériau magnétique, les divers éléments magnétiques (électrons, atomes) possédant un moment magnétique créent une aimantation moyenne à l'intérieur du matériau. Nous admettrons les principaux résultats de la théorie du paramagnétisme.

Ce sujet est constitué de 2 parties indépendantes. Dans la première, on cherche à obtenir l'aimantation moyenne du matériau en fonction de la température à partir d'une formule théorique connue. Dans la deuxième, on cherche à développer une modélisation microscopique d'un matériau magnétique à deux dimensions pour retrouver ce comportement (modèle d'Ising).

Les candidats sont fortement incités à expliciter brièvement leurs programmes à l'aide de quelques commentaires bien placés, et à soigner la présentation de leur code. En particulier :
- les noms de variables doivent être explicites quand leur usage n'est pas immédiatement clair.
- l'indentation de votre programme doit être spécifiée (par exemple, par des lignes).

L'utilisation du module numpy n'est pas autorisée.

= Transition paramagnétique/ferromagnétique sans champ magnétique extérieur

La théorie des matériaux indique que, dans un matériau ferromagnétique, l'aimantation volumique moyenne du matériau est donnée par :

$ M = N mu tanh ((mu B)/(k_B T)) $

où N est le nombre d'atomes par unité de volume, $B$ est la valeur du champ magnétique à l'intérieur du matériau, $mu$ le moment magnétique des atomes ou des ions, $k_B$ la constante de Boltzmann, $T$ la température et $tanh : x |-> (e^x - e^(-x))/(e^x + e^(-x))$ la fonction tangente hyperbolique.

On considère une situation sans champ magnétique extérieur. Le champ magnétique local à l'intérieur du matériau ferromagnétique est donc celui crée par la matériau lui-même. On admet que ce
champ magnétique est proportionnel à l'aimantation moyenne dans le matériau ($B = mu M$), et on
obtient alors : $M = N mu tanh ((mu lambda M)/(k_B T))$.


En introduisant l'aimantation réduite $m = M/(N mu)$ et la température réduite $t = (k_B T)/(N mu^2 lambda) = T/(T_C)$, l'équation
1 devient :
$ m = tanh(m/t) $

Cette équation d'inconnue m ne possède pas de solution analytique : si on veut connaître une approximation de l'aimantation moyenne dans le matériau, il est donc nécessaire de la résoudre numériquement par une méthode de recherche de zéro.


_Pour importer une ou plusieurs fonction d'un module python, on écrit :_
```python
from module import fonction1, fonction2
```

#question[Écrire les instructions nécessaires pour importer exclusivement les fonctions exponentielle (`exp`) et tangente hyperbolique (`tanh`) du module math. Ces fonctions seront ainsi utilisables dans tous les programmes que vous écrirez ultérieurement.]

#question[
    Mettre l'equation (2) sous la forme $f(m, t) = 0$, d'inconnue m que l'on doit résoudre.
]
#question[Écrire en Python la définition de la fonction $f$ correspondante (paramètres m et t, valeur renvoyée f(m, t)).]

#question[
    Écrire une fonction `recherche_dicho(t, a, b, eps)`, qui prend en argument :
    - la valeur de `t` pour la fonction `f`
    - un intervalle `[a, b]` dans lequel on va chercher un zéro de f
    - une précision `eps`

    Votre fonction doit renvoyer une valeur de `m` pour laquelle `f(m, t)` s'annule, à `eps` près.

    On demande d'utiliser une recherche dichotomique.
]

Une étude mathématique simple permet de prouver que l'équation $m = tanh(m/t)$ n'a de solution $m > 0$ que pour $0 < t < 1$, ce qui revient à dire que le matériau ne possède une aimantation non nulle que pour une température inférieure à la température de Curie. On admet ainsi que si $t >= 1$ alors $m = 0$. De plus, pour $t < 1$, on admet que la solution $m = 0$ ne doit pas être prise en compte car elle correspond à une solution instable.

#question[En utilisant la fonction `recherche_dicho`, écrire une fonction `construction_liste_m(t1, t2)` qui construit et retourne une liste de 500 solutions de l'équation (2), pour $t$ variant linéairement de `t1` à `t2` (bornes incluses). On cherchera les valeurs de $m$ à $10^(-6)$ près avec un intervalle de recherche initial $m in [0.001, 1]$.]

En traçant l'aimantation $m$ en fonction de la température $t$, on obtient le graphe de la figure 1
permettant de visualiser les domaines ferromagnétique $(t < 1)$ et paramagnétique $(t >= 1)$.

#figure(caption: [aimantation réduite $m$ en fonction de la température réduite $t$])[
    #image("figure1.png", width: 80%)
]

= Modèle microscopique d'un matériau magnétique

Pour étudier l'effet du champ magnétique sur un matériau magnétique, on adopte une modélisation microscopique. On modélise les atomes par des sites portant chacun une grandeur physique, nommée _spin_, dont il n'est pas nécessaire de connaître les propriétés.

L'échantillon modélisé est une zone carrée à deux dimensions possédant $h$ _spins_ régulièrement répartis dans chaque direction, donc formant une grille carrée de $n = h^2$ _spins_. Chaque _spin_ ne possède que deux états _down_ ou _up_, ce que l'on modélise par une variable $s_i in {-1, +1}$.

#figure(caption: [Modèle des _spins_ dans un matériau ferromagnétique])[
    #image("figure2.png", width: 70%)
]

Pour implémenter cette configuration de _spins_ décrivant l'état microscopique du matériau, on choisit de travailler sur une liste de listes `s`.

Ainsi, `s` est la liste des lignes du tableau des _spins_, et chaque ligne est la liste des _spins_ qui la composent.

Un domaine d'aimantation uniforme (cf. figure 2) sera donc représenté par un tableau contenant uniquement des "1" :
```py
[[1,1,1,....1],
 [1,1,1,....1],
 [1,1,1,....1],
 ...
 [1,1,1,....1]]
```
Le début du programme, outre les imports de module Python déjà réalisés à la question 1, comprend la ligne :

```python
h = 100
```

ce qui définit une variable globale utilisable dans tout le programme.

#question[
    Comment peut-on accéder au _spin_ en position `(i, j)` à partir du tableau `s` ?
]

#question[Écrire une fonction `initialisation()` renvoyant un tableau de _spins_ contenant $h times h$ fois un _spin_ $+1$, comme le tableau de la figure 2.]

L'antiferromagnétisme est une propriété de certains milieux magnétiques. Contrairement aux matériaux ferromagnétiques, dans les matériaux antiferromagnétiques, l'interaction d'échange entre les atomes voisins conduit à un alignement antiparallèle des moments magnétiques atomiques (cf. figure 3). L'aimantation totale du matériau est alors nulle (on se limite au cas où h est pair).


#figure(caption: [Modèle des _spins_ dans un matériau antiferromagnétique])[
    #image("figure3.png", width: 70%)
]

#question[Écrire une fonction `initialisation_anti()` renvoyant un tableau s d'initialisation contenant $h times h$ _spins_ en alternant les 1 et -1 comme sur la figure 3.]


Dans la modélisation adoptée (sans champ magnétique extérieur), l'énergie d'une configuration, définie par l'ensemble des valeurs de tous les _spins_, est donnée par :
$ E = - J/2 sum_i sum_(j in V_i) s_i s_j $

On suppose que seuls les quatre _spins_ situés juste au dessus, en dessous, à gauche et à droite de $s_i$ sont capables d'interagir avec lui.

J est nommée intégrale d'échange et modélise l'interaction entre deux _spins_ voisins. Pour simplifier, on considérera dans les programmes que J = 1.

Malgré le caractère fini de l'échantillon, on peut utiliser une modélisation très utile pour faire comme s'il était infini en utilisant les conditions aux limites périodiques. Lorsque l'on considère un _spin_ dans la colonne située la plus à droite (resp. gauche), il ne possède pas de plus proche voisin à droite (resp. gauche) : on convient de lui en affecter un, qui sera situé sur la même ligne complètement à gauche (resp. droite) de l'échantillon . De même, le plus proche voisin manquant d'un _spin_ situé sur la première (resp. dernière) ligne sera situé sur la dernière (resp. première) ligne de l'échantillon (voir
la figure 4)

#figure(caption: [Voisinage d'un _spin_ (les voisins des _spins_ sur les cases noires sont indiqués en gris)])[
    #image("figure4.png", width: 65%)
]

#question[Définir une fonction `liste_voisins(i, j)` qui renvoie la liste des indices des plus proches voisins du _spin_ $s_(i j)$ d'indice `(i, j)` dans la liste `s` (dans l'ordre gauche, droite, dessous, dessus).

    _On pourra utilement utiliser l'opérations %, qui renvoie le reste de la division euclidienne. En particulier, `h % h = 0` et `-1 % h = h - 1`_]

#question[Définir la fonction `energie(s)` qui calcule l'énergie d'une configuration s donnée (cf. équation 3).]
