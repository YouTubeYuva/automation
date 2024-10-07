class Item <  SitePrism::Section
element :sauce_labs, 'div.inventory_item_description  div a'
element :button, ''

  def sauce_labs_title
    sauce_labs.text
  end 

end

class Dropdown < SitePrism::Section
  elements :dropdown_list, 'select.product_sort_container option'
  element :nth_option, 'select.product_sort_container option:nth-child(3)'
  element :active_option, ' .active_option'

  def available_options
    dropdown_list.map{|item| item.text}
  end

  def select_option_text
    nth_option.text
  end

  def select_option
    nth_option.click
  end

  def current_option
    active_option.text
  end
end

class Dashboard < SitePrism::Page
 set_url 'https://www.saucedemo.com/inventory.html'
  
  element :title_element, 'div.app_logo'
  element :subtitle_element, 'span.title'
  element :dropdown, 'span.select_container'
  section :dropdown_section, Dropdown, 'span.select_container'
  sections:items, Item, 'div.inventory_item'

  def logo
    title_element.text
  end
  
  def subtitle
    subtitle_element.text
  end
  
  def click_dropdown
    dropdown.click
  end

  def title_of_items
    items = find_all('div.inventory_list div.inventory_item')
    items.map { |item| item.find_all('div.inventory_item_description .inventory_item_label a').map {|a|a.text}}.flatten
  end
  
   
  def click_add_to_cart
    items = find_all('div.inventory_list div.inventory_item div.inventory_item_description')
    items.first.find('button.btn.btn_primary.btn_small.btn_inventory').click
    first_item = items.first
    first_item.find('button.btn.btn_secondary.btn_small.btn_inventory').text
  end

  def click_cart_icon
    find('div.primary_header .shopping_cart_container .shopping_cart_link').click
  end

 def collect_items_data    
    items = find_all('div.inventory_list div.inventory_item')
    pricebar = items.select {|a| a.find('div.inventory_item_description .pricebar button')['class'] == "btn btn_secondary btn_small btn_inventory "}
    header = pricebar.map { |item| item.find_all('div.inventory_item_description .inventory_item_label a').map { |a| a.text } }
    desc = pricebar.map { |item| item.find_all('div.inventory_item_description .inventory_item_label .inventory_item_desc').map { |a| a.text } }
    rate =  pricebar.map { |item| item.find_all('div.inventory_item_description .pricebar .inventory_item_price').map {|a| a.text}}
    a = {header: header,desc: desc,rate: rate}
  end

end

class LoginPage < SitePrism::Page
set_url 'https://www.saucedemo.com/'

  element :username_input, '#user-name'
  element :password_input, '#password'
  element :login_button, '#login-button'
  
  def navigate
    self.load 
  end
  
  def login
    username_input.set('standard_user')
    password_input.set('secret_sauce')
    login_button.click
    Dashboard.new
  end
end
   