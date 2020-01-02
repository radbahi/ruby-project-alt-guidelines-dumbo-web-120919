require_relative '../config/environment'
require "tty-prompt"
require "colorize"
require 'colorized_string'
prompt = TTY::Prompt.new
cursor = TTY::Cursor
ActiveRecord::Base.logger.level = 1 # or Logger::INFO

system 'clear'
hitsounds = ["hitsounds/hit1.wav","hitsounds/hit2.wav","hitsounds/hit3.wav","hitsounds/hit4.wav","hitsounds/hit5.wav","hitsounds/hit6.wav","hitsounds/hit7.wav","hitsounds/hit8.wav","hitsounds/hit9.wav","hitsounds/hit10.wav","hitsounds/hit11.wav","hitsounds/hit12.wav","hitsounds/hit13.wav"]
fork { exec 'afplay', "music/AnnouncerSayingSuperSmashBros.mp3"}
puts "                    ███████╗██╗   ██╗██████╗ ███████╗██████╗       
                    ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗      
                    ███████╗██║   ██║██████╔╝█████╗  ██████╔╝      
                    ╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗      
                    ███████║╚██████╔╝██║     ███████╗██║  ██║      
                    ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝ ".colorize(:red)
 sleep(1.5)                                                                      
puts "                    ███████╗███╗   ███╗ █████╗ ███████╗██╗  ██╗    
                    ██╔════╝████╗ ████║██╔══██╗██╔════╝██║  ██║    
                    ███████╗██╔████╔██║███████║███████╗███████║    
                    ╚════██║██║╚██╔╝██║██╔══██║╚════██║██╔══██║    
                    ███████║██║ ╚═╝ ██║██║  ██║███████║██║  ██║    
                    ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝".colorize(:red)
sleep(2.2)       
                                                                      
puts "                    ██████╗ ██████╗  ██████╗ ███████╗              
                    ██╔══██╗██╔══██╗██╔═══██╗██╔════╝              
                    ██████╔╝██████╔╝██║   ██║███████╗              
                    ██╔══██╗██╔══██╗██║   ██║╚════██║              
                    ██████╔╝██║  ██║╚██████╔╝███████║██╗           
                    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝".colorize(:red)
