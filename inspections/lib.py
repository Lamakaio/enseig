import graphviz
import traceback
import sys
import __main__

def afficher_graphe(graphe):
    dot = graphviz.Graph(strict=True)
    try:
        for s, l in graphe.items():
            try:
                if type(l[0]) == type(""):
                    for v in l:
                        try:
                            dot.edge(s, v)
                        except Exception:
                            print("Erreur : Mauvais type pour les sommets ou les voisins", file=sys.stderr)
                            return
                else:
                    for (v, p) in l:
                        try:
                            dot.edge(s, v, str(p))
                        except Exception:
                            print("Erreur : Mauvais type pour les sommets ou les voisins", file=sys.stderr)
                            return
            except Exception:
                print("Erreur : Mauvais type pour le graphe, chaque sommet doit être associé à une liste de voisins", file=sys.stderr)
                return
        return dot
    except Exception:
        print("Erreur : Mauvais type pour le graphe, ça doit être un dictionnaire !", file=sys.stderr)


class ListeSecrete:
    def __init__(self, voisins):
        self.__voisins = voisins
    
    def __getitem__(self, key):
        return self.__voisins[key] 
    
    def __iter__(self):
        return self.__voisins.__iter__()

    def __len__(self):
        return self.__voisins.__len__()

class GrapheSecret:
    def __init__(self, adj):
        self.__adj = adj

    def __getitem__(self, key):
        return self.__adj[key]



graphe_secret = GrapheSecret(
    {"": ListeSecrete(["B", "I", "P ", "BO", "OP "]), 
    "B": ListeSecrete(["", "R"]), 
    "R": ListeSecrete(["B", "A"]),
    "A": ListeSecrete(["R", "V"]),
    "V": ListeSecrete(["A", "O", "CIRAPTOR"]),
    "I": ListeSecrete(["", "OB"]),
    "P ": ListeSecrete(["", "OT "]),
    "OT ": ListeSecrete(["P "]),
    "BO": ListeSecrete([""]),
    "OP ": ListeSecrete([""]),
    "OB": ListeSecrete(["VE", "C "]),
    "VE": ListeSecrete(["OB", "EL"]),
    "EL": ListeSecrete(["VE"]),
    "C ": ListeSecrete(["OB"]),
    "O": ListeSecrete(["V"]),
    "CIRAPTOR": ListeSecrete(["V"])
    }
)


