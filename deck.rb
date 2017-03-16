require 'squib'
require 'yaml'
require 'game_icons'

Version=1
Copywright = "version: v#{Version}"

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

#Cards = YAML.load_file('data/cards.yml')
#Squib::Deck.new(cards: Cards.size, layout: 'layout-cards.yml') do
#  set_background()
#
#  rect layout: 'Background', fill_color: Cards.map { |e| e["cardcolor"]}
#
#  text str: Cards.map { |e| e["title"]}, layout: 'Title', color: Cards.map { |e| e["textcolor"]}
#  text str: Cards.map { |e| e["shield"]}, layout: 'Shield', color: Cards.map { |e| e["textcolor"]}
#  png mask: Cards.map { |e| e["textcolor"]} , file: Cards.map { |e| e["icon"]}, layout: 'art'
#
#  text str: Cards.map { |e| e["theme"]}, layout: 'Theme', color: Cards.map { |e| e["textcolor"]}
#  text str: Cards.map { |e| e["description"]}, layout: 'Description', color: Cards.map { |e| e["textcolor"]}
#
#  save_home_made "cards.pdf"
#end

Cards = YAML.load_file('data/cards.yml')
Squib::Deck.new(cards: Cards.size, layout: 'layout-cards-white.yml') do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe', stroke_color: Cards.map { |e| e["cardcolor"]} # safe zone as defined by TheGameCrafter
  rect layout: 'Background', fill_color: Cards.map { |e| e["cardcolor"]}

  rect range: [0,3,6,9,12,15,18,21,24], layout: 'CardA', fill_color: Cards.map { |e| e["textcolor"]}
  rect range: [1,4,7,10,13,16,19,22,25], layout: 'CardB', fill_color: Cards.map { |e| e["textcolor"]}
  rect range: [2,5,8,11,14,17,20,23,26], layout: 'CardC', fill_color: Cards.map { |e| e["textcolor"]}


  text str: Cards.map { |e| e["title"]}, layout: 'Title', color: Cards.map { |e| e["textcolor"]}
  text str: Cards.map { |e| e["theme"]}, layout: 'Theme'
  text str: Cards.map { |e| e["description"]}, layout: 'Description'
  png mask: Cards.map { |e| e["textcolor"]} , file: Cards.map { |e| e["icon"]}, layout: 'art'
  text str: Cards.map { |e| e["tags"]}, layout: 'Tags', color: Cards.map { |e| e["cardcolor"]}

  save_home_made "cards-white.pdf"
end
