require 'pry'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'colorize'
# require 'activesupport'
require './lib/post'
require './lib/front_page'
require './lib/comment'
require './lib/comment_viewer'
require './lib/front_page_viewer'
require './lib/parser'

class Application
  attr_reader :post

  HN_URL       = /news\.ycombinator\.com\/item\?id=\d{7}/

  def initialize(commands)
    @page       = commands[0]
    @front_page = nil
    @post       = nil
  end

  def start
    if @page =~ HN_URL
      parse_post(@page.match(/id=(\d{7})/)[1])
    elsif @page == 'frontpage'
      parse_front_page
    else
      puts "Enter valid Hacker News post URL or 'frontpage'"
    end
  end

  def parse_front_page
    puts "HACKER NEWS ====================================".black.on_red
    @front_page = Parser.parse_front_page
    FrontPageViewer.new(@front_page).view
  end

  def parse_post(post_id)
    @post = Parser.parse_post(post_id)
    puts "Post Title: #{@post.title}".blue
    puts "Post URL: #{@post.url}".green
    puts "Post Points: #{@post.points}".magenta
    puts "Number of comments: #{@post.comments.length}"

    CommentViewer.new(@post).view
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
app = Application.new(ARGV).start

