# == Schema Information
#
# Table name: users
#
#  id                       :integer(4)      not null, primary key
#  email                    :string(255)     default(""), not null
#  encrypted_password       :string(255)     default(""), not null
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer(4)      default(0)
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  confirmation_token       :string(255)
#  confirmed_at             :datetime
#  confirmation_sent_at     :datetime
#  unconfirmed_email        :string(255)
#  authentication_token     :string(255)
#  created_at               :datetime        not null
#  updated_at               :datetime        not null
#  name                     :string(255)
#  admin                    :boolean(1)      default(FALSE), not null
#  profile_pic_file_name    :string(255)
#  profile_pic_content_type :string(255)
#  profile_pic_file_size    :integer(4)
#  profile_pic_updated_at   :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :profile_pic

  validates :email, :format => { :with => /@utp.ac.pa$/, :message =>
    "#{I18n.t('errors.messages.invalid')} - " +
    "#{I18n.t('activerecord.errors.user.email.only_utp')}" }
  validates :name, :presence => true

  has_many :posts, :dependent => :destroy
  has_many :enrollments, :dependent => :destroy
  has_many :groups, :through => :enrollments
  has_attached_file :profile_pic, :styles => { :medium => "100x100#", :thumb => "75x75#" },
    :default_url => '/assets/unknown-user.png'

  after_create :reload_enrollments

  def reload_enrollments
    for enrollment in Enrollment.where(:user_email => email)
      enrollment.search_user_by_email
      enrollment.save
    end
  end

  def readable(klass)
    klass = klass.to_s.singularize.camelcase.constantize
    if admin?
      klass.where('true')
    else
      klass.where('group_id IN(?) OR group_id IS NULL OR group_id <= 0', groups)
    end
  end

end
