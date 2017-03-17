require 'squib'

verso = 'ajisro-back.pdf'

task default: [:deck]

directory "_verso"

task :deck do
  load 'deck.rb'
end

task :deck_color do
  load 'deck_color.rb'
end

task :verso => [:deck, "_verso"] do
  Dir["_output/*.pdf"].each do |pdf|
    pages = `pdfinfo #{pdf} | awk '/Pages:/ {print $2}'`.to_i
    name = File.basename(pdf, '.pdf')
    shuffle = (1..pages).map {|i| "A#{i} B1"}.join(" ")
    sh "pdftk A=#{pdf} B=#{verso} cat #{shuffle} output _verso/#{name}-verso.pdf"
  end
end
