require './func'
require './menu'

# TODO: create_file function (for target.rb and run.bat) - DONE
# TODO: create_dir function (for testsuites folder) - DONE
# TODO: more 'error handling' - checks for existence of directories, files and folders
# TODO: implement while loops that reiterate if input is incorrect - DONE
start = true
while start
   Menu.title("pats project creator")
   get_dir = Menu.get_curr_dir
   puts "This your current active directory: #{get_dir}"
   Menu.text("Would you like to change it?", :green)
   dir_change = Menu.usr_interact("Y/N", :confirm)

   if dir_change == "yes"
      start = false
      selecting = true
      while selecting
         Menu.clear_screen()
         Menu.title("change directory")
         Menu.text("Active dir: #{get_dir}")
         check_dir = Menu.usr_interact("Enter directory", :change_dir)
         if check_dir
            Menu.title("create files")
            Menu.text("Please enter the name to use for class of target.rb file")
            files = Menu.usr_interact("target.rb classname", :create_files)
            if files
               selecting = false
               Menu.succes()
            end
         else
            Menu.text("Directory doesn't exist!", :red)
            Menu.text("Press enter to try again..", :retry)
            Menu.clear_screen()
         end
      end

   elsif dir_change == "no"
      start = false
      selecting = true
      while selecting
         Menu.title("create files")
         Menu.text("Please enter the name to use for class of target.rb file")
         files = Menu.usr_interact("target.rb classname", :create_files)
         if files
            selecting = false
            Menu.succes()
         else
            Menu.text("Name was empty!", :red)
            Menu.text("Press enter to try again..", :retry)
         end
      end
   end
   # This code is only reached if user doesn't type yes/no or y/n
   Menu.text("Invalid input!", :red)
   Menu.text("Press enter to try again...", :retry)
   Menu.clear_screen()
end




