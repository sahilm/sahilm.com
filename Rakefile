# frozen_string_literal: true

require 'html-proofer'

task default: %w[test]

desc 'test'
task :test do
  sh 'rubocop'
end

desc 'clean site'
task :clean do
  RakeFileUtils.rm_rf('build')
end

desc 'build site'
task build: %w[test] do
  sh 'middleman build -e production'
end

desc 'build site for local testing'
task build_local: %w[clean test] do
  sh 'GZIP_NO_OVERWRITE=1 middleman build -e production'
end

desc 'acceptance test'
task acceptance_test: %w[clean test] do
  sh 'middleman build -e development'
  opts = {
    disable_external: true,
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
