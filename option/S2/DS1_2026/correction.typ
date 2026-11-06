#set page(paper: "a4", numbering: "1")
#set document(title: "Correction du Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *
#import "@preview/diagraph:0.3.6": *

#align(center, text(17pt)[
    *Option Informatique MP, DS n°1*
])

= Quelques exercices

#question[Quels sont les langages reconnus par ces automates ? Donnez une expression régulière correspondante.]

a)
#figure(caption: [$A_1$])[
    #raw-render(
        ```dot
        digraph {
          rankdir=LR
          node [shape=circle]
          2 [shape=doublecircle]
          "" [shape=none]
          "" -> 0
          0 -> 0 [label="a"]
          0 -> 1 [label="b"]
          1 -> 2 [label="a, b"]
        }
        ```,
    )
]

b)
#figure(caption: [$A_2$])[
    #raw-render(
        ```dot
        digraph {
          rankdir=LR
          node [shape=circle]
          2 [shape=doublecircle]
          "" [shape=none]
          "" -> 0
          0 -> 1 [label=a]
          0 -> 3 [label="b"]
          1 -> 1 [label="b"]
          3 -> 3 [label="a"]
          3 -> 2 [label="b"]
          1 -> 2 [label="a"]
          
        }
        ```,
    )
]

#correction[
    *a)* $A_1$ lit un nombre quelconque de $a$, puis un $b$, puis une lettre quelconque : $L(A_1) = a^star b (a|b)$.

    *b)* Depuis $0$, un $a$ mène en $1$ où on lit des $b$ avant de finir par un $a$ ; un $b$ mène en $3$ où on lit des $a$ avant de finir par un $b$ :
    $ L(A_2) = a b^star a | b a^star b. $
]


#question[Donnez un automate déterministe correspondant aux langages suivants : ]
a) Le langage des mots contenant le facteur `aba`.

b) Le langage des mots avec un nombre pair de `a` et un nombre multiple de 3 de `b`.

#correction[
    *a)* 

    #figure(
        raw-render(
            ```dot
            digraph {
              rankdir=LR
              node [shape=circle]
              3 [shape=doublecircle]
              "" [shape=none]
              "" -> 0
              0 -> 1 [label=a]
              0 -> 0 [label=b]
              1 -> 1 [label=a]
              1 -> 2 [label=b]
              2 -> 3 [label=a]
              2 -> 0 [label=b]
              3 -> 3 [label="a, b"]
            }
            ```,
        ),
    )

    *b)* Automate : on retient $(|w|_a mod 2, |w|_b mod 3)$, soit 6 états $(i,j)$ ; $a$ envoie $(i,j)$ sur $(i+1 mod 2, j)$ et $b$ sur $(i, j+1 mod 3)$.

    #figure(
        raw-render(
            ```dot
            digraph {
              rankdir=LR
              node [shape=circle]
              "00" [shape=doublecircle]
              "" [shape=none]
              "" -> "00"
              "00" -> "10" [label=a]
              "10" -> "00" [label=a]
              "01" -> "11" [label=a]
              "11" -> "01" [label=a]
              "02" -> "12" [label=a]
              "12" -> "02" [label=a]
              "00" -> "01" [label=b]
              "01" -> "02" [label=b]
              "02" -> "00" [label=b]
              "10" -> "11" [label=b]
              "11" -> "12" [label=b]
              "12" -> "10" [label=b]
            }
            ```,
        ),
    )
]




= Racine carrée d'un langage (CCP 2019)

== Définitions

#def[Carré d'un langage][
    Soit $L$ un langage. On note $L^2$ l'ensemble ${u u| u in L}$
]


#def[Racine carrée d'un langage][
    Soit $L$ un langage. On note $sqrt(L)$ l'ensemble ${u | u u in L}$
]


#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $a^star b^star$
]

#correction[
    Je note $~$ pour "est décrit par l'expression rationnelle".

    $sqrt(L) ~ a^star | b^star$
]



#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $b^star a^star b^star$
]

#correction[
    $sqrt(L) ~ a^star | b^star$
]


#def[Automates][
    Soient $A = (Q, Sigma, q_0, F, delta)$ un automate fini déterministe, $q'$ un élément de $Q$ et $F'$ une
    partie de Q. L'automate $(Q, Sigma, q', F', delta)$ est noté $A_(q',F')$ . Si on note $L$ le langage reconnu par $A$, $L_(q',F')$
    désigne le langage reconnu par $A_(q',F')$
]


Ici, $L$ désigne le langage reconnu par l'automate $A$ suivant :

#image("a1.png")


