#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

// Numérotation des lignes pour les codes à compléter
#let numerote(body) = {
    show raw.line: l => box(width: 1.5em, align(right, text(fill: luma(50%), str(l.number)))) + h(0.8em) + l.body
    block(breakable: false, body)
}

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *ITC MP, DS n°1* \
])

Le sujet est extrait du sujet CCINP TSI 2026. 

*Important* : pour chaque question, vous pouvez utiliser les fonctions des questions précédentes même si vous ne les avez pas toutes implémentées.

Lorsqu'on écrit, dans le sujet,
```python
def fonction(arg1: int, arg2: list) -> float:
    ...
```

Cela sert à préciser le type des arguments et de la valeur de retour de la fonction. Ici, la fonction prend en argument un entier et une liste et renvoie un flottant.

Il n'est pas nécessaire de recopier ou de préciser ces informations dans vos fonctions.

Votre code doit utiliser des noms de variables pertinents, être commenté si nécéssaire, et signaler l'indentation clairement. 

#align(center, text(17pt)[
    #underline[Autour de jeux]
])

= Des algorithmes pour résoudre le problème des $n$ reines

*Organisation de la partie I* : les différentes sous-parties sont très largement indépendantes entre elles. On signale toutefois que :
- les sous-parties I.4 et I.5 nécessitent d'admettre la question Q11 si elle n'a pas été traitée ;
- la sous-partie I.6 nécessite d'admettre la question Q17 si elle n'a pas été traitée ;
- la sous-partie I.7 nécessite d'admettre la question Q10 si elle n'a pas été traitée.

Quelques rappels de syntaxe Python figurent dans l'annexe.

Les jeux de société (échecs, dames, reversi, awale, etc.) sont une grande source d'inspiration pour tester l'efficacité de différents algorithmes.
Nous nous proposons ici d'en étudier plusieurs autour d'un défi issu du jeu d'échecs.

Considérons une grille de taille $n times n$. Une reine est une pièce du jeu qui peut se déplacer du nombre de cases que l'on souhaite le long d'une ligne, d'une colonne ou d'une diagonale montante ou descendante (figure 1).

On cherche à placer $n$ reines dans cette grille de telle façon qu'il n'y ait pas plus d'une reine sur chaque ligne, sur chaque colonne et sur chaque diagonale montante ou descendante#footnote[Ce problème a été posé en 1848 par Max Bezzel pour un échiquier ordinaire, partiellement résolu par Carl Friedrich Gauss, puis complètement résolu par Franz Nauck en 1850.] (figure 2).

#figure(caption: [Diagonales dans le cas $n = 4$])[#image("fig1.png", width: 60%)]

#figure(caption: [Une reine a été placée : les cases qu'elle contrôle et qui ne peuvent pas être occupées par d'autres reines sont figurées par le symbole $*$])[#image("fig2.png", width: 25%)]

== Introduction

Pour $n = 3$ et donc une grille $3 times 3$, le problème n'a pas de solution. Deux reines suffisent à contrôler toutes les cases. Il est donc impossible de placer une troisième reine tout en respectant la consigne.
La figure 3 illustre cette situation dans un cas, les autres s'en déduisant par symétrie ou rotation.

#figure(caption: [Cas $n = 3$ : deux reines contrôlent toutes les cases])[#image("fig3.png", width: 20%)]

Pour une grille $4 times 4$ (figure 4) ainsi que pour des grilles de taille supérieure, il y a toujours une solution au problème étudié.

#figure(caption: [Deux exemples de configurations pour $n = 4$])[#image("fig4.png", width: 65%)]

#question[
    Expliquer pourquoi la configuration perdante de la figure 4 ne résout pas le problème.
]

#question[
    On décide de coder une configuration par une liste `L` telle que `L[i]` soit égale au numéro de colonne où se trouve la reine de la ligne `i`. Par exemple, la configuration de la figure 5 sera codée par la liste `L = [2, 4, 1, 3, 0]`.

    #figure(caption: [Un exemple de configuration gagnante pour $n = 5$])[#image("fig5.png", width: 35%)]

    Donner les listes décrivant les configurations de la figure 4.
]

