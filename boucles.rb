utilisateurs = ["joe", "marc", "laetitia", "connard", "fdp"]

utilisateurs.each do |utilisateur|
  puts utilisateur
end

3.times do |i|
  puts "hello mtf #{i}"
  i.times do
    puts "*" + " "
  end
end
