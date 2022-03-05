require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @name =  Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @dni = Faker::IDNumber.unique.spanish_citizen_number
    @user = User.create!(name: @name, last_name: @last_name, dni: @dni, password: 'test123')  
  end

  it 'is valid user whit all attributes' do
    expect(@user).to be_valid
  end

  it 'has name' do 
    expect(@user.name).to eq(@name)
  end 

  it 'has last name' do 
    expect(@user.last_name).to eq(@last_name)
  end

  it 'has dni' do
    expect(@user.dni).to eq(@dni)
  end
end
