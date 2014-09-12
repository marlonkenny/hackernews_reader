class FrontPageViewer

  def initialize(posts)
    @posts = posts
  end

  def view
    puts "Hit enter to continue, type 'view' to view comments or 'quit' to finish\n\n"
    @posts.each do |post|
      puts "#{post.title}".blue
      puts "URL: #{post.url}".green
      puts "Points: #{post.points}".magenta
      puts "Posted by: #{post.owner}".red
      response = $stdin.gets.chomp
      if response == 'view'
        Parser.parse_comments(post)
        CommentViewer.new(post).view
      elsif response == 'quit'
        return
      end
    end
  end

end