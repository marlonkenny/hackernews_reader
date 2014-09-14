class FrontPageViewer

  def initialize(posts, site)
    @posts = posts
    @site  = site
  end

  def view
    puts "Hit enter to continue, type 'view' to view comments or 'quit' to finish\n\n"
    @posts.each do |post|
      puts "#{post.title}".blue
      puts "URL: #{post.url}"
      puts "Points: #{post.points}"
      puts "Posted by: #{post.owner.magenta}"
      response = $stdin.gets.chomp
      if response == 'view'
        ParserController.parse_comments(post, @site)
        CommentViewer.new(post).view
      elsif response == 'quit'
        return
      end
    end
  end

end