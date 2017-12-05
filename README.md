
![Image](logo.png)
![Built with Ruby](http://pixel-cookers.github.io/built-with-badges/ruby/ruby-long-flat.png)


## ABOUT

* I was fedup with the missing download for Linkedin Learning courses. Here is a short ruby script to download linkedin learning videos directly to your drive. Nothing fancy but it works. You can adjust it accordningly. 

## INSTALL

* make sure to have ruby > 2.2.0
* Then install requirements:
```
gem install selenium-webdriver
pip install youtube-dl
```

## RUN

```
ruby lynda.rb
```
* When chrome opens, login and wait for the script to visit each course page and youtube-dl download the video. 
* It will download each course into its own subfolder. Videos will be numbered. 

## DEMO

[![asciicast](https://asciinema.org/a/T3jAzbdnUugCzFHoKl5A7l4XQ.png)](https://asciinema.org/a/T3jAzbdnUugCzFHoKl5A7l4XQ)
