require "rails_helper"

RSpec.describe UrlsController, type: :controller do
  describe "GET index" do
    it "renders the index page" do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it "assigns a new Url instance to @url" do
      get :index
      expect(assigns(:url)).to be_a_new(Url)
    end

    it "assigns the top 10 visited urls to @urls" do
      urls = create_list(:url, 15)
      get :index
      expect(assigns(:urls)).to eq(Url.order(visit_count: :desc).limit(10))
    end

    it "assigns recently created urls to @recently_created_urls" do
      url1 = Url.create(full_url: Faker::Internet.url)
      url2 = Url.create(full_url: Faker::Internet.url)
      url3 = Url.create(full_url: Faker::Internet.url)
      url4 = Url.create(full_url: Faker::Internet.url)
      url5 = nil

      travel_to 5.hours.ago do
        url5 = Url.create(full_url: Faker::Internet.url)
      end

      get :index
      expect(assigns(:recently_created_urls)).to include(url1, url2, url3, url4)
      expect(assigns(:recently_created_urls)).not_to include(url5)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new url" do
        expect {
          post :create, params: { url: { full_url: Faker::Internet.url } }
        }.to change(Url, :count).by(1)
      end

      it "redirects to root_path with success flash message" do
        post :create, params: { url: { full_url: Faker::Internet.url } }
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq("URL successfully shortened!")
      end
    end

    context "with invalid attributes" do
      it "does not create a new url" do
        expect {
          post :create, params: { url: { full_url: "invalid_url" } }
        }.not_to change(Url, :count)
      end

      it "redirects to root_path with error flash message" do
        post :create, params: { url: { full_url: "invalid_url" } }
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq("Invalid URL, please try again.")
      end
    end
  end

  describe "GET show" do
    context "with valid short_url" do
      let(:url) { FactoryBot.create(:url) }
      it "redirects to the full_url" do
        get :show, params: { id: url.short_url }
        expect(response).to redirect_to(url.full_url)
      end

      it "increments the visit count of the url" do
        expect {
          get :show, params: { id: url.short_url }
        }.to change { url.reload.visit_count }.by(1)
      end
    end

    context "with invalid short_url" do
      it "renders 404 page" do
        get :show, params: { id: "invalid_short_url" }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET redirect" do
    context "with valid short_url" do
      let(:url) { FactoryBot.create(:url) }
      it "redirects to the full_url" do
        get :redirect, params: { short_url: url.short_url }
        expect(response).to redirect_to(url.full_url)
      end

      it "increments the visit count of the url" do
        expect {
          get :redirect, params: { short_url: url.short_url }
        }.to change { url.reload.visit_count }.by(1)
      end
    end
  end
end