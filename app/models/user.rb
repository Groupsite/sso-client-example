require "net/https"
require "uri"
require "rexml/document"

class User < ActiveRecord::Base
  
  API_KEY = "CEE5CAED-366A-4D9D-9ED3-96419F65228B"
  API_URL = "https://bioworksplace.gs.com"
  
  after_create :add_sync
  after_update :update_sync
  
  def add_sync
    sync("add")
  end
  
  def update_sync
    sync("update")
  end

  def sync(method)
    uri = URI.parse("#{API_URL}/sync/#{method}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/xml"
    request["X-CollectiveX-API"] = API_KEY
    request.body = to_record_xml

    response = http.request(request)
    
    logger.info response.body
    
    if response.code == "200"
      doc = REXML::Document.new(response.body)
      if doc.root.attributes["status"] != "success"
        doc.elements.collect("result/error") do |el|
          errors.add_to_base el.text
        end
        raise "Failed to Sync"
      end
    else
      logger.error response.body
      raise "Failed to Sync, Response Code #{response.code}"
    end
  end
  
  def to_record_xml
    builder = Builder::XmlMarkup.new :indent => 2
    builder.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    builder.record(:type => "Member", :xuid => id) do |xml|
      xml.attribute(email, :name => "primary_email")
      xml.attribute(first_name, :name => "first_name")
      xml.attribute(last_name, :name => "last_name")
      xml.attribute(gender, :name => "gender")
      xml.attribute("Easter Time (US & Canada)", :name => "timezone")
      xml.attribute(city, :name => "city")
      xml.attribute(state, :name => "state")
      xml.attribute("United States", :name => "country")
      xml.attribute(zip, :name => "postal_code")
    end
  end
  
end
