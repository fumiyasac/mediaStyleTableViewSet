json.article do
  json.contents do
    json.array!(@articles) do |article|
      json.id article.id.to_s
      json.title do
        json.label article.title
      end
      json.category do
        json.label article.category
      end
      json.image_url do
        json.url ('https://' + article.authenticated_image_url(:large).host + article.authenticated_image_url(:large).path)
      end
    end
  end
end
