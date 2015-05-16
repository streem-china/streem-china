require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  let(:user) { create :user }
  before { sign_in user }
  let(:topic) { create :topic }
  let(:reply) { create(:reply, topic: topic, user: user) }

  describe 'create' do
    it 'should respond ok with create.js' do
      post :create, reply: { topic_id: topic.id, body: '### Hello' }, format: :js

      assert_response :ok
    end
  end

  describe 'edit' do
    it 'should respond ok' do
      get :edit, id: reply.id

      assert_response :ok
    end
  end

  describe 'update' do
    it 'should redirect_to reply anchor if reply saved success' do
      put :update, id: reply.id, reply: { body: '### Hello' }

      assert_redirected_to topic_path(reply.topic,
                                      page: Reply.page_of_floor(reply.floor),
                                      anchor: "reply-#{reply.floor}")
    end

    it 'should render edit if reply saved faield' do
      put :update, id: reply.id, reply: { body: nil }

      assert_response :ok
      assert_template :edit
    end
  end

  describe 'destroy' do
    it 'should respond no_content if reply destroy success' do
      delete :destroy, id: reply.id

      assert_response :no_content
    end

    it 'should respond not_found if reply not found' do
      delete :destroy, id: 0

      assert_response :not_found
    end
  end
end


