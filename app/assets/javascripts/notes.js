$(document).on('turbolinks:load', function() {
  Handlebars.registerHelper('noteDate', function(note) {
    if (note.created_at) {
      const currentNote = new Note(note);
      return currentNote.formatCreatedAtDate();
    };
  });

  if ($('h2').hasClass('lick-show-header')) {
    attachAddNoteEventListener();
  }
});

let Note = function(attributes) {
  this.id = attributes.id;
  this.content = attributes.content;
  this.user_id = attributes.user_id;
  this.lick_id = attributes.lick_id;
  this.created_at = attributes.created_at;
}

Note.prototype.formatCreatedAtDate = function() {
  const date = new Date(this.created_at);
  let dateInfo = `${date.getUTCMonth() + 1}/${date.getUTCDate()}/${date.getUTCFullYear()}`;
  return dateInfo;
}

Note.prototype.showNewNote = function() {
  $('form#new-note-form textarea').val("");
  $('div#notes-errors').empty();
  let newLickHTML = `<p><strong>${this.formatCreatedAtDate()}</strong></p><p class="notes-p-tags">${this.content}</p>`
  $('div#notes-list').prepend(newLickHTML);
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
        const currentNote = new Note(data);
        currentNote.showNewNote();
      },
      error: function(response) {
        $('div#notes-errors').html("<em>Sorry, something went wrong. Please try again.</em><br><br>")
      }
    });
  });
}
