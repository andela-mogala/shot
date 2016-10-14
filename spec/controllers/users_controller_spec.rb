require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    before do
      get :new
    end
    context 'when i try to sign up' do
      it 'should display the sign up form' do
        expect(response).to render_template 'new'
      end
      it 'should have the user instance variable set' do
        expect(assigns(:user)).to be_a_new User
      end
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      let!(:initial_db_count) { User.count }
      before { post :create, user: attributes_for(:user) }

      it 'should persist the new user to database' do
        expect(User.count).to eq (initial_db_count + 1)
      end

      it 'should have a flash notice' do
        expect(flash[:notice]).to be_present
      end

      it 'should redirect the user to dashboard' do
        expect(response).to redirect_to dashboard_path
      end

      it 'should set a valid session' do
        expect(session[:id]).to_not be_nil
      end
    end

    context 'with invalid params' do
      before { post :create, user: attributes_for(:user, password: nil) }
      let!(:initial_db_count) { User.count }

      it 'should not persist to the database' do
        expect(User.count).to eq initial_db_count
      end

      it 'should display the sign up page again' do
        expect(response).to render_template 'new'
      end

      it 'should have a flash message indicating the error' do
        expect(flash[:notice]).to_not be_nil
      end
    end
  end
end
