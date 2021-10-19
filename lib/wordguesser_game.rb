class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service


  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :correct_list
  attr_accessor :wrong_list
  attr_accessor :word_with_guesses
  attr_accessor :wrong_count 
  attr_accessor :check_win_or_lose

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @correct_list = ""
    @wrong_list = ""
    @word_with_guesses = ""
    @wrong_count = 0
    @check_win_or_lose = :play
    for i in 1..word.length
	    word_with_guesses.concat('-')
    end
  end

  def is_alpha(c)
	  if (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')
		  return true
	  else 
		  return false
	  end
  end 
 
  def guess(alpha)
    if alpha == nil || !is_alpha(alpha)
	    raise ArgumentError
    elsif alpha >= 'A' && alpha <= 'Z'
	    return false
    else
    	if word.index(alpha) != nil
    		if correct_list.index(alpha) == nil
    			@guesses = alpha
    			@correct_list.concat(alpha)
    			for i in 0..word.length-1
    				if word[i] == alpha
    					@word_with_guesses[i] = alpha
    				end
    			end
    			if word_with_guesses.index('-') == nil
    				@check_win_or_lose = :win
    			end
    		else
    			return false
    		end
    	else
    		if wrong_list.index(alpha) == nil
    			@wrong_guesses = alpha
    			@wrong_list.concat(alpha)
    			@wrong_count = @wrong_count + 1
    			if wrong_count >= 7
    				@check_win_or_lose = :lose
    			end
    		else
    			return false
    		end
      end
    end
  end 

  def is_win()
    if check_win_or_lose == :win
      return true
    end
  end

  def is_lose()
    if check_win_or_lose == :win
      return true
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
