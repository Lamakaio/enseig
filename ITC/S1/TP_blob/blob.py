import random
random.seed(142857)
nb_combats = 0


class Blob:
    def __init__(self, nom, force):
        self.nom = nom
        self.__force = force

    def __str__(self):
        return self.nom

    def __repr__(self):
        return "Blob " + self.nom

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


def get_blobs(N = 10000):
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
