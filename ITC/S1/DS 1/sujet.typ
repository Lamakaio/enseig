#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *ITC MPSI, DS n°1* \
    *Autour des nombres premiers*
])

= Questions de cours

Répondez succinctement aux questions suivantes :
+ Comment affiche-on une variable `x` en Python ?
+ Quelle est la différence entre une boucle `for` et une boucle `while` ? Quand utilise-on l'une ou l'autre ?
+ Comment définit-on un commentaire en Python ?
+ Quelle notation permet d'indiquer qu'un programme a une complexité _linéaire_ en fonction de `n`?
+ Si un programme fait $(n^3 + 5 n^2 + 8) / (n + 10)$ opérations, quelle est sa complexité en fonction de `n` ?
+ Citez trois algorithmes de tri. Le nom de l'un d'eux commence par un `i`. Détaillez les opérations effectuées par cet algorithme sur la liste `[3, 2, 5, 1]` lorsqu'on trie en ordre croissant.

= Préliminaires

Ce sujet est inspiré du sujet d'informatiques de 2019 aux Mines.

*Préambule*

Chiffrer les données est nécessaire pour assurer la confidentialité lors d'échanges d'informations
sensibles. Dans ce domaine, les nombres premiers servent de base au principe de clés publique et
privée qui permettent, au travers d'algorithmes, d'échanger des messages chiffrés. La sécurité de
cette méthode de chiffrement repose sur l'existence d'opérations mathématiques peu coûteuses en
temps d'exécution mais dont l'inversion (c'est-à-dire la détermination des opérandes de départ à
partir du résultat) prend un temps exorbitant. On appelle ces opérations « fonctions à sens unique ».
Une telle opération est, par exemple, la multiplication de grands nombres premiers. Il est aisé de
calculer leur produit. Par contre, connaissant uniquement ce produit, il est très difficile de déduire
les deux facteurs premiers.
Le sujet étudie différentes questions sur les nombres premiers.

Il n'est pas nécessaire d'avoir réussi à écrire le code d'une fonction pour pouvoir s'en servir dans une autre question.


*Définitions, rappels et notations*
- Un nombre premier est un entier naturel qui admet exactement deux diviseurs : 1 et lui-même. Ainsi 1 n'est pas considéré comme premier.
- Quand une fonction Python est définie comme prenant un « nombre » en paramètre cela signifie que ce paramètre pourra être indifféremment un flottant ou un entier.
- On note $floor.l x floor.r$ la partie entière de x.
- la notation `1e-3` en python représente $10^(-3)$.
- `abs(x)` renvoie la valeur absolue de x. La valeur renvoyée est du même type de données que celle en argument.
- `int(x)` convertit vers un entier. Lorsque x est un flottant positif ou nul, elle renvoie la partie entière de x, c'est-à-dire l'entier n tel que $n <= x < n + 1$.
- `round(x)` renvoie la valeur de l'entier le plus proche de x. Si deux entiers sont équidistants, l'arrondi se fait vers la valeur paire.
- `floor(x)` / `ceil(x)` renvoient la valeur du plus grand / petit entier inférieur ou égal à x.
- `log(x)` renvoie sous forme de flottant la valeur du logarithme népérien de x.
- Pour importer des fonctions `f1`, `f2` et `f3`  d'un module `m`, on écrit `from m import f1, f2, f3` (en remplaçant évidemment `m`, `f1`, `f2` et `f3` par les noms appropriés).

*Consignes d'écriture du code*
- Les noms de variables doivent être explicites, et le code doit être commenté lorsque c'est nécessaire. C'est d'autant plus nécessaire si vous définissez des fonctions auxiliaires.
- L'indentation de votre code doit être parfaitement claire. À cet effet, vous devez signaler les niveaux d'indentation par des lignes verticales.



*Q1* – Dans un programme Python on souhaite pouvoir faire appel aux fonctions `log`, `sqrt`, `floor` et `ceil` du module `math` (`round` est disponible par défaut). Écrire des instructions permettant d'avoir accès à ces fonctions et d'afficher le logarithme népérien de 0,5.


