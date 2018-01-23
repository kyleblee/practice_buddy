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

    Handlebars.registerPartial('tonality-list-items', document.getElementById('tonality-list-items').innerHTML);

    displaySortForm();

    renderLicks();
  };
});

function renderLicks() {
  // pull user ID from the url for JSON request
  const userId = window.location.href.match(/\/users\/\d\/licks/)[0].match(/\d/)[0];
  const filterAndSortParams = {
    filter: $('select#filter')[0].value,
    sort: $('select#sort')[0].value
  }

  //sends ajax request and delegates to appropriate callback function to display licks
  $.getJSON(`/users/${userId}/licks`, filterAndSortParams, displayCallback(filterAndSortParams));
}

function displayCallback(filterAndSortParams) {
  if (filterAndSortParams["sort"] === "") {
    return function(data) { displayUnsortedLicks(data, filterAndSortParams); }
  } else if (filterAndSortParams["sort"] === "Tonality") {
    return function(data) { displayTonalitySort(data, filterAndSortParams); }
  } else if (filterAndSortParams["sort"] === "Artist") {
    // NEED TO KEEP BUILDING OUT THIS CONDITIONAL FLOW BASED ON SORT. REMEMBER THAT FILTER IS ALREADY
    // TAKEN CARE OF UNLESS THE SORT REQUIRES HEADERS
  }
}

function displayUnsortedLicks(data, filterAndSortParams) {
  const template = Handlebars.compile(document.getElementById('unsorted-licks-template').innerHTML);
  const licksHTML = template(data);
  $('#licks').html(licksHTML);

  displaySortForm();
};

function displayTonalitySort (data, filterAndSortParams) {
  if (filterAndSortParams["filter"] !== "") {
    for (let tonality in data) {
      if (tonality !== filterAndSortParams["filter"]) {
        delete data[tonality];
      }
    }
  }

  const template = Handlebars.compile(document.getElementById('tonality-sort-licks-template').innerHTML);
  $('#licks').empty();
  $('#filter-and-sort-form').empty();

  for (let tonality in data) {
    let licksHTML = `<h4>${tonality}</h4><ul>`
    licksHTML += template(data[tonality]);
    licksHTML += `</ul>`
    $('#licks').append(licksHTML);
  }

  displaySortForm();
}

function displaySortForm() {
  const template = Handlebars.compile(document.getElementById('sort-form-template').innerHTML)
  const formHTML = template();
  $('#filter-and-sort-form').html(formHTML);

  $('form#filter-form').on('submit', function(e) {
    e.preventDefault();

    renderLicks();
  });
}
