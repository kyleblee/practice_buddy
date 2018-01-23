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

    Handlebars.registerHelper('lastPracticedDate', function(lick) {
      return formatDate(lick.last_practiced);
    })

    Handlebars.registerHelper('scheduledPracticeDate', function(lick) {
      return formatDate(lick.scheduled_practice);
    })

    Handlebars.registerPartial('tonality-list-items', document.getElementById('tonality-list-items').innerHTML);
    Handlebars.registerPartial('last-practiced-list-items', document.getElementById('last-practiced-list-items').innerHTML);
    Handlebars.registerPartial('scheduled-practice-list-items', document.getElementById('scheduled-practice-list-items').innerHTML);

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
    return function(data) { displayTonalityOrArtistSort(data, filterAndSortParams); }
  } else if (filterAndSortParams["sort"] === "Artist") {
    return function(data) { displayTonalityOrArtistSort(data, filterAndSortParams); }
  } else if (filterAndSortParams["sort"] === "Date Last Practiced") {
    return function(data) { displayUnsortedDateLicks(data, filterAndSortParams); }
  } else if (filterAndSortParams["sort"] === "Scheduled Practice Date") {
    return function(data) { displayUnsortedDateLicks(data, filterAndSortParams); }
  }
}

function displayUnsortedLicks(data, filterAndSortParams) {
  const template = Handlebars.compile(document.getElementById('unsorted-licks-template').innerHTML);
  const licksHTML = template(data);
  $('#licks').html(licksHTML);

  displaySortForm();
};

function displayUnsortedDateLicks(data, filterAndSortParams) {
  const template = dateTemplate(filterAndSortParams["sort"]);
  const licksHTML = template(data);
  $('#licks').html(licksHTML);

  displaySortForm();
}

function displayTonalityOrArtistSort (data, filterAndSortParams) {
  const cleanedData = removeUnwantedSortHeaders(data, filterAndSortParams);

  $('#licks').empty();
  $('#filter-and-sort-form').empty();

  generateSortWithHeadersHTML(cleanedData);

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

function removeUnwantedSortHeaders(data, filterAndSortParams) {
  if (filterAndSortParams["filter"] !== "") {
    for (let header in data) {
      if (header !== filterAndSortParams["filter"]) {
        delete data[header];
      };
    };
  };
  return data;
}

function generateSortWithHeadersHTML(data) {
  const template = Handlebars.compile(document.getElementById('sort-with-headers-template').innerHTML);

  for (let header in data) {
    let licksHTML = `<h4>${header}</h4><ul>`
    licksHTML += template(data[header]);
    licksHTML += `</ul>`
    $('#licks').append(licksHTML);
  }
}

function formatDate(rawDate) {
  if (rawDate) {
    const date = new Date(rawDate);
    let dateInfo = `(${date.getMonth() + 1}/${date.getDate()}/${date.getFullYear()})`;
    return dateInfo;
  };
}

function dateTemplate(sort) {
  if (sort === "Date Last Practiced") {
    return Handlebars.compile(document.getElementById('last-practiced-licks-template').innerHTML);
  } else {
    return Handlebars.compile(document.getElementById('scheduled-practice-licks-template').innerHTML);
  }
}
