require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
   it "succesful save when all validation criteria are met" do
    @category = Category.new
    @product = Product.new ({
      name: "iPhone",
      price: 599.99,
      quantity: 1,
      category: @category
      })
    expect(@product.save).to be true
  end
   it "does not save when no name assigned" do
    @catgory = Category.new
    @product = Product.new ({
      name: nil,
      price: 599.99,
      quantity: 1,
      category: @category
      })
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include "Name can't be blank"
  end

  it "does not save when no price assigned" do
    @catgory = Category.new
    @product = Product.new ({
      name: "mug",
      price: nil,
      quantity: 3,
      category: @category
      })
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include "Price can't be blank"
  end

  it "does not save when no quantity assigned" do
    @catgory = Category.new
    @product = Product.new ({
      name: "pencil",
      price: 4.99,
      quantity: nil,
      category: @category
      })
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include "Quantity can't be blank"
  end

    it "does not save when no category assigned" do
    @catgory = Category.new
    @product = Product.new ({
      name: "earphone",
      price: 39.99,
      quantity: 4,
      category: nil
      })
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include "Category can't be blank"
  end
 end
end

