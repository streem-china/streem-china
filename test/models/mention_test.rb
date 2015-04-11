require 'test_helper'

class MentionTest < ActiveSupport::TestCase
  describe 'callbacks' do
    let(:user) { create(:user) }
    let(:mention) { create(:mention, user: user) }

    it 'should create notifications after create' do
      mention.user.notifications.to_a.wont_be_empty
    end
  end
end

