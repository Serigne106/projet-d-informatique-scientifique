include("bfs.jl")
include("dijkstra.jl")
include("astar.jl")
include("glouton.jl")

function main()
    # les points de départ et d'arrivée et le fichier map fournit
    depart = (4, 1)
    arrivee = (3, 15)
    fichier_map = "test.map"
    # Vérifier si le fichier de la carte est valide
    if !isfile(fichier_map)
      println("Erreur : Le fichier '$fichier_map' n'est pas valide.")
      return
    end
    # Demande à l'utilisateur de choisir un algorithme
    println("\nChoisissez un algorithme :")
    println("1. BFS")
    println("2. Dijkstra")
    println("3. Astar")
    println("4. Glouton")
    choix = readline()
    choix = parse(Int, choix) # Convertir l'entrée utilisateur en entier
    println("SOLUTION : \n")
   # Exécute l'algorithme choisi
   if choix == 1
      println("-------------------------BFS-------------------------------")
      @time bfs(fichier_map, depart, arrivee)
   elseif choix == 2 
      println("------------------------DIJKSTRA--------------------------")
      @time Dijkstra(fichier_map, depart, arrivee)
   elseif choix == 3
      println("------------------------ASTAR-----------------------------")
      @time Astar(fichier_map, depart, arrivee)
   elseif choix == 4
      println("------------------------GLOUTON---------------------------") 
      @time Glouton(fichier_map, depart, arrivee)
   else
      println("Choix invalide.")
    end
end
# Appeler la fonction main pour exécuter le programme
main()