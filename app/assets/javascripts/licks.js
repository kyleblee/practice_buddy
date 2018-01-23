$(document).on('turbolinks:load', function() {
  if ($('#licks').length > 0) {
    Handlebars.registerHelper('tonalities', function(lick) {
      if (lick.tonalities.length > 0) {
        let tonalitiesList = "("
        for (let tonality of lick.tonalities) {
          tonalitiesList += `${tonality.name}, `
        }
        tonalitiesList = tonalitiesList.replace(/,\s*$/, ")")
        return tonalitiesList;
      };
    })

    attachEventListeners();

    renderLicks(displayUnsortedLicks);
  };
});


function attachEventListeners() {
  $('form#filter-form').on('submit', function(e) {
    e.preventDefault();
    debugger;
  });
}

function renderLicks(displayCallback) {
  // pull user ID from the url for JSON request
  const userId = window.location.href.match(/\/users\/\d\/licks/)[0].match(/\d/)[0];
  const filterAndSortParams = {
    filter: $('select#filter')[0].value,
    sort: $('select#sort')[0].value
  }

  //sends ajax request and delegates to appropriate callback function to display licks
  $.getJSON(`/users/${userId}/licks`, filterAndSortParams, displayCallback);
}

const displayUnsortedLicks = function(data) {
  const template = Handlebars.compile(document.getElementById('unsorted-licks-template').innerHTML);
  const licksHTML = template(data);
  $('#licks').html(licksHTML);
};
