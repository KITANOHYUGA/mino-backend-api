# app/models/attendance_record.rb

class Attendance
    include Dynamoid::Document
  
    # テーブル名を指定します。namespace設定と組み合わされて、最終的なテーブル名になります。
    table name: :attendance_records, key: :id
  
    # プライマリキー（パーティションキー）を定義します。
    # 勤怠レコードを一意に識別するためのIDです。
    field :id, :string
  
    # 勤怠レコードの属性（カラム）を定義します。
    field :user_id, :string    # ユーザーを一意に識別するID
    field :clock_in_time, :datetime # 出勤時間
    field :clock_out_time, :datetime # 退勤時間
    field :date, :date       # 勤怠記録の日付
    field :status, :string    # 勤怠状況（例: '出勤', '休暇'）
  
    # 複合キー（パーティションキーとソートキー）を使う場合は、
    # range_key を使ってソートキーを定義します。
    # 例: range_key :date, :string
  
    # インデックスを定義することで、特定のフィールドで高速に検索できます。
    # 例: global_secondary_index hash_key: :user_id
  end