puts"               Made by Radouane Bahi. Please don't sue me, Nintendo.".colorize(:yellow)                
sleep(3)
gameStatus = true
while gameStatus do 
    matchStatus = false
    fighterOne = nil
    fighterTwo = nil
    match = nil
    if matchStatus == false
        fighterOne = Fighter.create(name: Faker::Games::SuperSmashBros.unique.fighter)
        fighterTwo = Fighter.create(name: Faker::Games::SuperSmashBros.unique.fighter)
        Faker::UniqueGenerator.clear
        match = Match.create(fighter_one: fighterOne.name, fighter_two: fighterTwo.name)
        bettersThisMatch = []
        fork { exec 'afplay', "music/MatchTheme.mp3"}
        puts "It is time to schedule the next match!"
        while true do
            sleep(3)                                                            
            puts "This match will pin #{fighterOne.name.colorize(:light_blue)} against #{fighterTwo.name.colorize(:yellow)}! Who will come out on top?"
            better = Better.create()
            better.bet_match = match.id
            better.name = prompt.ask("Fancy a wager? Enter your name to continue:", required: true)
            dupeCheck = Better.find_by(name: better.name)
            fighterChoices = {fighterOne.name => fighterOne, fighterTwo.name => fighterTwo}
            if dupeCheck
                nameInput = prompt.select("Welcome back, #{better.name}. Bet on your fighter!", fighterChoices)
            else
                nameInput = prompt.select("Welcome, #{better.name}. Bet on your fighter!", fighterChoices)
            end
            better.bet_on = nameInput
            betInput = prompt.ask("Enter your bet amount:")
            while betInput.to_f == 0.0
                betInput = prompt.ask("ERROR: That's not a valid amount. Please enter your bet amount:")
            end
            better.bet_amount = betInput
            bettersThisMatch << better
            better.save
            myFighter = nameInput
            myFighter.bet_pot = better.bet_amount + myFighter.bet_pot
            myFighter.save
            fighterOne = Fighter.find(fighterOne.id)
            fighterTwo = Fighter.find(fighterTwo.id)
            puts "#{better.name} bet #{better.bet_amount} on #{myFighter.name}!"
            puts "#{fighterOne.name.colorize(:light_blue)} now has a total of $#{fighterOne.bet_pot.to_s.colorize(:light_magenta)} and #{fighterTwo.name.colorize(:yellow)} now has a total of $#{fighterTwo.bet_pot.to_s.colorize(:light_magenta)}."
            match.bet_pool = fighterOne.bet_pot + fighterTwo.bet_pot
            winnerPayout = match.bet_pool / bettersThisMatch.length
            puts "The total pot of this match is now at $#{match.bet_pool.to_s.colorize(:light_magenta)}"
            moreBetters =  prompt.select("Anyone else wanna put their money on the line?", %w(Yes No))
            print cursor.clear_lines(9, :up)
            if moreBetters == "No"
                system 'clear'
                matchStatus = true
                fork { exec 'afplay', "music/AnnouncerSayingReadyGo.mp3"}
                puts "
                    ██████╗ ███████╗ █████╗ ██████╗ ██╗   ██╗██████╗ 
                    ██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝╚════██╗
                    ██████╔╝█████╗  ███████║██║  ██║ ╚████╔╝   ▄███╔╝
                    ██╔══██╗██╔══╝  ██╔══██║██║  ██║  ╚██╔╝    ▀▀══╝ 
                    ██║  ██║███████╗██║  ██║██████╔╝   ██║     ██╗   
                    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝    ╚═╝     ╚═╝   
                                                                 ".colorize(:yellow)
                sleep(1)
                system 'clear'
                puts " 
                    ██████╗  ██████╗  ██╗
                    ██╔════╝ ██╔═══██╗██║
                    ██║  ███╗██║   ██║██║
                    ██║   ██║██║   ██║╚═╝
                    ╚██████╔╝╚██████╔╝██╗
                     ╚═════╝  ╚═════╝ ╚═╝".colorize(:green)
                sleep(1)
                puts "#{fighterOne.name.colorize(:light_blue)} and #{fighterTwo.name.colorize(:yellow)} lunge at each other!"
                multibar = TTY::ProgressBar::Multi.new
                fighterOneHealthBar = multibar.register("#{fighterOne.name.colorize(:light_blue)}'s health [:bar]", total: 101)
                fighterTwoHealthBar = multibar.register("#{fighterTwo.name.colorize(:yellow)}'s health [:bar]", total: 101)
                fighterTwoHealthBar.current = 100
                fighterOneHealthBar.current = 100
                sleep(2)
                break
            end
        end
    end
    while matchStatus do
        fighterOneDamage = rand(0...20)
        fighterTwoDamage = rand(0...20)
        fighterOne.health = fighterOne.health - fighterTwoDamage
        fighterTwo.health = fighterTwo.health - fighterOneDamage
        fighterOneHealthProgress = Thread.new { fighterOneHealthBar.advance(-fighterTwoDamage) }
        fighterTwoHealthProgress = Thread.new { fighterTwoHealthBar.advance(-fighterOneDamage) }
        [fighterOneHealthProgress, fighterTwoHealthProgress].each { |t| t.join }
        fork { exec 'afplay', hitsounds.sample}
        print "#{fighterOne.name.colorize(:light_blue)} does #{fighterOneDamage.to_s.colorize(:red)} damage to #{fighterTwo.name.colorize(:yellow)}!\n"
        sleep(1)
        fork { exec 'afplay', hitsounds.sample}
        print "#{fighterTwo.name.colorize(:yellow)} does #{fighterTwoDamage.to_s.colorize(:red)} damage to #{fighterOne.name.colorize(:light_blue)}!\n"
        sleep(1)
        print "#{fighterOne.name.colorize(:light_blue)} now has #{fighterOne.health.to_s.colorize(:green)} health! #{fighterTwo.name.colorize(:yellow)} now has #{fighterTwo.health.to_s.colorize(:green)} health!\n"
        sleep(2)
        print cursor.clear_lines(4, :up)
        if fighterOne.health <= 0 && fighterTwo.health <= 0 
            match.winner = "Tie"
            match.loser = "Tie"
            fork { exec 'afplay', "hitsounds/die1.wav"}
            puts "And down they both go!"
            fork { exec 'afplay', "hitsounds/die2.wav"}
            sleep(2)
            break
        end
        if fighterOne.health <= 0
            match.winner = fighterOne.name
            match.loser = fighterTwo.name
            fork { exec 'afplay', "hitsounds/die1.wav"}
            puts "#{fighterOne.name.colorize(:light_blue)} goes down!"
            sleep(2)
            break
        end
        
        if fighterTwo.health <= 0
            match.winner = fighterTwo.name
            match.loser = fighterOne.name
            fork { exec 'afplay', "hitsounds/die1.wav"}
            puts "#{fighterTwo.name.colorize(:yellow)} goes down!"
            sleep(2)
            break
        end
    end
    system 'clear'
    fork { exec 'afplay', "music/AnnouncerSayingGame.mp3"}
    puts "
     ██████╗  █████╗ ███╗   ███╗███████╗██╗
    ██╔════╝ ██╔══██╗████╗ ████║██╔════╝██║
    ██║  ███╗███████║██╔████╔██║█████╗  ██║
    ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ╚═╝
    ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██╗
     ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝".colorize(:red)
    fighterOneHealthBar
    fighterTwoHealthBar
    sleep(2)
    if fighterOne.health <= 0 && fighterTwo.health <= 0
        fork { exec 'afplay', "music/AnnouncerSayingNoContest.mp3"}
        puts "Match draw! Any money you have bet for this match should be refunded to you!"
    else
        
        fork { exec 'afplay', "music/AnnouncerSayingTheWinnerIs.mp3"}
        fork { exec 'afplay', "music/WinnerMusic.mp3"}
        puts "The winner is..."
        sleep(2)
        puts "#{match.winner.colorize(:red)}!"
        sleep(2)
        puts "Anyone who bet on the winner gets a payout in the amount of $#{winnerPayout.round(2)}!"
    end
    nextMatch =  prompt.select("Would you like to move on to the next match?", %w(Yes No))
    system 'clear'
