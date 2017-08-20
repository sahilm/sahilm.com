# frozen_string_literal: true

config[:css_dir] = 'css'
config[:js_dir] = 'js'
config[:source] = 'src'
page '/feed.xml', layout: false
page '/sitemap.xml', layout: false
activate :blog do |blog|
  blog.permalink = '{title}.html'
  blog.sources = 'articles/{title}.html'
  blog.layout = 'article'
  blog.prefix = '/'
end
page '/', layout: 'index'
activate :inliner
activate :meta_tags
activate :directory_indexes
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: false, css_class: 'syntax-highlight'
configure :production do
  activate :asset_hash
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :minify_html
  activate :imageoptim do |options|
    options.manifest = false
    options.image_extensions = %w[.png .jpg .jpeg .gif .svg]
  end
  activate :gzip do |gz|
    gz.overwrite = ENV.key?('GZIP_NO_OVERWRITE') ? false : true
    gz.exts = %w[.css .htm .html .js .svg .xhtml .ttf .json .xml .ico .eot .otf .txt]
  end
end

helpers do
  def article_date(article)
    date = article.date
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

  def title(page)
    data = page.data
    if data.type == 'article'
      "#{data.title} | Sahil Muthoo"
    else
      'Sahil Muthoo'
    end
  end

  private

  def tags(page)
    data = page.data
    {
      'og:image' => full_url(image_path(data.image)),
      'og:site_name' => 'Sahil Muthoo',
      'og:type' => data.type,
      'og:title' => data.title,
      'og:url' => full_url(page.url),
      'og:description' => data.description,
      'twitter:site' => 'sahilmuthoo',
      'twitter:creator' => 'sahilmuthoo'

    }
  end
end
