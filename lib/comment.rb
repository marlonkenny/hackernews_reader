class Comment
  attr_reader :user_id, :content
  
  def initialize(user_id, content)
    @user_id       =  user_id
    @content       =  content
  end

end