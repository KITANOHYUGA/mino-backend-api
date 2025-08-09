class Api::AttendancesController < ApplicationController
    # 認証済みユーザーのみアクセス可能とする
    before_action :authenticate_user!
  
    def create
      record_date = Date.current
      
      # ユーザーと今日の日付に紐づく勤怠レコードを検索
      attendance_record = Attendance.find_by(user_id: current_user.id, date: record_date)
  
      if params[:type] == 'clock_in'
        if attendance_record.nil?
          # 勤怠レコードが存在しない場合は新規作成（出勤打刻）
          attendance_record = Attendance.create!(
            id: SecureRandom.uuid,
            user_id: current_user.id,
            date: record_date,
            clock_in_time: Time.current
          )
          render json: attendance_record, status: :created
        else
          # 既に勤怠レコードが存在する場合はエラー
          render json: { error: '出勤は既に記録されています。' }, status: :conflict
        end
      elsif params[:type] == 'clock_out'
        if attendance_record.present? && attendance_record.clock_out_time.nil?
          # 勤怠レコードが存在し、かつ退勤時間が未記録の場合は更新
          attendance_record.update_attributes!(clock_out_time: Time.current)
          render json: attendance_record, status: :ok
        else
          # 勤怠レコードがない、または退勤時間が既に記録されている場合はエラー
          render json: { error: '退勤打刻に失敗しました。出勤記録を確認してください。' }, status: :unprocessable_entity
        end
      else
        render json: { error: '不正なリクエストです。' }, status: :bad_request
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  
    def index
      # ログイン中のユーザーの勤怠記録一覧を取得
      attendance_records = Attendance.where(user_id: current_user.id).all
      render json: attendance_records
    end
  
    private
  
    def authenticate_user!
      # ここに認証ロジックを実装します
      # 例：ヘッダーからトークンを取得し、ユーザーを特定する
    end
  end