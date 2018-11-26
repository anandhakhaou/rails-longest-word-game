require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

# require 'open-uri'
# require 'json'

# class GamesController < ApplicationController
#   def new
#     @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }
#   end

#   def score
#     @word = params[:word]
#     url = 'https://wagon-dictionary.herokuapp.com/:word' + @word
#     serialized = open(url).read
#     json_response = JSON.parse(serialized)
#     # binding.pry
#     # raise
#   end

#   def included?(guess, grid)
#     guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
#   end

#   def english_word?(word)
#     response = open("https://wagon-dictionary.herokuapp.com/#{word}")
#     json = JSON.parse(response.read)
#     return json['found']
#   end
# end
