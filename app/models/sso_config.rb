module SsoConfig
  extend self

  config_vars_from_files = %w[shared_key groupsite_url shared_domain shared_cookie_name]

  config_vars_from_files.each do |config_var|
    define_method config_var do
      IO.read(config_var_path(config_var)).strip
    end
  end

  def config_var_path(var_name)
    File.expand_path("config/#{var_name}.txt", Rails.root)
  end

  def cypher_key
    [shared_key].pack("H*")
  end

end
