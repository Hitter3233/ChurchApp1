# Church Hub Roku App - Setup Instructions

## Overview
This document provides step-by-step instructions to configure the Church Hub Roku App for your church.

---

## 📋 Table of Contents
1. [Initial Setup](#initial-setup)
2. [API Configuration](#api-configuration)
3. [App Branding](#app-branding)
4. [Build & Deploy](#build--deploy)
5. [Testing](#testing)
6. [Troubleshooting](#troubleshooting)

---

## Initial Setup

### Step 1: Update manifest.xml
**File:** `manifest.xml`

Change the following values:

```xml
<!-- Replace with your church name -->
<app_name>Your Church Name</app_name>

<!-- Create a unique ID (no spaces, lowercase) -->
<id>yourchurchname</id>

<!-- Set your app version -->
<version>1.0.0</version>

<!-- Add your church description -->
<description>Your church description here</description>

<!-- Set your church's main color (hex format) -->
<main_menu_item_color>FF671D</main_menu_item_color>

<!-- Update author info -->
<author>Your Church Name</author>
<author_url>https://yourchurch.com</author_url>

<!-- Update keywords for app store search -->
<keywords>yourchurch,events,sermons,community,faith</keywords>
```

---

## API Configuration

### Step 2: Update APIClient.brs
**File:** `utils/APIClient.brs`

Update the base URL to point to your backend API:

```brightscript
function init() as void
    ' CHANGE THIS to your API server URL
    m.baseURL = "https://api.yourchurch.com"
    m.timeout = 30000
    m.headers = {}
end function
```

### Step 3: Update build.properties
**File:** `build.properties`

Configure your API endpoints:

```properties
# CHANGE THESE to your actual values
api.base.url=https://api.yourchurch.com
api.timeout=30000
api.retry.attempts=3
api.retry.delay=1000

# Cache settings (in milliseconds)
cache.ttl=3600000
cache.enabled=true
```

### Step 4: Set Up Backend API Endpoints
Your backend API should support these endpoints:

**Events:**
- `GET /events` - List all events
- `GET /events/{id}` - Get event details

**Sermons:**
- `GET /sermons` - List all sermons
- `GET /sermons/{id}` - Get sermon details

**News:**
- `GET /news` - Get church news

**About:**
- `GET /church/about` - Get church information

**Contact:**
- `GET /church/contact` - Get contact info
- `POST /contact/submit` - Submit contact form

**Authentication:**
- `POST /auth/login` - User login
- `POST /auth/register` - User registration
- `POST /auth/logout` - User logout

**User:**
- `GET /users/{id}` - Get user profile
- `PUT /users/{id}` - Update user profile

---

## App Branding

### Step 5: Add App Icons and Images
**Directory:** `images/`

Create or add the following image files (replace with your church logo/branding):

```
images/
├── mm_icon_focus_hd.png      (336x210 pixels, HD focused)
├── mm_icon_focus_sd.png      (108x69 pixels, SD focused)
├── mm_icon_side_hd.png       (240x240 pixels, HD side)
├── mm_icon_side_sd.png       (80x80 pixels, SD side)
├── splash_screen_hd.png      (1920x1080 pixels, HD splash)
└── splash_screen_sd.png      (720x480 pixels, SD splash)
```

### Step 6: Update App Colors (Optional)
**File:** `components/Theme.brs` (create if needed)

Define your church brand colors:

```brightscript
function GetThemeColors() as object
    return {
        primary: "#FF671D",          ' Main brand color
        secondary: "#333333",        ' Secondary color
        accent: "#FFFFFF",           ' Accent color
        background: "#1a1a1a",       ' Background color
        text: "#FFFFFF"              ' Text color
    }
end function
```

---

## Build & Deploy

### Step 7: Configure Roku Device Connection
**File:** `build.properties`

Update with your Roku device info:

```properties
# Your Roku device IP address (find in Settings > Network > IP Address)
roku.device.ip=192.168.1.100

# Roku developer username (usually 'rokudev')
roku.device.user=rokudev

# Roku developer password (set in Settings > Developer Options)
roku.device.password=your_password_here
```

### Step 8: Build the App

**Using Roku Studio (GUI):**
1. Open Roku Studio
2. Load the project folder
3. Click "Package" → "Create Package"
4. Choose output location

**Using Command Line:**
```bash
# Navigate to project directory
cd ChurchApp1

# Build the project
./build.sh
# or
make build
```

### Step 9: Deploy to Roku Device

**Using Roku Studio:**
1. Connect to your Roku device
2. Click "Run" or "Deploy"
3. Select your device IP address

**Manual Deployment:**
```bash
# Upload to device
curl -F "myapp=@build/churchhub.zip" http://192.168.1.100:8060/plugin_install
```

---

## Testing

### Step 10: Test App Features

#### Test Events Page
- Verify events load from API
- Test event details display
- Check caching (load again, should be faster)

#### Test Sermons Page
- Verify sermon list loads
- Test sermon playback
- Check video quality options

#### Test Contact Form
- Fill out contact form
- Verify form submission to API
- Check for success/error messages

#### Test User Authentication
- Test login with valid credentials
- Test login with invalid credentials
- Test registration flow
- Test logout

#### Test Offline Mode
- Disable network connection
- Verify app shows cached data
- Check for offline indicators

### Step 11: Performance Testing

- Monitor memory usage
- Check load times
- Test with slow network (use Roku simulator)
- Verify no memory leaks during extended use

---

## Configuration Files Quick Reference

### manifest.xml
- **Location:** Root directory
- **Purpose:** App metadata, icons, permissions
- **Must Change:** app_name, id, description, author, author_url

### build.properties
- **Location:** Root directory
- **Purpose:** Build settings and API endpoints
- **Must Change:** api.base.url, roku.device.ip

### utils/APIClient.brs
- **Location:** utils/APIClient.brs
- **Purpose:** API communication
- **Must Change:** m.baseURL in init() function

### utils/DataManager.brs
- **Location:** utils/DataManager.brs
- **Purpose:** Data caching and storage
- **May Change:** m.cacheTTL for different cache duration

---

## Environment Variables (Optional)

Create a `.env` file for local development:

```
API_BASE_URL=https://api.yourchurch.com
ROKU_DEVICE_IP=192.168.1.100
ROKU_USERNAME=rokudev
ROKU_PASSWORD=your_password
DEBUG_MODE=false
CACHE_TTL=3600000
```

---

## Troubleshooting

### App Won't Connect to API
**Solution:**
1. Verify API URL in `build.properties` and `APIClient.brs`
2. Check API server is running and accessible
3. Verify firewall allows Roku device to access API
4. Test API manually: `curl https://api.yourchurch.com/events`

### Events/Sermons Not Loading
**Solution:**
1. Check API response format matches expected JSON
2. Verify cache is not corrupted: Clear cache in app settings
3. Check network connection
4. Look at Roku device logs for errors

### App Crashes on Startup
**Solution:**
1. Check manifest.xml syntax (valid XML)
2. Verify all required image files exist
3. Check for BrightScript syntax errors in main files
4. Review Roku device logs

### Performance Issues
**Solution:**
1. Reduce cache TTL in `build.properties`
2. Optimize API response sizes
3. Check for memory leaks in main.brs
4. Profile app using Roku SceneGraph debugger

### Images Not Displaying
**Solution:**
1. Verify image files are in `images/` directory
2. Check image dimensions match requirements
3. Ensure paths in manifest.xml are correct
4. Test image files can be opened locally

---

## Next Steps

1. ✅ Update manifest.xml with your church info
2. ✅ Configure API endpoints
3. ✅ Add your church branding (logos, colors)
4. ✅ Set up Roku device connection
5. ✅ Build and test the app
6. ✅ Submit to Roku Channel Store (optional)

---

## Support & Resources

- **Roku Developer Documentation:** https://developer.roku.com/
- **BrightScript Reference:** https://developer.roku.com/en-US/docs/references/brightscript/
- **Roku Community:** https://forums.roku.com/
- **Your Church's IT Support:** [Add your contact]

---

## Checklist Before Launch

- [ ] API base URL configured and tested
- [ ] All images added and paths correct
- [ ] App name and description updated
- [ ] Contact information verified
- [ ] Authentication working (login/logout)
- [ ] All content pages loading correctly
- [ ] Caching working properly
- [ ] App tested on target Roku device
- [ ] No crashes or errors in logs
- [ ] Performance acceptable

---

**Version:** 1.0.0  
**Last Updated:** August 2026  
**Maintained By:** Your Church Name
