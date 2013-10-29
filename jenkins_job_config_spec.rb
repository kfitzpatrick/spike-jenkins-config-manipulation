require "minitest/autorun"
require_relative 'jenkins_job_config'

describe JenkinsJobConfig do

  describe 'adds postscript' do
    
    it "adds a postscript node with 'I love you' to things that don't have it" do
      xml = <<-XML
      <?xml version="1.0"?>
      <note>
          <body>Don't forget me this weekend!</body>
      </note>
      XML
      rendered = JenkinsJobConfig.new(xml).render 
      postscript_node = Nokogiri::XML(rendered).at_css("note postscript")
      postscript_node.wont_be_nil
      postscript_node.content.must_equal "Love you!"
    end
    
    it 'only adds the postscript if necessary' do
      xml = <<-XML
      <?xml version="1.0"?>
      <note>
          <body>Don't forget me this weekend!</body>
          <postscript>Foo</postscript>
      </note>
      XML
      rendered = JenkinsJobConfig.new(xml).render 
      postscript_nodes = Nokogiri::XML(rendered).css("note postscript")
      postscript_nodes.length.must_equal 1
    end
  end
    
end

