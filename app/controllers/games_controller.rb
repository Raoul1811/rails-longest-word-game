require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    letters = ('A'..'Z').to_a
    @game = letters.sample(10)
  end

  def in_grid(letters, guess)
    let_arr = @letters.split(" ")
    stupid = true
    guess.split('').each do |let|
      if !let_arr.include?(let)
        stupid = false
      end
    end
    stupid
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    stupid = in_grid(@letters, @guess)

    if user["found"] == true && stupid == true
      @message = "Your'e amazing I wanna be you"
    elsif stupid == false
      @message = "That cant be made out of those ltters dummy!!!"
    else
      @message = "That's not english stoooooopid"
    end
  end

  

  # @guess.select {|letter| letter.include? @game}
end
