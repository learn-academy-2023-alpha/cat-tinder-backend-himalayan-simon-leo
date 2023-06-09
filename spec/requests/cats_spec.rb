require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create(
        name: "Tom",
        age: 80,
        enjoys: "hunting Jerry",
        image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
      )

      get '/cats'
      # we need our response to be in the format of JSON and then we assigned it to a variable
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)

      expect(cat.length).to eq 1
    end
  end

  describe "POST / create" do
    it "creates a cat" do
      cat_params = {
        cat: {
          name: "Tom",
          age: 80,
          enjoys: "hunting Jerry",
          image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
        }
      }


      post '/cats', params: cat_params
      
      expect(response).to have_http_status(200)
      cat = Cat.last

      expect(cat.name).to eq 'Tom'
      expect(cat.age).to eq 80
      expect(cat.enjoys).to eq 'hunting Jerry'
      expect(cat.image).to eq 'https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png'
    end
  end

  describe "PATCH /update" do
    it 'updates a cat' do
      cat_params = {
        cat: {
          name: "Tom",
          age: 80,
          enjoys: "hunting Jerry",
          image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
        }
      }
      
      post '/cats', params: cat_params
      cat = Cat.first

      updated_cat_params = {
        cat: {
          name: "Tom",
          age: 85,
          enjoys: "hunting Jerry",
          image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
        }
      }

      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
      expect(updated_cat.age).to eq 85
    end
  end

  describe "DELETE /destroy" do
    it "deletes a cat" do
      cat_params = {
          cat: {
          name: "Tom",
          age: 80,
          enjoys: "hunting Jerry",
          image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      cats = Cat.all

      delete "/cats/#{cat.id}"
      expect(response).to have_http_status(200)
      expect(cats).to be_empty
    end
  end

  describe "won't create a cat with all valid atributes" do
    it "doesn't create a cat without a name" do 
      cat_params = {
          cat: {
          age: 80,
          enjoys: "hunting Jerry",
          image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422

      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end

    it "doesn't create a cat without an age" do 
      cat_params = {
        cat: {
        name: "Tom",
        enjoys: "hunting Jerry",
        image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
      }
    }

    post '/cats', params: cat_params
    expect(response.status).to eq 422
    cat = JSON.parse(response.body)
    expect(cat['age']).to include "can't be blank"
    end

    it "doesn't create a cat without an enjoys" do 
      cat_params = {
        cat: {
        name: "Tom",
        age: 80, 
        image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"
      }
    }

    post '/cats', params: cat_params
    expect(response.status).to eq 422
    cat = JSON.parse(response.body)
    expect(cat['enjoys']).to include "can't be blank"
    end

    it "doesn't create a cat without an image" do 
      cat_params = {
        cat: {
        name: "Tom",
        age: 80, 
      }
    }

    post '/cats', params: cat_params
    expect(response.status).to eq 422
    cat = JSON.parse(response.body)
    expect(cat['image']).to include "can't be blank"
    end
  end

end
