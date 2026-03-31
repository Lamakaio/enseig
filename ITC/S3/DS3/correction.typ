#set page(paper: "a4", numbering: "1")
#set document(title: "Cours glouton")
#set heading(numbering: "1)")
#import "../../../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

#import "@preview/gviz:0.1.0": *

#show raw.where(lang: "dot-render"): it => render-image(it.text)

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *ITC MP* \
    *Correction DS3*
])

Ce document contient des éléments de correction pour le sujet 2025 des mines. Cela reste assez succin, donc n'hésitez pas à me poser des questions par mail si besoin.

=
==
```py
def degreMax(d):
    m = 0
    for s, l in d.items():
        if len(l) > m:
            m = len(l)
    return m
```

==

```py

def graphInv(d):
    dinv = {v: [] for v, _ in d.items()}
    for s1, l in d.items():
        for s2 in l:
            dinv[s2].append(s1)
    return dinv
```

==

```py
def colorationValide(d, L):
    for s1, l in d.items():
        for s2 in l:
            if L[s1] == L[s2]:
                return False
    return True
```

==
O(N+M)

==
```sql
SELECT nomfilm, duree FROM films JOIN locations
ON films.codefilm = locations.codefilm ORDER BY duree DESC LIMIT 1
```

==
```sql
SELECT F.codefilm, nomfilm, AVG(duree) as duree_moyenne FROM films as F JOIN locations as L
ON F.codefilm = L.codefilm GROUP BY codefilm HAVING duree_moyenne < 2 ORDER BY duree_moyenne DESC
```
=
==
```sql
SELECT idC, val / taille as rentabilite FROM Conteneurs WHERE
portDepC = "Marseille" AND portDestC = "Barcelone" AND dateDisp < 2025-01-01
ORDER BY rentabilite DESC;
```

==

Il n'y avais pas besoin de `JOIN`, tout était dans `Conteneurs`
```sql
SELECT idN, COUNT() as nbC FROM Conteneurs GROUP BY idN WHERE idN != 0;
```
==

```python
def profit(obj, S):
    total = 0
    for i in range(len(obj)):
        total += obj[i][1] * S[i]
    return total

```

==

```python
def contrainte(obj, S, b):
    capacite = 0
    for i in range(len(obj)):
        capacite += obj[i][0] * S[i]
    return capacite <= b

```
==
```
1 0 1
1 1 0
```

==
$2^n$ feuilles, donc $O(n 2^n)$. Attention, le `n` ne disparait pas !

==

```
1 1 0
```

==
```
Lqi.append(obj[i][1] / obj[i][0])
...
Li[j] = Li[j-1]
...
Li[j] = i
```


==

$O(n)$ $(O(n^2))$

==
```python
while j < len(obj):
    if obj[Li[j]][0] <= b:
        S[Li[j]] = 1
        b = b - objx    [Li[j]][0]
    j += 1
```

==
La solution optimale est 0 1 1, le glouton n'est donc pas optimal. On pouvait commenter sur la différence de poids choisie, qui était assez faible.
==
==
$O(b n)$
==
La complexité n'était pas modifiée.
==
```python
def est_feuille(a):
    return a['g'] == {}
```

==

```python

def possible(obj, Sk, b):
    n = len(obj)
    k = len(Sk)
    Smin = Sk + (n-k) * [0]
    Smax = Sk + (n-k) * [1]
    return contrainte(obj, Smin, b) and profit(obj, Smax) > Pmin

```

==

```python
else:
    if possible(obj, arbre['g']['S'], b):
        KPpse(arbre['g'], obj, b)
    if possible(obj, arbre['d']['S'], b):
        KPpse(arbre['d'], obj, b)
```

==

```python
for i in range(len(T)):
    T[i] *= rho
```

==

```python
kmax = 0
Pmax = 0
for i in range(len(S)):
    P = profit(obj, S[i])
    if P > Pmax:
        kmax = i
        Pmax = P
```

==

```python
for i in range(len(T)):
    if S[kmax][i] == 1:
        T[i] += 1/(1+PbestOfAll-Pmax)
        T[i] = max(T[i], Tmin)
        T[i] = min(T[i], Tmax)
```

==
```python
o0 = randint(0, n-1)
...
S[k][o0] = 1
b2 -= obj[o0][0]
```

==
```python
prob = {}
...
oi = candidats[i]
prob[oi] = (T[oi]**alpha)*((b * obj[oi][1] / obj[oi][0])**beta)
...
oi = candidats[i]
prob[oi] /= s
```

==
```python
prob = construitProb(obj, candidats, b, T)
c = choixCandidats(candidats, prob)
S[k][candidats[c]] = 1
b2 -= obj[candidats[c]][0]
candidats_2 = []
for cc in candidats:
    if cc != c and b2 > obj[cc][0]:
        candidats_2.append(cc)
candidats = candidats_2
```

==
Il n'y a pas une seule bonne réponse à ce genre de questions, mais il fallait remarquer que l'algorithme de progdyn allait vite et était optimal. Les algorithmes d'approximation peuvent aller encore plus vite si on accepte un résultat légèrement sous-optimal (en particulier la colonie de fourmis, qui a l'avantage d'être adaptable)


