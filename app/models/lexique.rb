class Lexique < ActiveRecord::Base

  before_save :init_lenght
  
  def init_lenght
    self.nbr_lettre = self.mot.length
  end

  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['mot like ?', "%#{search}%"], :order => 'mot'
  end

  def self.obtenir_liste_mot(ids)
    liste = []
    lexiques = Lexique.find(:all, :conditions => "id in (#{ids})", :order => "mot asc")
    lexiques.each {|lexique| liste << lexique.mot}
    liste
  end
end
