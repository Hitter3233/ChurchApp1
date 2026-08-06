'
' Church Hub Roku App - Verse Page Logic
' Displays Verse of the Day with background and formatting
'

function init() as void
    m.verseText = m.top.findNode("verseText")
    m.verseReference = m.top.findNode("verseReference")
    m.background = m.top.findNode("background")
    m.logo = m.top.findNode("logo")
end function

function setData(appData as object) as void
    if appData = invalid
        return
    end if
    
    verseData = GetVerse(appData)
    
    ' Set verse text
    if verseData.text <> invalid and verseData.text <> ""
        m.verseText.text = verseData.text
    else
        m.verseText.text = "Loading verse..."
    end if
    
    ' Set verse reference
    if verseData.reference <> invalid and verseData.reference <> ""
        m.verseReference.text = verseData.reference
    else
        m.verseReference.text = "Bible Verse"
    end if
    
    ' Set background image
    if verseData.backgroundUrl <> invalid and verseData.backgroundUrl <> ""
        m.background.uri = verseData.backgroundUrl
    end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if not press
        return false
    end if
    
    if key = "OK"
        ' Handle select action
        return true
    end if
    
    return false
end function
