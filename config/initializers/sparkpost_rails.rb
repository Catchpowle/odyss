SparkPostRails.configure do |c|
  c.api_key = ENV['SPARKPOST_KEY']
  c.html_content_only
end
