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
