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



=
```sql
SELECT idC, val / taille as rentabilite FROM Conteneurs WHERE
portDepC = "Marseille" AND portDestC = "Barcelone" AND dateDisp < 2025-01-01
ORDER BY rentabilite DESC;
```

=
```sql
SELECT idN, COUNT() as nbC FROM Conteneurs GROUP BY idN WHERE idN != 0;
```
=

```python
def profit(obj, S):
    total = 0
    for i in range(len(obj)):
        total += obj[i][1] * S[i]
    return total

```

=

```python
def contrainte(obj, S, b):
    capacite = 0
    for i in range(len(obj)):
        capacite += obj[i][0] * S[i]
    return capacite <= b

```
=
```
1 0 1
1 1 0
```

=
$2^n$ feuilles, donc $O(n 2^n)$

=

```
1 1 0
```

=
```
Lqi.append(obj[i][1] / obj[i][0])
...
Li[j] = Li[j-1]
...
Li[j] = i
```


=

$O(n)$ $(O(n^2))$

=
```python
while j < len(obj):
    if obj[Li[j]][0] <= b:
        S[Li[j]] = 1
        b = b - obj[Li[j]][0]
    j += 1
```

=
=
=
$O(b n)$
=
=
```python
def est_feuille(a):
    return a['g'] == {}
```

=

```python

def possible(obj, Sk, b):
    n = len(obj)
    k = len(Sk)
    Smin = Sk + (n-k) * [0]
    Smax = Sk + (n-k) * [1]
    return contrainte(obj, Smin, b) and profit(obj, Smax) > Pmin

```

=

```python
else:
    if possible(obj, arbre['g']['S'], b):
        KPpse(arbre['g'], obj, b)
    if possible(obj, arbre['d']['S'], b):
        KPpse(arbre['d'], obj, b)
```

=

```python
for i in range(len(T)):
    T[i] *= rho
```

=

```python
kmax = 0
Pmax = 0
for i in range(len(S)):
    P = profit(obj, S[i])
    if P > Pmax:
        kmax = i
        Pmax = P
```

=

```python
for i in range(len(T)):
    if S[kmax][i] == 1:
        T[i] += 1/(1+PbestOfAll-Pmax)
        T[i] = max(T[i], Tmin)
        T[i] = min(T[i], Tmax)
```

=
```python
o0 = randint(0, n-1)
...
S[k][o0] = 1
b2 -= obj[o0][0]
```

=
```python
prob = {}
...
oi = candidats[i]
prob[oi] = (T[oi]**alpha)*((b * obj[oi][1] / obj[oi][0])**beta)
...
oi = candidats[i]
prob[oi] /= s
```

=
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
