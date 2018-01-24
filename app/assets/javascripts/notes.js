function displayNotes(lickData) {
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
  debugger;
}
