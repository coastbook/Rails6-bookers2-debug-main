class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @books = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @books = Book.where("title LIKE?","%#{word}%")
    else
      @books = Book.all
    end
  end

end
