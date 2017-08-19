# frozen_string_literal: true

require 'html-proofer'

task default: %w[test]

desc 'test'
task :test do
  sh 'rubocop'
  sh 'scss-lint'
end

desc 'clean site'
task :clean do
  RakeFileUtils.rm_rf('build')
end

desc 'build site'
task build: %w[clean test] do
  sh 'middleman build -e production'
end

desc 'acceptance test'
task acceptance_test: %w[clean test] do
  sh 'middleman build -e development'
  opts = {
    check_img_http: true,
    check_html: true, validation: {
      report_missing_names: true
    },
    check_favicon: true,
    check_opengraph: true
  }
  HTMLProofer.check_directory('./build', opts).run
end

desc 'rubocop'
task :rubocop do
  sh 'rubocop -a'
end

desc 'run site'
task :run do
  sh 'middleman server'
end
