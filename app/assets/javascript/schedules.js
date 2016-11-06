$(function () {
  var $calendar = $('#calendar');

  var eventSources = [];
  var data = $calendar.data("calendar");
  if ($.isArray(data)) {
    eventSources = data;
  }
  else {
    eventSources.push(data);
  }

  console.log(eventSources);
  $calendar.fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,basicWeek,basicDay,listDay,listWeek'
    },
    navLinks: true, // can click day/week names to navigate views
    editable: true,
    eventLimit: true, // allow "more" link when too many events
    eventSources: eventSources,
    eventClick: function (calendarEvent, clickEvent, view) {
      console.log(calendarEvent);
      $calendar.trigger("event-clicked", [$(this), calendarEvent, clickEvent, view]);
    }
  });

  $("#calendar.show_offers").on("event-clicked", function (jqueryEvent, $elem, calendarEvent, clickEvent, view) {
    console.log(calendarEvent);
    $.ajax(calendarEvent.accept_link, {
        data: {
          approved: true
        },
        type: 'PUT'
      }
    )
    ;
  });

});

