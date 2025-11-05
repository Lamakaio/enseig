#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import "@preview/lovelace:0.3.0": *
#import "../../../utils.typtp": *
#import metropolis: focus, new-section

#show: metropolis.setup

#slide[
    #set page(header: none, footer: none, margin: 3em)


    #text(size: 1.3em)[
        *Algorithmes de recherche, dichotomie*
    ]

    #metropolis.divider

    #set text(size: .8em, weight: "light")
    Ambre Le Berre

    MPSI

    2025/2026
]

#slide[
    = Plan du cours

    #metropolis.outline
]

#new-section[Maximum, minimum]

#slide[
    = Recherche simple de maximum

    C'est _très courant_ de chercher le maximum / minimum d'une liste.
    #show: later
    ```python
    def minimum(L):
        """renvoie le minimum de la liste L et son indice"""
        val_min = L[0]
        i_min = 0
        #on commence à 1 car on a déjà vu l'élément 0
        for i in range(1, len(L)):
            if L[i] < val_min:
                val_min = L[i]
                i_min = i

        return (val_min, i_min)
    ```

]

#slide[
    = Autres recherches

    ```python
    def minimum(L):
        """renvoie le minimum de la liste L et son indice"""
        val_min = L[0]
        i_min = 0
        #on commence à 1 car on a déjà vu l'élément 0
        for i in range(1, len(L)):
            if L[i] < val_min:
                val_min = L[i]
                i_min = i

        return (val_min, i_min)
    ```

    Modifiez le code précédent pour trouver le deuxième maximum.

]

#new-section[Recherche d'un élément dans une liste]

#slide[
    = Recherche "naïve"

    ```python
    def recherche(L, x):
        """renvoie True si x est dans L, False sinon."""
        for y in L:
            if x == y:
                return True
        return False
    ```
]

#slide[
    = Recherche dans une liste triée : la dichotomie

    On a vu comment on peut trier une liste. Comment utiliser ce tri pour chercher un élément plus vite ?

    #show: later

    Idée : on regarde au _milieu_ de la liste.
    - Si milieu < x, alors x est dans la deuxième moitié
    - Sinon, dans la première moitié

]

#slide[
    = Recherche dans une liste triée : la dichotomie
    Recherche de "2" dans la liste [-1, 0, 1, 2, 3, 4, 5, 10, 123, 124]
    #let values = (-1, 0, 1, 2, 3, 4, 5, 10, 123, 124)
    #let ac = {
        let x = 2
        let i = 0
        let j = values.len()
        (
            (
                values.slice(0, i).map(x => table.cell()[#x])
                    + values.slice(i, j).map(x => table.cell(fill: green.lighten(60%))[#x])
                    + values.slice(j, values.len()).map(x => table.cell()[#x])
            )
                + (
                    while j - i > 1 {
                        let milieu = calc.floor((i + j) / 2)
                        if values.at(milieu) < x {
                            i = milieu + 1
                        } else if values.at(milieu) > x {
                            j = milieu
                        } else {
                            i = milieu
                            j = milieu + 1
                        }
                        (
                            values.slice(0, i).map(x => table.cell()[#x])
                                + values.slice(i, j).map(x => table.cell(fill: green.lighten(60%))[#x])
                                + values.slice(j, values.len()).map(x => table.cell()[#x])
                        )
                    }
                )
        )
    }

    #table(
        columns: (1fr,) * values.len(),
        ..ac
    )
]

#slide[
    = Recherche dans une liste triée : la dichotomie

    ```py
    def recherche_dicho(L, x):
        """Si L est une liste triée dans l'ordre croissant, renvoie l'indice de x dans L, ou bien None si x n'est pas dans L."""
        i = 0 #borne inf inclue
        j = len(L) #borne sup exclue

        while (j - i) > 1:
            milieu = (i + j) // 2
            if L[milieu] > x:
                i = milieu + 1
            elif L[milieu] < x:
                j = milieu
            else: #cas ou L[milieu] == x
                return milieu
        return None
    ```
]

#slide[
    = Complexité

    Combien de tour de boucle au maximum pour une liste de taille 8 ? De taille 16 ? Et pour $2^n$ en général ?

    #show: later

    En fait, la complexité est _logarithmique_, soit  en $O(log(n))$.
]

#new-section[D'autres applications de la dichotomie]

#slide[
    = Recherche du 0 d'une fonction

    Supposons qu'on ai une fonction $f$ quelconque et qu'on cherche où elle s'annule sur un intervalle $[a, b]$, tel que $f(a) < 0$ et $f(b) > 0$.

    On peut appliquer le même principe !
]

#slide[
    = Recherche du 0 d'une fonction

    ```py
    def recherche_zero(f, a, b, eps):
        """Si f(a) < 0 et f(b) > 0, renvoie un zero de f sur [a, b] à eps près."""
        while b - a > eps:
            milieu = a + b / 2
            if f(milieu) < 0:
                a = milieu
            else:
                b = milieu
        return (a + b) / 2
    ```
]
