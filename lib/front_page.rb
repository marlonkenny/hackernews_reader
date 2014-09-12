class FrontPage
  attr_reader :posts

  def initialize(posts, parser)
    @posts = posts
    @parser = @parser
  end

  def view
    puts "Hit enter to move to the next post. Type 'view' to check out the comments or 'quit' to exit"
    @posts.each do |post|
      puts "#{post.title}"
      input = $stdin.gets.chomp
      if input == 'quit'
        return
      elsif input == 'view'
        puts post.inspect
      end
    end
  end
end 
