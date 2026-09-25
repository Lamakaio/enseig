#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
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

#question[Donnez un automate déterministe correspondant aux langages suivants : ]
a) Le langage des mots contenant le facteur `aba`.

b) Le langage des mots avec un nombre pair de `a` et un nombre multiple de 3 de `b`.



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


#question[
    Décrire $sqrt(L)$ lorsque $Sigma = {a, b}$ et $L$ est décrit par l'expression rationnelle $b^star a^star b^star$
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


== Propriétés de la racine carrée d'un langage

Ici, on fixe $L$ un langage rationnel sur un alphabet $Sigma$ et $A = (Q, Sigma, q_0, F, delta)$ un automate fini reconnaissant celui-ci.

#question[
    Soit $u in Sigma^star$. Montrez que $u in sqrt(L)$ si et seulement s'il existe $q in Q$ tel que $u in L_(q_0, {q})$ et $u in L_(q, F)$.
]

#question[
    En déduire que $sqrt(L)$ est un langage rationnel.
]

#question[
    Montrer qu'on a $sqrt(L)^2 subset L$.
]



= Automates et reconnaissance de motifs (CCP 2024)


Un alphabet $A$ est un ensemble fini non vide d'éléments appelés lettres. Un mot défini sur $A$ est une suite finie d'éléments de $A$. Le mot vide sera noté $epsilon$. L'ensemble des mots sur l'alphabet $A$ est noté $A^star$. La longueur d'un mot $x$, notée $|x|$, est le nombre de lettres de ce mot. Pour $i$ allant de $0$ à $|x| - 1$, $x_i$ désignera la lettre en position $i$. Ainsi, $a a b$ est un mot de longueur 3, sur tout alphabet contenant les lettres $a$ et $b$.

Un mot $x$ est un _facteur_ d'un mot $y$ s'il existe 2 mots $u$ et $v$ tels que $y = u x v$. Dans ce cas, on dit qu'il y a une _occurrence_ de $x$ dans $y$. Quand $u = epsilon$, $x$ est un _préfixe_ de $y$ et quand $v = epsilon$, $x$ est un _suffixe_ de $y$.

Soit $x$ un mot non vide. Un entier $0 < p <= |x|$ est une _période_ de $x$ si $x_i = x_(i+p)$ pour $0 <= i <= |x| - p - 1$. On définit _la période_ de $x$ comme étant la plus petite des périodes.

Un _bord_ d'un mot non vide $x$ est un facteur de $x$, différent de $x$ et qui est à la fois un préfixe et un suffixe de la chaîne de caractères. Par exemple, $epsilon$, $a$, $a a$, $a a b a a$ sont les bords du mot $a a b a a b a a$. On note $"Bord"(x)$ le plus long bord de $x$. On constate que lorsqu'il est défini, le bord d'un bord d'un mot $x$ est aussi un bord de $x$. On le note $"Bord"^2 (x)$. On définit ainsi récursivement $"Bord"^n (x)$ avec $n$ un entier naturel.

#question[Justifier le fait que tout mot non vide possède au moins une période.]

#question[Déterminer la période du mot $x = a a b a a b a a$ défini sur l'alphabet $A = {a, b}$.]

#question[
    Soit $x$ une chaîne de caractères non vide et $p$ un entier naturel tel que $0 < p <= |x|$. Montrer que $p$ est une période de $x$ si et seulement s'il existe 3 chaînes de caractères $u, v, w$ telles que $x = u w = w v$ et $|u| = |v| = p$.
]

#question[
    Soit $x$ une chaîne de caractères non vide et $n$ le plus grand entier tel que $"Bord"^n (x)$ est bien défini. On a donc $"Bord"^n (x) = epsilon$. Montrer par récurrence sur la longueur des mots que $"Bord"(x), "Bord"^2 (x), dots, "Bord"^n (x)$ est la suite des bords de $x$ dans l'ordre décroissant de leur longueur et que $|x| - |"Bord"(x)|, |x| - |"Bord"^2 (x)|, dots, |x| - |"Bord"^n (x)|$ est la suite des périodes de $x$ dans l'ordre croissant.
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

Dans les questions suivantes, $p$ et $k$ désignent des entiers tels que $p > 2$ et $k in {0, 1, dots, p - 1}$.

#question[
    Soit $w in Sigma^star$. Expliciter l'état $delta^star (q_0, w)$, la lecture du mot étant effectuée dans l'automate $A_(k,p)$. On ne demande pas de démonstration.
]

Un corollaire direct du résultat de la question précédente est que l'ensemble des mots reconnus par l'automate $A_(k,p)$ est égal à :
$
    {w in Sigma^star mid(|) "Card"({m in NN | p m + k <= |w| - 1 "et" w_(p m + k) = 1}) "est impair"}.
$
Dans la suite du problème, on admet ce résultat.

#question[
    Soit $w$ un mot reconnu par un automate $A_(k,p)$. Montrer que $w$ est reconnu par au moins un autre automate parmi $A_(0,2)$, $A_(1,2)$, $A_(l,p)$ avec $l != k$.
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

#question[
    Soit $w$ un mot binaire vérifiant :
    $ L_(0,2) (w) = L_(1,2) (w) = 0 "et" forall k in {1, 2, dots, p - 1}, L_(k,p) (w) = 0. $
    + Montrer que $L_(0,p) (w) = 0$.
    + En déduire que pour tout mot $w' in 0^star dot w$, on a :
        $ L_(0,2) (w') = L_(1,2) (w') = 0 "et" forall k in {1, 2, dots, p - 1}, L_(k,p) (w') = 0. $
]

#question[
    Montrer que pour tout $w in Sigma^star$ et $w' in w dot 0^star$, on a $L_(k,p) (w) = L_(k,p) (w')$.
]

#rq[
    _Ces égalités permettent la construction d'une relation d'équivalence sur les mots qui est utilisée pour montrer que deux mots de longueur $N$ peuvent être séparés par un automate de la forme $A_(k,p)$ ayant $O(sqrt(N) ln(N))$ états._
]


