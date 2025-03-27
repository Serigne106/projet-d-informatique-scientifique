using DataStructures: PriorityQueue, enqueue!, dequeue!
include("graphe.jl")

function Astar_pondere(graphe::String, depart::Tuple{Int64, Int64}, arrivee::Tuple{Int64, Int64}, w::Float64)
    # Lire le graphe à partir du fichier
    G = lire_carte(graphe)
 
    # Vérifier l'existence des sommets
    if !haskey(G, depart)
        println("Erreur : Le sommet de départ n'existe pas dans le graphe.")
        return
    end
    if !haskey(G, arrivee)
        println("Erreur : Le sommet d'arrivée n'existe pas dans le graphe.")
        return
    end

    # File de priorité pour stocker les sommets à explorer avec leur coût estimé
    file_priorite = PriorityQueue{Tuple{Int64, Int64}, Float64}()
    enqueue!(file_priorite, depart, 0.0)

    # Dictionnaires pour stocker informations des nœuds
    predecesseurs = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()
    cout_reel = Dict{Tuple{Int64, Int64}, Float64}()
    cout_reel[depart] = 0.0
    cout_estime = Dict{Tuple{Int64, Int64}, Float64}()
    cout_estime[depart] = cout_reel[depart] + w * heuristique(depart, arrivee)

    nb_sommets_visites = 0

    while !isempty(file_priorite)
        sommet_courant = dequeue!(file_priorite)
        nb_sommets_visites += 1

        if sommet_courant == arrivee
            chemin = reconstruire_chemin(predecesseurs, depart, arrivee)
            distance = Int(round(cout_reel[arrivee]))
            println("La distance entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est : $distance")
            println("Le nombre de sommets visités est : $nb_sommets_visites")
            println("Le chemin optimal est :")
            afficher_chemin(chemin)
            return
        end

        for (voisin, cout) in G[sommet_courant]
            if !haskey(G, voisin)
                continue
            end

            nouveau_cout_reel = cout_reel[sommet_courant] + cout

            if !haskey(cout_reel, voisin) || nouveau_cout_reel < cout_reel[voisin]
                predecesseurs[voisin] = sommet_courant
                cout_reel[voisin] = nouveau_cout_reel
                if w > 1.0
                    cout_estime[voisin] = cout_reel[voisin] + w * heuristique(voisin, arrivee)
                elseif w >= 0.0 && w <= 1.0  
                    cout_estime[voisin] = w*cout_reel[voisin] + (1-w)*heuristique(voisin, arrivee)
                end
                #cout_estime[voisin] = cout_reel[voisin] + w * heuristique(voisin, arrivee)

                if voisin in keys(file_priorite)
                    file_priorite[voisin] = cout_estime[voisin]
                else
                    enqueue!(file_priorite, voisin, cout_estime[voisin])
                end
            end
        end
    end

    println("Aucun chemin trouvé entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2]))")
    println("Le nombre de sommets visités est : $nb_sommets_visites")
end
