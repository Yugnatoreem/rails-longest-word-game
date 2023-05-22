require "open-uri"

class GamesController < ApplicationController
  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(',')

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    result_serialized = URI.open(url).read
    @result = JSON.parse(result_serialized)

    if @result['found']
      array_true = @word.chars.map { |letter| @word.upcase.count(letter.upcase) <= @letters.count(letter.upcase) }
      if array_true.count(true) == array_true.size
        @response = 'Well done'
      else
        @response = 'Not in the grid'
      end
    else
      @response = 'Not an english word'
    end
  end
end
