#set page(paper: "a4", numbering: "1")
#set document(title: "notes correction")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *

#set math.equation(numbering: "(1)")

= Sujet CCP 2024

1. Oui, 0 rouge 123 bleu

2. Il s'agit de n, car, comme tous les sommets sont reliés deux à deux, ils ne peuvent pas avoir la même couleur.

3. $chi(G) <= n$ car on peut toujours colorier chaque sommet avec une couleur unique.

$omega(G) <= chi(G)$ : on a que $K_(omega(G))$ est un sous-graphe de G. Donc une coloration de G doit fonctionner pour $K_(omega(G))$, et donc elle a au moins $omega(G)$ couleurs.


4.

```py
d1 = {
    0: [1, 2, 3],
    1: [0],
    2: [0]
    3: [0]
}
```

5.

```py
def degres_sommets(d):
    return [(len(l), i) for (i, l) in d.items()]
```

6.

```py
def tri_degres(d):
    couples = degres_sommets(d)
    tri(couples) #on suppose une fonction in place ?
    return [s for (d, s) in couples]
```

7.

= Centrale 2024

2.

a) par récurrence

- Un graphe à deux sommets est connexe ssi il a une arrête
- Soit un $G = (S, A)$ graphe connexe avec n sommets.
On a deux cas :
- soit tous les sommets de G sont reliés a au moins 2 arrêtes. Alors on a au moins n arrêtes.
- soit il existe $x in S$ relié a exactement une arrête.
Alors, soit $G[S\\{x}]$ le sous graphe induit par les sommets sauf $x$. $G[S\\{x}]$ est nécessairement connexe, car, pour deux sommets $y$ et $z$ $in S\\{x}$, le chemin entre $y$ et $z$ ne peut pas passer par $x$.

Alors, par récurrence, $G[S\\{x}]$ a au moins n - 2 arrêtes.

Or, comme $G$ est connexe, il a au moins une arrête reliée à $x$, qui n'est donc pas dans $G[S\\{x}]$. Donc $|A| >= n - 1$.


b) Si un graphe a $|S|$ arrêtes ou plus, alors il a un cycle.

Par récurrence :
- ok pour 3 sommets (le seul graphe à 3 arrêtes est un triangle)
- Soit $G = (S, A)$, avec $|A| >= |S|$.
    - 1er cas : tous les sommets sont de degrés 2 ou plus. Dans ce cas, considérons une chaine de longueur maximale dans G, $s_1, ..., s_k$. Comme $s_k$ est de degrés 2 ou plus, il existe une arrête $s_k -> x$ tel que $x != s_(k-1)$. De plus, comme notre chaine est maximale, on ne peut pas avoir $x in.not {s_1, ..., s_k}$, et donc il existe $1 <= p < k - 1$ tel que $s_k -> s_p$. La chaine $s_p, ..., s_k$ est alors un cycle.
    - 2eme cas : il existe un sommet $x$ de degrés 0 ou 1. Dans ce cas, $G[S\\{x}]$ a au moins $|S| - 1$ arrêtes, et, par récurrence, il a un cycle.


3.
Par définition, $G "est un arbre" <=> G "est connexe et sans cycle"$. En appliquant les deux propriétés de la question 2, on en déduit $|A| >= |S| - 1 "et" |A| <= |S| - 1$.

Donc $G "est un arbre" => |A| = |S| - 1$, et donc implique aussi les propriétés 2 et 3.

Si on montre $2 <=> 3$, cela permet de conclure (car $2 + 3 => 1$ par définition).

Si G n'est pas connexe, alors on a deux composantes connexes $G[X] = (X, A_X) "et" G[Y] = (Y, A_Y)$ avec $X union.sq Y = S$ (union disjointe), et aucune arrête reliant $X$ à $Y$.

Donc toutes les arrêtes de $A$ sont soit dans $A_X$, soit dans $A_Y$.

Donc $|A_X| + |A_Y| = |S| - 1 = |X| + |Y| - 1$. Donc soit $A_X >= |X|$, soit $|A_Y| >= Y$, et donc d'après la question 2, soit $G[X]$, soit $G[Y]$, ont un cycle.


Inversement, si $G$ a un cycle, on prend $X$ les sommets du cycle, et $G[X] = (X, A_X)$ le sous-graphe associé.

On a forcément $|A_X| >= |X|$.

Il reste donc, au plus, $|S| - |X| - 1$ arrêtes qui ne sont pas dans $G[X]$.


Or, dire que G est connexe, reviens à dire que le graphe G', où on a fusionné tous les sommets de X en un seul, est connexe (car comme X est un cycle, tous ses sommets sont reliés).

Or, $G'$ a $|S| - |X| + 1$ sommets et $|S| - |X| - 1$ arrêtes. Donc il ne peut pas être connexe. Donc G n'est pas connexe.




6.


