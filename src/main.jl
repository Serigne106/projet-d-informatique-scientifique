include("bfs.jl")
include("dijkstra.jl")
include("astar.jl")
include("astar_pondere.jl")
include("glouton.jl")

#using BenchmarkTools

function main() 

    # les points de départ et d'arrivée et le fichier map fournit
    depart = (189, 193)
    arrivee = (226, 437)
    #depart = (12, 5)
    #arrivee = (2, 12)
    
    w = 0.0
    fichier_map = "theglaive.map"
    #fichier_map = "test.map"

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
    println("4. Astar_pondere")  
    println("5. Glouton")
    choix = readline()
    choix = parse(Int64, choix) # Convertir l'entrée utilisateur en entier
    println("SOLUTION : \n")
   # Exécute l'algorithme choisi
   if choix == 1
     # tmp_dep = time()
      println("-------------------------BFS-------------------------------")
      @time bfs(fichier_map, depart, arrivee)
      #tmp_arr = time()
      #println("Temps d'exécution : ", tmp_arr - tmp_dep)
   elseif choix == 2 
      println("------------------------DIJKSTRA--------------------------")
      @time Dijkstra(fichier_map, depart, arrivee)
   elseif choix == 3
      println("------------------------ASTAR-----------------------------")
      @time Astar(fichier_map, depart, arrivee)
   elseif choix == 4
      println("------------------------ASTAR_PONDERE---------------------")
      @time Astar_pondere(fichier_map, depart, arrivee, w)
   elseif choix == 5
      println("------------------------GLOUTON---------------------------") 
      @time Glouton(fichier_map, depart, arrivee)
   else
      println("Choix invalide.")
    end
end
# Appeler la fonction main pour exécuter le programme
main()