puts "                    ███████╗██╗   ██╗██████╗ ███████╗██████╗       
                    ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗      
                    ███████╗██║   ██║██████╔╝█████╗  ██████╔╝      
                    ╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗      
                    ███████║╚██████╔╝██║     ███████╗██║  ██║      
                    ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝ ".colorize(:red)                                                                      
puts "                    ███████╗███╗   ███╗ █████╗ ███████╗██╗  ██╗    
                    ██╔════╝████╗ ████║██╔══██╗██╔════╝██║  ██║    
                    ███████╗██╔████╔██║███████║███████╗███████║    
                    ╚════██║██║╚██╔╝██║██╔══██║╚════██║██╔══██║    
                    ███████║██║ ╚═╝ ██║██║  ██║███████║██║  ██║    
                    ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝".colorize(:red)   
puts "                    ██████╗ ██████╗  ██████╗ ███████╗              
                    ██╔══██╗██╔══██╗██╔═══██╗██╔════╝              
                    ██████╔╝██████╔╝██║   ██║███████╗              
                    ██╔══██╗██╔══██╗██║   ██║╚════██║              
                    ██████╔╝██║  ██║╚██████╔╝███████║██╗           
                    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝".colorize(:red)
puts"                Made by Radouane Bahi. Please don't sue me, Nintendo.".colorize(:yellow)                                           
    if nextMatch == "No"
    Better.destroy_all
    system 'clear'
    puts "
        ███        ▄█    █▄       ▄████████ ███▄▄▄▄      ▄█   ▄█▄    ▄████████ 
    ▀█████████▄   ███    ███     ███    ███ ███▀▀▀██▄   ███ ▄███▀   ███    ███ 
       ▀███▀▀██   ███    ███     ███    ███ ███   ███   ███▐██▀     ███    █▀  
        ███   ▀  ▄███▄▄▄▄███▄▄   ███    ███ ███   ███  ▄█████▀      ███        
        ███     ▀▀███▀▀▀▀███▀  ▀███████████ ███   ███ ▀▀█████▄    ▀███████████ 
        ███       ███    ███     ███    ███ ███   ███   ███▐██▄            ███ 
        ███       ███    ███     ███    ███ ███   ███   ███ ▀███▄    ▄█    ███ 
       ▄████▀     ███    █▀      ███    █▀   ▀█   █▀    ███   ▀█▀  ▄████████▀  ".colorize(:yellow)
    sleep(0.5)
    puts "
    ▄████████  ▄██████▄     ▄████████                                       
    ███    ███ ███    ███   ███    ███                                       
    ███    █▀  ███    ███   ███    ███                                       
   ▄███▄▄▄     ███    ███  ▄███▄▄▄▄██▀                                       
  ▀▀███▀▀▀     ███    ███ ▀▀███▀▀▀▀▀                                         
    ███        ███    ███ ▀███████████                                       
    ███        ███    ███   ███    ███                                       
    ███         ▀██████▀    ███    ███                                       
                            ███    ███".colorize(:yellow)
    sleep(0.5)
    puts "
    ▄███████▄  ▄█          ▄████████ ▄██   ▄    ▄█  ███▄▄▄▄      ▄██████▄   
    ███    ███ ███         ███    ███ ███   ██▄ ███  ███▀▀▀██▄   ███    ███  
    ███    ███ ███         ███    ███ ███▄▄▄███ ███▌ ███   ███   ███    █▀   
    ███    ███ ███         ███    ███ ▀▀▀▀▀▀███ ███▌ ███   ███  ▄███         
  ▀█████████▀  ███       ▀███████████ ▄██   ███ ███▌ ███   ███ ▀▀███ ████▄   
    ███        ███         ███    ███ ███   ███ ███  ███   ███   ███    ███  
    ███        ███▌    ▄   ███    ███ ███   ███ ███  ███   ███   ███    ███  
   ▄████▀      █████▄▄██   ███    █▀   ▀█████▀  █▀    ▀█   █▀    ████████▀   ██ ██ ██".colorize(:yellow)
    sleep(3)
    puts "
    ▄████████ ███    █▄   ▄████████    ▄█   ▄█▄    ▄████████    ▄████████   
    ███    ███ ███    ███ ███    ███   ███ ▄███▀   ███    ███   ███    ███   ████
    ███    █▀  ███    ███ ███    █▀    ███▐██▀     ███    █▀    ███    ███   ████
    ███        ███    ███ ███         ▄█████▀     ▄███▄▄▄      ▄███▄▄▄▄██▀   ████
  ▀███████████ ███    ███ ███        ▀▀█████▄    ▀▀███▀▀▀     ▀▀███▀▀▀▀▀     ████
           ███ ███    ███ ███    █▄    ███▐██▄     ███    █▄  ▀███████████   ████
     ▄█    ███ ███    ███ ███    ███   ███ ▀███▄   ███    ███   ███    ███   ▀██▀
   ▄████████▀  ████████▀  ████████▀    ███   ▀█▀   ██████████   ███    ███   
                                       ▀                        ███    ███    ██".colorize(:red)
   sleep(1.5)
   system 'clear'
    exit
    end
end


# CHECK GEMFILE TO SEE WHAT GEMS I INSTALLED