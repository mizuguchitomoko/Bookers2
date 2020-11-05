class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :profile_image, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image
  
  has_many :active_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower # 自分がフォローしている人
  has_many :passive_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :followed # 自分をフォローしている人
  
  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(followed_id: user.id).present?
  end
  
  validates :name, presence: :true,
                   length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
  
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
  
  def self.search(search,word)
    if search == "forward_match"
    @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
    @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
    @user = User.where("#{word}")
    elsif search == "partial_match"
    @user = User.where("name LIKE?","%#{word}%")
    else
    @user = User.all
  end
  end
end
