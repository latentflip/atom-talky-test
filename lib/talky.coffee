SimpleWebRTC = require('simplewebrtc')
View = require('space-pen').View

class Videos extends View
    @content: ->
        @div class: 'pane', =>
            @div id: 'local'
            @div id: 'remote'
            @ul id: 'chat'
            @input name: 'message', keyup: 'sendChat'

    addChat: (message) ->
        @find('#chat').append "<li>#{message}</li>"

    doSendChat: (message) ->

    sendChat: (e) =>
        if e.which == 13
            @doSendChat msg = @find('input').val()
            @find('input').val('')
            @addChat(msg)
            return false
        return true

module.exports =
    activate: ->
        video = new Videos

        atom.workspaceView.appendToRight(video)

        window.webrtc = webrtc = new SimpleWebRTC
            localVideoEl: 'local',
            remoteVideosEl: 'remote',
            autoRequestMedia: true

        webrtc.on 'readyToCall', ->
            webrtc.joinRoom('talkytest')
            console.log('Joined')

        webrtc.on 'channelOpen', console.log.bind(console)

        webrtc.on '*', ->
            console.log arguments

        webrtc.on 'message', (type, message) ->
            if type == 'unreliable'
                video.addChat(message)

        video.doSendChat = (message) ->
            webrtc.webrtc.peers.forEach (peer) ->
                if peer.channels.unreliable
                    peer.channels.unreliable.send message

    deactivate: ->

    serialize: ->


