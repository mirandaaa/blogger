class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    self.tags.collect(&:name).join(',')
  end

  def tag_list=(tags_string)
    tags = tags_string.split(",").each{ |s| s.strip.downcase }.uniq
    new_or_found_tags = tags.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
