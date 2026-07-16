'
' Church Hub Roku App - Main Entry Point
' Initializes the application and launches the main scene
'

function Main() as void
    print "Church Hub App Starting..."
    
    ' Create the screen and load the main scene
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    
    ' Load the main scene
    scene = screen.CreateScene("MainScene")
    screen.show()
    
    ' Initialize app data
    scene.callFunc("initialize")
    
    ' Event loop
    while true
        msg = wait(0, m.port)
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed()
                return
            end if
        end if
    end while
end function
