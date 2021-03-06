require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe PreferenciaController, type: :controller do

  let(:valid_attributes) {
    {ordem: '1'}
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
 
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all preferencias as preferencias" do
      preferencia = Preferencia.create! valid_attributes
      get :index, {:id => aluno.id}, valid_session
      expect(assigns(:preferencias)).to eq([preferencia])
    end
  end

  #describe "GET #show" do
  #  it "assigns the requested aluno as @aluno" do
  #    aluno = Aluno.create! valid_attributes
  #    get :show, {:id => aluno.to_param}, valid_session
  #    expect(assigns(:aluno)).to eq(aluno)
  #  end
  #end

  describe "GET #new" do
    it "assigns a new preferencia as @preferencia" do
      preferencia = Preferencia.create! valid_attributes
      get :new, {}, valid_session
      expect(assigns(:preferencias)).to eq([preferencia])
      expect(assigns(:preferencia)).to be_a_new(Preferencia)
    end
  end

  describe "GET #new" do
    let(:preferencias) { [FactoryGirl.build(:preferencia)] }

    before :each do
      get :new, {}, valid_session
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Preferencia" do
        expect {
          post :create, {:preferencia => valid_attributes}, valid_session
        }.to change(Preferencia, :count).by(1)
      end
      
      it "assigns a newly created preferencia as @preferencia" do
        post :create, {:preferencia => valid_attributes}, valid_session
        expect(assigns(:preferencia)).to be_a(Preferencia)
        expect(assigns(:preferencia)).to be_persisted
      end

      it "redirects to the created preferencia" do
        post :create, {:preferencia => valid_attributes}, valid_session
        expect(response).to redirect_to(Preferencia.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved preferencia as @preferencia" do
        post :create, {:preferencia => invalid_attributes}, valid_session
        expect(assigns(:preferencia)).to be_a_new(Preferencia)
      end

      it "re-renders the 'new' template" do
        post :create, {:preferencia => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

end  
