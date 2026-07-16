'
' Church Hub Roku App - Google Sheets Data Fetcher
' Handles all communication with Google Sheets and data parsing
'

function FetchGoogleSheetsData(sheetsUrl as string) as object
    print "Fetching data from Google Sheets: " + sheetsUrl
    
    data = InitializeAppData()
    
    ' Create HTTP request
    http = CreateObject("roUrlTransfer")
    http.SetUrl(sheetsUrl)
    http.SetCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    
    ' Set timeout
    http.SetTimeout(30)
    
    ' Perform request
    response = http.GetToString()
    
    if response <> invalid
        ' Parse JSON response
        parsedData = ParseJson(response)
        
        if type(parsedData) = "roAssociativeArray"
            ' Extract and populate app data
            if parsedData.Does("verse")
                verseData = parsedData.verse
                SetVerse(data, verseData.text, verseData.reference, verseData.backgroundUrl)
            end if
            
            if parsedData.Does("clock")
                clockData = parsedData.clock
                SetClockData(data, clockData.backgroundUrl, clockData.nextService)
            end if
            
            if parsedData.Does("contact")
                SetContactInfo(data, parsedData.contact)
            end if
            
            if parsedData.Does("events")
                SetEvents(data, parsedData.events, parsedData.eventsBackgroundUrl)
            end if
            
            if parsedData.Does("announcements")
                SetAnnouncements(data, parsedData.announcements, parsedData.announcementsBackgroundUrl)
            end if
            
            if parsedData.Does("sermons")
                ' Limit to 10 most recent sermons
                sermons = parsedData.sermons
                if sermons.Count() > 10
                    sermons = sermons.Slice(0, 10)
                end if
                SetSermons(data, sermons, parsedData.sermonsBackgroundUrl)
            end if
            
            data.lastUpdated = GetTickCount()
            return data
        end if
    else
        print "Failed to fetch Google Sheets data"
    end if
    
    return data
end function

function ParseJson(jsonString as string) as object
    ' Use Roku's built-in JSON parser
    json = CreateObject("roJson")
    json.Parse(jsonString)
    return json.GetData()
end function

function DownloadImage(imageUrl as string) as object
    print "Downloading image: " + imageUrl
    
    http = CreateObject("roUrlTransfer")
    http.SetUrl(imageUrl)
    http.SetCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.SetTimeout(30)
    
    ' Download to temp file
    tempFile = "tmp:/downloaded_image.tmp"
    success = http.GetToFile(tempFile)
    
    if success
        return tempFile
    else
        print "Failed to download image: " + imageUrl
        return invalid
    end if
end function
