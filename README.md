PROJET PATHFINDING

Ce projet s'inscrit dans le cadre du module "Projet d'Informatique Scientifique" de la licence mathématique et informatique de l'université de Nantes. Il consiste à concevoir et implémenter des algorithmes de recherche de plus court chemin, tels que Bfs, Dijkstra, Astar, pour atteindre un point d'arrivée tout en évitant les obstacles.

OBJECTIF

L'objectif de ce projet est de comparer les performances des différents algorithmes de recherche de chemin en termes de distance parcourue, de nombre de nœuds visités et de temps d'exécution. Les algorithmes implémentés sont :

1) BFS
2) DIJKSTRA
3) ASTAR
4) ASTAR_PONDERER

STRUCTURATION DU PROJET

Le projet se trouve dans le repertoire 'projet-d-informatique-scientifique' qui contient lui meme 3  sous répertoire: src, documentation et data. Dans src, vous y trouverez les fichiers sources du projet. dans documentation, il y a le rapport qui resume l'étude comparative des différents algorithmes et dans data il y a differents types de fichiers pour tester lke projet.

|-- Projet-d-informatique-scientifique
  |-- src
      |- main.jl : Construit le graphe à partir d'un fichier `.map` (carte) en entrée.
      |- graphe.jl : Point d'entrée du programme. Permet de choisir l'algorithme à exécuter.
      |- bfs.jl      : Implémentation de l'algorithme BFS.
      |- dijkstra.jl  : Implémentation de l'algorithme de Dijkstra.
      |- astar.jl     : Implémentation de l'algorithme A\*.
      |- glouton
  |-- documentation
     |
     |
  |-- data
     |- theglaive.map
     |- test.map


UTILISATION

Pour lancer le programme, suivez les étapes suivantes:
1) Ouvrez le REPL Julia.
2) taper ''include("main.jl") pour démarrer le programme.
3) 



