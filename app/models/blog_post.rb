class BlogPost < ApplicationRecord
    has_rich_text :content

    validates :title, presence: true
    validates :content, presence: true

    scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc)}
    scope :draft, -> { where(published_at: nil)}
    scope :published, -> { where("published_at <= ?", Time.current)}
    scope :scheduled, -> { where("published_at > ?", Time.current)}

    def draft?
        published_at.nil?
    end

    def published?
      published_at? && published_at <= Time.current
    end 
    def scheduled?
        published_at? && published_at > Time.current
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