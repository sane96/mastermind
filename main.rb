class Game

    def initialize
        puts "Welcome to the Mastermind Game!"
        self.color_pick
        puts "Please enter your name: "
        @player = gets.chomp
        puts "Hi #{@player}, you have to select which of these colors"

        @turns = 12
        self.player_plays
        
    end        

    def color_pick
        @@colors = ['red', 'blue', 'green', 'yellow', 'purple', 'orange']
        @code = ['1', '1', '1', '1'].map{|color| color = @@colors[rand(6)]}
        p @code
    end
    
    def player_plays
        puts "#{@turns} #{@turns == 1 ? 'turn' : 'turns'} remain"
        @player_input = gets.chomp.downcase.split(' ')
        p @player_input

        if @player_input.all?{ |str| @@colors.any?{ |color| str == color}}
            @turns -= 1
            self.response
        else
            type_again = @player_input.select{|clr| @@colors.none?{ |color| color == clr}}
            puts "Oops seems like you have a typo: #{type_again.join(' | ')}"
            puts "Guess colors again.."
            self.player_plays            
        end
    end    

    def response  
        if @player_input == @code 
            puts "Game over, #{@player} wins!"
            puts "Do you want to play again? Y / n"
            self.reset
            puts "Thank you for playing with us #{@player}, have a nice day"
        elsif @turns == 0 
            puts "Game over, computer wins!"
            puts "Do you want to play again? Y / n"
            self.reset
            puts "Thank you for playing with us #{@player}, have a nice day"
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
            


           
            p info_arr.sort
            
            self.player_plays
        end    
    end  
    
    def reset
        answer = gets.chomp.downcase 
        if answer == "y" || answer == ""
            self.initialize
        elsif answer == "n" 
            return
        else 
            "Please enter Y / n"
            self.reset
        end
    end    

end    

game = Game.new