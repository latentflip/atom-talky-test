SimpleWebRTC = require('simplewebrtc')

module.exports =
    activate: ->
        el = document.createElement('div')
        el.id = 'remote'
        document.body.appendChild(el)

        el = document.createElement('div')
        el.id = 'local'
        document.body.appendChild(el)

        webrtc = new SimpleWebRTC
            localVideoEl: 'local',
            remoteVideosEl: 'remote',
            autoRequestMedia: true

        webrtc.on 'readyToCall', ->
            webrtc.joinRoom('talkytest')
            console.log('Joined')

    deactivate: ->

    serialize: ->


