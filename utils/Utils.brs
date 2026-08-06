'
' Church Hub Roku App - Utility Functions
' Common helper functions used across the app
'

function ParseJSON(jsonString as string) as object
    ' Parse JSON string into an object
    if jsonString = invalid or jsonString = ""
        return {}
    end if
    
    ' Use built-in BrightScript JSON parser
    json = ParseJson(jsonString)
    return json
end function

function FormatJSON(obj as object) as string
    ' Convert object to formatted JSON string
    if obj = invalid
        return "{}"
    end if
    
    return FormatJson(obj)
end function

function IsValidEmail(email as string) as boolean
    ' Validate email format
    if email = invalid or email = ""
        return false
    end if
    
    ' Basic email validation
    if email.Instr("@") = -1 or email.Instr(".") = -1
        return false
    end if
    
    ' Check for valid format
    parts = email.Split("@")
    if parts.Count() <> 2
        return false
    end if
    
    if parts[0] = "" or parts[1] = ""
        return false
    end if
    
    return true
end function

function IsValidPhone(phone as string) as boolean
    ' Validate phone number format
    if phone = invalid or phone = ""
        return false
    end if
    
    ' Remove non-digit characters
    cleanPhone = ""
    for i = 0 to len(phone) - 1
        char = mid(phone, i + 1, 1)
        if char >= "0" and char <= "9"
            cleanPhone = cleanPhone + char
        end if
    end for
    
    ' Check if valid length (10 digits for US)
    return len(cleanPhone) >= 10
end function

function TrimString(str as string) as string
    ' Trim whitespace from string
    if str = invalid
        return ""
    end if
    
    ' Trim leading whitespace
    startIdx = 0
    for i = 0 to len(str) - 1
        char = mid(str, i + 1, 1)
        if char <> " " and char <> chr(9) and char <> chr(10) and char <> chr(13)
            startIdx = i
            exit for
        end if
    end for
    
    ' Trim trailing whitespace
    endIdx = len(str) - 1
    for i = len(str) - 1 to 0 step -1
        char = mid(str, i + 1, 1)
        if char <> " " and char <> chr(9) and char <> chr(10) and char <> chr(13)
            endIdx = i
            exit for
        end if
    end for
    
    if endIdx < startIdx
        return ""
    end if
    
    return mid(str, startIdx + 1, endIdx - startIdx + 1)
end function

function CapitalizeString(str as string) as string
    ' Capitalize first letter of string
    if str = invalid or str = ""
        return ""
    end if
    
    first = mid(str, 1, 1).ToUpper()
    rest = mid(str, 2)
    return first + rest
end function

function FormatDate(dateStr as string, format as string) as string
    ' Format date string
    ' Input format: YYYY-MM-DD
    ' Output formats: "short" (MM/DD/YY), "long" (Month Day, Year)
    
    if dateStr = invalid or dateStr = ""
        return ""
    end if
    
    parts = dateStr.Split("-")
    if parts.Count() <> 3
        return dateStr
    end if
    
    year = parts[0]
    month = parts[1]
    day = parts[2]
    
    if format = "short"
        return month + "/" + day + "/" + right(year, 2)
    else if format = "long"
        monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        monthIdx = int(month) - 1
        if monthIdx >= 0 and monthIdx < monthNames.Count()
            monthName = monthNames[monthIdx]
        else
            monthName = month
        end if
        return monthName + " " + day + ", " + year
    end if
    
    return dateStr
end function

function GetCurrentDateTime() as object
    ' Get current date and time
    now = CreateObject("roDateTime")
    now.Mark()
    
    return {
        date: now.GetString().Left(10),
        time: now.GetString().Mid(12, 8),
        timestamp: now.AsSeconds()
    }
end function

function LogMessage(message as string, level as string) as void
    ' Log message to debug output
    if level = invalid
        level = "INFO"
    end if
    
    timestamp = GetCurrentDateTime().time
    logLine = "[" + timestamp + "] [" + level + "] " + message
    print logLine
end function

function CreateArray() as object
    ' Create empty array
    return []
end function

function CreateObject_Wrapper(objType as string, id as string) as object
    ' Wrapper for creating BrightScript objects
    if id <> invalid and id <> ""
        obj = CreateObject(objType, id)
    else
        obj = CreateObject(objType)
    end if
    
    return obj
end function
