require "open-uri"

class ImageGeneratorService
  def self.generate_and_attach(recipe)
    user = OpenAI::User.new(access_token:"")
    response = user.images.generate(parameters:
    {
      prompt: "Professional food photography of #{recipe.name}, #{recipe.keywords}, high resolution, studio lighting", size: "512x512"
    })
    image_url = response.dig("data", 0, "url")
    if image_url.present?
      file = URI.open(image_url)
      recipe.photo.attach(io:file, filename: "recipe_#{recipe.id}.png", content_type: "image/png")
    end
  end
end
