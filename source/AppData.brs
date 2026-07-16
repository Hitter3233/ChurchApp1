'
' Church Hub Roku App - Application Data Manager
' Manages cached app data and provides data access methods
'

function InitializeAppData() as object
    data = {}
    
    ' Verse of the Day
    data.verse = {
        text: ""
        reference: ""
        backgroundUrl: ""
    }
    
    ' Clock page data
    data.clock = {
        backgroundUrl: ""
        nextService: ""
    }
    
    ' Contact information
    data.contact = {
        churchName: ""
        address: ""
        phone: ""
        email: ""
        website: ""
        facebook: ""
        backgroundUrl: ""
    }
    
    ' Events list
    data.events = []
    data.eventsBackgroundUrl = ""
    
    ' Announcements list
    data.announcements = []
    data.announcementsBackgroundUrl = ""
    
    ' Sermons list
    data.sermons = []
    data.sermonsBackgroundUrl = ""
    
    ' Cache timestamps
    data.lastUpdated = GetTickCount()
    
    return data
end function

function GetVerse(appData as object) as object
    return appData.verse
end function

function SetVerse(appData as object, text as string, reference as string, backgroundUrl as string) as void
    appData.verse.text = text
    appData.verse.reference = reference
    appData.verse.backgroundUrl = backgroundUrl
end function

function GetClockData(appData as object) as object
    return appData.clock
end function

function SetClockData(appData as object, backgroundUrl as string, nextService as string) as void
    appData.clock.backgroundUrl = backgroundUrl
    appData.clock.nextService = nextService
end function

function GetContactInfo(appData as object) as object
    return appData.contact
end function

function SetContactInfo(appData as object, contact as object) as void
    appData.contact = contact
end function

function GetEvents(appData as object) as object
    return {
        items: appData.events
        backgroundUrl: appData.eventsBackgroundUrl
    }
end function

function SetEvents(appData as object, events as object, backgroundUrl as string) as void
    appData.events = events
    appData.eventsBackgroundUrl = backgroundUrl
end function

function GetAnnouncements(appData as object) as object
    return {
        items: appData.announcements
        backgroundUrl: appData.announcementsBackgroundUrl
    }
end function

function SetAnnouncements(appData as object, announcements as object, backgroundUrl as string) as void
    appData.announcements = announcements
    appData.announcementsBackgroundUrl = backgroundUrl
end function

function GetSermons(appData as object) as object
    return {
        items: appData.sermons
        backgroundUrl: appData.sermonsBackgroundUrl
    }
end function

function SetSermons(appData as object, sermons as object, backgroundUrl as string) as void
    appData.sermons = sermons
    appData.sermonsBackgroundUrl = backgroundUrl
end function
