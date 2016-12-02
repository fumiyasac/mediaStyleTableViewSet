json.article do
  json.contents do
    json.array!(@articles) do |article|
      json.id article.id.to_s
      json.title article.title
      json.category article.category
      json.image_url ('https://' + article.authenticated_image_url(:large).host + article.authenticated_image_url(:large).path)
    end
  end
end
