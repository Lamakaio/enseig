import random
random.seed(142857)
nb_combats = 0

affiche_force = False

class Blob:
    def __init__(self, nom, force):
        self.nom = nom
        self.__force = force

    def __str__(self):
        global affiche_force
        if not affiche_force:
            return self.nom
        else:
            return f"{self.nom} - {self.__force}"

    def __repr__(self):
        global affiche_force
        if not affiche_force:
            return f"Blob {self.nom}"
        else:
            return f"Blob {self.nom} - {self.__force}"

    def combat(self, blob):
        global nb_combats
        nb_combats += 1
        if self.__force >= blob.__force:
            return self
        else:
            return blob



listes_des_blobs = []
prenoms = []
with open("prenoms.csv", "r") as f:
    for line in f:
        prenoms.append(line[:-1])



def get_blobs(N = 500):
    global prenoms
    random.seed(142857)
    if N < 20000:
        forces = list(range(N))
        blobs = [Blob(prenom, force) for (prenom, force) in zip(random.sample(prenoms, N), forces)]
    else:
        blobs = [Blob("", force) for force in range(N)]
    random.shuffle(blobs)
    return blobs

def reinit_compteur():
    global nb_combats
    nb_combats = 0

def lire_compteur():
    global nb_combats
    return nb_combats

def affiche_force_blobs():
    global affiche_force
    affiche_force = True