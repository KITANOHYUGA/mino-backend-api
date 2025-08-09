# config/initializers/dynamoid.rb

Dynamoid.configure do |config|
    # DynamoDBと連携するテーブル名のプレフィックスを設定します。
    # 環境ごとに異なるプレフィックスを設定することで、
    # 開発環境と本番環境のテーブルが混在しないようにします。
    config.namespace = "frontend_#{Rails.env}"
  
    # DynamoDBが動作しているAWSリージョンを設定します。
    # 東京リージョンの場合は 'ap-northeast-1' です。
    Dynamoid.configure do |config|
        config.region = 'ap-northeast-1' # AWS上のテーブルと同じリージョン
    end
  
    # AWSの認証情報を環境変数から取得します。
    # セキュリティのため、コードに直接書き込まないようにします。
    config.access_key = ENV['AWS_ACCESS_KEY_ID']
    config.secret_key = ENV['AWS_SECRET_ACCESS_KEY']
  
    # =======================================================
    # ローカル開発時の設定
    # =======================================================
    # `Rails.env.development?`はRailsの実行環境が開発モードかどうかを判定します。
    # if Rails.env.development?
      # ローカルで起動しているDynamoDB Localのエンドポイントを指定します。
      # 通常はポート番号8000で起動します。
    #   config.endpoint = 'http://localhost:8000'
    # end
  end