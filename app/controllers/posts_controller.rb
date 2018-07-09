class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :qrcode]

  # GET /posts
  # GET /posts.json
  def index
    @posts = current_user ? Post.where(user_id: current_user.id) : Post.where(guest_id: guest_id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = @post.user_id ? User.find_by(id: @post.user_id) : nil    
  end

  def qrcode
    qr = RQRCode::QRCode.new( @post.url, :size => 7, :level => :h )
    @qr_path = qr.to_img.resize(400,400).to_data_url
    render layout: false
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    redirect_to root_path unless @my_tissue
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.key = Post.new_key
   
    if current_user
      @post.user_id = current_user.id
      @post.is_guest = false
    else
      @post.guest_id = guest_id
      @post.is_guest = true
    end
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'ティッシュを作成しました。URL、Twitter、QRコードでシェアしよう！' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    redirect_to root_path unless @my_tissue
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'ティッシュを更新しました。URL、Twitter、QRコードでシェアしよう！' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    redirect_to root_path unless @my_tissue
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'ティッシュを削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
      @my_tissue = false
      if current_user
        @my_tissue = true if @post.user_id == current_user.id
      else
        @my_tissue = true if @post.guest_id == guest_id
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.fetch(:post, {}).permit(:title, :body)
    end 
end
