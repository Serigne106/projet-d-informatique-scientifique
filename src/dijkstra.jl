include("graphe.jl")
using DataStructures

function Dijkstra(graphe::String, depart::Tuple{Int64, Int64}, arrivee::Tuple{Int64, Int64})
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

    # Déclaration des structures de données
    distances = Dict{Tuple{Int64, Int64}, Float64}()  # Distances minimales
    precedents = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()  # Chemin optimal
    permanents = Dict{Tuple{Int64, Int64}, Bool}()  # Sommets permanents (true si permanent)
    a_explorer = PriorityQueue{Tuple{Int64, Int64}, Float64}()  # File de priorité

    # Initialisation des structures de données
    for sommet in keys(G)
        distances[sommet] = Inf
        precedents[sommet] = (-1, -1)
        permanents[sommet] = false  # Initialement, aucun sommet n'est permanent
    end
    # Initialisation du point de départ et du compteur de sommets visités
    distances[depart] = 0.0
    enqueue!(a_explorer, depart, 0.0) 
    nb_sommets_visites = 0
    # Boucle principale de l'algorithme 
    while !isempty(a_explorer)
        # Sélection du sommet avec la plus petite distance
        sommet_actuel = dequeue!(a_explorer)
        # Si le sommet est déjà permanent, on passe
        if permanents[sommet_actuel]
            continue
        end
        # Marquer le sommet comme permanent
        permanents[sommet_actuel] = true
        nb_sommets_visites += 1
        # Si on atteint l'arrivée, on arrête
        if sommet_actuel == arrivee
            break
        end
        # Mise à jour des distances des voisins non permanents
        for (voisin, poids) in get_voisins(G, sommet_actuel)
            if !haskey(G, voisin)
                continue
            end
            # Si le voisin n'est pas permanent
            if !permanents[voisin]
                nouvelle_distance = distances[sommet_actuel] + poids
                # Si une nouvelle distance plus courte est trouvée
                if nouvelle_distance < distances[voisin]
                    # Mettre à jour la distance 
                    distances[voisin] = nouvelle_distance
                    precedents[voisin] = sommet_actuel
                    enqueue!(a_explorer, voisin, nouvelle_distance)
                end
            end
        end
    end

    # Vérifier si l'arrivée est accessible
    
    if !permanents[arrivee]
        println("Le sommet d'arrivée n'est pas accessible depuis le sommet de départ.")
        println("Le nombre de sommets visités est : $nb_sommets_visites")
        return
    end
    

    # Reconstruire le chemin optimal
    chemin = reconstruire_chemin(precedents, depart, arrivee)
    distance = Int(round(distances[arrivee]))  # Utiliser la distance réelle
    # Afficher les résultats
    println("La distance entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est         : $distance")
    println("Le nombre de sommets visités est                : $nb_sommets_visites")
    println("Le chemin optimal entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est   :")
    afficher_chemin(chemin)
end