== Mise en place d'un affichage

Les solutions que nous obtiendrons dans les sous-parties suivantes seront des listes de $n$ positions pour les reines (comme décrit à la sous-partie I.1). Pour aider l'utilisateur, nous souhaitons afficher la grille solution trouvée et pour cela nous implémentons quelques fonctions basiques sur les listes Python.

#question[
    Écrire une fonction `ligne(n:int)->list` prenant pour paramètre un entier naturel `n` et qui renvoie une liste de taille `n` constituée uniquement de 0.
    Par exemple, pour `n = 5`, l'appel `ligne(5)` renverra `[0, 0, 0, 0, 0]`.

    _Remarque_ : l'utilisation de structures de données du module `numpy` comme `array` n'est pas autorisée.
]

#question[
    Écrire une fonction `grille(n:int)->list` prenant pour paramètre un entier `n` et qui renvoie une liste de `n` listes distinctes, chacune contenant `n` fois l'entier 0.
    Par exemple, pour `n = 3`, l'appel `grille(3)` renverra `[[0, 0, 0], [0, 0, 0], [0, 0, 0]]`.
]

On considère ainsi que pour une grille `G`, représentée par une liste de listes, `G[i][j]` correspond à la case de la $i^e$ ligne et $j^e$ colonne.

#question[
    Compléter la fonction `remplir(L:list)->list` prenant pour paramètre une liste `L` de taille `n` représentant une configuration. Cette fonction crée une grille de taille $n times n$ ne contenant que des zéros. Puis, elle remplace `G[i][j]` par la valeur 1 lorsque `L[i] = j`. Enfin, elle renvoie la grille ainsi obtenue.

    Écrire seulement les lignes à compléter sur votre copie.

    #numerote[
```python
def remplir(L):
    # On récupère la taille de L
    n = ..............
    # On crée la liste de listes G
    G = ..............
    # On remplit G à l'aide de L
    for i in range(n):
        ..............
    return ..............
```
    ]

    Par exemple, pour $n = 4$ :
    ```python
    >>> G = remplir([1, 3, 0, 2])
    >>> G
    [[0, 1, 0, 0], [0, 0, 0, 1], [1, 0, 0, 0], [0, 0, 1, 0]]
    ```
]

#question[
    La représentation des grilles produite par l'interpréteur n'est pas visuellement satisfaisante (pour l'utilisateur). Écrire une fonction `affiche(G:list)` qui prend pour paramètre une grille `G`, qui ne renvoie rien mais affiche la grille `G` ligne par ligne.
    Par exemple :
    ```python
    >>> G = remplir([1, 3, 0, 2])
    >>> G
    [[0, 1, 0, 0], [0, 0, 0, 1], [1, 0, 0, 0], [0, 0, 1, 0]]
    >>> affiche(G)
    [0, 1, 0, 0]
    [0, 0, 0, 1]
    [1, 0, 0, 0]
    [0, 0, 1, 0]
    ```
]

== Tester si une configuration est valide

Considérons une liste `L` ne contenant que des entiers entre 0 et `n-1` inclus. On admet que cette liste de positions pour les reines résout le problème étudié pour une grille de taille $n times n$ si et seulement si :
- (a) tous les `L[i]` sont distincts ;
- (b) tous les `L[i]+i` sont distincts ;
- (c) tous les `L[i]-i` sont distincts ;
- (d) cette liste `L` est de taille `n`.

#question[
    Expliquer ce que traduit d'une part le respect de (a) et d'autre part le respect de (b) et (c) pour le problème considéré.
]