#question[
    Construire un automate reconnaissant $L_(3, {1})$ en modifiant légèrement $A$.
]

#correction[
    - l'état initial est 3
    - le seul état acceptant est 1
]



== Propriétés de la racine carrée d'un langage

Ici, on fixe $L$ un langage rationnel sur un alphabet $Sigma$ et $A = (Q, Sigma, q_0, F, delta)$ un automate fini reconnaissant celui-ci.

#question[
    Soit $u in Sigma^star$. Montrez que $u in sqrt(L)$ si et seulement s'il existe $q in Q$ tel que $u in L_(q_0, {q})$ et $u in L_(q, F)$.
]

#correction[
    ($arrow.l.double$) Si $u in L_(q_0, {q}) inter L_(q, F)$, alors $delta^star (q_0, u) = q$ et $delta^star (q, u) in F$.

    Donc $delta^star (q_0, u^2) in F$, et $u in sqrt(L)$.


    ($arrow.r.double$) Si $u in sqrt(L)$, alors $u^2 in L$. Soit $q_0 -> q_1 -> dots -> q_(2|u|) in F$ un chemin acceptant pour $u^2$.

    Alors, avec $q = q_(|u|)$, $u in L_(q_0, {q})$, et $u in L_(q, {q_(2|u|)}) subset L_(q, F)$.
]


#question[
    En déduire que $sqrt(L)$ est un langage rationnel.
]

#correction[
    Par définition, les langages $L_(q', F')$ sont rationnels.

    Or, on a montré que $u in sqrt(L) <=> exists q, u in L_(q_0, {q}) inter L_(q, F)$.

    Donc $sqrt(L) = union.big_(q in Q) (L_(q_0, {q}) inter L_(q, F))$ : c'est une union finie d'intersections de langages rationnels, donc un langage rationnel.
]


#question[
    Montrer qu'on a $sqrt(L)^2 subset L$.
]

#correction[
    Soit $w in sqrt(L)^2$ : il existe $u in sqrt(L)$ tel que $w = u u$. Par définition de $sqrt(L)$, $u u in L$, donc $w in L$.
]




= Automates et reconnaissance de motifs (CCP 2024)


Un alphabet $A$ est un ensemble fini non vide d'éléments appelés lettres. Un mot défini sur $A$ est une suite finie d'éléments de $A$. Le mot vide sera noté $epsilon$. L'ensemble des mots sur l'alphabet $A$ est noté $A^star$. La longueur d'un mot $x$, notée $|x|$, est le nombre de lettres de ce mot. Pour $i$ allant de $0$ à $|x| - 1$, $x_i$ désignera la lettre en position $i$. Ainsi, $a a b$ est un mot de longueur 3, sur tout alphabet contenant les lettres $a$ et $b$.

Un mot $x$ est un _facteur_ d'un mot $y$ s'il existe 2 mots $u$ et $v$ tels que $y = u x v$. Dans ce cas, on dit qu'il y a une _occurrence_ de $x$ dans $y$. Quand $u = epsilon$, $x$ est un _préfixe_ de $y$ et quand $v = epsilon$, $x$ est un _suffixe_ de $y$.

Soit $x$ un mot non vide. Un entier $0 < p <= |x|$ est une _période_ de $x$ si $x_i = x_(i+p)$ pour $0 <= i <= |x| - p - 1$. On définit _la période_ de $x$ comme étant la plus petite des périodes.

Un _bord_ d'un mot non vide $x$ est un facteur de $x$, différent de $x$ et qui est à la fois un préfixe et un suffixe de la chaîne de caractères. Par exemple, $epsilon$, $a$, $a a$, $a a b a a$ sont les bords du mot $a a b a a b a a$. On note $"Bord"(x)$ le plus long bord de $x$. On constate que lorsqu'il est défini, le bord d'un bord d'un mot $x$ est aussi un bord de $x$. On le note $"Bord"^2 (x)$. On définit ainsi récursivement $"Bord"^n (x)$ avec $n$ un entier naturel.

#question[Justifier le fait que tout mot non vide possède au moins une période.]

#correction[
    Soit $x$ non vide. Pour $p = |x|$, la condition porte sur les $i$ tels que $0 <= i <= -1$ : il n'y en a aucun, donc elle est vérifiée. Ainsi $|x|$ est une période de $x$.
]


#question[Déterminer la période du mot $x = a a b a a b a a$ défini sur l'alphabet $A = {a, b}$.]

#correction[
    - $p = 1$ n'est pas une période : $x_1 = a != b = x_2$.
    - $p = 2$ n'est pas une période : $x_0 = a != b = x_2$.
    - $p = 3$ est une période : $x = a a b dot a a b dot a a$, et on vérifie $x_i = x_(i+3)$ pour $0 <= i <= 4$.

    La période de $x$ est donc $3$.
]


