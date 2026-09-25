#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: focus, new-section
#import "../../../utils.typtp": *

#show: metropolis.setup
#show raw: set text(ligatures: false, features: (calt: 0))

#slide[
  #set page(header: none, footer: none, margin: 3em)


  #text(size: 1.3em)[
    *Langages et expressions régulières*
  ]

  #metropolis.divider

  #set text(size: .8em, weight: "light")
  Ambre Le Berre

  2026/2027

  MP option info
]

#slide[
  = Agenda

  #metropolis.outline
]

#new-section[Vocabulaire]

#slide[
  = Alphabet et mots

  - Un _alphabet_ est un ensemble $Sigma$ de _lettres_. Par exemple, $Sigma = {a, b}$ est un alphabet.
  #show: later
  - Un _mot_ sur un alphabet est une suite finie de lettres de cet alphabet. Par exemple, $a b b a$ est un mot sur $Sigma$.
  #show: later
  - On note $epsilon$ le mot vide, qui ne contient aucune lettre.

  #show: later
  - Pour deux mots $u$ et $v$, on note $u v$ leur concaténation.
  - On note $|u| in NN$ la longueur d'un mot.
]


#slide[
  = Vocabulaire sur les mots

  Soit $m = m_1 m_2 dots m_n in Sigma^*$ un mot.
  - un _préfixe_ de $m$ est un mot $m_1 dots m_i$ avec $0 <= i <= n$.
  #show: later

  - un _suffixe_ de $m$ est un mot $m_(i+1) dots m_n$ avec $0 <= i <= n$.
  #show: later

  - un _facteur_ de $m$ est un mot $m_i dots m_j$ avec $1 <= i <= j <= n$, ou le mot vide.
  #show: later

  - un _sous-mot_ de $m$ est un mot $m_(i_1) m_(i_2) ... m_(i_k)$ avec $i_1 < i_2 < dots < i_k in [|1, n|]$
  #show: later

  - $epsilon$ est préfixe, suffixe, facteur et sous-mot de n'importe quel mot.
]


#slide[
  = Langages
  - Un _langage_ est un ensemble $L subset.eq Sigma^*$ de mots sur un alphabet
  #show: later

  - On note $emptyset$ le langage vide (à ne pas confondre avec ${epsilon}$ )
]

#new-section[Expression régulière, langages réguliers]

#slide[
  = Opérations régulières sur les langages

  On définit plusieurs _opérations_ dites _régulières_ sur les langages. Soit $L_1, L_2$ deux langages sur un alphabet $Sigma$.

  - $L_1 union L_2 = {u | u in L_1 "ou" u in L_2}$ est l'_union_ des langages.
  #show: later

  - $L_1 L_2 = {u v | u in L_1, v in L_2}$ est la _concaténation_ des langages.
  #show: later

  - $L_1^* = {u_1 u_2 dots u_n | n in NN, u_1 dots u_n in L_1}$ l'_étoile de Kleene_ d'un langage (ou juste _étoile_).
  #show: later

  - L'intersection et la soustraction ensembliste ne sont pas des opérations régulières !
]

#slide[
  = Expressions régulières


  On utilise les _expressions régulières_ pour définir une partie des langages.

  *Définition inductive*
  - Cas de base :
    - $emptyset$ est une expression régulière représentant le langage vide $emptyset$
    - $epsilon$ est une expression régulière représentant le langage ${epsilon}$
    - si $a in Sigma$, $a$ est une expression régulière représentant le langage ${a}$.
  #show: later

  - Cas inductifs : si $e_1, e_2$ sont des expressions régulières qui représentent des langages $L_1$ et $L_2$, alors
    - $e_1^*$ représente le langage $L_1^*$
    - $e_1 | e_2$ représente le langage $L_1 union L_2$
    - $e_1 e_2$ représente le langage $L_1 L_2$
]

