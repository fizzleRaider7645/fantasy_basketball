class Scraper

  BASE_PATH = 'https://www.basketball-reference.com'

  def self.get_doc
    html = open('https://www.basketball-reference.com/contracts/players.html')
    doc = Nokogiri::HTML(html)
  end

  def self.get_nba_players
    doc = Scraper.get_doc
    players_table = doc.css('.table_outer_container').css('tbody')
    players = players_table.css('tr').map { |row| row.children[1].css('a')[0] }
    names = players.map { |name| name.text unless el.class == NilClass }.compact
    # links = players.map { |player| player.attr("href") unless player.class == NilClass }.compact
    # points = Scraper.get_points(links)
  end



  # def self.get_points(links)
  #   links.map do |link|
  #     player_link = BASE_PATH + link
  #     html = open(player_link)
  #     doc = Nokogiri::HTML(html)
  #     stats = doc.css(".stats_pullout")
  #     points = doc.css('.p1').children.css('p').children[2].text
  #   end
  # end
end
