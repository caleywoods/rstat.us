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
  # * options: options as a Hash.
  #   * verbose: true if verbose mode, otherwise false
  #   * po_root: the root directory of po-files.
  #   * mo_root: the target root directory where the mo-files are stored.
  #   * mo_path_rule: the target directory for each mo-files.
  GetText.create_mofiles({
    :verbose =>  true, #verbosity
    :po_root => 'translations', #po root
    :mo_root => 'locale', #targetdir
  })
end
