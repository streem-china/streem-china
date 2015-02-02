module ApplicationHelper
  def sanitize_body_html(html)
    sanitize html,
             tags: %w(p br img h1 h2
                      h3 h4 blockquote pre code
                      b i strong em strike
                      del u a ul ol li span),
             attributes: %w(href src class title alt
                            target rel width height)
  end
end
