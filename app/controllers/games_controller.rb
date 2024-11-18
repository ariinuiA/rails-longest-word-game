require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters.append(('a'..'z').to_a.sample.upcase)
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(',')
    url = "https://dictionary.lewagon.com/#{@word}"
    serialized_word = URI.parse(url).read
    @jword = JSON.parse(serialized_word)
    @test = word_in_grid?(@jword, @letters)
  end

  def word_in_grid?(word, grid)
    letters = word["word"]
    return letters.upcase.chars.all? { |letter| letters.upcase.count(letter) <= grid.count(letter) }
  end

  # def get_score(word, grid, time)
  #   # Return score of player
  #   user_word = word_in_grid?(word, grid)
  #   return 0 if (word["found"] == false) || (user_word == false)
  #   if word["word"].length > 3
  #     return time > 10 ? 10 : 20
  #   else
  #     return time > 10 ? 5 : 8
  #   end
  # end

  # def get_message(word, grid, score)
  #   # Return message depending on player performance
  #   user_word = word_in_grid?(word, grid)
  #   if user_word == false
  #     return "not in the grid"
  #   elsif score.zero?
  #     return "not an english word"
  #   elsif score.positive?
  #     return "well done"
  #   end
  # end

  # def run_game(attempt, grid, start_time, end_time)
  #   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
  #   url = "https://dictionary.lewagon.com/#{attempt}"
  #   serialized_word = URI.parse(url).read
  #   word = JSON.parse(serialized_word)
  #   time = end_time - start_time
  #   score = get_score(word, grid, time)
  #   message = get_message(word, grid, score)
  #   result = { score: score, message: message, time: time }
  #   return result
  # end
end
