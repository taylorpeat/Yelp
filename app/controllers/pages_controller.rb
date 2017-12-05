class PagesController < ApplicationController
  def home
    @header = :none
    @home_image = %w(bar custard ice_cream_sandwich pasta plates).sample
  end
end