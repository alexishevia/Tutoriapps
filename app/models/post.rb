# == Schema Information
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  group_id   :integer(4)
#  text       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Post < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :group
  has_many :replies, :as => :post, :dependent => :destroy

  validates :author, :text, :presence => true

  def group_name
    group ? group.name : I18n.t('activerecord.attributes.group.public')
  end

  def group_id
    group ? group.id : 'home'
  end
end
