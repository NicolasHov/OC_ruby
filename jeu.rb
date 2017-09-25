# Remarques sur le code / l'exercice :
# 1.Les méthodes degats et soin sont redondantes pour les classes qui héritent de Personne
# => on pourrait les refactoriser dans Personne puis les override
# 2. Les noms des méthodes sont d'ailleurs mal choisis et devraient être remplacés par des verbes (idéalement en anglais)
# 3. De manière générale, éviter les \n dans le code, c'est assez moche et moins lisible qu'un retour à la ligne avec un puts

class Personne
  attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 300
    @en_vie = true
  end

  # READ
  def info
    # - Renvoie le nom et les points de vie si la personne est en vie
    # - Renvoie le nom et "vaincu" si la personne a été vaincu-
    if points_de_vie > 0
      "#{self.nom} (#{self.points_de_vie}/300pdv)"
    else
      "#{self.nom} vaincu"
    end
  end

  # READ
  def attaque(personne)
    # - Fait subir des dégats à la personne passée en paramètre
    # - Affiche ce qu'il s'est passé
    puts "#{nom} attaque #{personne.nom}" # TODO pourquoi attaque meme si plus ennemeis vivants ??
    personne.subit_attaque(self.degats)
  end

  # WRITE
  def subit_attaque(degats_recus)
    # - Réduit les points de vie en fonction des dégats reçus
    self.points_de_vie = self.points_de_vie - degats_recus
    # - Affiche ce qu'il s'est passé
    puts "#{self.nom} a perdu #{degats_recus} points de vie"
    # - Détermine si la personne est toujours en_vie ou non
    if self.points_de_vie <= 0
      self.en_vie = false
      #self.points_de_vie = 0 #  sécurité pour éviter d'avoir des pdv négatifs
    end
    puts "#{self.info}"
  end
end

class Joueur < Personne
  attr_accessor :degats_bonus

  def initialize(nom)
    # Par défaut le joueur n'a pas de dégats bonus
    @degats_bonus = 0
    # Appelle le "initialize" de la classe mère (Personne)
    super(nom)
  end

  # READ
  def degats
    # - Calculer les dégats
    puissance_degats = 5 + degats_bonus
    # - Affiche ce qu'il s'est passé
    puts "#{self.nom} a une attaque de #{puissance_degats} dégats"
    return puissance_degats
  end

  # WRITE
  def soin
    # - Gagner de la vie
    self.points_de_vie += 40
    # - Affiche ce qu'il s'est passé
    puts "#{self.nom} a gagné 40 pdv !"
  end

  # WRITE
  def ameliorer_degats
    # - Augmenter les dégats bonus
    self.degats_bonus += 20
    # - Affiche ce qu'il s'est passé
    puts "#{self.nom} a gagné 20 points de degats !"
  end
end

class Ennemi < Personne
  # READ
  def degats
    # - Calculer les dégats
    puissance_degats = 5
    # - Affiche ce qu'il s'est passé
    puts "#{nom} a une attaque de #{puissance_degats} degats"
    return puissance_degats
  end
end

class Jeu
  def self.actions_possibles(monde)
    puts "ACTIONS POSSIBLES :"

    puts "0 - Se soigner"
    puts "1 - Améliorer son attaque"

    # On commence à 2 car 0 et 1 sont réservés pour les actions
    # de soin et d'amélioration d'attaque
    i = 2
    monde.ennemis.each do |ennemi|
      # if ennemi.en_vie == true
        puts "#{i} - Attaquer #{ennemi.info}"
        i = i + 1
      # end
    end
    puts "99 - Quitter"
  end

  def self.est_fini(joueur, monde)
    # - Déterminer la condition de fin du jeu
    # >> si tous les ennemis sont morts et/ou le héros est mort
    !joueur.en_vie || monde.ennemis_en_vie.count <= 0
  end
end

class Monde
  attr_accessor :ennemis

  def ennemis_en_vie # TODO pb de MAJ => le jeu ne fini jamais
    self.ennemis.each do |ennemi| # pour chaque objet ennemi de l'array ennemis
      if ennemi.en_vie == true # si l'ennemi (personne) a au moins 1 de pdv
        puts ennemi.nom + " : #{ennemi.points_de_vie} pdv"
        ennemi # on retourne le nom de l'ennemi (ruby permet de renvoyer directement un tableau filtré !!)
      end
    end
  end
end

##############

# Initialisation du monde
monde = Monde.new

# Ajout des ennemis
monde.ennemis = [
  Ennemi.new("Balrog"),
  Ennemi.new("Goblin"),
  Ennemi.new("Squelette"),
  Ennemi.new("Macron")
]

# Initialisation du joueur
joueur = Joueur.new("JOE l'abominable")

# Message d'introduction. \n signifie "retour à la ligne"
puts "\n\nAinsi débutent les aventures de #{joueur.nom}\n\n"

# Boucle de jeu principale
100.times do |tour|
  puts "\n------------------ Tour numéro #{tour} ------------------\n\n"


  #Affiche les infos du joueur
  puts joueur.info
  puts "\n\n"

  # Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
  # On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.to_i # utiliser chomp et to_i ensemble est redondant il me semble http://ruby-doc.org/docs/ruby-doc-bundle/Tutorial/part_02/user_input.html

  # En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
    joueur.soin
  elsif choix == 1
    joueur.ameliorer_degats
  elsif choix == 99
    # On quitte la boucle de jeu si on a choisi
    # 99 qui veut dire "quitter"
    break
  elsif choix >= monde.ennemis.count - 2 && choix < 99
    # Choix - 2 car nous avons commencé à compter à partir de 2
    # car les choix 0 et 1 étaient réservés pour le soin et
    # l'amélioration d'attaque
    ennemi_a_attaquer = monde.ennemis_en_vie[choix - 2]
    joueur.attaque(ennemi_a_attaquer)
  elsif
    puts "CHOIX IMPOSSIBLE : recommence gamin !"
  end

  puts "\nLES ENNEMIS RIPOSTENT !"
  # Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
    puts ennemi.nom
    # ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  puts "\nEtat du héros: #{joueur.info}\n"
  # Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

# - Afficher le résultat de la partie
if joueur.en_vie
  puts "Vous avez gagné !"
else
  puts "Vous avez perdu !"
end
