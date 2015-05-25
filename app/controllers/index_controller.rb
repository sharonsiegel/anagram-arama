require 'sinatra' 

def distinct_letters?(input)
    letter_array = input.chars
    unique_letters = input.split("").uniq
    if unique_letters.length < letter_array.length
        false
    else
        true
    end
end

def valid_input?(input)
    if input.length < 2
        raise Exception.new("Word must be between 2 to 3 characters.")
    end
end

get '/' do
    erb :index
end

get '/anagrams/:text' do
    @word = params[:text]
    @anagrams = Word.find_anagram(@word)
    erb :show
end

post '/' do
    @word = params[:word]
    begin
        valid_input?(@word)
        redirect "/anagrams/#{@word}"
    rescue Exception => error
        @error = error.message
        erb :index
    end
end
