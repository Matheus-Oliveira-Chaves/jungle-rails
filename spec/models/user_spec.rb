require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation examples here

    it 'should be created with password and password_confirmation fields' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.valid?).to be true
    end

    it 'should have matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'differentpassword'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should require password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should have a unique email (case-insensitive)' do
      existing_user = User.create(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        email: 'TEST@example.com',
        first_name: 'Jane',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require email, first name, and last name' do
      user = User.new(
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'should have a password with a minimum length' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here

    it 'should authenticate with spaces around email' do
      user = User.create(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials(' test@example.com ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate with wrong case email' do
      user = User.create(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('tEsT@eXaMpLe.cOm', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end