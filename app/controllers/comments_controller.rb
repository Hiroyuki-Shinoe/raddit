class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # POST /comments
  # POST /comments.json
  def create
    # まず、 作成するcommentをどのlinkと結びつけるのかを判別するために、
    # paramsで link_id を取得し、対応するデータを @link に入れる。
    @link = Link.find(params[:link_id])
    # @link に結びつけた状態で、 comment_paramsで取得したcommentデータを
    # @commentに入れる。
    @comment = @link.comments.new(comment_params)
    # comment をどの userと結びつけるのかを判別するための記述を書く。
    @comment.user = current_user

    # respond_to はクライアント側からの指定に応じて、
    # html やjsonでの表示を切り替えるための記述。
    # url の末尾に html と指定すれば、 format.html {} の記述が表示に使用される
    # url の末尾に json と指定すれば、format.json {} の記述が表示に使用される
    # url の末尾に何も指定しなければ、使用される viewファイルのデフォルトと同じ形式が
    # format.html か format.jason から選択され表示に使われる。
    respond_to do |format|
      if @comment.save
        # comments#show ではなく、links#showへredirectさせるように書き換える。
      # format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.html { redirect_to @link, notice: 'Comment was successfully created.' }
        # comments#show をrender するのではなく、 @comment の中身を表示する。
      # format.json { render action: 'show', status: :created, location: @comment }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      # commentを削除した時、 comments#index へ飛ばすのではなく、
      # 元のurlへ戻すように書き換える。
    # format.html { redirect_to comments_url }
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
end
