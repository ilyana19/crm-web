require 'sinatra'
require_relative 'contact'

get '/' do
  redirect to('/home')
  erb :index
end

get '/home' do
  erb :index
end

get '/contacts' do
  @contacts = Contact.all
  erb :contacts
end

get '/contacts/add-contact' do
  erb :add_contact
end

get '/contacts/:id' do
  # params[:id] contains the id from the URL
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )
  redirect to('/contacts')
end

get '/about' do
  erb :about
end

at_exit do
  ActiveRecord::Base.connection.close
end


# require_relative 'contact'
#
# class CRM
#
#   def initialize(name)
#     @name = name
#   end
#
#   def main_menu
#     while true # repeat indefinitely
#       print_main_menu
#       user_selected = gets.to_i
#       call_option(user_selected)
#     end
#   end
#
#   def print_main_menu
#     puts '[1] Add a new contact'
#     puts '[2] Modify an existing contact'
#     puts '[3] Delete a contact'
#     puts '[4] Display all the contacts'
#     puts '[5] Search by attribute'
#     puts '[6] Exit'
#     puts ""
#     print 'Enter a number: '
#   end
#
#   def call_option(user_selected)
#     case user_selected
#     when 1 then add_new_contact
#     when 2 then modify_existing_contact
#     when 3 then delete_contact
#     when 4 then display_all_contacts
#     when 5 then search_by_attribute
#     when 6 then exit
#     end
#     # should be able to check for invalid input
#   end
#
#   def add_new_contact
#     print "Enter First Name: "
#     first_name = gets.chomp
#
#     print "Enter Last Name: "
#     last_name = gets.chomp
#
#     print "Enter Email Address: "
#     email = gets.chomp
#
#     print "Enter a Note: "
#     note = gets.chomp
#
#     contact = Contact.create(
#       first_name: first_name,
#       last_name: last_name,
#       email: email,
#       note: note
#     )
#
#     clear_src
#   end
#
#   def modify_existing_contact
#     clear_src
#     puts "Modify Menu".upcase
#     puts "-------------------------"
#
#     until @confirmation == 'y'
#       print "Enter the ID of the contact to modify: "
#       user_id = gets.to_i
#       contact = Contact.find(user_id)
#
#       puts ""
#       p contact
#       puts ""
#       print "Is this the correct one? (Y/N): "
#       @confirmation = gets.chomp.downcase
#       puts ""
#       clear_src
#     end
#     # should be able to return to main menu because they changed their minds
#
#     display_attribute_menu
#     print "\nSelect the field you wish to search with: "
#     @user_input = gets.to_i
#
#     # "mapping" user input integer to actual attribute keys then save to a variable
#     # but maybe should be an instance variable??
#     attribute = convert_attribute_input
#
#     if @user_input == 1
#       puts "Error: cannot modify user id.".upcase
#       puts "\nRestarting...".upcase
#       sleep(2)
#       clear_src
#     else
#       print "Enter the new value: "
#       new_value = gets.chomp
#       contact = Contact.update(contact.id, attribute => new_value)
#       puts ""
#       p contact
#       puts "\nProcessing...".upcase
#       sleep(2)
#       clear_src
#     end
#     # should be able to check for invalid input
#   end
#
#   def delete_contact # => deleting everything from the database would be bad...
#     clear_src
#     until @confirmation == 'y'
#       print "Enter the ID of the contact to delete: "
#       user_id = gets.to_i
#       contact = Contact.find(user_id)
#
#       puts ""
#       p contact
#       puts ""
#       print "Is this the correct one? (Y/N): "
#       @confirmation = gets.chomp.downcase
#       puts ""
#       clear_src
#     end
#     # should be able to return to main menu because they changed their minds
#
#     contact.delete
#     puts "\nContact deleted".upcase
#     sleep(2)
#     clear_src
#   end
#
#   def display_all_contacts
#     clear_src
#     p Contact.all
#     puts ""
#   end
#
#   def search_by_attribute
#     clear_src
#     puts "Search Menu".upcase
#     puts "-------------------------"
#
#     display_attribute_menu
#     print "\nSelect the field you wish to search with: "
#     @user_input = gets.to_i
#
#     # "mapping" user input integer to actual attribute keys then save to a variable
#     # but maybe should be an instance variable??
#     attribute = convert_attribute_input
#
#     print "Enter the value (case sensitive): "
#     user_value = gets.chomp
#
#     puts ""
#     # searching if the record actually exists
#     if Contact.exists?(attribute => user_value)
#       contact = Contact.find_by(attribute => user_value)
#       p contact
#     else
#       puts "The contact does not exists."
#     end
#
#     puts "\nProcessing...".upcase
#     sleep(3)
#     clear_src
#     # nice to be able to return to main menu
#   end
#
#   # clears terminal screen
#   def clear_src
#     puts "\e[H\e[2J"
#   end
#
#   def display_attribute_menu
#     puts '[1] User ID'
#     puts '[2] First Name'
#     puts '[3] Last Name'
#     puts '[4] Email Address'
#     puts '[5] Notes'
#   end
#
#   # "mapping" user input integer to actual attribute keys then return the new "key"
#   def convert_attribute_input
#     case @user_input
#     when 1 then attribute = 'id'
#     when 2 then attribute = 'first_name'
#     when 3 then attribute = 'last_name'
#     when 4 then attribute = 'email'
#     when 5 then attribute = 'note'
#     end
#
#     return attribute
#   end
# end
#
# ec_app = CRM.new("Evillious Chronicles")
# ec_app.main_menu
#
# at_exit do
#   ActiveRecord::Base.connection.close
# end