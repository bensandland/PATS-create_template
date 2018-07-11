require './func'
require './menu'

# TODO: create_file function (for target.rb and run.bat) - DONE
# TODO: create_dir function (for testsuites folder) - DONE
# TODO: more 'error handling' - checks for existence of directories, files and folders and create exception-handling
# TODO: implement while loops that reiterate if input is incorrect - DONE

start = true
while start
   Menu.title("pats project creator")
   get_dir = Menu.get_curr_dir
   puts "This your current active directory: #{get_dir}"
   puts "Would you like to change it?".green
   dir_change = Menu.usr_interact(:confirm)

   if dir_change == 1
      start = false
      selecting = true
      while selecting
         Menu.clear_screen()
         Menu.title("change directory")
         puts "Active dir: #{get_dir}"
         check_dir = Menu.usr_interact(:change_dir)
         if check_dir
            Menu.title("create files")
            puts "Please enter the class name to use for target.rb and run.bat"
            classname = Menu.usr_interact(:classname)
            if classname
               Menu.usr_interact(:create_files)
               state = Func.get_state
               if state > 0
                  selecting = false
                  Menu.end(:success)
               else # state is 0 - no files were created
                  selecting = false
                  Menu.end(:inconclusive)
               end
            end
         else
            puts "Directory doesn't exist!".red
            Menu.retry("Press enter to try again..")
            Menu.clear_screen()
         end
      end

   elsif dir_change == 0
      start = false
      selecting = true
      while selecting
         Menu.title("create files")
         puts "Please enter the class name to use for target.rb and run.bat"
         classname = Menu.usr_interact(:classname)
         if classname
            Menu.usr_interact(:create_files)
            state = Func.get_state
            if state > 0
               selecting = false
               Menu.end(:success)
            else # state is 0 - no files were created
               selecting = false
               Menu.end(:inconclusive)
            end
         end
      end
   else
      # This code is only reached if user doesn't type yes/no or y/n
      Menu.text("Invalid input!", :red)
      Menu.retry("Press enter to try again...")
      Menu.clear_screen()
   end
end






