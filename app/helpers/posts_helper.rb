module PostsHelper
  def tweet_url(url, title)
    #"http://twitter.com/share?url=[シェアするURL]&text=[ツイート内テキスト]&via=[ツイート内に含むユーザ名]&related=[ツイート後に表示されるユーザー]&hashtags=[ハッシュタグ]"
    text = title
    "http://twitter.com/share?url=#{url}&text=#{text}"
  end
end