#question[
    Soit $x$ une chaîne de caractères non vide et $p$ un entier naturel tel que $0 < p <= |x|$. Montrer que $p$ est une période de $x$ si et seulement s'il existe 3 chaînes de caractères $u, v, w$ telles que $x = u w = w v$ et $|u| = |v| = p$.
]

#correction[
    Notons $n = |x|$.

    ($arrow.r.double$) Supposons que $p$ est une période. Posons $u = x_0 dots x_(p-1)$, $w = x_p dots x_(n-1)$ et $v = x_(n-p) dots x_(n-1)$. On a bien $x = u w$ et $|u| = |v| = p$. De plus, le préfixe de longueur $n - p$ de $x$ est $x_0 dots x_(n-p-1) = x_p dots x_(n-1) = w$ car $x_i = x_(i+p)$ pour $0 <= i <= n - p - 1$. Donc $x = w v$.

    ($arrow.l.double$) Supposons $x = u w = w v$ avec $|u| = |v| = p$. Alors $|w| = n - p$, et $w$ est à la fois le suffixe de longueur $n - p$ de $x$ (car $x = u w$), c'est-à-dire $w_i = x_(i+p)$, et le préfixe de longueur $n - p$ (car $x = w v$), c'est-à-dire $w_i = x_i$. Donc pour $0 <= i <= n - p - 1$, $x_i = w_i = x_(i+p)$ : $p$ est une période.
]


#question[
    Soit $x$ une chaîne de caractères non vide et $n$ le plus grand entier tel que $"Bord"^n (x)$ est bien défini. On a donc $"Bord"^n (x) = epsilon$. Montrer par récurrence sur la longueur des mots que $"Bord"(x), "Bord"^2 (x), dots, "Bord"^n (x)$ est la suite des bords de $x$ dans l'ordre décroissant de leur longueur et que $|x| - |"Bord"(x)|, |x| - |"Bord"^2 (x)|, dots, |x| - |"Bord"^n (x)|$ est la suite des périodes de $x$ dans l'ordre croissant.
]

#correction[
    *Lemme.* Soit $y$ un bord de $x$ et $z$ un mot. Alors $z$ est un bord de $y$ si et seulement si $z$ est un bord de $x$ avec $|z| < |y|$.

    En effet, si $z$ est un préfixe de $y$, qui est un préfixe de $x$, alors $z$ est un préfixe de $x$ ; de même pour les suffixes, et $|z| < |y|$ car $z != y$. Réciproquement, si $z$ est un préfixe de $x$ avec $|z| < |y|$, comme $y$ est aussi un préfixe de $x$, $z$ est un préfixe de $y$ ; de même pour les suffixes, et $z != y$.

    *Bords.* Montrons par récurrence forte sur $|x| >= 1$ que les bords de $x$ sont exactement $"Bord"(x), dots, "Bord"^n (x)$, de longueurs strictement décroissantes.
    - Si $|x| = 1$, le seul bord de $x$ est $epsilon = "Bord"(x)$, et $n = 1$.
    - Sinon, soit $y = "Bord"(x)$. Un bord de $x$ est soit $y$, soit (par maximalité de $y$) de longueur $< |y|$, donc d'après le lemme un bord de $y$. Réciproquement, les bords de $y$ sont des bords de $x$. Donc les bords de $x$ sont $y$ et les bords de $y$.
        - Si $y = epsilon$, alors $n = 1$ et $y$ est le seul bord de $x$.
        - Sinon, $1 <= |y| < |x|$, et par hypothèse de récurrence, les bords de $y$ sont $"Bord"(y), dots, "Bord"^(n-1) (y)$, c'est-à-dire $"Bord"^2 (x), dots, "Bord"^n (x)$, de longueurs strictement décroissantes, toutes $< |y|$.

    *Périodes.* D'après la question précédente, $p in [|1, |x||]$ est une période si et seulement s'il existe $w$ de longueur $|x| - p$ qui est à la fois préfixe et suffixe de $x$, c'est-à-dire (comme $p > 0$, $w != x$) un bord de longueur $|x| - p$. L'application $p |-> |x| - p$ est donc une bijection décroissante des périodes de $x$ vers les longueurs des bords de $x$. Les périodes de $x$ sont donc $|x| - |"Bord"(x)| < |x| - |"Bord"^2 (x)| < dots < |x| - |"Bord"^n (x)|$.
]





= Étude d'une famille d'automates (CCP 2023)

