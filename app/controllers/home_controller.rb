class HomeController < ApplicationController

  def index
    render "index", layout: "home"
  end

  def about
    render "about", layout: "application"
  end

end
