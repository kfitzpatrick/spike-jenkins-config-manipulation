require 'nokogiri'

class JenkinsJobConfig
  
  def initialize(template_xml)
    @template = template_xml
  end
  
  def render
    document = Nokogiri::XML(@template)
    document = add_postscript(document)
    document.to_xml    
  end
  
  private
  
  def add_postscript(document)
    return document unless document.at_css('postscript').nil?
    root = document.root
    postscript_node = Nokogiri::XML::Node.new "postscript", document
    postscript_node.content = "Love you!"
    root.add_child postscript_node
    document
  end
  
end