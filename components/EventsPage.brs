'
' Church Hub Roku App - Events Page Logic
' Displays upcoming church events
'

function init() as void
    m.eventsList = m.top.findNode("eventsList")
    m.background = m.top.findNode("background")
    m.events = []
end function

function setData(appData as object) as void
    if appData = invalid
        return
    end if
    
    ' Set events data
    if appData.events <> invalid
        m.events = appData.events
        DisplayEvents()
    end if
    
    ' Set background image
    if appData.backgroundUrl <> invalid and appData.backgroundUrl <> ""
        m.background.uri = appData.backgroundUrl
    end if
end function

function DisplayEvents() as void
    ' Clear existing items
    m.eventsList.removeChildrenIndex(m.eventsList.getChildCount(), 0)
    
    if m.events.count() = 0
        ' Show "No events" message
        noEventsLabel = CreateObject("roSGNode", "Label")
        noEventsLabel.text = "No upcoming events"
        noEventsLabel.font = "font:MediumSystemFont"
        noEventsLabel.textColor = "0xCCCCCCFF"
        noEventsLabel.height = 60
        m.eventsList.appendChild(noEventsLabel)
        return
    end if
    
    ' Add each event
    for each event in m.events
        eventGroup = CreateEventItem(event)
        m.eventsList.appendChild(eventGroup)
    end for
end function

function CreateEventItem(event as object) as object
    eventGroup = CreateObject("roSGNode", "Group")
    eventGroup.width = 1000
    eventGroup.height = 120
    
    ' Event name
    eventName = CreateObject("roSGNode", "Label")
    eventName.text = event.name
    eventName.font = "font:MediumBoldSystemFont"
    eventName.textColor = "0x00FF00FF"
    eventName.width = 1000
    eventName.height = 40
    eventName.translation = [0, 0]
    eventGroup.appendChild(eventName)
    
    ' Event date and time
    eventDateTime = CreateObject("roSGNode", "Label")
    dateTimeStr = event.date + " at " + event.time
    eventDateTime.text = dateTimeStr
    eventDateTime.font = "font:SmallSystemFont"
    eventDateTime.textColor = "0xFFFFFFFF"
    eventDateTime.width = 1000
    eventDateTime.height = 30
    eventDateTime.translation = [0, 45]
    eventGroup.appendChild(eventDateTime)
    
    ' Event description
    eventDesc = CreateObject("roSGNode", "Label")
    eventDesc.text = event.description
    eventDesc.font = "font:SmallSystemFont"
    eventDesc.textColor = "0xCCCCCCFF"
    eventDesc.width = 1000
    eventDesc.height = 45
    eventDesc.translation = [0, 75]
    eventDesc.wordWrap = true
    eventGroup.appendChild(eventDesc)
    
    return eventGroup
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if not press
        return false
    end if
    
    if key = "OK"
        ' Handle select action
        return true
    else if key = "up" or key = "down"
        ' Navigate through events
        return true
    end if
    
    return false
end function

function FormatEventDate(dateStr as string) as string
    ' Format date as readable string
    ' Expected format: YYYY-MM-DD
    return dateStr
end function
