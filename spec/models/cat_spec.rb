require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate all inputs for adding a cat" do
    cat = Cat.create
    expect(cat.errors[:name]).to_not be_empty
    expect(cat.errors[:age]).to_not be_empty
    expect(cat.errors[:enjoys]).to_not be_empty
    expect(cat.errors[:image]).to_not be_empty
  end
  it "validates enjoys has a minimun length of 10 characters" do
    cat = Cat.create(
      name: "Tom",
      age: 80,
      enjoys: "hunting",
      image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
    )
    expect(cat.errors[:enjoys]).to_not be_empty

  end
end
