class JuscrConfigParser
  
  attr_reader :compress, :files
  
  def initialize(config_file)
    begin
      raise IOError, "#{config_file} does not exist", caller unless File.exists? config_file
      @compress = false
      @files = Array.new
      lines = IO.readlines config_file
      lines.each do |line|
        if line =~ /compress\:\s*/
          compress_value = line.gsub(/compress\:\s*/, '').strip
          @compress = compress_value == 'true' ? true : false
        else
          line.gsub!(/\s*/, '')
          @files.push line unless line.length < 1
        end
      end
    rescue IOError => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
end