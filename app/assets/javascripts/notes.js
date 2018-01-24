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
  const notesHTML = template(lickData);
  $('#view-options').append(notesHTML);
  //trigger new note AJAX here, to ensure that the previous AJAX callback has attached the form in time
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
  $('form#new-note-form').on('submit', function(e) {
    e.preventDefault();
    const formData = $(this).serialize();
    $.post($(this).attr("action"), formData, function(data) {
      debugger;
    })
    // $.ajax({
    //   url: $(this).attr("action"),
    //   method: 'post',
    //   data: formData
    // });
  });
}
