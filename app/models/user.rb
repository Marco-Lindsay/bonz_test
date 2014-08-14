# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  user_name   :string(255)
#  email       :string(255)
#  password    :string(255)
#  role        :integer          default(0)
#  has_picture :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

class User < ActiveRecord::Base
  class Role
    COMMENTER = 0
    CONTRIBUTOR = 1
    MANAGER = 2
    ADMIN = 3
    SUPER_ADMIN = 4
  end

  xss_terminate

  has_one :avatar, foreign_key: :user_id, class_name: 'UserProfileImage', dependent: :destroy

  validates_presence_of :user_name, :email
  validates_uniqueness_of :user_name, case_sensitive: false

  validates_presence_of :password, on: :create
  validates_confirmation_of :password, unless: lambda { |u| u.password.blank? }

  #	---------------------------------------------------------------------------
  def admin?
    role > 2
  end

  #	---------------------------------------------------------------------------
  def can_modify_blogs?(_blog_id = nil)
    admin?
  end
  alias_method :can_blog?, :can_modify_blogs?
  alias_method :can_moderate_blog_comments?, :can_modify_blogs?

  #	---------------------------------------------------------------------------
  def blog_comment_auto_approved?(options = {})
    blog_post = options[:blog_post]
    if admin? || !blog_post.is_moderated
      true
    else
      false
    end
  end
end
