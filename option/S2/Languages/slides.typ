#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: focus, new-section
#import "../../../utils.typtp": *

#show: metropolis.setup

#slide[
  #set page(header: none, footer: none, margin: 3em)


  #text(size: 1.3em)[
    *Languages et expressions régulières*
  ]

  #metropolis.divider

  #set text(size: .8em, weight: "light")
  Ambre Le Berre

  2025/2026

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
]


#slide[
  = Vocabulaires sur les mots

  Soit $m = m_1 m_2 dots m_n in Sigma^*$ un mot.
  - un _préfixe_ de $m$ est un mot $m_1 dots m_i$ avec $0 <= i <= n$.
  #show: later

  - un _suffixe_ de $m$ est un mot $m_(i+1) dots m_n$ avec $0 <= i <= n$.
  #show: later

  - un _facteur_ de $m$ est un mot $m_i dots m_j$ avec $0 <= i, j <= n$.
  #show: later

  - un _sous-mot_ de $m$ est un mot $m_(i_1) m_(i_2) ... m_(i_k)$ avec $i_1 < i_2 < dots < i_k in [|1, n|]$
  #show: later

  - $epsilon$ est préfixe, suffixe, facteur et sous-mot de n'importe quel mot.
]


#slide[
  = Languages
  - Un _language_ est un ensemble $L subset.eq Sigma^*$ de mots sur un alphabet
  #show: later

  - On note $emptyset$ le language vide (à ne pas confondre avec ${epsilon}$ )
]

#new-section[Expression régulière, languages réguliers]

#slide[
  = Opérations régulières sur les languages

  On défini plusieurs _opérations_ dites _régulières_ sur les languages. Soit $L_1, L_2$ deux languages sur un alphabet $Sigma$.

  - $L_1 union L_2 = {u | u in L_1 "ou" u in L_2}$ est l'_union_ des languages.
  #show: later

  - $L_1 | L_2 = {u v | u in L_1, v in L_2}$ est la _concaténation_ des languages.
  #show: later

  - $L_1^* = {u_1 u_2 dots u_n | n in NN, u_1 dots u_n in L_1}$ l'_étoile de Kleene_ d'un language (ou juste _étoile_).
  #show: later

  - L'intersection et la soustraction ensembliste ne sont pas des opérations régulières !
]
