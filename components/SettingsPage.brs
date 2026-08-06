'
' Church Hub Roku App - Settings Page Logic
' Manages application settings
'

function init() as void
    m.settingsList = m.top.findNode("settingsList")
    m.background = m.top.findNode("background")
    m.settings = {}
end function

function setData(appData as object) as void
    if appData = invalid
        return
    end if
    
    ' Set settings data
    if appData.settings <> invalid
        m.settings = appData.settings
        DisplaySettings()
    end if
    
    ' Set background image
    if appData.backgroundUrl <> invalid and appData.backgroundUrl <> ""
        m.background.uri = appData.backgroundUrl
    end if
end function

function DisplaySettings() as void
    ' Clear existing items
    m.settingsList.removeChildrenIndex(m.settingsList.getChildCount(), 0)
    
    ' Create settings options
    settings = [
        { label: "Display", value: "Brightness & Colors" },
        { label: "Audio", value: "Volume & Sound" },
        { label: "Notifications", value: "Enable/Disable" },
        { label: "Language", value: "English" },
        { label: "Captions", value: "Off" },
        { label: "Privacy", value: "View Settings" },
        { label: "About", value: "App Version" },
        { label: "Check for Updates", value: "Latest" }
    ]
    
    for each setting in settings
        settingItem = CreateSettingItem(setting.label, setting.value)
        m.settingsList.appendChild(settingItem)
    end for
end function

function CreateSettingItem(label as string, value as string) as object
    settingGroup = CreateObject("roSGNode", "Group")
    settingGroup.width = 1000
    settingGroup.height = 60
    
    ' Setting label
    settingLabel = CreateObject("roSGNode", "Label")
    settingLabel.text = label
    settingLabel.font = "font:MediumSystemFont"
    settingLabel.textColor = "0xFFFFFFFF"
    settingLabel.width = 500
    settingLabel.height = 50
    settingLabel.translation = [0, 5]
    settingGroup.appendChild(settingLabel)
    
    ' Setting value
    settingValue = CreateObject("roSGNode", "Label")
    settingValue.text = value
    settingValue.font = "font:MediumSystemFont"
    settingValue.textColor = "0x00FF00FF"
    settingValue.width = 400
    settingValue.height = 50
    settingValue.translation = [550, 5]
    settingValue.horizAlign = "right"
    settingGroup.appendChild(settingValue)
    
    ' Divider line
    divider = CreateObject("roSGNode", "Rectangle")
    divider.width = 1000
    divider.height = 2
    divider.color = "0x444444FF"
    divider.translation = [0, 55]
    settingGroup.appendChild(divider)
    
    return settingGroup
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if not press
        return false
    end if
    
    if key = "OK"
        ' Handle setting selection
        return true
    else if key = "up" or key = "down"
        ' Navigate through settings
        return true
    else if key = "left" or key = "right"
        ' Adjust setting values
        return true
    end if
    
    return false
end function

function SaveSettings() as void
    ' Save current settings to persistent storage
    registry = CreateObject("roRegistry")
    registry.Write("settings", FormatJson(m.settings))
    registry.Flush()
end function

function LoadSettings() as void
    ' Load settings from persistent storage
    registry = CreateObject("roRegistry")
    if registry.Exists("settings")
        ' Parse saved settings
        m.settings = registry.Read("settings")
    end if
end function

function FormatJson(obj as object) as string
    ' Convert object to JSON string for storage
    return FormatJSON(obj)
end function
