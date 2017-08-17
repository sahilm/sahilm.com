xml.instruct!
xml.feed 'xmlns' => 'http://www.w3.org/2005/Atom' do
  xml.link 'href' => 'https://sahilm.com/feed.xml',
           'rel' => 'self',
           'type' => 'application/atom+xml'

  xml.link 'href' => 'https://sahilm.com/',
           'rel' => 'alternate',
           'type' => 'text/html'

  xml.updated blog.articles.first.date.to_time.iso8601

  xml.id 'https://sahilm.com/'

  xml.title 'Sahil Muthoo'

  xml.author {xml.name 'Sahil Muthoo'}

  blog.articles[0..10].each do |article|
    xml.entry do
      xml.title article.title

      xml.link 'href' => article.url,
               'rel' => 'alternate',
               'type' => 'text/html',
               'title' => article.title

      xml.published article.date.to_time.iso8601

      xml.updated article.date.to_time.iso8601

      xml.id article.url

      xml.content article.body,
                  'type' => 'html',
                  'xml:base' => "https://sahilm.com#{article.url}"

      xml.summary article.summary,
                  'type' => 'html'
    end
  end
end
