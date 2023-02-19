class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    if params[:reviewable]
      @q = user_signed_in? ? current_user.reviews.ransack(params[:q]) : current_admin.reviews.ransack(params[:q])
      @reviews = @q.result(distinct: true)
      @show_user = false
      @show_book = true
    else
      @show_user = true
      @show_book = true
      @q = Review.ransack(params[:q])
      @reviews = @q.result(distinct: true)
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @book ||= Book.find(params[:book_id])
  end

  # GET /reviews/1/edit
  def edit
    session[:previous_page_url] = request.referer
    @review = Review.find(params[:id])
    @book ||= @review.book
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @review.reviewable = user_signed_in? ? current_user : current_admin

    respond_to do |format|
      if @review.save
        format.html { redirect_to book_path(@review.book), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review.book }
      else
        @book = Book.find(params[:review][:book_id])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to session.delete(:previous_page_url) || authenticated_root_path, notice: 'Review was successfully updated.' }
        format.json { render json: { redirect_to: session.delete(:previous_page_url) || authenticated_root_path } }
      else
        @book = Book.find(params[:review][:book_id])
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def show_my_reviews
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :review, :book_id, :book_name)
    end
end
