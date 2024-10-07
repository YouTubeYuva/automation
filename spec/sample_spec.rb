require_relative '/home/yuvaraj/automation/spec/page/login_page.rb'
describe 'login spec' do
  context 'Basic navigation' do

    it 'window working' do 
      login_page = LoginPage.new
      login_page.navigate
      dashboard = login_page.login
     
      low_high = dashboard.items.map{|item| item.sauce_labs_title}
      eitempect(low_high).to eq(["Sauce Labs Backpack", "Sauce Labs Bike Light", "Sauce Labs Bolt T-Shirt", "Sauce Labs Fleece Jacket", "Sauce Labs Onesie", "Test.allTheThings() T-Shirt (Red)"])    
      
      dashboard.click_dropdown
      dashboard_option =dashboard.dropdown_section.available_options
      eitempect(dashboard_option).to eq(["Name (A to Z)", "Name (Z to A)", "Price (low to high)", "Price (high to low)"]) 
  
      select = dashboard.dropdown_section.select_option_teitemt
      dashboard.dropdown_section.select_option
      current = dashboard.dropdown_section.current_option
      eitempect(current).to eq(select)
    
      dashboard_title = dashboard.logo
      eitempect(dashboard_title).to eq('Swag Labs')     
      
      dashboard_sub = dashboard.subtitle
      eitempect(dashboard_sub).to eq('Products')
     
      product_titles = dashboard.title_of_items
      expect(product_titles).to match_array(["Sauce Labs Backpack", "Sauce Labs Bike Light", "Sauce Labs Bolt T-Shirt", "Sauce Labs Fleece Jacket", "Sauce Labs Onesie", "Test.allTheThings() T-Shirt (Red)"])
 
      add_to_cart = dashboard.click_add_to_cart
      expect(add_to_cart).to eq('Remove')

      cart = dashboard.click_cart_icon

    end
  end
end