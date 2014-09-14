class RedditParser

  R_FRONT_PAGE = 'http://www.reddit.com/.json'
  POST_URL     = 'http://www.reddit.com'

  def self.front_page
    retries = 2
    begin
      @page = JSON.parse(open(R_FRONT_PAGE).read)
      parse_front_page_posts
    rescue StandardError=>e
      puts "Error #{e}"
      if retries > 0
        puts "\tTrying #{retries} more times\n"
        retries -= 1
        sleep 2
        retry
      end
    end
  end

  def self.parse_front_page_posts
    @page['data']['children'].map do |item|
      post = Post.new(item['data']['title'], item['data']['id'], item['data']['url'], item['data']['score'], item['data']['author'])
      post.permalink = item['data']['permalink']
      post
    end
  end

  def self.parse_comments(post)
    comment_page = JSON.parse(open(POST_URL + post.permalink + '.json').read)
    binding.pry
    # puts comment_page.recursive_find_by_key('data')
    # comment_page.map do |comment|

  end

end