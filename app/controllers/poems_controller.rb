class PoemsController < ApplicationController
  def index
    @poem = Poem.all
  end

  def show
    @poem = Poem.find(params[:id])
  end
end