#question[
    Écrire une fonction `tous_distincts(L:list)->bool` prenant en paramètre une liste `L` de positions et renvoyant `True` si tous ses éléments sont distincts, `False` sinon. Cette fonction procède comme suit :
    - on initialise un dictionnaire `presents` vide ;
    - on parcourt la liste `L`. Si on rencontre un élément `x` non encore présent parmi les clés du dictionnaire, on insère la clé `x` dans le dictionnaire avec comme valeur le booléen `True` (par exemple). Si par contre cet élément est déjà présent, on quitte la fonction en renvoyant le booléen `False` ;
    - si le parcours complet de la liste n'a pas repéré de doublon, on renvoie `True`.
]

Un étudiant propose le code alternatif suivant qui comporte plusieurs erreurs :

```python
def tous_distincts2(L):
    n = len(L)
    for i in range(n):
        for j in range(i, n):
            if L[i] == L[j]:
                return True
    return False
```

#question[
    Écrire une version corrigée de la fonction `tous_distincts2`.

    Comparer la complexité temporelle des codes `tous_distincts` et `tous_distincts2` (corrigé) dans le pire des cas, ceci pour une liste `L` de taille `n` donnée en paramètre. On justifiera en s'aidant des rappels sur la complexité donnés en annexe 2.
]

#question[
    Écrire une fonction `est_possible(L:list)->bool` prenant en paramètre une liste `L` de positions et qui renvoie un booléen indiquant si `L` satisfait simultanément les trois conditions (a), (b) et (c), ou pas.
    On pourra utiliser plusieurs appels à la fonction `tous_distincts`.

    Par exemple, `est_possible([2, 4, 1, 7, 0, 6, 3, 5])` renvoie `True` et `est_possible([3, 4, 1, 7, 0, 6, 2, 5])` renvoie `False`.
]

#question[
    Écrire une fonction `est_solution(L:list, n:int)->bool` prenant en paramètres une liste `L` de positions, un entier `n` représentant la taille de la grille et renvoyant un booléen indiquant si `L` satisfait simultanément les quatre conditions (a), (b), (c) et (d), ou pas.

    On part du principe que `L` contient uniquement des entiers de ${0, 1, dots, n-1}$, il est donc inutile de le vérifier.
]

Nous disposons maintenant d'une fonction permettant de tester si une liste de positions permet de résoudre le problème pour une grille de taille $n times n$.

== Une première approche par recherche aléatoire

Considérons une liste `L` d'éléments distincts. On appelle _permutation_ de cette liste, toute liste de même taille contenant les éléments de `L` dans un ordre éventuellement différent.
Par exemple, si `L = [0, 1, 2]`, les permutations de `L` sont les 6 listes :

#align(center)[`[0, 1, 2], [0, 2, 1], [1, 0, 2], [1, 2, 0], [2, 0, 1], [2, 1, 0]`.]

Une première méthode pour trouver une configuration solution du problème des $n$ reines consiste à générer aléatoirement des permutations de `[0, 1, …, n-1]`. Chaque permutation représente une configuration possible. Il suffit alors de tester si elle est valide. Si le nombre de permutations testées est grand et que $n$ ne l'est pas trop, on peut espérer trouver une solution.

#question[
    La fonction `sample` du module `random` peut renvoyer une permutation aléatoire d'une liste `L`. Il y a plusieurs manières d'importer cette fonction. Compléter un des codes pour utiliser `sample` comme indiqué (on attends uniquement une des trois méthodes).

    Écrire seulement les lignes à compléter sur votre copie.

    #numerote[
```python
# Méthode 1 :
.............................................
rd.sample(L, len(L))

# Méthode 2 :
.............................................
sample(L, len(L))

# Méthode 3 :
.............................................
random.sample(L, len(L))
```
    ]
]

Par la suite, on considèrera avoir importé `sample` avec la méthode 2. Pour générer une permutation aléatoire d'une liste `L`, on saisira alors `sample(L, len(L))`.
Par exemple, si `L = [0, 1, 2, 3, 4]`, `sample(L, 5)` pourra renvoyer `[1, 0, 3, 4, 2]` ou toute autre liste permutation de `L`.

