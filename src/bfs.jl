include("graphe.jl")
using DataStructures

function bfs(graphe::String, depart::Tuple{Int64,Int64}, arrivee::Tuple{Int64,Int64})
    # Lire le graphe à partir du fichier
    G = lire_carte(graphe)
     # Vérifier que le sommet de départ existe dans le graphe
     if !haskey(G, depart) 
        println("Erreur : Le sommet de départ n'existe pas dans le graphe.")
        return
     end
     # Vérifier que le sommet d'arrivée existe dans le graphe
     if !haskey(G, arrivee) 
        println("Erreur : Le sommet d'arrivée n'existe pas dans le graphe.")
        return
     end
    # Créer une file FIFO pour explorer les sommets
    file = Queue{Tuple{Int64, Int64}}() 
    # Ensemble des sommets visités 
    visites = Set{Tuple{Int64, Int64}}()  
    # Dictionnaire pour stocker les prédécesseurs de chaque sommet
    predecesseur = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()
    # Ajouter le sommet de départ à la file et le marquer comme visité
    enqueue!(file, depart)  
    push!(visites, depart)  
    # initialisation du nombre de sommets visités
    nb_sommets_visites = 1 
    # Boucle principale de l'algorithme
    while !isempty(file) 
        # Récupérer le premier sommet de la file
        u = dequeue!(file)  
        # Vérifier si on a atteint le sommet d'arrivée
        if u == arrivee
            chemin = reconstruire_chemin(predecesseur, depart, arrivee)
            distance = length(chemin) - 1  
            println("La distance entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est             : $distance")
            println("Le nombre de sommets visités est                    : $nb_sommets_visites")
            println("Le chemin optimal entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est       : ") 
            afficher_chemin(chemin)
            return 
        end

        # Récupérer les successeurs de u dans G
        S = [voisin for (voisin, _) in get_voisins(G, u)]
        #S = get_voisins(G, u)  

        for s in S
            if !(s in visites)
                # Ajouter le successeur à la file 
                enqueue!(file, s)  
                #marquer ce successeur comme visité
                push!(visites, s)
                # Mettre à jour le prédécesseur du successeur
                predecesseur[s] = u
                # Incrémenter le compteur de sommets visités
                nb_sommets_visites += 1
            end
        end
    end
    println("Aucun chemin trouvé entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])).")
    println("le nombre de sommets visités est : $nb_sommets_visites")
    
end
