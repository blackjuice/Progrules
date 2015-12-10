require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe AlunoController, type: :controller do

  let(:valid_attributes) {
    {name: 'Gideao', rand_pass: 'AABBCC', classe: 'C', sexo: 'M'}
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
 
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all alunos as alunos" do
      aluno = Aluno.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:alunos)).to eq([aluno])
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
    it "assigns a new aluno as @aluno" do
      aluno = Aluno.create! valid_attributes
      get :new, {}, valid_session
      expect(assigns(:alunos)).to eq([aluno])
      expect(assigns(:aluno)).to be_a_new(Aluno)
    end
  end

  describe "GET #new" do
    let(:alunos) { [FactoryGirl.build(:aluno)] }

    before :each do
      get :new, {}, valid_session
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Aluno" do
        expect {
          post :create, {:aluno => valid_attributes}, valid_session
        }.to change(Aluno, :count).by(1)
      end
      
      it "assigns a newly created aluno as @aluno" do
        post :create, {:aluno => valid_attributes}, valid_session
        expect(assigns(:aluno)).to be_a(Aluno)
        expect(assigns(:aluno)).to be_persisted
      end

      it "redirects to the created aluno" do
        post :create, {:aluno => valid_attributes}, valid_session
        expect(response).to redirect_to(Aluno.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved aluno as @aluno" do
        post :create, {:aluno => invalid_attributes}, valid_session
        expect(assigns(:aluno)).to be_a_new(Aluno)
      end

      it "re-renders the 'new' template" do
        post :create, {:aluno => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

end  
