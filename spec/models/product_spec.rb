require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Example Category')
      @product = Product.new(
        name: 'Example Product',
        price_cents: 10000,
        quantity: 5,
        category: @category
      )
    end

    it 'saves successfully with all four fields set' do
      expect(@product.save).to be_truthy
    end

    it 'validates presence of name' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates presence of price' do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates presence of quantity' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates presence of category' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
