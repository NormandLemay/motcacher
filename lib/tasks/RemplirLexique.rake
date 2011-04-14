# encoding: utf-8
# il suffit juste d'appeler remplir_all qui va faire epurer_fichier ensuite il va executer ajouter_data
namespace :lexique do
  desc "methode servant à lire un fichier de data"
  task :ajouter_data => :environment do
    #tofind = "ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ"
    #replac = "AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn"
    File.open("data.txt") do |file|
      file.readlines.each do |line|
        line.strip.downcase.split(/ /).each do |mot|
          mot = enlever_accent(mot)
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
  task :epurer_fichier do
    data = File.open("data.txt","r+")
    File.open("Lexique3.txt") do |file|
      file.readlines.each do |line|
        line.chop
        if line.include?("NOM")
          @f = line.split("\t")
          if @f[3] == "NOM" and @f[14].to_i >= 3 and !@f[0].include?("-") and !@f[0].include?(" ") and @f[0].upcase != "ABC"
            data.print "#{enlever_accent(@f[2])}\n"
          end
        end
      end
    end
    data.close
  end

  task :remplir_all => [:epurer_fichier, :ajouter_data]

  def enlever_accent(string)
    tofind = "ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ"
    replac = "AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn"
    string.tr(tofind,replac).downcase
  end
end