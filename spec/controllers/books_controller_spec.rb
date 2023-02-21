require 'rails_helper'

RSpec.describe "BooksController", type: :controller do
  before(:all) do
    @controller = BooksController.new
  end

  describe "GET #index" do
    let(:user) { create :user }
    before(:each) do
      sign_in user
    end

    it "assigns all books to @books" do
      book1 = create(:book)
      book2 = create(:book)
      get :index
      expect(assigns(:books)).to match_array([book1, book2])
    end

    it "assigns a shopping cart to @shopping_cart if user is signed in" do
      get :index
      expect(assigns(:shopping_cart)).to be_a(ShoppingCart)
    end
  end

  describe "GET #show" do
    let(:user) { create :user }
    before(:each) do
      sign_in user
    end
    let(:book) { create :book }

    it "assigns the requested book to @book" do
      get :show, params: { id: book.id }
      expect(assigns(:book)).to eq(book)
    end

    it "assigns reviews of the requested book to @reviews" do
      review1 = create(:review, book: book)
      review2 = create(:review, book: book)
      get :show, params: { id: book.id }
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "sets @show_user and @show_book to true and false, respectively" do
      get :show, params: { id: book.id }
      expect(assigns(:show_user)).to be(true)
      expect(assigns(:show_book)).to be(false)
    end
  end

  describe "GET #new" do
    context 'admin_signed_in?' do
      let(:admin) { create :admin }
      before(:each) do
        sign_in admin
      end

      it "assigns a new book to @book" do
        get :new
        expect(assigns(:book)).to be_a_new(Book)
      end
    end

    context 'user_signed_in?' do
      let(:user) { create :user }
      before(:each) do
        sign_in user
      end
      it "redirects to user dashboard" do
        get :new
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end

  describe "POST #create" do
    context 'admin_signed_in?' do
      let(:admin) { create :admin }
      before(:each) do
        sign_in admin
      end

      context "with valid parameters" do
        let(:valid_params) { { book: attributes_for(:book) } }

        it "creates a new book" do
          expect {
            post :create, params: valid_params
          }.to change(Book, :count).by(1)
        end

        it "redirects to the new book" do
          post :create, params: valid_params
          expect(response).to redirect_to(book_url(assigns(:book)))
        end
      end

      context "with invalid parameters" do
        let(:invalid_params) { { book: { name: nil } } }

        it "does not create a new book" do
          expect {
            post :create, params: invalid_params
          }.to_not change(Book, :count)
        end

        it "renders the new template" do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
        end
      end
    end

    context 'user_signed_in?' do
      let(:user) { create :user }
      before(:each) do
        sign_in user
      end

      context "with valid parameters" do
        let(:valid_params) { { book: attributes_for(:book) } }

        it "does not create a new book" do
          expect {
            post :create, params: valid_params
          }.to_not change(Book, :count)
        end

        it "redirects to user dashboard" do
          post :create, params: valid_params
          expect(response).to redirect_to(authenticated_root_path)
        end
      end
    end
  end

  describe "GET #edit" do
    context 'admin_signed_in?' do
      let(:admin) { create :admin }
      before(:each) do
        sign_in admin
      end
      let(:book) { create(:book) }

      it "assigns the requested book to @book" do
        get :edit, params: { id: book.id }
        expect(assigns(:book)).to eq(book)
      end
    end

    context 'user_signed_in?' do
      let(:user) { create :user }
      before(:each) do
        sign_in user
      end
      let(:book) { create(:book) }

      it "redirects to user dashboard" do
        get :edit, params: { id: book.id }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end

  describe "PUT #update" do
    context 'admin_signed_in?' do
      let(:admin) { create :admin }
      before(:each) do
        sign_in admin
      end
      let(:book) { create(:book) }

      context "with valid parameters" do
        let(:valid_params) { { id: book.id, book: { name: "New Name" } } }

        it "updates the requested book" do
          put :update, params: valid_params
          book.reload
          expect(book.name).to eq("New Name")
        end
      end
    end

    context 'user_signed_in?' do
      let(:user) { create :user }
      before(:each) do
        sign_in user
      end
      let(:book) { create(:book) }

      context "with valid parameters" do
        let(:valid_params) { { id: book.id, book: { name: "New Name" } } }

        it 'does not update the requested book' do
          put :update, params: valid_params
          book.reload
          expect(book.name).not_to eq("New Name")
        end
      end
    end
  end
end