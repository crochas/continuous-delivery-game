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
    background color: 'white'
end

Cards = YAML.load_file('data/cards.yml')
Squib::Deck.new(cards: Cards.size, layout: 'layout-cards.yml') do
  set_background()
  png mask: Cards.map { |e| e["textcolor"]} , file: 'icons/shieldA.png', layout: 'badge'

  rect layout: 'Background', fill_color: Cards.map { |e| e["cardcolor"]}

  text str: Cards.map { |e| e["title"]}, layout: 'Title', color: Cards.map { |e| e["textcolor"]}
  png mask: Cards.map { |e| e["textcolor"]} , file: Cards.map { |e| e["icon"]}, layout: 'art'

  text str: Cards.map { |e| e["theme"]}, layout: 'Theme', color: Cards.map { |e| e["textcolor"]}
  text str: Cards.map { |e| e["description"]}, layout: 'Description', color: Cards.map { |e| e["textcolor"]}
#  text str: Cards.map { |e| e["tags"]}, layout: 'Tags'

  save_home_made "cards.pdf"
end
