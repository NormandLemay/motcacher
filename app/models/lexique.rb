class Lexique < ActiveRecord::Base

  before_save :init_lenght

  def init_lenght
    self.nbr_lettre = self.mot.length
  end
end
