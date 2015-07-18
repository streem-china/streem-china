$(document).on 'ready page:load', ->
  if $('.topic-form #upload, .reply-form #upload').length
    uploader = $('#upload')
    domain = uploader.data('qiniu-domain')
    topic_id = uploader.data('topic-id')

    Qiniu.uploader
      runtimes: 'html5,flash,html4',
      browse_button: 'upload',
      uptoken_url: '/qiniu_uptoken',
      max_file_size: '4mb',
      domain: domain,
      auto_start: true,
      init:
        FilesAdded: (up, files) ->
          plupload.each files, (file) ->
        BeforeUpload: (up, file) ->
          uploader.text(' 0%')
        UploadProgress: (up, file) ->
          uploader.text(' ' + file.percent + '%')
        FileUploaded: (up, file, info) ->
          reply_textarea = uploader.parents('form').find('textarea')
          old_value = reply_textarea.val()
          old_value = old_value + '\n' if old_value
          new_value = old_value + '![](' + domain + JSON.parse(info).key + '?imageView/2/w/600)\n'
          reply_textarea.val(new_value).focus().trigger('autosize.resize')
        Error: (up, err, errTip) ->
          if err.message
            Flash.notify(err.message, 'alert')
          else
            Flash.notify(err.response, 'alert')
        UploadComplete: ->
          uploader.text('')
        Key: (up, file) ->
          "topics/#{topic_id}/#{md5(Date.now())}"

  if $('#upload-avatar').length
    uploader = $('#upload-avatar')
    old_url = uploader.find('img').attr('src')
    domain = uploader.data('qiniu-domain')
    user_id = uploader.data('user-id')

    Qiniu.uploader
      runtimes: 'html5,flash,html4',
      browse_button: 'upload-avatar',
      uptoken_url: '/qiniu_uptoken',
      max_file_size: '2mb',
      domain: domain,
      auto_start: true,
      init:
        FilesAdded: (up, files) ->
          plupload.each files, (file) ->
        BeforeUpload: (up, file) ->
          uploader.html('<i class="fa fa-spin fa-spinner" style="position: absolute; left: 43px; top: 43px; color: black"></i>')
        UploadProgress: (up, file) ->
        FileUploaded: (up, file, info) ->
          url = domain + JSON.parse(info).key + '?imageView/1/w/150'
          image = '<img src="' + url + '" alt="Avatar">'
          $.ajax '/avatar.js',
            method: 'put'
            data:
              url: url
          uploader.html(image)

          $('.top-bar .avatar').attr('src', url)

          Flash.notify(I18n.t('user.change_avatar_success'), 'success')
        Error: (up, err, errTip) ->
          image = '<img src="' + old_url + '" alt="Avatar">'
          uploader.html(image)

          if err.message
            Flash.notify(err.message, 'alert')
          else
            Flash.notify(err.response, 'alert')
        UploadComplete: ->
        Key: (up, file) ->
          "avatars/#{user_id}/#{md5(Date.now())}"
