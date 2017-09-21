#Je code ma première classe en ruby#

class Pokemon
  attr_accessor :attaque , :puissance
end

pikachu = Pokemon.new
pikachu.attaque = "electricité"
pikachu.puissance = 20

puts "Pikachu a une attaque " + pikachu.attaque + " de " + pikachu.puissance.to_s + " points !"


#je code ma première méthode
class Eleve
  attr_accessor :prenom, :nom, :langages_preferes

  #méthode sans paramètre
  def nom_complet
    prenom + " " + nom
  end

  #méthode avec paramètre
  def aime_le(langage)
    langages_preferes.each do |element|
      if langage == element
        puts "Oui :)"
      elsif
        puts "Non :("
      end
    end
  end

end

jc = Eleve.new

jc.prenom = "John"

jc.nom = "Cleese"

jc.langages_preferes = ["Ruby", "C"]


puts "Est-ce que " + jc.nom_complet + " aime le Ruby ?\n"  
jc.aime_le("Ruby")
