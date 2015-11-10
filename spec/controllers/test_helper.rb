RSpec.describe AlunosController, type: :controller do

  let(:valid_attributes) {
    {name: 'Gideao', rand_pass: 'AABBCC', classe: 'C', sexo: 'M'}
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
 
  let(:valid_session) { {} }

  describe "GET #index" do
    #it "assigns all pokemons as @pokemons" do
    #  pokemon = Pokemon.create! valid_attributes
    #  get :index, {}, valid_session
    #  expect(assigns(:pokemons)).to eq([pokemon])
    end
  end
