class Article < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true
	validates :text, presence: true
	validates :user_id, presence: true
	validates :medium, presence: true


end
