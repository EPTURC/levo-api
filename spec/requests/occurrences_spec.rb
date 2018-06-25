require 'rails_helper'

RSpec.describe "Occurrences", type: :request do
  describe "GET /occurrences" do
    it "works! (now write some real specs)" do
      get occurrences_path
      expect(response).to have_http_status(200)
    end
  end
end
