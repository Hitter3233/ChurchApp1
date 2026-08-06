'
' Church Hub Roku App - Clock Page Logic
' Displays current time and next service time
'

function init() as void
    m.clockDisplay = m.top.findNode("clockDisplay")
    m.nextServiceTime = m.top.findNode("nextServiceTime")
    m.background = m.top.findNode("background")
    
    ' Start clock update timer
    m.timer = CreateObject("roTimer")
    m.timer.mark()
end function

function setData(appData as object) as void
    if appData = invalid
        return
    end if
    
    ' Get service times from app data
    if appData.serviceTimes <> invalid
        m.serviceTimes = appData.serviceTimes
    end if
    
    ' Set background image
    if appData.backgroundUrl <> invalid and appData.backgroundUrl <> ""
        m.background.uri = appData.backgroundUrl
    end if
    
    ' Start updating clock
    UpdateClock()
end function

function UpdateClock() as void
    ' Get current time
    now = CreateObject("roDateTime")
    timeString = now.GetHours().toStr() + ":" + PadZero(now.GetMinutes()) + ":" + PadZero(now.GetSeconds())
    
    m.clockDisplay.text = timeString
    
    ' Calculate and display next service time
    nextService = GetNextServiceTime()
    if nextService <> invalid
        m.nextServiceTime.text = nextService
    end if
end function

function GetNextServiceTime() as string
    if m.serviceTimes = invalid
        return "No services scheduled"
    end if
    
    now = CreateObject("roDateTime")
    currentTime = now.GetHours() * 60 + now.GetMinutes()
    
    ' Find next service time
    for each service in m.serviceTimes
        serviceTime = ParseTimeString(service)
        if serviceTime > currentTime
            return FormatTimeString(serviceTime)
        end if
    end for
    
    ' If no service today, show first service tomorrow
    return "Tomorrow at " + m.serviceTimes[0]
end function

function ParseTimeString(timeStr as string) as integer
    ' Parse "HH:MM" format to minutes
    parts = timeStr.split(":")
    if parts.count() = 2
        hours = val(parts[0])
        minutes = val(parts[1])
        return hours * 60 + minutes
    end if
    return 0
end function

function FormatTimeString(minutes as integer) as string
    hours = minutes / 60
    mins = minutes mod 60
    return hours.toStr() + ":" + PadZero(mins)
end function

function PadZero(num as integer) as string
    if num < 10
        return "0" + num.toStr()
    else
        return num.toStr()
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
