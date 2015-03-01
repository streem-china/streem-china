require 'markdowner'

module Markdownable
  extend ActiveSupport::Concern

  included do
    before_save { parse_markdown_from_body if body_changed? }

    scope :without_body, -> do
      attributes = attribute_names - %w(body body_html)

      select(attributes)
    end
  end

  private

  def parse_markdown_from_body
    self.body_html = Markdowner.render(body)
  end
end
