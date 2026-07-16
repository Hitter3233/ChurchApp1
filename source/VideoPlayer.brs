'
' Church Hub Roku App - Video Player Manager
' Handles Vimeo video playback
'

function PlayVimeoVideo(vimeoUrl as string) as void
    print "Playing Vimeo video: " + vimeoUrl
    
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    
    ' Create video player scene
    videoNode = screen.CreateScene("VideoPlayer")
    videoNode.content = CreateVideoContent(vimeoUrl)
    screen.show()
    
    ' Handle video player events
    while true
        msg = wait(0, m.port)
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed()
                return
            end if
        end if
    end while
end function

function CreateVideoContent(vimeoUrl as string) as object
    content = CreateObject("roSGNode", "ContentNode")
    content.url = vimeoUrl
    content.mediaType = "video/mp4"
    content.title = "Church Sermon"
    content.description = "Streaming from Vimeo"
    return content
end function

function GetVimeoMetadata(vimeoUrl as string) as object
    ' Extract video ID from Vimeo URL
    ' Format: https://vimeo.com/XXXXX or https://player.vimeo.com/video/XXXXX
    
    metadata = {
        url: vimeoUrl
        title: "Sermon"
        duration: 0
    }
    
    return metadata
end function
