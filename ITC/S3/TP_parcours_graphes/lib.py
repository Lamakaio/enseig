import graphviz
import traceback
import sys
import __main__

def afficher_graphe(graphe):
    dot = graphviz.Graph(strict=True)
    try:
        for s, l in graphe.items():
            try:
                for (v, p) in l:
                    try:
                        dot.edge(s, v, str(p))
                    except Exception:
                        print("Erreur : Mauvais type pour les sommets ou les voisins", file=sys.stderr)
                        return
            except Exception:
                print("Erreur : Mauvais type pour le graphe, chaque sommet doit être associé à une liste de paires (voisin, longueur)", file=sys.stderr)
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


import p5
import time

file = [None for i in range(7)]
debut = 0
fin = 0
elements = list(range(50))

op = ["+", "+", "+", "+", "-", "-", "+", "+", "+", "-", "+", "-", "+", "-", "+", "-", "-", "-" "+", "-", "-", "+", "+", "+", "+", "-", "-", "-", "-"]
id_op = 0
id_el = 0

__last_time = 0
__speed = 0.5
def setup():
    p5.createCanvas(300, 300)
    p5.background(255)
    
def draw():
    p5.background(255)
    global __last_time, __speed, debut, fin, id_op, id_el
    for i, el in enumerate(file): 
        if el is None:
            p5.noFill()
            p5.rect(10 + 40 * i, 50, 30, 30)
        else: 
            p5.fill(200, 0, 0)
            p5.rect(10 + 40 * i, 50, 30, 30)
            p5.fill(0, 0, 0)
            p5.text(str(el), 20 + 40 * i, 70)
            
    
    p5.fill(0, 0, 200)
    p5.triangle(10 + 40 * fin + 15, 65 + 15, 10 + 40 * fin + 5, 65 + 50, 10 + 40 * fin + 25, 65 + 50)
    p5.text("fin", 17 + 40 * fin, 128)
    
    p5.fill(0, 200, 0)
    p5.triangle(10 + 40 * debut + 15, 65 - 15, 10 + 40 * debut + 5, 65 - 50, 10 + 40 * debut + 25, 65 - 50)
    p5.text("début", 10 + 40 * debut, 10)
    
    if time.time() > __last_time + __speed:
        __last_time = time.time()
        if op[id_op] == "+":
            file[debut] = elements[id_el]
            debut = (debut + 1) % 7
            id_el = (id_el + 1) % 50
        else:
            file[fin] = None
            fin = (fin + 1) % 7
        id_op = (id_op + 1) % 28

def debut_animation():
    p5.run()

def arret_animation():
    p5.stop()



# contenu du fichier _validation.py
from capytale.autoeval import Validate, ValidateFunctionPretty

cellule_import = Validate()
# c'est cet appel qui aura pour effet de valider la cellule d'import
cellule_import()

def sequence_op(s):
    file = getattr(__main__, 'cree_file')()
    L = []
    for (op, arg) in s:
        if op == "enfile":
            getattr(__main__, 'enfile')(file, arg)
        else:
            L.append(getattr(__main__, 'defile')(file))
    return L

def sequence_op2(s):
    file = getattr(__main__, 'cree_file2')(10)
    L = []
    for (op, arg) in s:
        if op == "enfile":
            getattr(__main__, 'enfile2')(file, arg)
        else:
            L.append(getattr(__main__, 'defile2')(file))
    return L


tests = [[("enfile", 1), ("defile", None)], 
    [("enfile", 1), ("enfile", 2), ("enfile", 3), ("enfile", 4), ("defile", None), ("defile", None), ("defile", None), ("defile", None)], 
    [("enfile", 1), ("enfile", 2), ("defile", None), ("defile", None), ("enfile", 3), ("enfile", 4), ("defile", None), ("defile", None)], 
    [("enfile", 1), ("enfile", 2), ("defile", None), ("enfile", 3), ("defile", None), ("enfile", 4), ("defile", None), ("defile", None)]]
resultat = [[1], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]]
valider_file_2piles = ValidateFunctionPretty("sequence_op", tests, resultat)
valider_file_circulaire = ValidateFunctionPretty("sequence_op2", tests, resultat)


