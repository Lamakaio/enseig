#set page(paper: "a4", numbering: "1")
#set document(title: "Cours glouton")
#set heading(numbering: "1.a)")
#import "../utils.typtp": *
#import "@preview/lovelace:0.3.0": *

#import "@preview/gviz:0.1.0": *

#show raw.where(lang: "dot-render"): it => render-image(it.text)

#set math.equation(numbering: "(1)")

#align(center, text(17pt)[
    *Contexte et documents en vue de l'inspection du 09/04/2026*
])


