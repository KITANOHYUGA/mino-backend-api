class User
    include Dynamoid::Document
  
    table name: :users, key: :id  # DynamoDBテーブル名
  
    field :name, :string
    field :email, :string
    field :role, :string
    field :created_at, :datetime
  
    # バリデーション例
    validates :name, presence: true
  end
  