Dans cette partie, l'alphabet $Sigma$ désigne l'ensemble ${0, 1}$, le symbole $epsilon$ désigne le mot vide et on rappelle que $Sigma^star$ désigne l'ensemble des mots sur l'alphabet $Sigma$.

Étant donné un mot $w$, on rappelle que $|w|$ désigne la longueur du mot $w$ et l'indexation des lettres de $w$ commence par $0$. La première lettre de $w$ est donc $w_0$.

La notation $"Card"(E)$ désigne le cardinal d'un ensemble $E$.

Étant donnés un entier $n$ et un entier non nul $m$, la notation $n mod m$ désigne le reste de la division euclidienne de $n$ par $m$.

== Définitions


#def[Automate $A_(k,p)$, fonction indicatrice $L_(k,p)$][
    Soient $p$ et $k$ deux entiers vérifiant $0 <= k <= p - 1$. L'automate $A_(k,p)$ est défini par :
    - $Q = {0, 1, dots, p - 1} times {0, 1}$,
    - $Sigma = {0, 1}$,
    - $forall (c, e) in Q, delta((c, e), 0) = ((c + 1) mod p, e)$,
    - $forall (c, e) in Q, delta((c, e), 1) = display(cases(
            ((c + 1) mod p, 1 - e) & "si" c = k mod p,
            ((c + 1) mod p, e) & "sinon."
        ))$
    - $q_0 = (0, 0)$,
    - $F = {0, 1, dots, p - 1} times {1}$.

    On note $L_(k,p)$ la fonction indicatrice de l'ensemble des mots reconnus par $A_(k,p)$. Soit autrement :
    $
        forall u in Sigma^star, L_(k,p) (u) = cases(
            1 & "si" A_(k,p) "reconnaît" u,
            0 & "sinon."
        )
    $
]

== Exemples et propriétés élémentaires des $A_(k,p)$

#question[
    Soit $w in Sigma^star$. Expliciter sans démonstration l'état $delta^star (q_0, w)$, la lecture du mot étant effectuée dans l'automate $A_(1,3)$. On pourra s'aider d'une représentation graphique de l'automate.
]

#correction[
    #figure(
        raw-render(
            ```dot
            digraph {
              rankdir=LR
              node [shape=circle]
              "0,1" [shape=doublecircle]
              "1,1" [shape=doublecircle]
              "2,1" [shape=doublecircle]
              "" [shape=none]
              "" -> "0,0"
              "0,0" -> "1,0" [label="0, 1"]
              "1,0" -> "2,0" [label="0"]
              "1,0" -> "2,1" [label="1"]
              "2,0" -> "0,0" [label="0, 1"]
              "0,1" -> "1,1" [label="0, 1"]
              "1,1" -> "2,1" [label="0"]
              "1,1" -> "2,0" [label="1"]
              "2,1" -> "0,1" [label="0, 1"]
            }
            ```,
        ),
    )

    La première composante compte les lettres lues modulo $3$, et la seconde change à chaque $1$ lu en position $i equiv 1 [3]$ :
    $ delta^star (q_0, w) = (|w| mod 3, "Card"({i in [|0, |w| - 1|] | i mod 3 = 1 "et" w_i = 1}) mod 2). $
]


Dans les questions suivantes, $p$ et $k$ désignent des entiers tels que $p > 2$ et $k in {0, 1, dots, p - 1}$.

#question[
    Soit $w in Sigma^star$. Expliciter l'état $delta^star (q_0, w)$, la lecture du mot étant effectuée dans l'automate $A_(k,p)$. On ne demande pas de démonstration.
]

#correction[
    $ delta^star (q_0, w) = (|w| mod p, "Card"({m in NN | p m + k <= |w| - 1 "et" w_(p m + k) = 1}) mod 2). $
]


Un corollaire direct du résultat de la question précédente est que l'ensemble des mots reconnus par l'automate $A_(k,p)$ est égal à :
$
    {w in Sigma^star mid(|) "Card"({m in NN | p m + k <= |w| - 1 "et" w_(p m + k) = 1}) "est impair"}.
$
Dans la suite du problème, on admet ce résultat.

#question[
    Soit $w$ un mot reconnu par un automate $A_(k,p)$. Montrer que $w$ est reconnu par au moins un autre automate parmi $A_(0,2)$, $A_(1,2)$, $A_(l,p)$ avec $l != k$.
]

