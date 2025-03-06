# Importation des structures de données nécessaires
using DataStructures: PriorityQueue, enqueue!, dequeue!
include("graphe.jl")

function Astar(graphe::String, depart::Tuple{Int, Int}, arrivee::Tuple{Int, Int})
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

    # File de priorité pour stocker les sommets à explorer avec leur coût estimé
    file_priorite = PriorityQueue{Tuple{Int, Int}, Float64}()
    enqueue!(file_priorite, depart, 0.0)
    # Dictionnaire pour stocker les prédécesseurs de chaque nœud
    predecesseurs = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    # Dictionnaire pour stocker le coût réel de chaque sommet
    cout_reel = Dict{Tuple{Int, Int}, Float64}()
    cout_reel[depart] = 0.0  # Coût réel du départ est 0
    # Dictionnaire pour stocker le coût estimé de chaque sommet
    cout_estime = Dict{Tuple{Int, Int}, Float64}()
    cout_estime[depart] = heuristique(depart, arrivee)  # Coût estimé du départ
    # initialisation du nombre de sommets visités
    nb_sommets_visites = 0
    # Tant qu'il y a des sommets à explorer dans la file de priorité
    while !isempty(file_priorite)
        # Récupère le sommet avec le plus petit coût estimé
        sommet_courant = dequeue!(file_priorite)
        nb_sommets_visites += 1
        # Si on a atteint le sommet d'arrivée, on reconstruit le chemin
        if sommet_courant == arrivee
            chemin = reconstruire_chemin(predecesseurs, depart, arrivee)
            # Calculer la distance (coût réel du chemin)
            distance = Int(round(cout_reel[arrivee]))
            println("La distance entre  ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est          : $distance ")
            println("Le nombre de sommets visités est                  : $nb_sommets_visites")
            println("Le chemin optimal entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2])) est     : ") 
            afficher_chemin(chemin)
            println("\t")
            return
        end
        
        # Explore chaque voisin du sommet actuel
        for (voisin, cout) in G[sommet_courant]
            if !haskey(G, voisin)
                continue
            end
            # Calcule le coût réel pour atteindre le voisin
            nouveau_cout_reel = cout_reel[sommet_courant] + cout
            # Si ce coût est meilleur que celui déjà enregistré
            if !haskey(cout_reel, voisin) || nouveau_cout_reel < cout_reel[voisin]
                # Met à jour le prédécesseur du voisin
                predecesseurs[voisin] = sommet_courant
                # Met à jour le coût réel du voisin
                cout_reel[voisin] = nouveau_cout_reel
                # Met à jour le coût estimé du voisin
                cout_estime[voisin] = cout_reel[voisin] + heuristique(voisin, arrivee)
               
    
               if voisin in keys(file_priorite)
                # Mettre à jour la priorité du nœud existant
                file_priorite[voisin] = cout_estime[voisin]
               else
                # Ajouter le nœud à la file de priorité
                enqueue!(file_priorite, voisin, cout_estime[voisin])
               end

            end
        end
    end
    
    # Si on sort de la boucle, aucun chemin n'a été trouvé
    println("Aucun chemin trouvé entre ($(depart[1]), $(depart[2])) et ($(arrivee[1]), $(arrivee[2]))")
    println("Le nombre de sommets visités est            : $nb_sommets_visites")
end