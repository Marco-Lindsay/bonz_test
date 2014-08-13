# == Schema Information
#
# Table name: blogs
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  subtitle         :string(255)
#  url_identifier   :string(255)
#  stylesheet       :string(255)
#  feedburner_url   :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  is_visible       :boolean          default(FALSE)
#  canonical_domain :string(255)
#  fb_commenting    :boolean          default(FALSE)
#

class Blog < ActiveRecord::Base
end
