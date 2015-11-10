require 'rails_helper'

RSpec.describe UserController, type: :controller do

  let(:valid_attributes) {
    {name: 'Gideao', pass_hash: 'AABBCC', position: ''}
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
 
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all users as users" do
      user = User.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:users)).to eq([aluno])
    end
  end

  describe "GET #new" do
    it "assigns a new user as @user" do
      user = User.create! valid_attributes
      get :new, {}, valid_session
      expect(assigns(:uers)).to eq([user])
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #new" do
    let(:users) { [FactoryGirl.build(:user)] }

    before :each do
      get :new, {}, valid_session
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end
      
      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:aluno => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

end  
