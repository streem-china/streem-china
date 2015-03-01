class QiniuController < ApplicationController
  def uptoken
    render json: { uptoken: Qiniu.generate_upload_token(scope: Rails.application.secrets.qiniu_bucket) }
  end
end
