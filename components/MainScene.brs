'
' Church Hub Roku App - Main Scene Logic
' Manages page navigation and global app state
'

function init() as void
    m.top.observeField("focusedChild", "onFocusChange")
    m.currentPage = 0
    m.pages = [
        "versePage",
        "clockPage",
        "contactPage",
        "eventsPage",
        "announcementsPage",
        "sermonsPage"
    ]
    m.appData = InitializeAppData()
end function

function initialize() as void
    ' Fetch data from Google Sheets
    sheetsUrl = "https://your-google-sheets-url-here"
    m.appData = FetchGoogleSheetsData(sheetsUrl)
    
    ' Initialize all pages with data
    InitializePages()
    
    ' Show first page (Verse of the Day)
    ShowPage(0)
end function

function InitializePages() as void
    container = m.top.findNode("pageContainer")
    
    ' Initialize each page with app data
    for i = 0 to m.pages.Count() - 1
        page = container.findNode(m.pages[i])
        if page <> invalid
            page.callFunc("setData", m.appData)
        end if
    end for
end function

function ShowPage(pageIndex as integer) as void
    container = m.top.findNode("pageContainer")
    
    ' Hide all pages
    for i = 0 to m.pages.Count() - 1
        page = container.findNode(m.pages[i])
        if page <> invalid
            page.visible = false
        end if
    end for
    
    ' Show selected page
    selectedPage = container.findNode(m.pages[pageIndex])
    if selectedPage <> invalid
        selectedPage.visible = true
        selectedPage.setFocus(true)
    end if
    
    m.currentPage = pageIndex
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if not press
        return false
    end if
    
    if key = "left"
        ' Go to previous page
        prevPage = (m.currentPage - 1 + m.pages.Count()) mod m.pages.Count()
        ShowPage(prevPage)
        return true
    else if key = "right"
        ' Go to next page
        nextPage = (m.currentPage + 1) mod m.pages.Count()
        ShowPage(nextPage)
        return true
    else if key = "down"
        ' Handle down key on Sermons page
        if m.currentPage = 5
            container = m.top.findNode("pageContainer")
            sermonsPage = container.findNode("sermonsPage")
            if sermonsPage <> invalid
                sermonsPage.callFunc("showArchive")
            end if
        end if
        return true
    else if key = "up"
        ' Handle up key to return from archive
        container = m.top.findNode("pageContainer")
        sermonsPage = container.findNode("sermonsPage")
        if sermonsPage <> invalid
            sermonsPage.callFunc("hideArchive")
        end if
        return true
    end if
    
    return false
end function
