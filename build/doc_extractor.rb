



 

class CodeDef
	attr_reader :line_number, :section, :declaration, :description, :name, :todo

	def initialize(line_number, section, declaration, description)
		@line_number = line_number
		@section = section
		@declaration = declaration

		# extract *only* the function name
		function_name_matchdata = / (?<func_identifier>[_A-Za-z0-9:]*)\(/.match(declaration)
		@name = function_name_matchdata[:func_identifier] if !function_name_matchdata.nil?

		@todo = description.match(/TODO[\s\S]*/)
		if @todo.nil?
			@description = description
		else
			@description = description.gsub(@todo.to_s, "") if !@todo.nil?
		end
	end
end




class DocParser
	attr_reader :function_defs, :section_names

	def initialize
		@filename = filename = '../include/allegro_flare/useful_.h'
		@function_defs = Array.new
		parse_contents
	end


	def parse_contents
		# myregex = /\n(?<name>(\n\/\/ (.+))+)(?<funcs>(\n.+)+)/
		myregex = /\n(?<description>(\n\/\/ (.+))+)(?<function_def>(\n.+)+)/

		str = File.read(@filename)

		str.scan(myregex) do |a, b|
			@function_defs.push(CodeDef.new(0, '--', b, a.gsub("// ", "")))
		end
	end


	def write_html

		content = String.new
		content += "<DOCTYPE html>\n<head>\n<link rel='stylesheet' href='docstyle.css'/></head>\n<body>\n\n"
		content += "<H1>AllegroFlare Documentation</H1>\n";

		@function_defs.each do |fdef|
			content += "<h3>#{fdef.name}</h3>\n"
			content += "<code><pre>#{fdef.declaration}</pre></code>\n"
			content += "<p>#{fdef.description}</p>\n"
			content += "<p class='todo'>#{fdef.todo}</p>" if !fdef.todo.nil? 
		end

		content += "\n\n</body>\n"
		File.write('./usefuldoc.html', content)

	end
end



doc_parser = DocParser.new
#puts doc_parser.function_defs.inspect
doc_parser.write_html




