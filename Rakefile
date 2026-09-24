# frozen_string_literal: true

task default: %w[run]

desc 'run site'
task :run do
  sh 'middleman server'
end

namespace :build do
  desc 'clean'
  task :clean do
    RakeFileUtils.rm_rf('build')
  end

  desc 'production'
  task :production do
    sh 'middleman build -e production'
  end

  desc 'development'
  task :development do
    sh 'middleman build'
  end
end
