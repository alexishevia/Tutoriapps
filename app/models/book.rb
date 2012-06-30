# == Schema Information
#
# Table name: books
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  group_id        :integer(4)
#  title           :string(255)
#  author          :string(255)
#  publisher       :string(255)
#  available       :boolean(1)      default(TRUE), not null
#  additional_info :text
#  contact_info    :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  offer_type      :string(255)
#  price           :decimal(5, 2)
#

class Book < ActiveRecord::Base
  OFFER_TYPES = %w[gift borrow loan sale]

  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :group
  has_many :replies, :as => :post

  validates :title, :author, :publisher, :offer_type, :presence => true
  validates :offer_type, :inclusion => {:in => OFFER_TYPES}
  validates :price, :numericality => { :greater_than => 0 }, :allow_blank => true
  validate :price_if_sale

  def offer_type_name
    I18n.t("activerecord.attributes.books.offer_types.#{status}")
  end

  def group_name
    group ? group.name : I18n.t('activerecord.attributes.group.public')
  end

  def group_id
    group ? group.id : 'home'
  end

  private

    def price_if_sale
      if offer_type == 'sale' or offer_type == 'loan'
        errors.add(:price, I18n.t('activerecord.errors.messages.blank')) unless price
      end
    end
end
