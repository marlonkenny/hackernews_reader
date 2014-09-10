class Post
  attr_reader :comments, :page, :item_id, :title, :url, :points, :owner

  def initialize(page, item_id, title, url, points, owner, comments)
    @page     = page
    @item_id  = item_id
    @title    = title
    @url      = url
    @points   = points
    @comments = comments
  end

  def add_comment(user_id, content)
    @comments << Comment.new(user_id, content)
  end

end