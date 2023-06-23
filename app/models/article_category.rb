class ArticleCategory < ApplicationRecord
  # many-to-many associations
  belongs_to :article
  belongs_to :category
end