#slide[
  = Expressions régulières : raccourcis

  On utilise souvent les syntaxes suivantes par facilité :
  - $e^+$ pour désigner $e e^*$
  - $e^n$ pour désigner $e e e dots e$ (n fois)
  - $e?$ pour désigner $e | epsilon$
]



#slide[
  = Quelques exemples

  Décrivez, en quelques mots, les langages décrits par les expressions régulières suivantes sur l'alphabet $Sigma = {a, b}$:

  - $(a|b)^*$

  - $(a|b)^+$

  - $(b^* a b^*)^5$

  - $(a b | b)^*$
]

#slide[
  = Dans l'autre sens

  Donnez des expressions régulières pour les langages suivants :

  - les mots qui contiennent "abba"

  - les mots qui contiennent d'abord que des b (au moins 1), puis que des a (au moins 1)

  - les mots dont la longueur est multiple de 3

  - les mots dont "abba" est un sous-mot
]

#slide[
  = Langage régulier / rationnel

  Un langage _régulier_ ou _rationnel_ est un langage qui peut être représenté par une expression régulière.

  Q : Est-ce que tous les langages sont réguliers ?
  #show: later
  Non !
]

#slide[
  = Un exemple de langage non régulier

  Le langage $L_0 = {a^n b^n | n in NN}$ n'est pas régulier.

  #show: later

  *Intuition* : les expressions régulières ont toujours une "mémoire" finie. Entre autres, elles ne peuvent pas "compter" $n$ "a" pour attendre ensuite le même nombre de "b".
]

#slide[
  = _Lemme de l'étoile_ (première version)

  Soit $L$ un langage régulier. Alors il existe $N$, tel que pour tout mot $u in L$ avec $|u| >= N$, il existe une décomposition $u = x y z$, telle que :

  - $ |x y| <= N $

  - $ y != epsilon $

  - $ x y^* z subset.eq L $
]

#slide[
  = Montrer qu'un langage n'est pas rationnel

  Montrons que $L_0$ n'est pas rationnel par l'absurde : si $L_0$ est rationnel, alors, soit $N in NN$ suffisamment grand pour appliquer le lemme de l'étoile.

  On prend le mot $u = a^(N+1) b^(N+1) in L_0$. Supposons qu'il existe $x y z = u$ tel que $ |x y| <= N, y != epsilon "et" x y^* z subset.eq L_0 $

  #show: later

  Alors, comme $|x y| <= N$, $x$ et $y$ sont de la forme $a^p$ et $a^k$, et $z$ est de la forme $a^l b^(p + k + l)$.

  Donc, $a^p (a^k)^* a^l b^(p + k + l) subset.eq L_0$. Entre autres, $a^(p + 2k + l) b^(p + k + l) in L_0$. Absurde !
]

#slide[
  = Exercice

  Montrer que le langage $L_p = {u_1 u_2 dots u_k | u_1 u_2 dots u_k = u_k dots u_2 u_1}$ le langage des palindromes, n'est pas rationnel.

  #show: later

  *Idée* : considérer le mot $a^(N+1) b a^(N+1)$
]


#slide[
  = Expressions régulières en pratique

  La plupart des éditeurs de texte vous permettent de rechercher des expressions régulières :

  - remplacer `(\n\s*= .*)\n` par `$1.\n`
]


#slide[
  = Expressions régulières en pratique

  Syntaxe :
  - `.` $->$ n'importe quel caractère (sauf `\n`)
  - `\s` $->$ n'importe quel espace / tab / etc
  - `\w` $->$ n'importe quelle lettre, chiffre ou `_`
  - `[abfg ]` $->$ un des caractères parmi "a" "b" "f" "g" et " ".
  - `[^ab ]` $->$ tout sauf un des caractères parmi "a" "b" " ".
  - `*`, `+`, `?`, `|` $->$ comme ce qu'on a vu
]

#slide[
  = Expressions régulières en pratique

  Remplacement :
  - `$0` $->$ tout
  - `$1` $->$ la première partie entre parenthèses
  - `$2` $->$ la deuxième, etc.
]
