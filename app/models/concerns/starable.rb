module Starable
  extend ActiveSupport::Concern

  def star_rating
    return 0 unless rating
    
    if rating % 1 < 0.25
      rating.to_i
    elsif rating % 1 < 0.75
      "#{rating.to_i}-half"
    else
      rating.to_i + 1
    end
  end
end