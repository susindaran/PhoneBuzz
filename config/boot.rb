ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

END {
  puts 'Shutting down scheduler and killing existing jobs'
  Rufus::Scheduler.singleton.shutdown(kill: true)
  puts 'Scheduler shutdown!'
}