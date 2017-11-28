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

courses = [
"https://www.linkedin.com/learning/amazon-web-services-for-data-science",
"https://www.linkedin.com/learning/analyzing-big-data-with-hive",
"https://www.linkedin.com/learning/apache-spark-essential-training-big-data-engineering",
"https://www.linkedin.com/learning/big-data-foundations-building-architecture-and-teams",
"https://www.linkedin.com/learning/creating-interactive-dashboards-in-tableau",
"https://www.linkedin.com/learning/creating-interactive-presentations-with-shiny-and-r",
"https://www.linkedin.com/learning/d3-js-essential-training-for-data-scientists",
"https://www.linkedin.com/learning/data-science-and-analytics-career-paths-and-certifications-first-steps",
"https://www.linkedin.com/learning/data-science-foundations-data-mining",
"https://www.linkedin.com/learning/data-science-foundations-python-scientific-stack",
"https://www.linkedin.com/learning/data-science-tips-weekly",
"https://www.linkedin.com/learning/data-visualization-for-data-analysts",
"https://www.linkedin.com/learning/data-visualization-tips-and-tricks",
"https://www.linkedin.com/learning/dc-js-for-data-science-essential-training",
"https://www.linkedin.com/learning/extending-hadoop-for-data-science-streaming-spark-storm-and-kafka",
"https://www.linkedin.com/learning/hadoop-data-analysis",
"https://www.linkedin.com/learning/learning-data-governance",
"https://www.linkedin.com/learning/learning-data-science-ask-great-questions",
"https://www.linkedin.com/learning/learning-data-science-manage-your-team",
"https://www.linkedin.com/learning/learning-data-science-tell-stories-with-data",
"https://www.linkedin.com/learning/learning-data-science-understanding-the-basics",
"https://www.linkedin.com/learning/learning-data-science-using-agile-methodology",
"https://www.linkedin.com/learning/learning-hadoop",
"https://www.linkedin.com/learning/learning-microsoft-power-bi-desktop",
"https://www.linkedin.com/learning/learning-neo4j",
"https://www.linkedin.com/learning/learning-watson-analytics",
"https://www.linkedin.com/learning/numpy-data-science-essential-training",
"https://www.linkedin.com/learning/pandas-for-data-science",
"https://www.linkedin.com/learning/power-bi-pro-essential-training",
"https://www.linkedin.com/learning/processing-interactive-data-visualization",
"https://www.linkedin.com/learning/python-data-analysis",
"https://www.linkedin.com/learning/social-network-analysis-using-r",
"https://www.linkedin.com/learning/sql-tips-tricks-techniques",
"https://www.linkedin.com/learning/tableau-10-for-data-scientists",
"https://www.linkedin.com/learning/tableau-9-essential-training",
"https://www.linkedin.com/learning/the-data-science-of-economics-banking-and-finance-with-barton-poulson",
"https://www.linkedin.com/learning/the-data-science-of-media-and-entertainment-with-barton-poulson",
"https://www.linkedin.com/learning/the-data-science-of-retail-sales-and-commerce",
"https://www.linkedin.com/learning/the-data-science-of-sports-management-with-barton-poulson",
"https://www.linkedin.com/learning/twelve-myths-about-data-science"
]

s = Scrape.new()
s.visit("https://www.linkedin.com/learning/login")
while !s.page.has_title? "LinkedIn Learning: Online Courses for Creative, Technology, Business Skills"
    puts "waiting"
end

courses.each do |course_url|
    puts "Working on #{course_url}"
    s.visit(course_url)
    sleep(5)
    s.page.execute_script "window.scrollBy(0,10000)"
    sleep(5)
    links = s.find_all(".video-item-container a").collect{|s| s[:href]}
    links.each_with_index do |link,i|
        s.visit(link)
        system("youtube-dl #{s.find("video")[:src]} -o '#{course_url.split("/").last}/#{i} #{s.title}.%(ext)s'")
    end
end