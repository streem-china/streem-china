class QiniuController < ApplicationController
  before_action :authenticate_user!

  def uptoken
    qiniu_bucket = Rails.application.secrets.qiniu_bucket

    render json: { uptoken: Qiniu.generate_upload_token(scope: qiniu_bucket) }
  end
end
