# Continuous Delivery game

How to generate :
```
docker build -t card-game .
docker run -i -t card-game /bin/bash
  ruby deck.rb
docker cp 39c92f73f6ea://workspace/_output .
```
