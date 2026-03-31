import p5
import time
__mat = [[False for i in range(30)] for i in range(30)]

def setup():
    p5.createCanvas(300, 300)
    p5.background(200)
    p5.noStroke()

__etape = lambda x: x
__speed = 0.5
__last_time = 0.0

def draw():
    global __mat, etape, __last_time
    for i in range(30):
        for j in range(30):
            if __mat[i][j]:
                p5.fill(0, 255)
            else:
                p5.fill(255, 255)
            p5.rect(10 * i + 1, 10 * j + 1, 8, 8)
    if time.time() > __last_time + __speed:
        __last_time = time.time()
        __mat = __etape(__mat)


def vitesse_execution(secondes_par_iter):
    global __speed
    __speed = secondes_par_iter
def afficher_matrice(plateau):
    """Affiche la matrice donnée en argument."""
    global __mat
    __mat = plateau
    p5.run()
    p5.stop()

def animer_matrice(plateau, etape):
    """Lance l'animation en partant de plateau, et en appelant etape entre deux."""
    global __mat, __etape
    __etape = etape
    __mat = plateau
    p5.run()


def stop():
    """Arrête l'animation"""
    p5.stop()
