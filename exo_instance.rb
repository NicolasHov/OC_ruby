class Utilisateur
  attr_accessor :nom, :amis

#attention j'ai utilisé nom au lieu de prenom
  def initialize(nom, amis)
    @nom = nom
    @amis = amis
  end

  #methode sans param
  def lister_amis
    puts "Les amis de #{self.nom} sont "
    self.amis.each do |ami|
      puts ami
    end
  end

  #methode qui renvois true si utilisateur ami avec autre utilisateur
  def est_amis_avec?(autre_nom)
    puts "Est-ce que " + nom + " est ami avec " + autre_nom + " ? "
    answer = nil
    self.amis.each do |ami|
      if ami == autre_nom
        answer= "Oui"
      else
        answer= "Non"
      end
    end
    puts answer
  end

end

jane = Utilisateur.new("Jane", ["mickael", "john", "alain", "tom"])
bob = Utilisateur.new("Bob", ["jane", "thomas", "tom", "kiki"])
alice = Utilisateur.new("Alice", ["jane", "bob", "koko", "kuku"])



#appel des méthodes

jane.est_amis_avec?("john")
alice.est_amis_avec?("koko")
bob.est_amis_avec?("thomas")
