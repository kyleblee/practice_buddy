$(document).on('turbolinks:load', function() {
  Handlebars.registerHelper('noteDate', function(note) {
    if (note.created_at) {
      let dateHTML = formatDate(note.created_at);
      return dateHTML;
    };
  });

  if ($('h2').hasClass('lick-show-header')) {
    attachAddNoteEventListener();
  }
});

function displayNotes(lickData) {
  //get Handlebars templates for notes and use callbacks with closures to pass lickData and templateData along
  $.get(`/users/${lickData["user_id"]}/notes`, notesIndexTemplateCallback(lickData));
}

function notesIndexTemplateCallback(lickData) {
  return function(data) {
    renderNotesIndexTemplate(lickData, data);
  }
}

function renderNotesIndexTemplate(lickData, templateData) {
  const template = Handlebars.compile(templateData);
  const notesHTML = template(lickData["notes"].reverse());
  $('#view-options').append(notesHTML);

  //trigger AJAX for new note template here, to ensure that the previous AJAX callback has attached the form in time
  $.get(`/users/${lickData["user_id"]}/notes/new`, newNoteTemplateCallback(lickData));
}

function newNoteTemplateCallback(lickData) {
  return function(data) {
    renderNewNoteTemplate(lickData, data);
  }
}

function renderNewNoteTemplate(lickData, templateData) {
  const template = Handlebars.compile(templateData);
  const newNoteHTML = template(lickData);
  $('#new-note').html(newNoteHTML);
  attachAddNoteEventListener();
}

function attachAddNoteEventListener() {
  $('form#new-note-form').on('submit', function(e) {
    e.preventDefault();
    const formData = $(this).serialize();
    $.ajax({
      url: $(this).attr("action"),
      method: 'post',
      data: formData,
      success: function(data) {
        showNewNote(data);
      },
      error: function(response) {
        $('div#notes-errors').html("<em>Sorry, something went wrong. Please try again.</em><br><br>")
      }
    });
  });
}

function showNewNote(data) {
  $('form#new-note-form textarea').val("");
  $('div#notes-errors').empty();
  let newLickHTML = `<p><strong>${formatDate(data["created_at"])}</strong></p><p class="notes-p-tags">${data["content"]}</p>`
  $('div#notes-list').prepend(newLickHTML);
}
