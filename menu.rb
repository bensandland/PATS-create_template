require 'colorize'
require './func'

module Menu
   def Menu.title(txt)
      puts "******* #{txt} *******".upcase.yellow
   end

   def Menu.retry(txt)
      print "#{txt}".light_cyan
      gets
   end

   def Menu.usr_interact(type)
      case type
      when :confirm
         input = Menu.get_usrinteract_input("Y/N")
         if input
            return Func.get_yes_no(input)
         end

      when :change_dir
         input = Menu.get_usrinteract_input("Enter directory")
         if input
            return Func.change_dir(input)
         end

      when :classname
         input = Menu.get_usrinteract_input("Class name")
         if input
            Func.set_classname = input
         end

      when :create_files
         classname = Func.get_classname()
         testsuite_folder = Func.create_folder()
         if testsuite_folder
            puts "'testsuites' folder successfully created!".green
         else
            puts "non-empty 'testsuites' folder already exists! - skipping...".yellow
         end

         if !Func.check_existence("target.rb") # target.rb doesn't exist
            Func.create_file(classname, :ruby)
            puts "'target.rb' was successfully created!".green
            Func.incr_state
         else
            puts "'target.rb' already exists! - skipping...".yellow
         end

         if !Func.check_existence("run.bat") # run.bat doesn't exist
            Func.create_file(classname, :bat)
            puts "'run.bat' was successfully created!".green
            Func.incr_state
         else
            puts "'run.bat' already exists! - skipping...".yellow
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

   def Menu.end(type)
      case type
      when :success
         curr_dir = Menu.get_curr_dir
         Menu.title("success")
         Menu.text("Project created in: #{curr_dir}")
      when :inconclusive
         Menu.title("completed")
         puts "No files were created - try validating your selected directory"
      end
   end

   def Menu.get_usrinteract_input(txt)
      print "#{txt}: ".cyan
      input = gets.chomp
      if input.empty?
         return false
      else
         return input
      end
   end
end