class Lexique < ActiveRecord::Base

  before_save :init_lenght
  
  def init_lenght
    self.nbr_lettre = self.mot.length
  end

  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['mot like ?', "%#{search}%"], :order => 'mot'
  end

end
