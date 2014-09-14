require 'pry'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'colorize'
# require 'activesupport'
require './lib/parser_controller'
require './lib/hn_parser'
require './lib/reddit_parser.rb'
require './lib/post'
require './lib/front_page'
require './lib/comment'
require './lib/comment_viewer'
require './lib/front_page_viewer'
require './lib/errors.rb'
require './lib/recursive_find'

class Application
  attr_reader :post

  HN_URL     = /news\.ycombinator\.com\/item\?id=\d{7}/
  REDDIT_URL = /reddit\.com\/r\/\w*\//

  def initialize(commands)
    @page       = commands[0]
    @front_page = nil
    @post       = nil
  end

  def start
    if @page =~ HN_URL
      parse_post(@page.match(/id=(\d{7})/)[1], 'hn')
    elsif @page =~ REDDIT_URL
      parse_post(@page.match(/\/r\/\w*\/comments\/(\w{6})/)[1], 'reddit')
    elsif @page == 'hn-frontpage'
      parse_hn_front_page
    elsif @page == 'reddit-frontpage'
      parse_r_front_page
    else
      puts "Enter valid Hacker News post URL or 'frontpage'"
    end
  end

  def parse_hn_front_page
    puts "===========================================================================".black.on_red
    puts "==HACKER NEWS==============================================================".black.on_red
    puts "===========================================================================".black.on_red
    @front_page = ParserController.parse_front_page('hn')
    raise InvalidPageFormat, "Page format invalid" if !@front_page.is_a?(Array)
    FrontPageViewer.new(@front_page, 'hn').view
  end

  def parse_r_front_page
    puts "===========================================================================".black.on_blue
    puts "==REDDIT===================================================================".black.on_blue
    puts "===========================================================================".black.on_blue
    @front_page = ParserController.parse_front_page('reddit')
    raise InvalidPageFormat, "Page format invalid" if !@front_page.is_a?(Array)
    FrontPageViewer.new(@front_page, 'reddit').view
  end

  def parse_post(post_id, site)
    @post = ParserController.parse_post(post_id, site)
    puts "#{@post.title}".blue
    puts "URL: #{@post.url}"
    puts "Points: #{@post.points}"
    puts "Posted by: #{@post.owner.magenta}"

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

