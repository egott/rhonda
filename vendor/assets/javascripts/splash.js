//inspired & based on bowtie.io's splash.js file
$(document).foundation();

$(function () {
  var typed_items = [
      'Do I have any free time today?',
      'I\'m having a meeting tomorrow at 5 pm untill 6 pm at Dev Bootcamp',
      'I want to cook a meal with chicken',
      'Are there any rap concerts in NYC tonight?',
      'Show me a cat giph',
      'Send this giph to Thomas',
      'What exercise should I do today?',
      'Schedule this run tonight at 8 pm',
      'What\'s the weather in New York today?',
      'What\'s dexter about?',
      'Are there any interesting Art Meetups today?',
      'What time is The Affair airing?'
  ];

  shuffle(typed_items);
  $('#typed_items').typed({
    strings: typed_items,
    typeSpeed: 60,
    backSpeed: 5,
    backDelay: 1000,
    loop: true
  });

  function shuffle(text_array) {
    var text_item, place_holder, i;
    for (i = text_array.length; i; i -= 1) {
      text_item = Math.floor(Math.random() * i);        place_holder = text_array[i - 1];
      text_array[i - 1] = text_array[text_item];
      text_array[text_item] = place_holder;
    }
  }

});
