# == Schema Information
#
# Table name: blog_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  group_id   :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#

class BlogCategory < ActiveRecord::Base
  MAIN_BLOG_ID = 1
  FEATURE_ANNOUNCEMENTS_ID = 11
end
