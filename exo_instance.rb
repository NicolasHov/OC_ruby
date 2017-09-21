class Utilisateur
  attr_accessor :nom, :amis

#attention j'ai utilisé nom au lieu de prenom
  def initialize(nom)
    @nom = nom
  end

  #methode sans param
  def lister_amis
    amis.each do |ami|
      puts ami.nom
    end
  end

  #methode qui renvois true si utilisateur ami avec autre utilisateur
  def est_amis_avec?(autre_nom)
    puts "Est-ce que " + nom + " est ami avec " + autre_nom + " ? "
    amis.each do |ami|
      if ami.nom != autre_nom
        puts "Non"
      else
        puts "Oui"
      end
    end
  end
end
utilisateur1 = Utilisateur.new("Bob")
utilisateur2 = Utilisateur.new("Jane")
utilisateur0 = Utilisateur.new("Alice")
utilisateur0.amis = [utilisateur1, utilisateur2]
#appel des méthodes
puts "Les amis de #{utilisateur0.nom} sont "
utilisateur0.lister_amis
utilisateur0.est_amis_avec?("Bob")
