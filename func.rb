require 'fileutils'
require 'colorize'

module Func
   def Func.get_yes_no(input)
      find_yes = /\A(yes)\z|\A[y]\z/i # finds 'yes' or 'y'
      find_no = /\A(no)\z|\A[n]\z/i # finds 'no' or 'n'
      input.downcase # downcase input to work around uppercase letters
      case input
      when find_yes then
         return true
      when find_no then
         return false
      else
         puts "ERROR - something went wrong inside #{__method__}!".red
      end
   end

   def Func.check_extension(input)
      find_rb = /\.(?:rb)$/ # finds '.rb' at end of string
      find_bat = /\.(?:bat)$/ # finds '.bat' at end of string

      case input
      when find_rb
         return true
      when find_bat
         return true
      else
         puts "ERROR - something went wrong inside #{__method__}!".red
      end
   end

   def Func.get_classname(input)
      input[0] = input.capitalize[0] unless input.nil?
      return input
   end

   def Func.change_dir(chosen_dir)
      check_dir = Func.check_dir_exists(chosen_dir)
      if check_dir # Check if dir exists
         Dir.chdir(chosen_dir)
         return true
      else
         return false
      end
   end

   def Func.create_file(name, type)
      case type
      when :ruby
         classname = Func.get_classname(name)
         lines = [
               "module Target",
               "   class #{classname} < Target_common",
               "",
               "      include Interfaces",
               "      def initialize(tfw)",
               "         @tfw = tfw",
               "      end",
               "",
               "   end",
               "end"
         ]
         if File.exist?("target.rb")
            return false
         else
            File.open("target.rb", "w") {|f| f.write(lines.join("\n"))}
            Func.create_folder()
            return true
         end
      when :bat
         # create bat file
         classname = Func.get_classname(name)
         content = "%PATSRUBY%/bin/ruby %PATSPATH%/test.rb -p . -T #{classname} -s Test_setup"
         if File.exist?("run.bat")
            return false
         else
            File.open("run.bat", "w") {|f| f.write(content)}
            return true
         end
      else
         # fucky wucky
      end
   end

   def Func.get_curr_dir()
      curr_dir = Dir.pwd
      return curr_dir
   end

   def Func.create_folder()
      dir = Func.get_curr_dir()
      check_dir = check_dir_exists("#{dir}/testsuites")
      if check_dir # If 'testsuites' folder exists
         dir_empty = (Dir.entries("#{dir}/testsuites") - %w{ . .. }).empty?
         if dir_empty
            FileUtils::rm_rf("#{dir}/testsuites")
            FileUtils::mkdir("#{dir}/testsuites")
            return true
         elsif !dir_empty
            return false
         end
      else
         FileUtils::mkdir("#{dir}/testsuites")
         return true
      end
   end

   def Func.check_dir_exists(dir)
      if File.exist?(dir)
         return true
      else
         return false
      end
   end
end





