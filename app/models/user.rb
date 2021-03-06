class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :medicines
  has_many :friendships
  has_many :friends, through: :friendships

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    'Anonymous'
  end

  def not_friends_with?(friend_id)
    self.friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) LIKE ?", "%#{param}%")
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.search(param)
    return User.none if param.blank?

    param.strip!
    param.downcase!
    (self.first_name_matches(param) + self.last_name_matches(param) + self.email_matches(param)).uniq
  end
end
