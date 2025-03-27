__PROJET PATHFINDING__  

Ce projet s'inscrit dans le cadre du module "Projet d'Informatique Scientifique"
de la licence mathématique et informatique de l'université de Nantes. Il
consiste à concevoir et implémenter des algorithmes de recherche de plus court
chemin, tels que Bfs, Dijkstra, Astar etc pour atteindre un point d'arrivée tout en
évitant les obstacles.

__OBJECTIF__  

L'objectif de ce projet est de comparer les performances des différents
algorithmes de recherche de plus court chemin en termes de distance parcourue,
de nombre de nœuds visités et de temps d'exécution. Les algorithmes implémentés
sont :  

1) BFS  
2) DIJKSTRA  
3) ASTAR  
4) ASTAR_PONDERER

__STRUCTURATION DU PROJET__

Le projet se trouve dans le repertoire projet-d-informatique-scientifique qui
contient lui meme 3 sous répertoire: src, documentation et data. Dans src, vous
y trouverez les fichiers sources du projet. dans documentation, il y a le
rapport qui resume l'étude comparative des différents algorithmes et dans data
il y a differents types de fichiers pour tester le projet.  

|-- 📂Projet-d-informatique-scientifique  
|-- 📂src  
  |- graphe.jl : Construit le graphe à partir d'un fichier .map en entrée.  
  |- main.jl : Point d'entrée du programme.Permet de choisir l'algorithme à exécuter.    
  |- bfs.jl  : Implémentation de l'algorithme BFS.  
  |- dijkstra.jl : Implémentation de l'algorithme de Dijkstra.  
  |- astar.jl  : Implémentation de l'algorithme Astar.    
  |- astar_pondere : implementation de l'algorithme Astar_pondere    
|-- 📂documentation   
  | rapport du projet    
|-- 📂data   
  |- theglaive.map   
  |- test.map    
  

__UTILISATION__    


Pour lancer le programme, veuillez suivre les étapes suivantes:
1) Ouvrez le REPL de Julia.
2) taper include("main.jl") pour démarrer le programme
3) choisissez l'algorithme que vous voulez lancer.

Pour changer les points de depart et d'arrivée ou le poids dans astar_pondere,  
aller dans le fichier main.jl qui se trouve dans le repertoire src et mettez vos  
valeur souhaitées dans depart, arrivée , w et/ou fichier_carte pour changer de
carte.  
NB: Avant de lancer le programme, assurer vous d'avoir le fichier   map que vous voulez lancer dans le répertoire src