#question[
    Écrire une fonction `recherche_aleatoire(n:int, N:int)->list` prenant en paramètres deux entiers naturels non nuls `n` et `N`.
    Cette fonction crée d'abord la liste `L = [0, 1, …, n-1]`. Ensuite, elle crée au maximum `N` permutations de `L` et teste si elles sont solutions du problème des $n$ reines.
    Dès qu'une liste solution est trouvée, elle est renvoyée. En cas d'échec après `N` essais, la liste vide `[]` est renvoyée.
]

En prenant `N = 100 000`, on trouve ainsi rapidement des configurations gagnantes jusqu'à $n = 12$.
À titre documentaire, on signale qu'il est possible d'accélérer cette recherche aléatoire en utilisant le fait que lorsqu'une configuration est fausse, l'erreur vient souvent du mauvais placement des premières reines. La sous-partie I.7 exploitera partiellement cette remarque.

On se propose dans la sous-partie suivante de procéder à une recherche exhaustive des configurations solutions, quitte à se restreindre à des entiers $n$ plutôt petits.

== Déterminer toutes les permutations de `L = [0, 1, …, n-1]`

#question[
    Écrire une fonction `insertion(x:int, L:list, i:int)->list` prenant pour paramètres un entier `x`, une liste `L`, un indice `i` et renvoyant une nouvelle liste obtenue en :
    - recopiant les termes de la liste `L` d'indices 0 à `i-1` inclus ;
    - puis en ajoutant `x` à la position `i` ;
    - enfin, en recopiant les termes de la liste `L` depuis l'indice `i` jusqu'à l'indice `len(L)-1` inclus.

    On renvoie donc une liste avec un élément de plus que la liste `L` : l'élément `x` inséré à l'indice `i`.

    Par exemple, l'appel `insertion(5, [2, 3, 6, 4], 1)` renvoie la liste `[2, 5, 3, 6, 4]` et l'appel `insertion(5, [2, 3, 6, 4], 4)` renvoie la liste `[2, 3, 6, 4, 5]`.

    _Attention_ : l'usage d'une quelconque fonction Python faisant cette insertion est bien sûr interdit ici.
]

On considère maintenant le code suivant :

```python
L = [[0, 1], [1, 0]]
v = 2
P = []
for l1 in L:
    for i in range(v+1):
        p1 = insertion(v, l1, i)
        P.append(p1)
```

#question[
    Quel est le contenu de `P` à l'issue du premier passage dans la première boucle ?
    Donner le contenu de `P` après l'exécution complète du code ci-dessus.
    (On demande à chaque fois de respecter l'ordre des différents éléments de `P`).

    Expliquez exactement ce que fait ce code.
]

#question[
    Compléter le code de la fonction `permutations(n:int)->list` prenant en paramètre un entier `n` supérieur ou égal à 2 et renvoyant la liste de toutes les permutations possibles des entiers de 0 à `n-1` (c'est-à-dire toutes les listes possibles contenant les entiers de 0 à `n-1` une fois et une seule).

    Par exemple, `permutations(3)` renverra une liste de sous-listes de la forme suivante (les sous-listes n'étant pas forcément dans cet ordre) :

    #align(center)[`[[0, 1, 2], [0, 2, 1], [2, 0, 1], [2, 1, 0], [1, 0, 2], [1, 2, 0]]`.]

    Écrire seulement les lignes à compléter sur votre copie.

    #numerote[
```python
def permutations(n):
    L = [[0]]
    for v in range(1, n):
        P = ..............
        for l1 in L:
            ..............
            ..............
            ..............
        L = P
    return L
```
    ]
]

#question[
    En déduire une fonction `configurations(n:int)->list` prenant en paramètre un entier `n` et renvoyant la liste de toutes les configurations satisfaisant les conditions imposées par le jeu.
]

Avec cette fonction, on peut vérifier qu'il y a 10 configurations possibles pour $n = 5$ et 92 configurations possibles pour $n = 8$.

Cependant, on peut constater que certaines configurations sont similaires : elles peuvent se déduire les unes des autres par symétrie ou rotation. La sous-partie suivante détermine les configurations similaires.

== Classer les configurations similaires

