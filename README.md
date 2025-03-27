# projet d'informatique scientifique
Ce projet s'inscrit dans le cadre du module projet-d'informatique-scientifique de la licence mathématique-informatique. Intitulé PATHFINDING, il consiste à concevoir des algorithmes de plus court chemins tels que BSF, DIJKSTRA, ASTAR, GLOUTON etc qui permettent d'atteindre un point d'arrivée tout en évitant les obstacles. 
Il est composé de 6 fichiers: le fichier graphe.jl qui construit le graphe à partir du fichier map entrée, le fichier main.jl qui est le point d'entrée du programme , les 4 autres fichiers contiennent respectivement les 4 algorithmes précédemment cités. 

Pour lancer le programme, il faut taper include("main.jl") dans le REPL et ensuite on peut choisir quel algorithme exécuter avec les chiffres 1 pour BFS, 2 pour Dijkstra, 3 pour Astar et enfin 4 pour Glouton.

Pour charger le fichier map , les points départ et arrivée, il faut aller dans le main et affecter les valeurs souhaitées aux points depart et arrivée 
