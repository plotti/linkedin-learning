require 'capybara'
require 'capybara/dsl'
require "selenium/webdriver"

class Scrape
    include Capybara::DSL
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.default_driver = :chrome
end

course_url = "https://www.linkedin.com/learning/crossfilter-for-data-science-essential-training"

s = Scrape.new
s.visit("https://www.linkedin.com/learning/login")
while !s.page.has_title? "LinkedIn Learning: Online Courses for Creative, Technology, Business Skills"
    puts "waiting"
end
s.visit(course_url)
sleep(5)
s.page.execute_script "window.scrollBy(0,10000)"
links = s.find_all(".video-item-container a").collect{|s| s[:href]}
links.each_with_index do |link,i|
    s.visit(link)
    system("youtube-dl #{s.find("video")[:src]} -o '#{course_url.split("/").last}/#{i} #{s.title}.%(ext)s'")
end