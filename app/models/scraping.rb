class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    next_url = ""

    while true do
      current_page = agent.get("http://review-movie.herokuapp.com/")
      links = current_page.search('.entry-title a')
      get_product(links)

      next_link = current_page.at('.pagination .next a')
      break unless next_link
      next_url = next_link.get_attribute('href')
    end
  end

  def self.get_product(links)


    agent = Mechanize.new
    links.each do |link|
      url = "http://review-movie.herokuapp.com" + "#{link[:href]}"
      kobetu_page = agent.get(url)
      image_url =  kobetu_page.search('.alignleft')[0][:src]
      page_title = kobetu_page.search('.entry-title').inner_text
      director = kobetu_page.search('.director span').inner_text
      open_date = kobetu_page.search('.date span').inner_text
      detail = kobetu_page.search('.entry-content p').inner_text
      binding.pry

      product = Product.where(title: page_title, image_url: image_url).first_or_initialize
      product.image_url = image_url
      product.director = director
      product.detail = detail
      product.open_date = open_date
      product.save
    end
  end
end