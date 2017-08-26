# frozen_string_literal: true

task default: %w[run]

desc 'run site'
task :run do
  sh 'middleman server'
end

desc 'sync site to s3'
task :s3_sync do
  sh 'middleman s3_sync -B -e production'
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
