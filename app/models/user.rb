require "net/https"
require "uri"
require "rexml/document"

class User < ActiveRecord::Base

  def to_pipe_delimited_string
    [
      [:uid, id],
      [:email, email],
      [:first_name, first_name],
      [:last_name, last_name],
      [:gender, gender],
      [:city, city],
      [:state, state],
      [:postal_code, zip],
      [:country, country],
      [:timezone, "Eastern Time (US & Canada)"],
      [:groups, groups]
    ].map do |k,v|
      "#{k}=#{v}"
    end.join("|")
  end

end
