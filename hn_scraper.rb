require 'pry'
require 'open-uri'
require 'nokogiri'
# require 'activesupport'
require './lib/post'
require './lib/comment'
require './lib/parser'

class Application
  attr_reader :post

  def initialize(commands)
    @page = commands[0]
  end

  def read_post
    if (@page == nil) || !(@page =~ /news\.ycombinator\.com\/item\?id=\d{7}/)
      puts "Enter valid Hacker News post URL"
    end

    parse_post

  end

  def parse_post
    @post = Parser.new(@page).parse_post
    puts "Post Title: #{@post.title}"
    puts "Post URL: #{@post.url}"
    puts "Post Points: #{@post.points}"
    puts "Number of comments: #{@post.comments.length}"
  end

  def add_comment
    puts "What is your user id?"
    user_id = gets.chomp

    puts "Enter your comment"
    content = gets.chomp
    
    @post.add_comment(user_id, content)

    puts "#{@post.comments[-1].user_id}: #{@post.comments[-1].content}."
  end

end

page = 'post.html'
app = Application.new(ARGV).read_post

