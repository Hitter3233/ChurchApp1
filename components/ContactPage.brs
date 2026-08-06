'
' Church Hub Roku App - Contact Page Logic
' Displays church contact information
'

function init() as void
    m.phoneNumber = m.top.findNode("phoneNumber")
    m.emailAddress = m.top.findNode("emailAddress")
    m.addressText = m.top.findNode("addressText")
    m.hoursText = m.top.findNode("hoursText")
    m.background = m.top.findNode("background")
end function

function setData(appData as object) as void
    if appData = invalid
        return
    end if
    
    ' Set contact information
    if appData.contactInfo <> invalid
        contactInfo = appData.contactInfo
        
        ' Set phone number
        if contactInfo.phone <> invalid and contactInfo.phone <> ""
            m.phoneNumber.text = contactInfo.phone
        else
            m.phoneNumber.text = "Not available"
        end if
        
        ' Set email
        if contactInfo.email <> invalid and contactInfo.email <> ""
            m.emailAddress.text = contactInfo.email
        else
            m.emailAddress.text = "Not available"
        end if
        
        ' Set address
        if contactInfo.address <> invalid and contactInfo.address <> ""
            m.addressText.text = contactInfo.address
        else
            m.addressText.text = "Address not available"
        end if
        
        ' Set service hours
        if contactInfo.hours <> invalid and contactInfo.hours <> ""
            m.hoursText.text = contactInfo.hours
        else
            m.hoursText.text = "Hours not available"
        end if
    end if
    
    ' Set background image
    if appData.backgroundUrl <> invalid and appData.backgroundUrl <> ""
        m.background.uri = appData.backgroundUrl
    end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if not press
        return false
    end if
    
    if key = "OK"
        ' Handle select action - could open contact options
        return true
    else if key = "left" or key = "right"
        ' Navigate between sections
        return true
    end if
    
    return false
end function

function FormatPhoneNumber(phone as string) as string
    ' Remove any non-digit characters
    cleanPhone = ""
    for i = 0 to len(phone) - 1
        char = mid(phone, i + 1, 1)
        if char >= "0" and char <= "9"
            cleanPhone = cleanPhone + char
        end if
    end for
    
    ' Format as (XXX) XXX-XXXX
    if len(cleanPhone) = 10
        return "(" + mid(cleanPhone, 1, 3) + ") " + mid(cleanPhone, 4, 3) + "-" + mid(cleanPhone, 7, 4)
    end if
    
    return phone
end function
