module GrillesHelper

  def valide_mot_cache(reponse)
    lexique = Lexique.find(:first, :conditions => "id = #{@grilles.mot_cache}")
    if reponse == lexique.mot
      return 'Oui'
    else
      return 'Non'
    end
  end
end
