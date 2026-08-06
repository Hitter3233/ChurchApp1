'
' Church Hub Roku App - Data Manager
' Handles data caching, storage, and retrieval
'

function init() as void
    m.cache = {}
    m.cacheExpiry = {}
    m.cacheTTL = 3600000 ' 1 hour in milliseconds
    m.registry = CreateObject("roRegistry")
end function

function SetCacheTTL(milliseconds as integer) as void
    ' Set cache time-to-live
    if milliseconds > 0
        m.cacheTTL = milliseconds
    end if
end function

function CacheData(key as string, data as object) as void
    ' Cache data in memory with expiry time
    if key = invalid or key = ""
        return
    end if
    
    m.cache[key] = data
    
    ' Set expiry time
    now = CreateObject("roDateTime")
    now.Mark()
    expiryTime = now.AsSeconds() + (m.cacheTTL / 1000)
    m.cacheExpiry[key] = expiryTime
end function

function GetCachedData(key as string) as object
    ' Retrieve cached data if not expired
    if key = invalid or key = ""
        return invalid
    end if
    
    if not m.cache.DoesExist(key)
        return invalid
    end if
    
    ' Check if cache is expired
    now = CreateObject("roDateTime")
    now.Mark()
    currentTime = now.AsSeconds()
    
    if m.cacheExpiry.DoesExist(key)
        if currentTime > m.cacheExpiry[key]
            ' Cache expired, remove it
            m.cache.Delete(key)
            m.cacheExpiry.Delete(key)
            return invalid
        end if
    end if
    
    return m.cache[key]
end function

function ClearCache(key as string) as void
    ' Clear specific cache entry
    if key <> invalid and key <> ""
        m.cache.Delete(key)
        m.cacheExpiry.Delete(key)
    end if
end function

function ClearAllCache() as void
    ' Clear all cached data
    m.cache = {}
    m.cacheExpiry = {}
end function

function SaveToRegistry(key as string, data as object) as boolean
    ' Save data to persistent storage
    if key = invalid or key = "" or data = invalid
        return false
    end if
    
    try
        dataStr = FormatJson(data)
        m.registry.Write(key, dataStr)
        m.registry.Flush()
        return true
    catch e
        LogMessage("Error saving to registry: " + e.Message, "ERROR")
        return false
    end try
end function

function LoadFromRegistry(key as string) as object
    ' Load data from persistent storage
    if key = invalid or key = ""
        return invalid
    end if
    
    if not m.registry.Exists(key)
        return invalid
    end if
    
    try
        dataStr = m.registry.Read(key)
        data = ParseJson(dataStr)
        return data
    catch e
        LogMessage("Error loading from registry: " + e.Message, "ERROR")
        return invalid
    end try
end function

function DeleteFromRegistry(key as string) as boolean
    ' Delete data from persistent storage
    if key = invalid or key = ""
        return false
    end if
    
    try
        m.registry.Delete(key)
        m.registry.Flush()
        return true
    catch e
        LogMessage("Error deleting from registry: " + e.Message, "ERROR")
        return false
    end try
end function

function GetEvents(useCache as boolean) as object
    ' Get events with optional caching
    cacheKey = "events"
    
    if useCache
        cachedData = GetCachedData(cacheKey)
        if cachedData <> invalid
            return cachedData
        end if
    end if
    
    ' Fetch from API
    response = GetEvents()
    
    if response.success
        CacheData(cacheKey, response.data)
        SaveToRegistry(cacheKey, response.data)
    end if
    
    return response
end function

function GetSermons(useCache as boolean) as object
    ' Get sermons with optional caching
    cacheKey = "sermons"
    
    if useCache
        cachedData = GetCachedData(cacheKey)
        if cachedData <> invalid
            return cachedData
        end if
    end if
    
    ' Fetch from API
    response = GetSermons()
    
    if response.success
        CacheData(cacheKey, response.data)
        SaveToRegistry(cacheKey, response.data)
    end if
    
    return response
end function

function GetNews(useCache as boolean) as object
    ' Get news with optional caching
    cacheKey = "news"
    
    if useCache
        cachedData = GetCachedData(cacheKey)
        if cachedData <> invalid
            return cachedData
        end if
    end if
    
    ' Fetch from API
    response = GetNews()
    
    if response.success
        CacheData(cacheKey, response.data)
        SaveToRegistry(cacheKey, response.data)
    end if
    
    return response
end function

function SaveUserData(userData as object) as boolean
    ' Save user data locally
    if userData = invalid
        return false
    end if
    
    CacheData("userData", userData)
    return SaveToRegistry("userData", userData)
end function

function GetUserData() as object
    ' Get locally stored user data
    cachedData = GetCachedData("userData")
    if cachedData <> invalid
        return cachedData
    end if
    
    return LoadFromRegistry("userData")
end function

function ClearUserData() as boolean
    ' Clear user data
    ClearCache("userData")
    return DeleteFromRegistry("userData")
end function

function SaveAppSettings(settings as object) as boolean
    ' Save app settings
    if settings = invalid
        return false
    end if
    
    CacheData("appSettings", settings)
    return SaveToRegistry("appSettings", settings)
end function

function GetAppSettings() as object
    ' Get app settings
    cachedData = GetCachedData("appSettings")
    if cachedData <> invalid
        return cachedData
    end if
    
    settings = LoadFromRegistry("appSettings")
    if settings = invalid
        settings = GetDefaultSettings()
    end if
    
    return settings
end function

function GetDefaultSettings() as object
    ' Return default app settings
    return {
        language: "en",
        theme: "dark",
        notifications: true,
        autoPlay: false,
        quality: "high",
        fontSize: "medium"
    }
end function
