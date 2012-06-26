# == Schema Information
#
# Table name: enrollments
#
#  id         :integer(4)      not null, primary key
#  user_email :string(255)
#  group_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer(4)
#

class Enrollment < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  before_validation :search_user_by_email
  validates :group, :presence => true
  validates :user_id, :user_email, :uniqueness => {:scope => :group_id}
  validates :user_id, :presence => {:unless => :user_email}
  validates :user_email, :allow_nil => true, :format => { :with => /@utp.ac.pa$/, :message =>
    "#{I18n.t('errors.messages.invalid')} - " +
    "#{I18n.t('activerecord.errors.user.email.only_utp')}" }
  validates :user_id, :existence => { :allow_nil => true }

  def user_identifier
    user_id || user_email
  end

  def user_name
    return user.name if user
    user_email
  end

  def as_json(options = {})
    super(options.merge(:methods => [ :user_name ]))
  end

  def serializable_hash(options = nil)
    options ||= {}
    options[:methods] ||= []
    options[:methods] += [:user_name]
    options[:methods].uniq!
    super(options)
  end

  def search_user_by_email
    if !user and user_email
      user = User.find_by_email(user_email)
      if user
        self.user_email = nil
        self.user = user
      end
    end
  end

end
