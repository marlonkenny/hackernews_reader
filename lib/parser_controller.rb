class ParserController

  HN_FRONT_PAGE = 'http://api.ihackernews.com/page'
  HN_POST       = 'http://api.ihackernews.com/'
  POST_URL      = 'https://news.ycombinator.com/item?id='

  def self.parse_front_page(site)
    case site
    when 'hn'
      HNParser.front_page
    when 'reddit'
      RedditParser.front_page
    end


    # retries = 2
    # begin
    #   @page = JSON.parse(open(HN_FRONT_PAGE).read)
    #   parse_front_page_posts
    # rescue StandardError=>e
    #   puts "Error #{e}"
    #   if retries > 0
    #     puts "\tTrying #{retries} more times\n"
    #     retries -= 1
    #     sleep 2
    #     retry
    #   end
    # end
  end

  def self.parse_post(post_id, site)
    case site
    when 'hn'
      HNParser.single_post(post_id)
    when 'reddit'
      RedditParser.single_post(post_id)
    end

    # url = POST_URL + id.to_s
    # @single_post = Nokogiri::HTML(open(url))
    # post = Post.new(get_post_title, get_post_id, get_post_url, get_post_points, get_post_owner)
    # parse_comments(post)
    # post
  end

  private

  def self.parse_comments(post_id)
    url = POST_URL + post.id.to_s
    page = Nokogiri::HTML(open(url))
    comments = page.css('td .default')
    comment_array = comments.map do |comment|
      user_id = comment.css('.comhead > a')[0].text
      content = comment.css('.comment font').text
      Comment.new(user_id, content)
    end
    post.comments = comment_array
  end

  def self.parse_front_page_posts
    @page['items'].map do |item|
      Post.new(item['title'], item['id'], item['url'], item['points'], item['postedBy'])
    end
  end

  def self.get_post_id
    @single_post.css('form input[name=parent]')[0]['value']    
  end

  def self.get_post_title
    @single_post.css('.title a')[0].text
  end

  def self.get_post_url
    @single_post.css('.title a')[0]['href']
  end

  def self.get_post_points
    @single_post.css('.subtext span')[0].text.match(/\d{0,5}/).to_s
  end

  def self.get_post_owner
    @single_post.css('.subtext > a:nth-child(2)')[0].text
  end
end