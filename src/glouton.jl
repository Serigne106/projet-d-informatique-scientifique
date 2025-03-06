include("graphe.jl")

function Glouton(graphe::String, depart::Tuple{Int, Int}, arrivee::Tuple{Int, Int})
     # Lire le graphe à partir du fichier
    G = lire_carte(graphe)
     # Vérifier que le sommet de départ existe dans le graphe
     if !haskey(G, depart) #
        println("Erreur : Le sommet de départ n'existe pas dans le graphe.")
        return
     end
     # Vérifier que le sommet d'arrivée existe dans le graphe
     if !haskey(G, arrivee) 
        println("Erreur : Le sommet d'arrivée n'existe pas dans le graphe.")
        return
     end
    # Initialiser la file de priorité avec le sommet de départ
    file_priorite = PriorityQueue{Tuple{Int, Int}, Float64}()
    enqueue!(file_priorite, depart, heuristique(depart, arrivee))
     # Initialiser les structures de données pour les prédécesseurs et les sommets visités
    predecesseurs = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    visites = Set{Tuple{Int, Int}}()
    push!(visites, depart)
    #compteur du nombre de sommets visités
    nb_sommets_visites = 0
    # Boucle principale de l'algorithme
    while !isempty(file_priorite)
        # Récupérer le sommet avec la plus petite valeur heuristique
        sommet_courant = dequeue!(file_priorite)
        # Vérifier si on a atteint le sommet d'arrivée
        if sommet_courant == arrivee
            chemin = reconstruire_chemin(predecesseurs, depart, arrivee)
            distance = length(chemin) - 1  
            println("La distance entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est              : $distance")
            println("Le nombre de sommets visités est                     : $nb_sommets_visites")
            println("Le chemin optimal entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est        : ") 
            afficher_chemin(chemin)
            return
        end
        # Parcourir les voisins du sommet courant
        for (voisin, cout) in G[sommet_courant]
            # Vérifier si le voisin existe dans le graphe
            if !haskey(G, voisin)
               # Si le voisin n'existe pas, passer au suivant
                continue
             end
            # Vérifie si le voisin n'a pas encore été visité
            if !(voisin in visites)
                # Mettre à jour le prédécesseur du voisin
                predecesseurs[voisin] = sommet_courant
                # Marquer le voisin comme visité
                push!(visites, voisin)
                # Incrémenter le compteur de sommets visités
                nb_sommets_visites += 1
                # Ajouter le voisin à la file de priorité avec sa valeur heuristique
                enqueue!(file_priorite, voisin, heuristique(voisin, arrivee))
            end
        end
    end

    # Si on sort de la boucle, aucun chemin n'a été trouvé
    println("Aucun chemin trouvé entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2]))")
    println("Le nombre de sommets visités est            : $nb_sommets_visites")
    
end