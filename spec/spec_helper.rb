require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'webdrivers/chromedriver'
require 'byebug'

Capybara.register_driver :webdriver do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.configure do |config|
  config.default_driver = :webdriver
end
Capybara.page.driver.browser.manage.window.resize_to(1024, 768)