class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_one_attached :profile_picture, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :username, :first_name, :last_name, presence: true

  has_many :playlists, dependent: :destroy

  def avatar
    if profile_picture.attached?
      Rails.application.routes.url_helpers.rails_blob_path(profile_picture, only_path: true)
    else
      ActionController::Base.helpers.asset_path("default_avatar.png")
    end
  end
end
