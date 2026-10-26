# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "apiverve_news"
  spec.version       = "1.2.3"
  spec.authors       = ["APIVerve"]
  spec.email         = ["hello@apiverve.com"]

  spec.summary       = "World News API - Ruby Client"
  spec.description   = "World News is a global news API that reads about 275 outlet feeds in 29 editions and 6 languages and merges them into stories: one entry per story however many outlets carry it, ranked by that coverage. Filter by 13 topics, by the country a story is about, by the edition it ran in, or by language."
  spec.homepage      = "https://apiverve.com/marketplace/news?utm_source=ruby&utm_medium=referral&utm_content=homepage"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/apiverve/news-API/tree/main/ruby"
  spec.metadata["changelog_uri"] = "https://apiverve.com/changelog"
  spec.metadata["documentation_uri"] = "https://docs.apiverve.com/ref/news"

  spec.files = Dir.glob("{lib}/**/*") + %w[README.md LICENSE]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 1.0", "< 3.0"
  spec.add_dependency "faraday-multipart", "~> 1.0"
  spec.add_dependency "json", "~> 2.0"
end
