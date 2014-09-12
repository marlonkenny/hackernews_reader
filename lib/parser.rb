class Parser

  HN_FRONT_PAGE = 'front_page.json'
  HN_POST       = 'http://api.ihackernews.com/'
  POST_URL      = 'https://news.ycombinator.com/item?id='

  def self.parse_post(id)
    url = POST_URL + post.id.to_s
    page = Nokogiri::HTML(open(url))
    post = Post.new(title, id, url, points, owner)
    post
  end

  def self.parse_front_page
    @page = JSON.parse(open(HN_FRONT_PAGE).read)
    parse_front_page_posts
  end

  private

  def self.parse_comments(post)
    url = POST_URL + post.id.to_s
    page = Nokogiri::HTML(open(url))
    comments = page.css('td .default')
    comment_array = comments.map do |comment|
      user_id = comment.css('.comhead > a')[0].text
      content = comment.css('.comment font').text
      Comment.new(user_id, content)
    end
    puts post.comments.inspect
    post.comments = comment_array
  end

  def self.parse_front_page_posts
    @page['items'].map do |item|
      Post.new(item['title'], item['id'], item['url'], item['points'], item['postedBy'])
    end
  end

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
end