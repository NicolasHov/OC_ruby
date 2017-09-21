#bugs sur rispostes des ennemis

class Personne
  attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 100
    @en_vie = true
  end

  def info
    # A faire:
    # - Renvoie le nom et les points de vie si la personne est en vie
    # - Renvoie le nom et "vaincu" si la personne a été vaincue
    if points_de_vie > 0
      "#{nom} -> pdv:#{points_de_vie}"
    else
      "#{nom}, vaincu"
      self.en_vie = false
    end
  end
  def attaque(autre_personne)
    # A faire:
    # - Fait subir des dégats à la personne passée en paramètre
    # - Affiche ce qu'il s'est passé
    autre_personne.subit_attaque(10)
    puts "#{autre_personne.nom} a subit une attaque de #{self.nom}"
  end

  def subit_attaque(degats_recus)
    # A faire:
    # - Réduit les points de vie en fonction des dégats reçus
    # - Affiche ce qu'il s'est passé
    # - Détermine si la personne est toujours en_vie ou non

    self.points_de_vie = self.points_de_vie - degats_recus
    puts "#{nom} a perdu #{degats_recus} points de vie"
    puts "#{info}"
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

  def degats
    # A faire:
    # - Calculer les dégats

    # - Affiche ce qu'il s'est passé
    puts "#{self.nom} a une attaque de #{degats_bonus} dégats"
  end

  def soin
    # A faire:
    # - Gagner de la vie
    self.points_de_vie += 40
    # - Affiche ce qu'il s'est passé
    puts "#{self.nom} a gagné 40 pdv !"
  end

  def ameliorer_degats
    # A faire:
    # - Augmenter les dégats bonus
    self.degats_bonus += 20
    # - Affiche ce qu'il s'est passé
    puts "#{self.nom} a gagné 20 points de degats !"
  end
end

class Ennemi < Personne
  def degats
    # A faire:
    # - Calculer les dégats
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
      puts "#{i} - Attaquer #{ennemi.info}"
      i = i + 1
    end
    puts "99 - Quitter"
  end

  def self.est_fini(joueur, monde)
    # A faire:
    # - Déterminer la condition de fin du jeu
    # >> si tous les ennemis sont morts et/ou le héros est mort
    if monde.ennemis_en_vie.count == 0
      "true"
    end
    if joueur.points_de_vie <= 0
      "true"
    end
  end
end

class Monde
  attr_accessor :ennemis

  def ennemis_en_vie
    # A faire:
    # - Ne retourner que les ennemis en vie
    #pas de paramètre, la méthode est appelée sur un array et renvois un array avec les ennemis en vie
    ennemis.each do |ennemi| #pour chaque objet ennemi de l'array ennemis
      if ennemi.points_de_vie > 0 #si l'ennemi (personne) a au moins 1 de pdv
        ennemi.nom #on retourne le nom de l'ennemi
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
  Ennemi.new("Squelette")
]

# Initialisation du joueur
joueur = Joueur.new("Jean-Michel Paladin")

# Message d'introduction. \n signifie "retour à la ligne"
puts "\n\nAinsi débutent les aventures de #{joueur.nom}\n\n"

# Boucle de jeu principale
100.times do |tour|
  puts "\n------------------ Tour numéro #{tour} ------------------"

  # Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
  # On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.chomp.to_i

  # En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
    joueur.soin
  elsif choix == 1
    joueur.ameliorer_degats
  elsif choix == 99
    # On quitte la boucle de jeu si on a choisi
    # 99 qui veut dire "quitter"
    break
  else
    # Choix - 2 car nous avons commencé à compter à partir de 2
    # car les choix 0 et 1 étaient réservés pour le soin et
    # l'amélioration d'attaque
    ennemi_a_attaquer = monde.ennemis[choix - 2]
    joueur.attaque(ennemi_a_attaquer)
  end

  puts "\nLES ENNEMIS RIPOSTENT !"
  # Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
    # ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  puts "\nEtat du héro: #{joueur.info}\n"
  puts "nombre ennemis vivants : #{monde.ennemis_en_vie.count}"
  puts Jeu.est_fini(joueur,monde)
  # Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

puts "\nGame Over!\n"

# A faire:
# - Afficher le résultat de la partie

if joueur.en_vie
  puts "Vous avez gagné !"
else
  puts "Vous avez perdu !"
end
