require 'colorize'
require './func'

module Menu
   def Menu.title(txt)
      puts "******* #{txt} *******".upcase.yellow
   end

   def Menu.text(txt, type = :default)
      case type
      when :default
         puts "#{txt}"
      when :green
         puts "#{txt}".green
      when :cyan
         puts "#{txt}".cyan
      when :lb
         puts "#{txt}".light_blue
      when :red
         puts "#{txt}".red
      when :retry
         print "#{txt}".yellow
         gets
      end
   end

   def Menu.usr_interact(txt, type)
      print "#{txt}: ".cyan
      input = gets.chomp
      if input.empty?
         return false
      else
         case type
         when :confirm
            Func.get_yes_no(input)
            if Func.get_yes_no(input) # check if true
               return "yes"
            else
               return "no"
            end
         when :change_dir
            Func.change_dir(input)
            if Func.change_dir(input) # check if true
               pretty_dir = "#{input}".yellow
               puts "Directory changed to: #{pretty_dir}"
               return true
            else
               return false
            end
         when :filename
            Func.check_extension(input)
            if Func.check_extension(input) # check if input string contains anything
               return true
            else
               return false
            end
         when :create_files
            classname = Func.get_classname(input)
            if classname
               target_file = Func.create_file(input, :ruby)
               bat_file = Func.create_file(input, :bat)
               if target_file and bat_file
                  puts "'target.rb' and 'run.bat' was successfully created!".green
                  return true
               else
                  dir = Menu.get_curr_dir()
                  puts "target.rb already exists in: #{dir}".red
                  return false
               end
            else
               puts "Classname was empty!".red
            end
         else
            puts "ERROR - no case was entered!".red
         end
      end
   end

   def Menu.clear_screen()
      if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
         system('cls')
      else
         system('clear')
      end
   end

   def Menu.get_curr_dir()
      curr_dir = Func.get_curr_dir
      pretty_dir = "#{curr_dir}".black.on_yellow
      return pretty_dir
   end

   def Menu.succes()
      curr_dir = Menu.get_curr_dir
      Menu.title("success")
      Menu.text("Empty project created in: #{curr_dir}")
   end
end