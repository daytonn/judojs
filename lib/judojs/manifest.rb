module Judojs
  module Manifest
    def directories
      %w(application elements lib models modules plugins tests)
    end
    
    module_function :directories
  end
end