Deux configurations sont dites _similaires_ si l'on peut passer de l'une à l'autre par rotations successives d'un quart de tour, par symétrie axiale, ou par une composition des transformations précédentes.

#figure(caption: [Un exemple de symétrie horizontale, un exemple de rotation vers la droite])[#image("fig6.png")]

#question[
    On se place dans une grille de taille $5 times 5$ et on considère la configuration initiale représentée par la liste `L = [2, 4, 1, 3, 0]` (figure 6).

    Donner, sous forme d'une liste d'entiers de 0 à 4, la liste `L1` correspondant à une symétrie horizontale de la grille et la liste `L2` correspondant à une rotation d'un quart de tour vers la droite de la grille.

    De façon générale, comment obtient-on la liste `L1` correspondant à une symétrie horizontale à partir d'une liste `L` initiale ?
]

#question[
    Écrire une fonction `symetrie(L:list)->list` prenant en paramètre une liste `L` représentant une configuration et renvoyant la liste correspondant à une symétrie horizontale de la grille.
    Par exemple, cette fonction appliquée à `[1, 0, 2]` renvoie `[2, 0, 1]`.
]

#question[
    Écrire une fonction `rotation(L:list)->list` prenant en paramètre une liste `L` représentant une configuration et renvoyant la liste correspondant à la configuration obtenue par rotation d'un quart de tour vers la droite : chaque reine à la position ligne `i`/colonne `L[i]` se retrouve, après rotation, à la position ligne `L[i]`/colonne `n-1-i`.

    Par exemple, cette fonction appliquée à `[2, 5, 3, 1, 7, 4, 6, 0]` renvoie `[0, 4, 7, 5, 2, 6, 1, 3]`.
]

On suppose que l'on dispose d'une fonction `similaires(L1:list, L2:list)->bool` prenant en paramètres deux listes `L1` et `L2` de taille `n` représentant des configurations. Cette fonction renvoie `True` si `L1` et `L2` sont des configurations similaires, `False` sinon. Cette fonction est basée sur les fonctions `symetrie` et `rotation` mais il n'est pas demandé de l'implémenter.

On donne alors le code d'une fonction `partition` qui prend en paramètre un entier `n`.

#block(breakable: false)[
```python
def partition(n):
    C = configurations(n)
    P = []
    for c in C:
        test = False
        for elt in P:
            if similaires(elt[0], c):
                elt.append(c)
                test = True
        if test == False:
            P.append([c])
    return P
```
]

#question[
    Que fait la ligne 2 de la fonction `partition` ?

    Quel est le type de la variable renvoyée par l'appel `partition(n)` ? Décrire complètement la structure de cette variable.

    Expliquer en quelques phrases comment fonctionne cette fonction `partition`.
]

#question[(bonus)

Implémenter (ou proposer des pistes pour implémenter) la fonction `similaires`.]

#align(center, text(15pt)[
    *Annexe - Rappels de syntaxe Python*
])

#table(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, center + horizon),
    [Création d'un dictionnaire vide], [`dico = dict()`], [$O(1)$],
    [Nombre de clés d'un dictionnaire], [`len(dico)`], [$O(1)$],
    [Test d'appartenance d'une clé à un dictionnaire], [`x in dico`], [$O(1)$],
    [Création d'une liste vide], [`L = []`], [$O(1)$],
    [Taille d'une liste], [`len(L)`], [$O(1)$],
    [Test d'appartenance à une liste], [`x in L`], [$O($`len(L)`$)$],
    [Ajouter un élément à la fin d'une liste],
    [```python
    >>> L = [1, 2, 3]
    >>> L.append(5)
    >>> L
    [1, 2, 3, 5]
    ```],
    [$O(1)$],
    [Supprimer et renvoyer le dernier élément d'une liste],
    [```python
    >>> L = [1, 2, 3]
    >>> a = L.pop()
    >>> a
    3
    >>> L
    [1, 2]
    ```],
    [$O(1)$],
    [Affichage d'une variable `x` et retour à la ligne], [`print(x)`], [],
)
