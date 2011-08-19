require "rubygems"
require "zip/zipfilesystem"

module Redcar
  module XulrunnerWin
    def self.ensure_unpacked
      return if File.exist?(path)
      
      print "unzipping #{path}..."; $stdout.flush
      Dir.chdir(vendor_dir) do
        Zip::ZipFile.open(zip_path) do |zipfile|
          zipfile.entries.each do |entry|
            FileUtils.mkdir_p(File.dirname(entry.name))
            begin
              entry.extract
            rescue Zip::ZipDestinationFileExistsError
            end
          end
        end
      end
    end
    
    def self.vendor_dir
      File.dirname(zip_path)
    end
    
    def self.zip_path
      glob = File.expand_path("../../vendor/xulrunner-*.zip", __FILE__)
      Dir[glob].first
    end
    
    def self.path
      File.expand_path("../../vendor/xulrunner", __FILE__)
    end
  end
end
