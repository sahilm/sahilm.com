# frozen_string_literal: true

xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  sitemap.resources.select { |page| page.destination_path =~ /\.html/ && !page.data.noindex == true }.each do |page|
    xml.url do
      xml.loc full_url(page.url)
    end
  end
end