*Q2* – Écrire une fonction `sont_proches(x, y)` qui renvoie `True` si la condition suivante est remplie et `False` sinon
$ |x - y| <= "atol" + |y| times "rtol" $
où `atol` et `rtol` sont deux constantes, à définir dans le corps de la fonction, valant respectivement
$10^(-5)$ et $10^(-8)$. Les paramètres x et y sont des nombres quelconques.

*Q3* – On donne la fonction `mystere` ci-dessous. Que renvoie `mystere(1001,10)` ? Le paramètre `x` est un nombre strictement positif et `b` un entier naturel non nul.

```python
def mystere(x, b):
    cpt = 0
    while x > b:
        cpt += 1
        x /= b
    return cpt
```

*Q4* – Exprimer ce que renvoie mystere en fonction de la partie entière d'une fonction usuelle.

= Génération de nombres premiers

Le crible d'Ératosthène est un algorithme qui permet de déterminer la liste des nombres premiers
appartenant à l'intervalle $[|1,N|]$. Son pseudo-code s'écrit comme suit :

#figure(caption: [Crible d'd'Ératosthène])[
    #pseudocode-list(hooks: .5em, booktabs: true)[
        #underline()[Données] : N un entier supérieur ou égal à 1.

        #underline()[Résultat] : _liste_bool_, une liste de booléens.

        + _liste_bool_ $<-$ liste de N booléens initialisée à Vrai
        + Marquer comme Faux le premier élément de _liste_bool_
        + *Pour* _i_ $<-$ 2 *à* $floor.l sqrt(N) floor.r$ *faire*
            + *si* _i_ n'est pas marqué comme Faux dans _liste_bool_ *alors*
                + Marquer comme Faux tous les multiples de _i_ différents de _i_ dans _liste_bool_.
        + *retourner* _liste_bool_
    ]]

*Q5* - Donnez une majoration de la complexité de l'algorithme du crible d'd'Ératosthène en fonction de `N`. (On demande un `O(...)`.)

*Q6* - Écrire la fonction `crible_erato(N)` qui implémente l'algorithme de la Figure 1, pour un paramètre `N` qui est un entier supérieur ou égal à 1.


= Compter les nombres premiers

La question de la répartition des nombres premiers a été étudiée par de nombreux mathématiciens, dont Euclide, Riemann, Gauss et Legendre. On étudie dans cette partie les propriétés de la
fonction $pi(N)$, qui renvoie le nombre de nombres premiers appartenant à $[|1,N|]$.

*Q7* - Écrire une fonction `pi(N)` qui calcule la valeur exacte de $pi(N)$ pour tout entier k de $[|1,N|]$.
Les nombres premiers sont déduits de la liste _liste_bool_ renvoyée par la fonction `crible_erato` de la question 6. On demande que `pi(N)` renvoie son résultat sous la forme d'une liste de $[k, pi(k)]$ pour `k` allant de 1 à `N`.
Par exemple `pi(4)` renvoie la liste `[[1, 0], [2, 1], [3, 2], [4, 2]]`.



Il a été prouvé que $n/(ln(n) - 1) < pi(n)$ pour tout $n > 5393$. On souhaite vérifier cette inégalité en se
basant sur la fonction `pi(N)` écrite en question 8.

*Q8* - Écrire une fonction `verif_pi(N)` qui renvoie `True` si l'inégalité est vérifiée de 5393 jusqu'à `N` inclus, `False` sinon. Le paramètre `N` est un entier supposé supérieur ou égal à 5393.


= Vérification

On suppose dans cette partie qu'on nous donne une liste d'entiers non triée.

*Q9* - Écrire une fonction `est_liste_premier(L)` qui vérifie que tous les entiers de la liste sont premiers. Elle doit renvoyer `True` si c'est le cas, `False` sinon. On demande d'utilisez la fonction `crible_erato` de la question 6.

*Q10* - Écrire une fonction `trier_liste(L)` qui trie _en place_ la liste L donnée en argument, par ordre croissant. Vous pouvez utilisez l'algorithme de votre choix, mais on vous demande de nommer cet algorithme.

*Q11* - Écrire une fonction `est_complete(L, N)` qui vérifie si la liste `L` contient _exactement_ tous les nombres premiers de $[|1, N|]$. Vous utiliserez pour cela les fonctions `trier_liste` et `crible_erato`.
