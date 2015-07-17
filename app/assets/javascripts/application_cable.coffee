if App.env == 'development'
  ws_url = 'ws://localhost:28080'
else if App.env == 'production'
  ws_url = 'ws://streem-china.org:28080'

App.cable = Cable.createConsumer ws_url
