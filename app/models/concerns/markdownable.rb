require 'markdowner'

module Markdownable
  extend ActiveSupport::Concern

  included do
    before_save { parse_markdown_from_body if body_changed? }
  end

  private

  def parse_markdown_from_body
    self.body_html = Markdowner.render(body)
  end
end
