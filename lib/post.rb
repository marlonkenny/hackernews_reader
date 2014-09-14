class Post
  attr_reader :id, :title, :url, :points, :owner
  attr_accessor :comments, :permalink

  def initialize(title, id, url, points, owner, comments=[])
    @title     = title
    @id        = id
    @url       = url
    @points    = points
    @owner     = owner
    @comments  = comments
    @permalink = nil
  end

  def add_comment(user_id, content)
    @comments << Comment.new(user_id, content)
  end

end