class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  class String
    def is_upper?
      !!self.match(/\p{Upper}/)
    end

    def is_lower?
      !!self.match(/\p{Lower}/)
      # or: !self.is_upper?
    end
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess char
    if char == nil
      throw ArgumentError
    end
    if char == '' 
      throw ArgumentError
    end
    if !char.match(/^[[:alpha:]]$/)
      throw ArgumentError
    end
    if @guesses.include? char or @guesses.include? char.downcase
      return false
    end
    if @wrong_guesses.include? char or @wrong_guesses.include? char.downcase
      return false
    end
    if @word.include? char
        @guesses += char
        outcome = check_win_or_lose
        if check_win_or_lose == :win
          return :win
        end
        return true
      else
        @wrong_guesses += char
      end
  end

  def word_with_guesses
    matched = ''
    wordlist = @word.split('')
    wordlist.each do |char|
      if @guesses.include? char
        matched += char
      else
        matched += '-'
      end
    end
    return matched
  end

  def check_win_or_lose
    wordlist = word.split('')
    matched = ''
    wordlist.each do |char|
      if @guesses.include? char
        matched += char
      else
        matched+= '-'
      end
    end
    if !matched.include? '-'
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
