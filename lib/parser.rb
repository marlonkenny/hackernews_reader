class Parser

  def initialize(page)
    @page = Nokogiri::HTML(open(page))
  end

  def parse_post
    post = Post.new(@page, get_post_id, get_post_title, get_post_url, get_post_points, get_post_owner, parse_comments)
  end

  private

  def get_post_id
    @page.css('form input[name=parent]')[0]['value']    
  end

  def get_post_title
    @page.css('.title a')[0].text
  end

  def get_post_url
    @page.css('.title a')[0]['href']
  end

  def get_post_points
    @page.css('.subtext span')[0].text.match(/\d{0,5}/).to_s
  end

  def get_post_owner
    @page.css('.subtext > a:nth-child(2)')[0].text
  end

  def parse_comments
    comments = @page.css('td .default')
    comments.map do |comment|
      user_id = comment.css('.comhead > a')[0].text
      content = comment.css('.comment font').text
      Comment.new(user_id, content)
    end
  end
end