require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @other_user = users(:michael)
    @micropost = @user.microposts.create!(content: "Lorem ipsum")
    @comment = @other_user.comments.build(
      content: "this is a comment!",
      micropost_id: @micropost.id
    )
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user_id should be valid" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "micropost_id should be valid" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end

  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "content should be at most 140 characters" do
    @comment.content = "a" * 141
    assert_not @comment.valid?
  end

  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
end
