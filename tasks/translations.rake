desc "Update pot/po files."
task :updatepo do
  require 'sinatra-hat'
  require 'gettext/haml_parser'
  require 'gettext/tools'
  GetText.update_pofiles(
    "rstat.us", #domain
    Dir.glob("{lib,views}/**/*.{rb,haml}") << "rstatus.rb", #files to scan
    "rstat.us 1.0.0", #version 
    :po_root => 'translations'
  )
end

task :makemo do
  require 'gettext/tools'
  GetText.create_mofiles(
    true, #verbosity
    'translations', #po root
    'locale', #targetdir
  )
end
