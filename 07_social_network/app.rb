# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/post_repository'
require_relative 'lib/useraccounts_repository'

DatabaseConnection.connect('social_network')

repo = PostRepository.new 

repo.all.each do |post|
  puts "#{post.title} - #{post.content} - #{post.views} - #{post.user_account_id}"
end 


repo_two = UserAccountRepository.new

repo_two.all.each do |user|
  puts "#{user.user_name} - #{user.email_address}"
end