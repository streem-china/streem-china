require 'test_helper'

class MarkdownableTest < ActiveSupport::TestCase
  let(:topic) { create(:topic) }

  describe 'callbacks' do
    it 'should parse body html before save' do
      topic.body_html.wont_be_nil
    end
  end

  describe 'without_body scope' do
    it 'should without body and body_html attributes' do
      topic = create(:topic)
      topic = Topic.without_body.first

      topic.attribute_names.wont_include 'body_html'
      topic.attribute_names.wont_include 'body'
    end
  end
end

