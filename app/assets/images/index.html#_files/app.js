var LIBRARY = [
  {title: 'C Major Scale', notes: 'A B C D E F G' },
  {title: 'Chromatic Scale', notes: 'A A# B C C# D D# E F F# G G#' },
  {title: 'Random Song', notes: 'A B*2 C D A*4 D E*2 F A B A A*2' },
  {title: 'Adup Licate', notes: 'A B*2 C D A*4 D E*2 F A B A A*2' },
  {title: 'Yankee Doodle', notes: 'C F*4 C F*4 B C D A*2 B*2 A B*2 C' },
  {title: 'Descending Notes', notes: 'G F E D C B A G F E D C B A' }
];

var BPM = 600;


// Add a song with the given title and notes to the library.
var addSongToLibrary = function(title, notes) {
  $('#library-list').append("<li>" +
                                "<i class='fa fa-bars'></i>" +
                                "<i class='fa fa-trash'></i>" +
                                "<span class='title'>" + title + "</span>" +
                                "<div class='notes'>" + notes + "</div>" +
                              "</li>");
};


// Add all LIBRARY songs to the library.
var initializeLibrary = function() {
  for(var i=0; i < LIBRARY.length; i+=1) {
    addSongToLibrary(LIBRARY[i].title, LIBRARY[i].notes);
  }
};


// Play all songs in the playlist.
var playAll = function() {

  // Grab the top song in the queue, parse its notes and play them.
  // Then recurse until there are no more songs left in the queue.
  //
  var playNext = function() {
    var songItem = $('#playlist-list li:first-child');

    if (songItem.length == 0) {
      // No more songs.

      // Re-enable the play button.
      $('#play-button').attr('disabled', false).text('Play All');

      // Fade out the message.
      $('#message').fadeOut();
      return;
    }

    var title = songItem.find('.title').text();
    var notes = songItem.find('.notes').text();
    var song = parseSong(notes);

    $('#message').html("Now playing: <strong>" + title + "</strong>").show();

    playSong(song, BPM, function() {
      songItem.remove();
      $('#library-list').append(songItem);
      playNext();
    });
  };

  // Disable the play button to start.
  $('#play-button').attr('disabled', true).text('Playing');

  playNext();
}


$(document).ready(function() {

  // Initialize the library with some songs.
  initializeLibrary();

  // Play all songs in the playlist when the "play" button is clicked.
  $('#play-button').on('click', playAll);


  // Add Your Code Here.

  // When the page loads, make the message fade in over 0.8s. Then, after 3s
  // have passed, fade out the message over 0.8s.
  $('#message').fadeIn(800, function() {
    $('#message').delay(3000).fadeOut(800);
  });

  // Make the song notes hidden when the page initially loads. Then,
  // when you double click a song, they should slide down over 0.3 second.
  // (Hint: See the `dblclick` event type)
  // When a song is played and then returned to the library, try double 
  // clicked it to show the notes. If you weren't careful, it won't work 
  // anymore! Use event delegation with the `on` method to fix this problem.
  $('div.notes').hide();
  $('ul').on('dblclick', 'span.title', function() {
    $(this).siblings('.notes').slideDown(300);
  });

  // When the delete icons for a song are clicked slide up that song over 0.5s.
  // AFTER the song is finished sliding up, remove it from the list entirely.
  $('.fa-trash').on('click', function() {
    var target = $(this).parent();
    target.slideUp(500, function() {
      $(target).remove();
    });
  });

  // Make the Library and Playlist sortable.
  // Allow dragging and dropping songs between the Library and the Playlist.
  $('#playlist-list, #library-list').sortable({
    connectWith: 'ul'
  }).disableSelection();

  // Filter the library, so that it includes only songs that match whatever
  // is typed in the "filter" box.
  $('#filter-library').on('keyup', function() {
    $('#library-list li').hide();
    $('#library-list span.title:contains("' + $(this).val() + '")').parent().show();
  });

  // Make the "Play" button shake when it is clicked but
  // there are no songs in the playlist.
  $('#play-button').on('click', function() {
    if ($('#playlist-list').is(':empty')) {
      $(this).addClass('shake');
      $(this).bind('animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd', function() {
        $(this).removeClass('shake');
      });
    } else {
      $(this).removeClass('shake');
    }
  });

});