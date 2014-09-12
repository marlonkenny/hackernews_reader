class CommentViewer

  def initialize(post)
    @comments = post.comments
  end

  def view
    puts "#{@comments.length} comments. View? (yes/no)"
    response = $stdin.gets.chomp
    if response == 'yes'
      puts "Hit enter to continue, type 'back' to return to front page\n\n"
      @comments.each do |comment|
        puts "{#{comment.user_id.blue}}: #{comment.content}"
        return if $stdin.gets.chomp == 'back'
      end
    end
  end

end