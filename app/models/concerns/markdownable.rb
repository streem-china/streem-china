require 'markdowner'

module Markdownable
  extend ActiveSupport::Concern

  included do
    before_save { markdown_body if body_changed? }
  end

  private

  def markdown_body
    self.body_html = Markdowner.render(body)
  end
end
