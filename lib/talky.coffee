SimpleWebRTC = require('simplewebrtc')
View = require('space-pen').View

class Videos extends View
    @content: ->
        @div class: 'pane', =>
            @div id: 'local'
            @div id: 'remote'

module.exports =
    activate: ->
        atom.workspaceView.appendToRight(new Videos)

        webrtc = new SimpleWebRTC
            localVideoEl: 'local',
            remoteVideosEl: 'remote',
            autoRequestMedia: true

        webrtc.on 'readyToCall', ->
            webrtc.joinRoom('talkytest')
            console.log('Joined')

        webrtc.on '*', console.log.bind(console)

    deactivate: ->

    serialize: ->


