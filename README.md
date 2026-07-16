# ChurchApp1
Church Hub Roku App – Project Specification (Version 1.0)

Project Overview

Church Hub is a Roku SceneGraph application designed for church members to easily access sermons, announcements, events, contact information, the Verse of the Day, and a live clock. The app is intended to be simple enough for users of all ages to navigate with only a Roku remote.

The application should feel like a professionally designed TV app rather than a web page.

⸻

Platform

* Roku SceneGraph
* BrightScript
* XML Components
* 1280 × 720 (HD)
* Landscape only

⸻

Navigation

The application opens directly to the Verse of the Day page.

Navigation uses the Roku remote.

* Left → Previous page
* Right → Next page
* Down (Sermons page only) → Opens sermon archive
* Up → Returns from sermon archive
* OK → Plays selected sermon

Page order:

Sermons ← Announcements ← Events ← Verse of the Day → Clock → Contact

The pages wrap around, so pressing Right on Contact returns to Sermons.

⸻

Pages

1. Verse of the Day (Home)

Purpose:
Display the daily Bible verse.

Contents:

* Verse text
* Bible reference
* Church logo
* Background image
* Large readable text

Updates:
Remote through Google Sheets.

⸻

2. Clock

Purpose:
Display current time and date.

Contents:

* Large digital clock
* Current date
* Next scheduled church service
* Background image

Time comes from Roku.

Background and service information come from Google Sheets.

⸻

3. Contact

Display:

* Church name
* Address
* Phone
* Email
* Website
* Facebook page

Background image loads remotely.

⸻

4. Events

Display upcoming events.

Each event contains:

* Title
* Date
* Description

Background updates remotely.

⸻

5. Announcements

Display weekly announcements.

Examples:

* Prayer meeting
* VBS reminder
* Fellowship dinner
* Mission trip

Background updates remotely.

⸻

6. Sermons

Top section:

Latest sermon

Display:

* Sermon title
* Speaker
* Date

Large Play button prompt:

Press OK to Watch

Below:

Press Down for More Sermons

When Down is pressed:

Display the ten most recent sermons.

Each sermon displays:

* Title
* Speaker
* Date

Pressing OK plays the selected sermon.

Footer:

Showing the 10 most recent sermons.

Older sermons are available on our Facebook page.

⸻

Sermon Videos

Videos are hosted on Vimeo.

Only the sermon portion of each church service is uploaded.

The Roku app always highlights the newest sermon.

Only the ten most recent sermons are shown.

Older sermons remain available on Facebook.

⸻

Data Source

Google Sheets

The app downloads information from a published Google Sheet.

No app update is required when content changes.

⸻

Remote Content

Google Sheets controls:

Verse of the Day

Announcements

Events

Contact information

Next service

Background image URLs

Latest sermon

Sermon archive

⸻

Background Images

Every page has its own background image.

Examples:

Verse

Clock

Announcements

Events

Contact

Sermons

Google Sheets stores image URLs.

The Roku app downloads the images.

Changing the URL changes the page appearance without republishing the app.

⸻

Google Sheet Structure

The sheet contains multiple sections.

Verse

* Verse text
* Verse reference
* Background URL

Clock

* Background URL
* Next service

Contact

* Church name
* Address
* Phone
* Email
* Website
* Facebook

Announcements

List of announcements.

Events

List of events.

Sermons

Maximum:

10 sermons

Each sermon:

* Title
* Speaker
* Date
* Vimeo video URL

Newest sermon appears first.

⸻

UI Design

Clean.

Modern.

Minimal.

Readable from across the room.

Large fonts.

Consistent spacing.

No clutter.

No advertisements.

No QR codes.

No unnecessary menus.

⸻

Animation

Smooth page slide transitions.

Background fade when changed.

Fast loading.

⸻

Error Handling

If Google Sheets cannot be reached:

Use cached/default data.

If a background image cannot load:

Use default background.

If a sermon URL is unavailable:

Display:

Video unavailable.

⸻

Future Features

Possible Version 2:

Prayer Requests

Church Staff page

Giving information

Service countdown timer

Weather

Daily devotional

Livestream support

Full sermon archive

Search sermons

Settings page

Theme customization

⸻

Folder Structure

ChurchRoku/
│
├── manifest
│
├── source/
│   ├── main.brs
│   ├── AppData.brs
│   ├── GoogleSheets.brs
│   └── VideoPlayer.brs
│
├── components/
│   ├── MainScene.xml
│   ├── MainScene.brs
│   ├── VersePage.xml
│   ├── VersePage.brs
│   ├── ClockPage.xml
│   ├── ClockPage.brs
│   ├── ContactPage.xml
│   ├── ContactPage.brs
│   ├── EventsPage.xml
│   ├── EventsPage.brs
│   ├── AnnouncementsPage.xml
│   ├── AnnouncementsPage.brs
│   ├── SermonsPage.xml
│   ├── SermonsPage.brs
│   ├── SermonList.xml
│   └── SermonList.brs
│
├── images/
│
└── assets/

⸻

Development Principles

* Use Roku SceneGraph best practices.
* Keep code modular and well commented.
* Load Google Sheets once and share the data throughout the app.
* Avoid unnecessary files.
* Prioritize performance and readability.
* Keep navigation simple enough for users unfamiliar with technology.
* Build with future expansion in mind while keeping Version 1 focused and easy to maintain.
