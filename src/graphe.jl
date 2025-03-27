
function lire_carte(fichier_carte::String)
    # Lire la carte ligne par ligne
    carte = readlines(fichier_carte)
    # Convertir l'entrée utilisateur en entier
    if isempty(carte)
        println("Le fichier est vide ou mal formaté.")
    end
    # Ignorer les lignes de métadonnées jusqu'à trouver "map"
    while !isempty(carte) && carte[1] != "map"
        popfirst!(carte)  # Supprime la première ligne
    end
    # Vérifier si le mot-clé "map" est trouvé 
    if isempty(carte) || carte[1] != "map"
        println("Format du fichier incorrect : mot-clé 'map' non trouvé")
    end
    # Supprimer la ligne "map", on garde seulement la carte
    popfirst!(carte) 
    # Dimensions de la carte
    nb_lignes = length(carte)
    nb_colonnes = length(carte[1])
    # Coût des cases
    #cout_cases = Dict{Char, Float64}('@' => Inf, '.' => 1.0, 'S' => 5.0, 'W' => 8.0)
    #car_non_def = 1.0  # Valeur par défaut pour les caractères inconnus
    # Structure pour stocker le graphe : dictionnaire de vecteurs de tuples
    graphe = Dict{Tuple{Int64,Int64}, Vector{Tuple{Tuple{Int64,Int64}, Float64}}}()
    # Parcourir la carte et ajouter les arêtes
    for i in 1:nb_lignes
        for j in 1:nb_colonnes
            sommet = (i, j)
            # Vérifier si la case (i,j) est un mur '@'
            if carte[i][j] == '@'
               continue  # Ne pas ajouter les murs au graphe
            end
            # Initialiser la liste des voisins pour le sommet courant
            graphe[sommet] = Vector{Tuple{Tuple{Int64,Int64}, Float64}}()
            voisins = [(i-1, j), (i+1, j), (i, j-1), (i, j+1)]  # Haut, Bas, Gauche, Droite
            # Ajouter les voisins valides
            for (vi, vj) in voisins
                if 1 <= vi <= nb_lignes && 1 <= vj <= nb_colonnes
                    car = carte[vi][vj]
                    cout = valuation(car)
                    push!(graphe[sommet], ((vi, vj), cout))
                end
            end
        end
    end
    return graphe
end
  

function get_voisins(G::Dict{Tuple{Int64,Int64}, Vector{Tuple{Tuple{Int64,Int64}, Float64}}} , u::Tuple{Int64,Int64})
    voisins = []   # Initialiser la liste des voisins
    if haskey(G, u) # Vérifier si le sommet u est dans le graphe
        for (voisin, poids) in G[u]  # itere sur les voisins du sommet
            push!(voisins, (voisin, poids))  # Ajouter le voisin à la liste
        end
    end
    return voisins # Retourner la liste des voisins
end


# Fonction pour afficher le chemin trouvé
function afficher_chemin(chemin::Vector{Tuple{Int64, Int64}})
    for i in 1:length(chemin)-1
        print("($(chemin[i][1]), $(chemin[i][2])) → ")
    end
    println("($(chemin[end][1]), $(chemin[end][2]))")
end


# Fonction pour reconstruire le chemin optimal à partir des prédécesseurs
function reconstruire_chemin(precedents::Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}, depart::Tuple{Int64, Int64}, arrivee::Tuple{Int64, Int64})
    chemin = Tuple{Int64, Int64}[]
    sommet = arrivee

    while sommet != depart
        if sommet == (-1, -1)
            println("Aucun chemin trouvé.")
            return Tuple{Int, Int}[]
        end
        pushfirst!(chemin, sommet)
        sommet = precedents[sommet]
    end

    pushfirst!(chemin, depart)
    return chemin
end



# Fonction heuristique : calcul le cout estimé restant 
function heuristique(sommet_actuel::Tuple{Int64,Int64}, arrivee::Tuple{Int64, Int64})
    return abs(sommet_actuel[1] - arrivee[1]) + abs(sommet_actuel[2] - arrivee[2])
end



function valuation(car::Char)
    if car == '@'
        return Inf
    elseif car == 'S'
       return 5.0
    elseif car == 'W'
       return 8.0
    elseif car == '.'
       return 1.0
    else
      return Inf
    end
end
