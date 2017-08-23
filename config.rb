# frozen_string_literal: true

require 'middleman-s3_sync'
require 'middleman-core/renderers/redcarpet'

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
page '/404.html', layout: '404'
activate :inliner
activate :meta_tags
activate :directory_indexes
class AnchorRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML
  def header(title, level)
    @headers ||= []
    permalink = title.gsub(/\W+/, '-')

    if @headers.include? permalink
      permalink += '_1'
      permalink = permalink.succ while @headers.include? permalink
    end
    @headers << permalink

    %(
      <h#{level} id=\"#{permalink}\" class="title">
        <a name="#{permalink}" class="anchor icon" href="##{permalink}">
          <i class="icon-link" title="link"></i>
          <span class="sr-only">link</span>
        </a>
        #{title}
      </h#{level}>
    )
  end
end
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, renderer: AnchorRenderer
activate :syntax, line_numbers: false, css_class: 'syntax-highlight'
configure :production do
  activate :asset_hash
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :minify_html
  activate :imageoptim do |options|
    options.manifest = false
    options.image_extensions = %w[.png .jpg .jpeg .gif .svg]
    options.jpegoptim = { allow_lossy: true, strip: ['all'], max_quality: 85 }
  end
  activate :s3_sync do |s3_sync|
    s3_sync.bucket = 'sahilm.com'
    s3_sync.region = 'eu-west-1'
    s3_sync.delete = true
    s3_sync.after_build = false
    s3_sync.prefer_gzip = false
    s3_sync.path_style = true
    s3_sync.reduced_redundancy_storage = false
    s3_sync.acl = 'public-read'
    s3_sync.encryption = false
    s3_sync.prefix = ''
    s3_sync.version_bucket = false
    s3_sync.index_document = 'index.html'
    s3_sync.error_document = '404/index.html'
  end

  %w[text/html
     text/xml
     text/plain
     image/x-icon
     image/vnd.microsoft.icon
     application/json
     application/atom+xml
     application/rss+xml
     application/xml].each do |mime_type|
    caching_policy mime_type, public: true, max_age: 0, must_revalidate: true
  end

  default_caching_policy public: true, max_age: (60 * 60 * 24 * 365)
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
