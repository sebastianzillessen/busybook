Request examples
=================
Collection of CalDAV requests. Server is [Radicale](http://radicale.org/).

For OS X Calendar users
-----------------------
OS X Calendar.app has debugging mode and a feature to log communication with servers
(excluding iCloud). To enable it, use `defaults(1)`:

```
$ defaults write com.apple.iCal IncludeDebugMenu 1  # enable debug menu
$ defaults write com.apple.iCal LogHTTPActivity -boolean TRUE  # logging HTTP activities
```
*Tested in Yosemite*

You can investigate its log in Console.app.



First request of OS X Calendar
------------------------------
It checks functionalities of the CalDAV server.

*HTTP request header:*
```
PROPFIND / HTTP/1.1
```

*HTTP request body*
```xml
<?xml version="1.0" encoding="UTF-8"?>
<A:propfind xmlns:A="DAV:">
  <A:prop>
    <B:calendar-home-set xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <B:calendar-user-address-set xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <A:current-user-principal/>
    <A:displayname/>
    <C:dropbox-home-URL xmlns:C="http://calendarserver.org/ns/"/>
    <C:email-address-set xmlns:C="http://calendarserver.org/ns/"/>
    <C:notification-URL xmlns:C="http://calendarserver.org/ns/"/>
    <A:principal-collection-set/>
    <A:principal-URL/>
    <A:resource-id/>
    <B:schedule-inbox-URL xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <B:schedule-outbox-URL xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <A:supported-report-set/>
  </A:prop>
</A:propfind>
```

----

*HTTP response header:*
```
HTTP/1.1 207 Multi-Status
```

*HTTP response body*
```xml
<?xml version="1.0"?>
<multistatus xmlns="DAV:" xmlns:C="urn:ietf:params:xml:ns:caldav" xmlns:CS="http://calendarserver.org/ns/">
  <response>
    <href>/</href>
    <propstat>
      <prop>
        <C:calendar-home-set>
          <href>/</href>
        </C:calendar-home-set>
        <C:calendar-user-address-set>
          <href>/</href>
        </C:calendar-user-address-set>
        <displayname />
        <principal-collection-set>
          <href>/</href>
        </principal-collection-set>
        <principal-URL>
          <href>/</href>
        </principal-URL>
        <supported-report-set>
          <supported-report>
            <report>principal-property-search</report>
          </supported-report>
          <supported-report>
            <report>sync-collection</report>
          </supported-report>
          <supported-report>
            <report>expand-property</report>
          </supported-report>
          <supported-report>
            <report>principal-search-property-set</report>
          </supported-report>
        </supported-report-set>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
    <propstat>
      <prop>
        <current-user-principal />
        <CS:dropbox-home-URL />
        <CS:email-address-set />
        <CS:notification-URL />
        <resource-id />
        <C:schedule-inbox-URL />
        <C:schedule-outbox-URL />
      </prop>
      <status>HTTP/1.1 404 Not Found</status>
    </propstat>
  </response>
</multistatus>
```


Get a list of calendar
----------------------

*HTTP request header:*
```
PROPFIND / HTTP/1.1
```

*HTTP request body*
```xml
<?xml version="1.0" encoding="UTF-8"?>
<A:propfind xmlns:A="DAV:">
  <A:prop>
    <A:add-member/>
    <C:allowed-sharing-modes xmlns:C="http://calendarserver.org/ns/"/>
    <D:autoprovisioned xmlns:D="http://apple.com/ns/ical/"/>
    <E:bulk-requests xmlns:E="http://me.com/_namespace/"/>
    <D:calendar-color xmlns:D="http://apple.com/ns/ical/"/>
    <B:calendar-description xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <B:calendar-free-busy-set xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <D:calendar-order xmlns:D="http://apple.com/ns/ical/"/>
    <B:calendar-timezone xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <A:current-user-privilege-set/>
    <B:default-alarm-vevent-date xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <B:default-alarm-vevent-datetime xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <A:displayname/>
    <C:getctag xmlns:C="http://calendarserver.org/ns/"/>
    <C:invite xmlns:C="http://calendarserver.org/ns/"/>
    <D:language-code xmlns:D="http://apple.com/ns/ical/"/>
    <D:location-code xmlns:D="http://apple.com/ns/ical/"/>
    <A:owner/>
    <C:pre-publish-url xmlns:C="http://calendarserver.org/ns/"/>
    <C:publish-url xmlns:C="http://calendarserver.org/ns/"/>
    <C:push-transports xmlns:C="http://calendarserver.org/ns/"/>
    <C:pushkey xmlns:C="http://calendarserver.org/ns/"/>
    <A:quota-available-bytes/>
    <A:quota-used-bytes/>
    <D:refreshrate xmlns:D="http://apple.com/ns/ical/"/>
    <A:resource-id/>
    <A:resourcetype/>
    <B:schedule-calendar-transp xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <B:schedule-default-calendar-URL xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <C:source xmlns:C="http://calendarserver.org/ns/"/>
    <C:subscribed-strip-alarms xmlns:C="http://calendarserver.org/ns/"/>
    <C:subscribed-strip-attachments xmlns:C="http://calendarserver.org/ns/"/>
    <C:subscribed-strip-todos xmlns:C="http://calendarserver.org/ns/"/>
    <B:supported-calendar-component-set xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <B:supported-calendar-component-sets xmlns:B="urn:ietf:params:xml:ns:caldav"/>
    <A:supported-report-set/>
    <A:sync-token/>
  </A:prop>
</A:propfind>
```


----

*HTTP response header:*
```
HTTP/1.1 207 Multi-Status
```

*HTTP response body*
```xml
<?xml version="1.0"?>
<multistatus xmlns="DAV:" xmlns:C="urn:ietf:params:xml:ns:caldav" xmlns:CS="http://calendarserver.org/ns/" xmlns:ICAL="http://apple.com/ns/ical/" xmlns:ME="http://me.com/_namespace/">
  <response>
    <href>/</href>
    <propstat>
      <prop>
        <ICAL:calendar-color>#80b25c</ICAL:calendar-color>
        <C:calendar-timezone>BEGIN:VCALENDAR
PRODID:-//Radicale//NONSGML Radicale Server//EN
VERSION:2.0
END:VCALENDAR
</C:calendar-timezone>
        <current-user-privilege-set>
          <privilege>
            <all />
            <read />
            <write />
            <write-properties />
            <write-content />
          </privilege>
        </current-user-privilege-set>
        <C:default-alarm-vevent-date>BEGIN:VALARM
X-WR-ALARMUID:5DC5216A-6549-460E-AEC2-6F38D4EF5806
UID:5DC5216A-6549-460E-AEC2-6F38D4EF5806
TRIGGER:-PT15H
ATTACH;VALUE=URI:Basso
ACTION:AUDIO
END:VALARM
</C:default-alarm-vevent-date>
        <C:default-alarm-vevent-datetime>BEGIN:VALARM
X-WR-ALARMUID:659F266D-F726-43D8-B720-52679D440713
UID:659F266D-F726-43D8-B720-52679D440713
TRIGGER;VALUE=DATE-TIME:19760401T005545Z
ACTION:NONE
END:VALARM
</C:default-alarm-vevent-datetime>
        <displayname />
        <CS:getctag>"d41d8cd98f00b204e9800998ecf8427e"</CS:getctag>
        <resourcetype>
          <principal />
          <collection />
        </resourcetype>
        <C:supported-calendar-component-set>
          <C:comp name="VTODO" />
          <C:comp name="VEVENT" />
          <C:comp name="VJOURNAL" />
        </C:supported-calendar-component-set>
        <supported-report-set>
          <supported-report>
            <report>principal-property-search</report>
          </supported-report>
          <supported-report>
            <report>sync-collection</report>
          </supported-report>
          <supported-report>
            <report>expand-property</report>
          </supported-report>
          <supported-report>
            <report>principal-search-property-set</report>
          </supported-report>
        </supported-report-set>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
    <propstat>
      <prop>
        <add-member />
        <CS:allowed-sharing-modes />
        <ICAL:autoprovisioned />
        <ME:bulk-requests />
        <C:calendar-description />
        <C:calendar-free-busy-set />
        <ICAL:calendar-order />
        <CS:invite />
        <ICAL:language-code />
        <ICAL:location-code />
        <owner />
        <CS:pre-publish-url />
        <CS:publish-url />
        <CS:push-transports />
        <CS:pushkey />
        <quota-available-bytes />
        <quota-used-bytes />
        <ICAL:refreshrate />
        <resource-id />
        <C:schedule-calendar-transp />
        <C:schedule-default-calendar-URL />
        <CS:source />
        <CS:subscribed-strip-alarms />
        <CS:subscribed-strip-attachments />
        <CS:subscribed-strip-todos />
        <C:supported-calendar-component-sets />
        <sync-token />
      </prop>
      <status>HTTP/1.1 404 Not Found</status>
    </propstat>
  </response>
  <response>
    <href>/calendar/</href>
    <propstat>
      <prop>
        <ICAL:calendar-color>#0E61B9FF</ICAL:calendar-color>
        <C:calendar-description>こんにちは</C:calendar-description>
        <C:calendar-free-busy-set>
        </C:calendar-free-busy-set>
        <ICAL:calendar-order>11</ICAL:calendar-order>
        <C:calendar-timezone>BEGIN:VCALENDAR
PRODID:-//Radicale//NONSGML Radicale Server//EN
VERSION:2.0
BEGIN:VTIMEZONE
TZID:Asia/Tokyo
BEGIN:DAYLIGHT
TZOFFSETFROM:+0900
RRULE:FREQ=YEARLY;UNTIL=19510505T170000Z;BYMONTH=5;BYDAY=1SU
DTSTART:19500507T020000
TZNAME:GMT+9
TZOFFSETTO:+1000
X-RADICALE-NAME:Asia/Tokyo
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:+1000
DTSTART:19510908T020000
TZNAME:GMT+9
TZOFFSETTO:+0900
X-RADICALE-NAME:Asia/Tokyo
END:STANDARD
X-RADICALE-NAME:Asia/Tokyo
END:VTIMEZONE
END:VCALENDAR
</C:calendar-timezone>
        <current-user-privilege-set>
          <privilege>
            <all />
            <read />
            <write />
            <write-properties />
            <write-content />
          </privilege>
        </current-user-privilege-set>
        <C:default-alarm-vevent-date>BEGIN:VALARM
X-WR-ALARMUID:C8F5FC22-DA44-4AF8-8AF4-A1D2E319F3E6
UID:C8F5FC22-DA44-4AF8-8AF4-A1D2E319F3E6
TRIGGER:-PT15H
ATTACH;VALUE=URI:Basso
ACTION:AUDIO
END:VALARM
</C:default-alarm-vevent-date>
        <C:default-alarm-vevent-datetime>BEGIN:VALARM
X-WR-ALARMUID:6799FDCF-FDEB-47A4-8A30-DC3A7B11C3FF
UID:6799FDCF-FDEB-47A4-8A30-DC3A7B11C3FF
TRIGGER;VALUE=DATE-TIME:19760401T005545Z
ACTION:NONE
END:VALARM
</C:default-alarm-vevent-datetime>
        <displayname>Untitled</displayname>
        <CS:getctag>"73c9a9d65c5e74a0ee4a8b56a16c60d5"</CS:getctag>
        <resourcetype>
          <C:calendar />
          <collection />
        </resourcetype>
        <C:supported-calendar-component-set>
          <C:comp name="VEVENT" />
        </C:supported-calendar-component-set>
        <supported-report-set>
          <supported-report>
            <report>principal-property-search</report>
          </supported-report>
          <supported-report>
            <report>sync-collection</report>
          </supported-report>
          <supported-report>
            <report>expand-property</report>
          </supported-report>
          <supported-report>
            <report>principal-search-property-set</report>
          </supported-report>
        </supported-report-set>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
    <propstat>
      <prop>
        <add-member />
        <CS:allowed-sharing-modes />
        <ICAL:autoprovisioned />
        <ME:bulk-requests />
        <CS:invite />
        <ICAL:language-code />
        <ICAL:location-code />
        <owner />
        <CS:pre-publish-url />
        <CS:publish-url />
        <CS:push-transports />
        <CS:pushkey />
        <quota-available-bytes />
        <quota-used-bytes />
        <ICAL:refreshrate />
        <resource-id />
        <C:schedule-calendar-transp />
        <C:schedule-default-calendar-URL />
        <CS:source />
        <CS:subscribed-strip-alarms />
        <CS:subscribed-strip-attachments />
        <CS:subscribed-strip-todos />
        <C:supported-calendar-component-sets />
        <sync-token />
      </prop>
      <status>HTTP/1.1 404 Not Found</status>
    </propstat>
  </response>
  <response>
    <href>/73177CD3-7C11-4324-9A4D-89041BC18691/</href>
    <propstat>
      <prop>
        <ICAL:calendar-color>#44A703FF</ICAL:calendar-color>
        <C:calendar-free-busy-set>
        </C:calendar-free-busy-set>
        <ICAL:calendar-order>7</ICAL:calendar-order>
        <C:calendar-timezone>BEGIN:VCALENDAR
PRODID:-//Radicale//NONSGML Radicale Server//EN
VERSION:2.0
BEGIN:VTIMEZONE
TZID:Asia/Tokyo
BEGIN:DAYLIGHT
TZOFFSETFROM:+0900
RRULE:FREQ=YEARLY;UNTIL=19510505T170000Z;BYMONTH=5;BYDAY=1SU
DTSTART:19500507T020000
TZNAME:GMT+9
TZOFFSETTO:+1000
X-RADICALE-NAME:Asia/Tokyo
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:+1000
DTSTART:19510908T020000
TZNAME:GMT+9
TZOFFSETTO:+0900
X-RADICALE-NAME:Asia/Tokyo
END:STANDARD
X-RADICALE-NAME:Asia/Tokyo
END:VTIMEZONE
END:VCALENDAR
</C:calendar-timezone>
        <current-user-privilege-set>
          <privilege>
            <all />
            <read />
            <write />
            <write-properties />
            <write-content />
          </privilege>
        </current-user-privilege-set>
        <displayname>Hello</displayname>
        <CS:getctag>"62f8a81855896e2f251dd39d06fabe43"</CS:getctag>
        <resourcetype>
          <C:calendar />
          <collection />
        </resourcetype>
        <C:supported-calendar-component-set>
          <C:comp name="VEVENT" />
        </C:supported-calendar-component-set>
        <supported-report-set>
          <supported-report>
            <report>principal-property-search</report>
          </supported-report>
          <supported-report>
            <report>sync-collection</report>
          </supported-report>
          <supported-report>
            <report>expand-property</report>
          </supported-report>
          <supported-report>
            <report>principal-search-property-set</report>
          </supported-report>
        </supported-report-set>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
    <propstat>
      <prop>
        <add-member />
        <CS:allowed-sharing-modes />
        <ICAL:autoprovisioned />
        <ME:bulk-requests />
        <C:calendar-description />
        <C:default-alarm-vevent-date />
        <C:default-alarm-vevent-datetime />
        <CS:invite />
        <ICAL:language-code />
        <ICAL:location-code />
        <owner />
        <CS:pre-publish-url />
        <CS:publish-url />
        <CS:push-transports />
        <CS:pushkey />
        <quota-available-bytes />
        <quota-used-bytes />
        <ICAL:refreshrate />
        <resource-id />
        <C:schedule-calendar-transp />
        <C:schedule-default-calendar-URL />
        <CS:source />
        <CS:subscribed-strip-alarms />
        <CS:subscribed-strip-attachments />
        <CS:subscribed-strip-todos />
        <C:supported-calendar-component-sets />
        <sync-token />
      </prop>
      <status>HTTP/1.1 404 Not Found</status>
    </propstat>
  </response>
</multistatus>
```

Get a ctag
----------
It requests Calendar Collection Entity Tag (ctag in short), a non-standard extension
of CalDAV introduced by Apple. [Specification](http://svn.calendarserver.org/repository/calendarserver/CalendarServer/trunk/doc/Extensions/caldav-ctag.txt)

*HTTP request header:*
```
PROPFIND /73177CD3-7C11-4324-9A4D-89041BC18691/ HTTP/1.1
```

*HTTP request body*
```xml
<?xml version="1.0" encoding="UTF-8"?>
<A:propfind xmlns:A="DAV:">
  <A:prop>
    <C:getctag xmlns:C="http://calendarserver.org/ns/"/>
    <A:sync-token/>
  </A:prop>
</A:propfind>
```

----

*HTTP response header:*
```
HTTP/1.1 207 Multi-Status
```

*HTTP response body*
```xml
<?xml version="1.0"?>
<multistatus xmlns="DAV:" xmlns:CS="http://calendarserver.org/ns/">
  <response>
    <href>/73177CD3-7C11-4324-9A4D-89041BC18691/</href>
    <propstat>
      <prop>
        <CS:getctag>"62f8a81855896e2f251dd39d06fabe43"</CS:getctag>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
    <propstat>
      <prop>
        <sync-token />
      </prop>
      <status>HTTP/1.1 404 Not Found</status>
    </propstat>
  </response>
</multistatus>
```


Get a list of calendar objects
------------------------------

*HTTP request header:*
```
PROPFIND /73177CD3-7C11-4324-9A4D-89041BC18691/ HTTP/1.1
```

*HTTP request body*
```xml
<?xml version="1.0" encoding="UTF-8"?>
<A:propfind xmlns:A="DAV:">
  <A:prop>
    <A:getcontenttype/>
    <A:getetag/>
  </A:prop>
</A:propfind>
```

----

*HTTP response header:*
```
HTTP/1.1 207 Multi-Status
```

*HTTP response body*
```xml
<?xml version="1.0"?>
<multistatus xmlns="DAV:">
  <response>
    <href>/73177CD3-7C11-4324-9A4D-89041BC18691/80206729-DA20-4185-9497-F2521433F3E2.ics</href>
    <propstat>
      <prop>
        <getcontenttype>text/calendar; component=vevent</getcontenttype>
        <getetag>"54d119af7a4d399276ecc5ba88904a30"</getetag>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
  </response>
  <response>
    <href>/73177CD3-7C11-4324-9A4D-89041BC18691/</href>
    <propstat>
      <prop>
        <getcontenttype>text/calendar</getcontenttype>
        <getetag>"62f8a81855896e2f251dd39d06fabe43"</getetag>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
  </response>
  <response>
    <href>/73177CD3-7C11-4324-9A4D-89041BC18691/7AB4DF85-0828-455D-8938-ED35B06F5E1D.ics</href>
    <propstat>
      <prop>
        <getcontenttype>text/calendar; component=vevent</getcontenttype>
        <getetag>"5e341bfbf438ce34b3afefd6bc68cc69"</getetag>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
  </response>
</multistatus>
```


Get contents of calendar objects
--------------------------------

*HTTP request header:*
```
REPORT /73177CD3-7C11-4324-9A4D-89041BC18691 HTTP/1.1
```

*HTTP request body*
```xml
<?xml version="1.0" encoding="UTF-8"?>
<B:calendar-multiget xmlns:B="urn:ietf:params:xml:ns:caldav">
  <A:prop xmlns:A="DAV:">
    <A:getetag/>
    <B:calendar-data/>
    <C:updated-by xmlns:C="http://calendarserver.org/ns/"/>
    <C:created-by xmlns:C="http://calendarserver.org/ns/"/>
  </A:prop>
  <A:href xmlns:A="DAV:">/73177CD3-7C11-4324-9A4D-89041BC18691/80206729-DA20-4185-9497-F2521433F3E2.ics</A:href>
  <A:href xmlns:A="DAV:">/73177CD3-7C11-4324-9A4D-89041BC18691/7AB4DF85-0828-455D-8938-ED35B06F5E1D.ics</A:href>
</B:calendar-multiget>
```

----

*HTTP response header:*
```
HTTP/1.1 207 Multi-Status
```

*HTTP response body*
```xml
<?xml version="1.0"?>
<multistatus xmlns="DAV:" xmlns:C="urn:ietf:params:xml:ns:caldav" xmlns:CS="http://calendarserver.org/ns/">
  <response>
    <href>/73177CD3-7C11-4324-9A4D-89041BC18691/7AB4DF85-0828-455D-8938-ED35B06F5E1D.ics</href>
    <propstat>
      <prop>
        <getetag>"5e341bfbf438ce34b3afefd6bc68cc69"</getetag>
        <C:calendar-data>BEGIN:VCALENDAR ...</C:calendar-data>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
    <propstat>
      <prop>
        <CS:updated-by />
        <CS:created-by />
      </prop>
      <status>HTTP/1.1 404 Not Found</status>
    </propstat>
  </response>
  <response>
    <href>/73177CD3-7C11-4324-9A4D-89041BC18691/80206729-DA20-4185-9497-F2521433F3E2.ics</href>
    <propstat>
      <prop>
        <getetag>"54d119af7a4d399276ecc5ba88904a30"</getetag>
        <C:calendar-data>BEGIN:VCALENDAR ...</C:calendar-data>
      </prop>
      <status>HTTP/1.1 200 OK</status>
    </propstat>
    <propstat>
      <prop>
        <CS:updated-by />
        <CS:created-by />
      </prop>
      <status>HTTP/1.1 404 Not Found</status>
    </propstat>
  </response>
</multistatus>
```