#correction[
    Pour $r >= 1$ et $l in [|0, r - 1|]$, notons $N_(l,r) (w)$ le nombre de $1$ de $w$ en une position $i equiv l [r]$. Ainsi $L_(l,r) (w) = N_(l,r) (w) mod 2$. Notons aussi $N(w)$ le nombre total de $1$ dans $w$. On a :
    $ N(w) = sum_(l = 0)^(p-1) N_(l,p) (w) = N_(0,2) (w) + N_(1,2) (w). $

    Par hypothèse, $N_(k,p) (w)$ est impair. S'il existe $l != k$ tel que $N_(l,p) (w)$ est impair, $w$ est reconnu par $A_(l,p)$. Sinon, $N(w)$ est une somme d'un nombre impair et de nombres pairs, donc est impair. Alors $N_(0,2) (w)$ ou $N_(1,2) (w)$ est impair, et $w$ est reconnu par $A_(0,2)$ ou $A_(1,2)$.

    Comme $p > 2$, ces automates sont bien différents de $A_(k,p)$.
]


#def[Ou exclusif étendu aux mots binaires][
    On rappelle que le _Ou exclusif_, qu'on note $xor$, est une opération définie sur ${0, 1}$ par :
    $ 0 xor 0 = 1 xor 1 = 0 "et" 0 xor 1 = 1 xor 0 = 1. $
    Soient $n in NN$, $u$ et $v$ deux éléments de ${0, 1}^n$. On définit le _Ou exclusif_ de $u$ et $v$, noté $u xor v$, le mot de longueur $n$ défini par :
    $ forall i in {0, 1, dots, n - 1}, (u xor v)_i = u_i xor v_i. $
]

#question[
    Soient $u$ et $v$ deux mots de $Sigma^star$ de même longueur. Montrer que :
    $ L_(k,p) (u xor v) = L_(k,p) (u) xor L_(k,p) (v). $
]

#correction[
    Notons $n = |u| = |v|$ et $I = {i in [|0, n - 1|] | i equiv k [p]}$. Sur ${0, 1}$, $a xor b = (a + b) mod 2$. Donc :
    $ L_(k,p) (u xor v) = (sum_(i in I) (u xor v)_i) mod 2 = (sum_(i in I) (u_i + v_i)) mod 2 = (sum_(i in I) u_i + sum_(i in I) v_i) mod 2 $
    $ = L_(k,p) (u) xor L_(k,p) (v). $
]


#question[
    Soit $w$ un mot binaire vérifiant :
    $ L_(0,2) (w) = L_(1,2) (w) = 0 "et" forall k in {1, 2, dots, p - 1}, L_(k,p) (w) = 0. $
    + Montrer que $L_(0,p) (w) = 0$.
    + En déduire que pour tout mot $w' in 0^star dot w$, on a :
        $ L_(0,2) (w') = L_(1,2) (w') = 0 "et" forall k in {1, 2, dots, p - 1}, L_(k,p) (w') = 0. $
]

#correction[
    + Avec les notations précédentes, $N(w) = N_(0,2) (w) + N_(1,2) (w)$ est pair. Or $N(w) = N_(0,p) (w) + sum_(k=1)^(p-1) N_(k,p) (w)$, et les $N_(k,p) (w)$ pour $k >= 1$ sont pairs. Donc $N_(0,p) (w)$ est pair, soit $L_(0,p) (w) = 0$.
    + Soit $w' = 0^j w$. Les $1$ de $w'$ sont exactement en les positions $i + j$ pour $i$ position d'un $1$ de $w$. Donc, pour $r in {2, p}$ et $l in [|0, r-1|]$, $N_(l,r) (w') = N_(l',r) (w)$ où $l' = (l - j) mod r$. Or, d'après la question précédente et l'hypothèse, tous les $N_(l',p) (w)$ et $N_(l',2) (w)$ sont pairs. Donc tous les $N_(l,r) (w')$ le sont, ce qui donne le résultat.
]


#question[
    Montrer que pour tout $w in Sigma^star$ et $w' in w dot 0^star$, on a $L_(k,p) (w) = L_(k,p) (w')$.
]

#correction[
    Soit $w' = w 0^j$. Les positions $i < |w|$ de $w'$ portent les mêmes lettres que dans $w$, et les positions $i >= |w|$ portent des $0$. Donc $w$ et $w'$ ont les mêmes $1$ aux mêmes positions, et $N_(k,p) (w') = N_(k,p) (w)$, d'où $L_(k,p) (w) = L_(k,p) (w')$.
]


#rq[
    _Ces égalités permettent la construction d'une relation d'équivalence sur les mots qui est utilisée pour montrer que deux mots de longueur $N$ peuvent être séparés par un automate de la forme $A_(k,p)$ ayant $O(sqrt(N) ln(N))$ états._
]


