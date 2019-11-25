require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
    @comment = comments(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:lana))
    assert_no_difference 'Comment.count' do
      delete micropost_path(@comment)
    end
    assert_redirected_to root_url
  end
end
