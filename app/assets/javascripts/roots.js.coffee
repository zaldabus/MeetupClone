# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.datepicker').datepicker({
      dateFormat: 'yy-mm-dd',
      inline: true,
      showOtherMonths: true,
      dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      onSelect: (dateText, inst) ->
        $.ajax(
          url: "",
          type: "GET",
          data: (date: dateText),
          success: (events) ->
            console.log(events)
            $('.date-listings').remove()
            $('.event-list').html(events)

        )
    })

    # Eventually I will add logic that allows a user to click on the calendar
    # and that will rerender the page to show that date at the top of the list

$('.dropdown-toggle').dropdown()