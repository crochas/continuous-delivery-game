require 'squib'
require 'yaml'
require 'game_icons'

Version=1
Copywright = "version: v#{Version}"

def yaml2dataframe(yamldata)
  resultCards = Squib::DataFrame.new

  # Get keys :
  card_keys = yamldata[0].keys
  card_keys.each do |k|
    resultCards[k] = yamldata.map { |e| e[k]}
  end
  return resultCards
end

def cutmark(top, left, right, bottom, size)
  line x1: left, y1: top, x2: left+size, y2: top, stroke_width: 1, cap: :round, stroke_color: 'white'
  line x1: left, y1: top, x2: left, y2: top+size, stroke_width: 1, cap: :round, stroke_color: 'white'

  line x1: right, y1: top, x2: right, y2: top+size, stroke_width: 1, cap: :round, stroke_color: 'white'
  line x1: right, y1: top, x2: right-size, y2: top, stroke_width: 1, cap: :round, stroke_color: 'white'

  line x1: left, y1: bottom, x2: left+size, y2: bottom, stroke_width: 1, cap: :round, stroke_color: 'white'
  line x1: left, y1: bottom, x2: left, y2: bottom-size, stroke_width: 1, cap: :round, stroke_color: 'white'

  line x1: right, y1: bottom, x2: right-size, y2: bottom, stroke_width: 1, cap: :round, stroke_color: 'white'
  line x1: right, y1: bottom, x2: right, y2: bottom-size, stroke_width: 1, cap: :round, stroke_color: 'white'
end

def save_home_made(file)
  cutmark 40, 40, 785, 1085, 10
  save format: :pdf, file: file, width: "29.7cm", height: "21cm", trim: 40, gap: 0
end

def debug_grid()
  grid width: 25,  height: 25,  stroke_color: '#659ae9', stroke_width: 1.5
  grid width: 100, height: 100, stroke_color: '#659ae9', stroke_width: 4
end

def set_background()
    background color: 'black'
end

Cards = YAML.load_file('data/cards.yml')
Cards2 = yaml2dataframe(Cards)
                            

Squib::Deck.new(cards: Cards.size, layout: 'layout-cards-white.yml') do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe', stroke_color: Cards2.cardcolor # safe zone as defined by TheGameCrafter
  rect layout: 'HeaderFlatBottom', fill_color: Cards2.cardcolor
  rect layout: 'HeaderRound', fill_color: Cards2.cardcolor

  card_marker = ['CardA', 'CardB', 'CardC']
  0.upto(Cards.size-1) do |n|
    rect range: n, layout: card_marker[n % 3], fill_color: Cards2.textcolor, stroke_color: Cards2.textcolor
  end
    
  text str: Cards2.title, layout: 'Title', color: Cards.map { |e| e["textcolor"]}
  text str: Cards2.theme, layout: 'Theme'
  text str: Cards2.description, layout: 'Description'
  png mask: Cards2.textcolor, file: Cards2.icon, layout: 'icon'
  text str: Cards2.tags, layout: 'Tags', color: Cards2.cardcolor

  save_home_made "cards-white.pdf"
end
