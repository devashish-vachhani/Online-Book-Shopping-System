class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    if params[:book_id]
      @book = Book.find(params[:book_id])
      @q = @book.reviews.ransack(params[:q])
      @reviews = @q.result(distinct: true)
      @show_user = true
      @show_book = false
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @q = @user.reviews.ransack(params[:q])
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
    if @book.nil?
      @book = Book.find(params[:book_id])
    end
  end

  # GET /reviews/1/edit
  def edit
    if @book.nil?
      @book = @review.book
    end
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to book_path(@review.book), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review.book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to request.referrer, notice: 'Review was successfully updated.' }
        format.json { render json: { redirect_to: request.referrer } }
      else
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
      params.require(:review).permit(:rating, :review, :book_id)
    end
end
