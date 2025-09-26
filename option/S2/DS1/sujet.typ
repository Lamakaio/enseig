#set page(paper: "a4", numbering: "1")
#set document(title: "Devoir Surveillé n°1")
#set heading(numbering: "I.1)")
#import "../../../utils.typtp": *


#align(center, text(17pt)[
  *Option Informatique MP, DS n°1*

  *Algorithmique du texte*
])

*Note de début* : ce DS porte sur un sujet de biologie. Les connaissances de l'auteure sur le sujet étant un peu approximative, veuillez ne pas utilisez ce DS comme source sur ce sujet.

Quand vous écrivez du code, il est attendu que celui-ci soit clair, commenté lorsque c'est nécéssaire, et que les types d'entrée et de sortie des fonctions soient précisés.

On demande de ne pas utiliser les fonctions du module `String`.

Les questions suivies d'une étoile sont difficiles.

= Généralités

L'acide acide désoxyribonucléique, plus connu sous le nom d'ADN, est une molécule présente dans presque tout le vivant sur Terre. Elle contient toute l'information génétique, ou génome, d'un individu.

Les molécules d'ADN des cellules vivantes sont formées de deux brins antiparallèles enroulés l'un autour de l'autre pour former une double hélice.

Chaque brin d'ADN est constitué d'une série de nucléotides : adénine (A), cytosine (C), guanine (G) ou thymine (T).

Lorsqu'on travaille sur le génome d'un individu ou d'une espèce, on modélise en général le génome par une (très longue) chaine de caractère, composée des 4 lettres suivantes : A, C, G, T.

Chez l'humain, l'ADN est composé d'environ 3 milliards de nucléotides. Il est donc nécéssaire d'utiliser des algorithmes efficaces pour traiter ces chaines de caractères.

= Implémentation en OCaml

En language OCaml, on modélise un génome par une liste de caractères :
```OCaml
type genome = char list
```

1. _Définissez une variable OCaml pour modéliser le genome `AACGTTGCC`._

Dans les questions suivantes, on demande de définir des fonctions, souvent récursives, en précisant leur type. Vous devez annoter les arguments de vos fonctions avec leur types.

2. _Définissez une fonction `compter` de type `genome -> char -> int` qui prend en argument un génome et l'identifiant d'un nucléotide (`A`, `C`, `G`, ou `T`), et qui renvoie le nombre d'occurences de ce nucléotides dans le génome._


Dans une molécule d'ADN, les deux brins encodent en fait la même information : chaque nucléotide est situé en face de son complémentaire. Le complémentaire de A est T, et celui de C est G.

3. _Donnez le complémentaire du brin `AACGTTGCC`._

4. _Écrivez une fonction `complementaire` de type `genome -> genome` qui prends un génome et renvoie son complémentaire._

= Distance entre deux chaines

En génétique, on peut s'intéresser au degrés de différence entre les génomes, pour savoir à quel points deux individus, ou deux espèces, sont similaires.

== Distance naive

On défini une première distance entre les chaines de caractère de même longueur : la *distance naive*.

Pour deux chaines `A = [a_0; a_1; ...; a_n]` et `B = [b_0; b_1; ...; b_n]`, la distance naive entre A et B est :
$ d = sum_(i = 1)^(n) 1_(a_i = b_i) $
où $1_(a_i = b_i)$ vaut 1 si $a_i = b_i$, et 0 sinon.


5. _Si la distance naive vaut 0, que peut-on en déduire ?_

6. _Recopiez et complétez la fonction suivante, pour qu'elle calcule la distance naive entre deux chaines. Votre fonction doit renvoyer une erreur si les deux chaines n'ont pas la même longueur._

```OCaml
(*Calcule la distance naive entre deux chaines*)
let rec (g1: genome) (g2: genome): int = match (g1, g2) with
  |(x1::q1, x2::q2) -> (*à compléter*)

  |([], []) ->         (*à compléter*)

  |([], _) | (_, [])-> (*à compléter*)

```

En pratique, la distance naïve n'est pas adaptée pour comparer des génomes. En effet, lors des mutations, il est courant que des parties de génomes soient supprimées ou ajoutées.

