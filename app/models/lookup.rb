class Lookup < ActiveRecord::Base
  attr_accessible :destination, :match, :sorttype

  def search
  end
end
