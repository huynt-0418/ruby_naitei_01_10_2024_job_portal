require 'rails_helper'

RSpec.describe "Enterprise::Sessions", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/enterprise/sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/enterprise/sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
