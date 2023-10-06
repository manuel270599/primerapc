class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    # Testeado por -invalid
    if letter.nil? || letter.empty? || !letter.match?(/[a-zA-Z]/)
      raise ArgumentError
    end
    
    # Testeado por -correctly -incorrectly -same letter repeatedly
    letter = letter.downcase

    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    elsif @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end

  def word_with_guesses
    #Testeado por -displayed word with guesses
    display_word = ''
    @word.each_char do |char|
      if @guesses.include?(char)
        display_word += char
      else
        display_word += '-'
      end
    end
    display_word
  end

  def check_win_or_lose
    #Testeado por -game status
    if word.each_char.all? { |char| @guesses.include?(char) }
      return :win
    elsif wrong_guesses.length >= 7
      return :lose
    else 
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end