'
' Church Hub Roku App - API Client
' Handles all HTTP requests and API communications
'

function init() as void
    m.baseURL = "https://api.churchhub.com"
    m.timeout = 30000
    m.headers = {}
end function

function SetBaseURL(url as string) as void
    ' Set the base URL for API requests
    if url <> invalid and url <> ""
        m.baseURL = url
    end if
end function

function SetHeader(key as string, value as string) as void
    ' Set a custom header for API requests
    if key <> invalid and value <> invalid
        m.headers[key] = value
    end if
end function

function SetTimeout(milliseconds as integer) as void
    ' Set request timeout in milliseconds
    if milliseconds > 0
        m.timeout = milliseconds
    end if
end function

function GET(endpoint as string) as object
    ' Perform GET request
    return MakeRequest("GET", endpoint, invalid)
end function

function POST(endpoint as string, body as object) as object
    ' Perform POST request
    return MakeRequest("POST", endpoint, body)
end function

function PUT(endpoint as string, body as object) as object
    ' Perform PUT request
    return MakeRequest("PUT", endpoint, body)
end function

function DELETE(endpoint as string) as object
    ' Perform DELETE request
    return MakeRequest("DELETE", endpoint, invalid)
end function

function MakeRequest(method as string, endpoint as string, body as object) as object
    ' Make HTTP request
    
    if endpoint = invalid or endpoint = ""
        return CreateErrorResponse("Invalid endpoint")
    end if
    
    ' Build full URL
    url = m.baseURL + endpoint
    
    ' Create HTTP request object
    http = CreateObject("roUrlTransfer")
    http.SetUrl(url)
    http.SetTimeout(m.timeout)
    
    ' Set headers
    headerArray = []
    headerArray.Push("Content-Type: application/json")
    headerArray.Push("Accept: application/json")
    
    ' Add custom headers
    for each key in m.headers
        headerArray.Push(key + ": " + m.headers[key])
    end for
    
    http.SetHeaders(headerArray)
    
    ' Handle request based on method
    if method = "GET"
        response = http.GetToString()
        return ParseResponse(response, http.GetResponseCode())
    else if method = "POST" or method = "PUT"
        if body <> invalid
            bodyStr = FormatJson(body)
            http.AddHeader("Content-Type", "application/json")
            response = http.PostFromString(bodyStr)
        else
            response = http.PostFromString("")
        end if
        return ParseResponse(response, http.GetResponseCode())
    else if method = "DELETE"
        response = http.DeleteRequest()
        return ParseResponse(response, http.GetResponseCode())
    end if
    
    return CreateErrorResponse("Unknown HTTP method")
end function

function ParseResponse(response as string, statusCode as integer) as object
    ' Parse HTTP response
    
    result = {
        success: false,
        statusCode: statusCode,
        data: invalid,
        error: ""
    }
    
    if statusCode >= 200 and statusCode < 300
        result.success = true
        
        if response <> invalid and response <> ""
            try
                data = ParseJson(response)
                result.data = data
            catch e
                result.error = "Failed to parse response: " + e.Message
            end try
        end if
    else
        result.success = false
        result.error = "HTTP Error " + statusCode.ToStr() + ": " + response
    end if
    
    return result
end function

function CreateErrorResponse(message as string) as object
    return {
        success: false,
        statusCode: 0,
        data: invalid,
        error: message
    }
end function

function GetEvents() as object
    ' Get list of upcoming events
    return GET("/events")
end function

function GetEventDetails(eventId as string) as object
    ' Get details for a specific event
    if eventId = invalid or eventId = ""
        return CreateErrorResponse("Invalid event ID")
    end if
    return GET("/events/" + eventId)
end function

function GetSermons() as object
    ' Get list of sermons
    return GET("/sermons")
end function

function GetSermonDetails(sermonId as string) as object
    ' Get details for a specific sermon
    if sermonId = invalid or sermonId = ""
        return CreateErrorResponse("Invalid sermon ID")
    end if
    return GET("/sermons/" + sermonId)
end function

function GetNews() as object
    ' Get church news
    return GET("/news")
end function

function GetAboutInfo() as object
    ' Get church information
    return GET("/church/about")
end function

function GetContact() as object
    ' Get church contact information
    return GET("/church/contact")
end function

function SubmitContactForm(data as object) as object
    ' Submit contact form
    if data = invalid
        return CreateErrorResponse("Invalid form data")
    end if
    return POST("/contact/submit", data)
end function

function Login(email as string, password as string) as object
    ' Authenticate user
    if email = invalid or password = invalid
        return CreateErrorResponse("Email and password required")
    end if
    
    body = {
        email: email,
        password: password
    }
    
    return POST("/auth/login", body)
end function

function Register(userData as object) as object
    ' Register new user
    if userData = invalid
        return CreateErrorResponse("Invalid user data")
    end if
    
    return POST("/auth/register", userData)
end function

function GetUserProfile(userId as string) as object
    ' Get user profile
    if userId = invalid or userId = ""
        return CreateErrorResponse("Invalid user ID")
    end if
    return GET("/users/" + userId)
end function

function UpdateUserProfile(userId as string, data as object) as object
    ' Update user profile
    if userId = invalid or data = invalid
        return CreateErrorResponse("Invalid parameters")
    end if
    return PUT("/users/" + userId, data)
end function

function Logout() as object
    ' Logout user
    return POST("/auth/logout", {})
end function
