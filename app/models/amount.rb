class Amount
  include Mongoid::Document

  def self.default
    15_00
  end

end
