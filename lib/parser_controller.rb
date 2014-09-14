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
  end

  def self.parse_post(post_id, site)
    case site
    when 'hn'
      HNParser.single_post(post_id)
    when 'reddit'
      RedditParser.single_post(post_id)
    end
  end

  def self.parse_comments(post, site)
    case site
    when 'hn'
      HNParser.parse_comments(post)
    when 'reddit'
      RedditParser.parse_comments(post)
    end
  end

end