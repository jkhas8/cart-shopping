require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "Test action index" do
    context "when request GET index" do
      it "should render the index page" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end
