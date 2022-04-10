class Game

    def initialize
        puts "Welcome to the Mastermind Game!"
        self.color_pick
        puts "Please enter your name: "
        @player = gets.chomp
        puts "Hi #{@player}, pick colors and their order by typing the color name and separate them with 1 space"
        puts "For example: green green red yellow"
        puts "Colors available are red, blue, green, yellow, purple, orange"
        puts "If you guessed correctly both position and color in the code you will get return value 2,"
        puts "if only the color was guessed correctly the number will be 1 and 0 means you guessed wrong color"
        puts "Order of return values is always ascending"
        puts "Type any key to start the game:"
        gets
        @turns = 12
        p @code
        self.play
        
    end        

    def color_pick
        @@colors = ['red', 'blue', 'green', 'yellow', 'purple', 'orange']
        @code = ['1', '1', '1', '1'].map{|color| color = @@colors[rand(6)]}
    end
    
    def play
        puts "#{@turns} #{@turns == 1 ? 'turn' : 'turns'} remain"
        puts "Please type in your code:"
        @player_input = gets.chomp.downcase.split(' ')
        if(@player_input == "")
            puts "Please type in the colors"
            self.play
        end
        self.check_spelling(@player_input)
    end    

    def check_spelling(input)
        if input.all?{ |str| @@colors.any?{ |color| str == color}}
            @turns -= 1
            self.response
        else
            type_again = input.select{|clr| @@colors.none?{ |color| color == clr}}
            puts "Oops, seems like you have a typo: #{type_again.join(' | ')}"
            self.play            
        end
    end

    def response  
        if @player_input == @code 
            puts "Game over, #{@player} wins!"
            self.reset     
        elsif @turns == 0 
            puts "Game over, computer wins!"
            self.reset
        else 
            info_arr = []
            counter2 = []
            counter1 = []
            counter0 = []
            @player_input.each_with_index do |color, i|  
                if color == @code[i] 
                    counter2.push(i)
                    info_arr.push(2)
                end
            end 

            @player_input.each_with_index do |color, i|
                if counter2.any?{|y| i == y} || 
                   counter1.any?{|y| i == y} ||
                   counter0.any?{|y| i == y} 
                    next 
                end

                if color == @code.any?{|clr| clr == color}
                    counter = @player_input.each_index.select do |x| 
                        if counter2.any?{|y| x == y} || 
                           counter1.any?{|y| x == y} ||
                           counter0.any?{|y| x == y}
                           next 
                        end
                        color == @player_input[x]
                    end                   
                    counter_code = @code.each_index.select{|x| @code[x] == color}.size

                    correct_num = counter.size - counter_code
                    if correct_num <= 0
                        counter.size.times {info_arr.push(1)}
                        counter1.push(counter).flatten
                    else
                        counter_code.times {info_arr.push(1)}
                        correct_num.times {info_arr.push(0)}
                        for k in 0..counter_code do
                            counter1.push(counter[k])
                        end
                        for v in 0..correct_num do
                            counter0.push(counter[v])
                        end
                    end
                else
                    info_arr.push(0)
                    counter0.push(i)
                end
            end
            


           
            puts info_arr.sort.join(' ')
            
            self.play
        end    
    end  
    
    def reset
        puts "Do you want to play again? Y / n"
        answer = gets.chomp.downcase 
        if answer == "y" || answer == ""
            self.initialize
        elsif answer == "n" 
            puts "Thank you for playing with us #{@player}, have a nice day"
            return
        else 
            "Please enter Y / n"
            self.reset
        end
    end    

end    

game = Game.new