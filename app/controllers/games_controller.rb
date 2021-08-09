require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:guess]}"
    word_info = JSON.parse(URI.open(url).read)
    if !params[:guess].upcase.chars.all? { |letter| params[:guess].upcase.count(letter) <= params[:letters].split(" ").count(letter) }
      @result = "Sorry but you word cannot be built out of #{params[:letters]}"
    else
      if !word_info["found"]
        @result = 'Sorry but your guess does not seem to be a valid English word...'
      else
        @result = "Congratulations! Your word is a valid English word!"
      end
    end
  end

  # def score
  #   url = "https://wagon-dictionary.herokuapp.com/#{params[:guess]}"
  #   word_info = JSON.parse(URI.open(url).read)
  #   if !word_info["found"]
  #     @result = 'Sorry but your guess does not seem to be a valid English word...'
  #   elsif params[:guess].upcase.chars.all? { |letter| params[:guess].upcase.count(letter) <= params[:letters].split(" ").count(letter) }
  #     @result = "Congratulations! Your word is a valid English word!"
  #   else
  #     @result = "Sorry but you word cannot be built out of #{params[:letters]}"
  #   end
  # end

  private

  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end
end
