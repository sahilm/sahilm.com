# frozen_string_literal: true

module SiteHelpers
  def formatted_date(date)
    date.strftime("#{date.day.ordinalize} %b %Y")
  end

  def figure(url, alt: nil, caption: nil)
    if caption
      content_tag(:figure) do
        image_tag(url, alt: alt) + content_tag(:figcaption) { caption }
      end
    else
      image_tag(url, alt: alt)
    end
  end

  def mark(text)
    content_tag(:mark) { text }
  end

  def fonts(*fonts)
    <<-EOF
    <script>
      WebFont.load({
                     custom: {
                       families: #{fonts}
                     },
                     timeout: 5000
                   });
    </script>
    EOF
  end

  def full_url(url)
    "https://sahilm.com#{url}"
  end

  def site_meta_tags(page)
    display_meta_tags(tags(page))
  end

  def site_title(page)
    data = page.data
    if data.type == 'article'
      "#{data.title} | Sahil Muthoo"
    else
      'Sahil Muthoo'
    end
  end

  def manifest
    { short_name: 'sahilm.com',
      name: 'Sahil Muthoo',
      icons: [
        {
          src: 'images/android-chrome-192x192.png',
          sizes: '192x192',
          type: 'image/png'
        },
        {
          src: 'images/android-chrome-512x512.png',
          sizes: '512x512',
          type: 'image/png'
        }
      ],
      background_color: '#ffffff',
      display: 'standalone',
      start_url: '/',
      theme_color: '#458588' }.to_json
  end

  private

  def tags(page)
    data = page.data
    {
      'og:site_name' => 'Sahil Muthoo',
      'og:type' => data.type,
      'og:title' => data.title,
      'og:url' => full_url(page.url),
      'og:description' => data.description,
      'twitter:site' => 'sahilmuthoo',
      'twitter:creator' => 'sahilmuthoo',
      'description' => data.description
    }.tap do |t|
      t['og:image'] = full_url(image_path(data.image)) if data.image
    end
  end
end
