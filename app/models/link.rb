require 'mechanize'
class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits

  scope :newest_first, -> { order("links.created_at DESC").limit(5) }
  scope :popular, -> { order("links.clicks DESC").limit(5) }
  scope :find_url, -> { select('given_url').where(slug: :slug) }

  validates :given_url, presence: true
  validates :slug,      uniqueness: true,
                        presence: true

  after_create :scrape_title

  def scrape_title
    self.title = Mechanize.new.get(given_url).title
    save
  end

  def display_slug
    ENV['BASE_URL'] + slug
  end
end
