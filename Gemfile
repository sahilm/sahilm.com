source 'https://rubygems.org'
git_source(:github) {|repo_name| "https://github.com/#{repo_name}"}

gem 'middleman'
gem 'middleman-blog'
gem 'middleman-meta-tags'
gem 'middleman-syntax'
gem 'middleman-autoprefixer'
gem 'middleman-inliner', github: 'sahilm/middleman-inliner'
gem 'middleman-minify-html'
gem 'middleman-imageoptim', github: 'plasticine/middleman-imageoptim', ref: 'a539cae'
gem 'redcarpet'

group :development do
  gem 'middleman-livereload'
end

group :test do
  gem 'scss_lint', require: false
  gem 'rubocop'
end
