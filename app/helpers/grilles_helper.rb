module GrillesHelper

  def valide_mot_cache(reponse)
    lexique = Lexique.find(:first, :conditions => "id = #{@grilles.mot_cache}")
    if reponse == lexique.mot
      return 'Oui'
    else
      return 'Non'
    end
  end

  def afficher_liste_mots
 #   liste = Lexique.find(:all, :conditions => "id in (#{@grilles.listes_mots})", :order => "mot asc")
#    result = "<table>"
#    result += "<tr><th>Mot a trouver</th></tr>"
#    liste.each do |mot|
#      result += "<tr><td class='vide' onclick='cSwap(this);'>#{mot.mot}</td></tr>"
#    end
#    result += "</table>"
#    , nil, :class => 'error_messages'
#    content_tag :table do
#      content = content_tag(:tr)
#      content << content_tag(:th, "Mot a trouver")
#      liste.each do |mot|
#        content << content_tag(:tr)
#        content_tag :td, mot.mot
#      end
#    end
  end
end
