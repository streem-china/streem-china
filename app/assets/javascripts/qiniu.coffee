$(document).on 'ready page:load', ->
  if $('#upload').length
    domain = $('#upload').data('qiniu-domain')

    Qiniu.uploader
      runtimes: 'html5,flash,html4',
      browse_button: 'upload',
      uptoken_url: '/qiniu/uptoken',
      max_file_size: '20mb',
      domain: domain,
      chunk_size: '4mb',
      auto_start: true,
      init:
        FilesAdded: (up, files) ->
          plupload.each files, (file) ->
        BeforeUpload: (up, file) ->
          $('#upload').text(' 0%')
        UploadProgress: (up, file) ->
          $('#upload').text(' ' + file.percent + '%')
        FileUploaded: (up, file, info) ->
          reply_textarea = $('#upload').parents('form').find('textarea')
          new_value = reply_textarea.val() + '![](' + domain + JSON.parse(info).key + '?imageView/2/w/600)\n'
          reply_textarea.val(new_value).focus().trigger('autosize.resize')
        Error: (up, err, errTip) ->
          console.log(err)
        UploadComplete: ->
          $('#upload').text('')
        Key: (up, file) ->
          md5(Date.now())