7. _Quelle est la distance naive entre `AACGTA` et `ACGTAC` ?_

== Distance d'édition

On défini la *distance de Levenstein*, ou *distance d'édition*, pour palier à ce problème.

On défini les *opérations d'éditions* suivantes :
- Ajout : on ajoute un caractère.
- Suppression : on supprime un caractère.
- Modification : on change un caratcère en un autre.

La *distance d'édition* entre les deux chaines est le nombre minimal d'opérations pour passer de l'une à l'autre.

#figure(caption: [Distance d'édition], image("levenstein.png", width: 50%))

8. _Quelle est la distance d'édition entre les deux chaines de la figure 1 ?_

9. _Quelle est la distance d'édition entre la chaine vide `[]` et une chaine quelconque g ? (Pour accéder à la longueur d'une liste `g`, on utilise `List.length g`)._

On suppose maintenant que les deux chaines sont de longueur non nulle, et on les note `g1 = x1::q1` et `g2 = x2::q2`.

10. _En supposant `x1 = x2`, donnez la distance d'édition entre `g1` et `g2` en fonction de celle entre `q1` et `q2`._

11\*. _En supposant `x1 != x2`, donnez la distance d'édition entre `g1` et `g2` avec une formule récursive. Vous considererez la première opération effectuée (modification, ajout, ou suppression)._

12\*. _En déduire une fonction `distance_edition` de type `genome -> genome -> int` qui calcule la distance d'édition entre deux genomes. Votre fonction peut ne pas être optimale, tant qu'elle renvoie la bonne solution._

= Recherche d'un mot dans une chaine
== Méthode naive
On aimerait savoir si une certaine séquence d'ADN (un gène, par exemple) est présente dans le génome.

On définit le type OCaml suivant pour les gènes :
```OCaml
type gene = char list
```

À noter que ce type est identique au type `genome`. La distinction sert donc uniquement à la clarté du code.

13. _Écrivez une fonction `est_prefixe` de type `genome -> gene -> bool` qui renvoie `vrai` si le gène est présent au début du génome._


14. _En utilisant votre fonction `est_préfixe`, écrivez une fonction `est_facteur` de type `genome -> gene -> bool` qui renvoie `vrai` si le gène est présent dans le génome._

Dans les question précédentes, l'algorithme consiste à tester toutes les positions possibles du facteur dans le mot. Mais on peut faire mieux !

== Algorithme de Rabin-Karp (simplifié)

Considérons l'exemple suivant : on recherche le gène `ACCT` dans une chaine.

```
? ? ? G ? ? ? ? ? ? ? ...
      |
A C C T - - - - - - -
      ^
```

L'astuce est de commencer la comparaison par la fin du gène. On commence donc ici par comparer la lettre `T` et la lettre `G`.

15. _Sachant qu'on a vu un `G` à la 4ème position du génome, quelle est la première position qui pourrait acceuillir le gène ?_

L'idée est donc de "sauter" des comparaisons lorsqu'on est sûr que le gène ne pourra pas être présent à un endroit.

On va pré-calculer, pour chaque lettre du génome (parmis `A`, `C`, `G`, `T`), et pour chaque indice du gène (un entier entre 0 et `List.length gene - 1`), l'indice de décallage minimum entre deux tests de position.

On utilise une table de hashage, associant un couple `char * int` à un décallage. On dispose des fonctions suivantes :

- `Hashtbl.create n` pour créer une table avec `n` emplacements de départ.
- `Hashtbl.add clé valeur` pour ajouter une correspondance clé $<->$ valeur à la table.
- `Hashtbl.find clé` renvoie la valeur associée à une clé, ou une erreur si elle est absente.

16\*\*. _Écrivez une fonction de type `gene -> ((char * int) * int) Hashtbl.t` permettant de calculer cette table._

17\*. _Écrivez une fonction de type `((char * int) * int) Hashtbl.t -> genome -> gene -> bool` qui renvoie `vrai` si le gène est présent dans le génome, en utilisant l'idée developpée._
