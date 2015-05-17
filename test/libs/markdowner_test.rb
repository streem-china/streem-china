require 'test_helper'
require 'markdowner'

class MarkdownerTest < ActiveSupport::TestCase
  describe '.renderer' do
    it 'should return a CustomRenderer' do
      Markdowner.send(:renderer).must_be_kind_of Markdowner::CustomRenderer
    end
  end

  describe '.markdowner' do
    it 'should returns a Redcarpet::Markdown' do
      Markdowner.send(:markdowner).must_be_kind_of Redcarpet::Markdown
    end
  end

  describe '.render' do
    it 'should not be empty' do
      Markdowner.render('### Hello').must_equal "<h3>Hello</h3>\n"
    end
  end

  describe 'CustomRenderer' do
    let(:renderer) { Markdowner::CustomRenderer.new }

    describe '#paragraph' do
      it 'should not be empty' do
        renderer.paragraph('Hello').must_equal "<p>Hello</p>"
      end
    end

    describe '#parse_user_name' do
      it 'should parse user name' do
        result = renderer.send(:parse_user_name, '@streem')

        result.must_equal "<a href='/streem'> @streem </a>"
      end
    end

    describe '#parse_reply_floor' do
      it 'should parse reply floor' do
        floor_name = I18n.t('reply.floor')

        result = renderer.send(:parse_reply_floor, "#3#{floor_name}")

        result.must_equal "<a href='?page=1#reply-3'> #3#{floor_name} </a>"

        result = renderer.send(:parse_reply_floor, "#3 #{floor_name}")

        result.must_equal "<a href='?page=1#reply-3'> #3 #{floor_name} </a>"
      end

      it 'should parse reply floor' do
        floor_name = I18n.t('reply.floor')

        result = renderer.send(:parse_reply_floor, "#3  #{floor_name}")

        result.must_be_nil
      end
    end

    describe '#parse_emoji' do
      it 'should parse emoji' do
        result = renderer.send(:parse_emoji, ':smile:')

        result.must_equal "<img alt='smile' src='/images/emoji/unicode/1f604.png' style=vertical-align: middle width='16' height='16' />"
      end

      it 'should not parse' do
        result = renderer.send(:parse_emoji, ':not_exists:')

        result.must_equal ':not_exists:'
      end
    end
  end
end
