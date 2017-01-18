//inspired & based on bowtie.io's splash.js file
$(document).foundation();

$(function () {
  var typed_items = [
      'Do I have any free time today?',
      'I\'m having a meeting tomorrow at 5 pm untill 6 pm at Dev Bootcamp.',
      'I want to cook chicken.',
      'I want to go to a concert in NYC.',
      'Set this event.',
      'Show me a cat giph.',
      'Send this giph to ...., only verified phone numbers for now...',
      'Give me a run.',
      'I\'ll do this run at 8 pm.',
      'What\'s the weather in New York today.',
      'What\'s dexter about?',
      'I\'ll watch this show at 8 pm.',
      'I would like to know more about Wolverine.',
      'Can I get a Meetup about Health for today in New York.',
      'Show me a dog'
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
