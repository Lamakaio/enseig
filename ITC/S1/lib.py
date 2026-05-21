import graphviz
import traceback
import sys
import __main__
import time
import random
import asyncio

mots = [m + ".pdf" for m in ["choc","clair","virus","juteux","urgent","dauphins","immersion","jour","harpon","critique","spoilers","terrasses","auberge","reine","bocal","ace","chatouiller","renverser","rouflaquettes","objectifs","rio","grognement","vallée","dépravé","boxeur","architecte","éclat","kamikaze","spirale","buffle","dentiste","trompette","mafia","champagne","note","vain","angoisse","facile","conceptuel","toujours"]]

async def lancer_imprimante():
    requetes = sorted([int(random.betavariate(1, 4)*1000) for i in range(10)])
    k = 0
    prochain_document = getattr(__main__, 'prochain_document')
    demande_impression = getattr(__main__, 'demande_impression')
    spl_mots = random.sample(mots, 10)
    print(requetes)
    for i in range(1, 1001):
        await asyncio.sleep(0.01)
        if i % 100 == 0:
            n = prochain_document()
            print(f"\x1b[31m Impression du document {n}\x1b[0m", flush=True)
        if k < 10 and i > requetes[k]:
            demande_impression(spl_mots[k])
            print(f"Demande d'impression du document {spl_mots[k]}")
            k += 1

import p5

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


