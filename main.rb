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

        if @player_input.all?{ |str| @@colors.any?{ |color| str == color}}
            @turns -= 1
            self.response
        else
            type_again_index = @player_input.each_index.select{|i| @code.any?{ |color| color == @player_input[i]}}
            type_again = type_again_index.map{ |typo| @player_input[typo]}
            puts "Oops seems like you have a typo: #{type_again.join(' | ')}"
            puts "Enter colors again.."
            self.player_plays            
        end
    end    

    def response  
        if @player_input == @color_code 
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
            self.reset
            counter = {}
            @player_input.each do |color|
                counter[color] = [] unless counter[color] 
            end
            info_arr1 = @player_input.map.with_index do |color, i|  
                color = color == @code[i] ? 2 : color
            end
            puts info_arr1
            # info_arr2 = info_arr1.map do |color|
            #     unless color.class == 'String'
            #         color
            #     end
            #     duplicate =  @code.each_index.select{ |clr| clr == color}   
            #     for i in 0..duplicate.length-1 do

            #         if  counter[color].any?{|color| color == duplicate[i]}
            #             counter[color].push(duplicate[i]) 
            #             color = 1
            #         else 
            #             color = 0
            #         end
            #     end
            # end       
            p info_arr2.sort
            
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