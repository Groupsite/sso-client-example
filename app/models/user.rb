class User < ActiveRecord::Base
  after_create :add_sync
  after_update :update_sync
  
  def add_sync
    
  end
  
  def update_sync
    
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
