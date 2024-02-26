require 'net/http'
require 'json'
require 'ostruct'

api_url = "https://mya-cms.urbansoft.app/api/about"
api_token = "Bearer ccf7a687e6f3206da214aa9997d784aff82544f1894af683edc4ac91e8e28960f29d1e57e9e104607c09cc1288e70efc83436c72eb6188a07644a63c83f5854b5b8e2e2eb3584e566ec6eeb5beb65a41070af349f7572a6ab888865f1c71322dea9355cb2d51c88d5edb1d493127cf0794bfcffb9f19bdd71135c3df0df54c25"

url = URI(api_url)

# puts ENV["STRAPI_URL"]
# puts ENV["STRAPI_AUTH_TOKEN"]

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["fwd"] = "proxy"
request["Authorization"] = api_token

response = https.request(request)

result = JSON.parse(response.body, object_class: OpenStruct)

document = result.data

about_file = File.new("en/about.md", "w")
about_file.puts("---")
about_file.puts("layout: about")
about_file.puts("title: \"#{document.attributes.title}\"")
about_file.puts("subtitle: \"#{document.attributes.subtitle}\"")
about_file.puts("description: #{document.attributes.content}")
about_file.puts("locale: #{document.attributes.locale}")
about_file.puts("direction: ltr")
about_file.puts("---")
about_file.puts("#{document.attributes.content}")


# print(document)