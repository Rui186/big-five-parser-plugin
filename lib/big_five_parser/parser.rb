module BigFiveParser  
  class Parser
    require 'nokogiri'

    def initialize(file_path, options = {})
      return unless File.file?(file_path)

      @file_path = file_path
      @result = {}
      @result['NAME'] = options[:name] if options[:name].present?
      @result['EMAIL'] = options[:email] if options[:email].present?
    end

    def parse
      return if @file_path.blank?

      file = File.open(@file_path)

      body_content = body_content(file)
      result =  parse_content(body_content)

      file.close

      result
    end

    private

    def body_content(file)
      Nokogiri::HTML(file).text
    end

    def parse_content(content)
      domain = ''

      content.each_line do |line|
        next if line.scan(/\.\d/).blank?

        if match = line.match(/([\D+]+[a-zA-Z])(\.+)([\d+]+)/i)
          item = match.captures[0].squish
          score = match.captures[2]

          if item == item.upcase
            domain = item
            @result[domain] = { 'Overall Score' => score, 'Facets' => {} }
          else
            @result[domain]['Facets'][item] = score
          end
        end
      end

      @result.to_json
    end
  end
end