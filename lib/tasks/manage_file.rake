namespace :manage_file do
  desc "Clean log files"
  file "clean" do
    require "rake/clean"
    CLEAN.include "log/*.log"
    puts "All log files were cleaned"
  end
end
