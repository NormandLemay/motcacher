# encoding: utf-8
#task :greet do
#  puts "hello worlds!"
#end
#
#task :ask => :greet do
#  puts "comment tu vas!"
#end
#namespace # sert a faire un regroupement (exemple même début de méthode
#desc "test normand" # ce desc sert à le voir lorsqu'on fait rake -T
#task :pick(testes) => :environment do
#  user = Lexique.find(:first)
#  puts "winner: #{user.mot}"
#end
#desc "methode servant à lire un fichier de data"
#task :lire_data do
#  File.open("test.txt") do |file|
#    file.readlines.each do |line|
#      puts line.upcase
#    end
#  end
#end
desc "methode servant à lire un fichier de data"
task :lire_fichier => :environment do
          tofind = "ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ"
          replac = "AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn"
  File.open("data.txt") do |file|
    file.readlines.each do |line|
      line.strip.downcase.split(/ /).each do |mot|
        mot = mot.tr(tofind,replac).downcase
        if mot.strip.length >=3
          lexique = Lexique.find_by_mot(mot)
          if !lexique
            nouv_mot = Lexique.new(:mot=>mot)
            nouv_mot.save
          end
        end
      end
    end
  end
end

desc "epuration d'un fichier de donné"
task :epure_fichier do
          tofind = "ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ"
          replac = "AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn"
   data = File.open("data.txt","r+")
  File.open("Lexique3.txt") do |file|
    file.readlines.each do |line|
      line.chop
     # puts line
      if line.include?("NOM")
        @f = line.split("\t")
       # puts @f[3]
         if @f[3] == "NOM" and @f[14].to_i >= 3 and !@f[0].include?("-") and !@f[0].include?(" ") and @f[0].upcase != "ABC"
           data.print "#{@f[0].tr(tofind,replac).downcase} \n"
         end
      end
    end
  end
  data.close
end