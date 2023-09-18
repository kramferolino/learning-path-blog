class BlogPost < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true

    scope :sorted, -> { order(published_at: :desc, updated_at: :desc)}
    scope :draft, -> { where(:published_at => nil)}
    scope :published, -> { where("published_at <= ?", Time.current)}
    scope :scheduled, -> { where("published_at > ?", Time.current)}

    def draft?
        published_at.nil?
    end

    def published?
      published_at.nil? && published_at <= Time.current
    end 
    def scheduled?
        published_at.nil? && published_at > Time.current
    end     
end

# BlogPost.all
# BlogPost.draft
# BlogPost.published
# BlogPost.sheduled

# `published_at` datetime field
# - nil
# - 1.year.ago
# - 1.year.from.now