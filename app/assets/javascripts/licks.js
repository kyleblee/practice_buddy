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
  //determines how to display licks, based on "sort" option
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
  //for displaying licks with no filter or sort selected
  const template = Handlebars.compile(document.getElementById('unsorted-licks-template').innerHTML);
  const licksHTML = template(data);
  $('#licks').html(licksHTML);
  displaySortForm();
  attachLickListeners();
};

function displayUnsortedDateLicks(data, filterAndSortParams) {
  //for displaying date based sort options
  const template = dateTemplate(filterAndSortParams["sort"]);
  const licksHTML = template(data);
  $('#licks').html(licksHTML);
  displaySortForm();
  attachLickListeners();
}

function displayTonalityOrArtistSort (data, filterAndSortParams) {
  //for displaying tonality or artist sorted licks (with headers)
  const cleanedData = removeUnwantedSortHeaders(data, filterAndSortParams);

  $('#licks').empty();
  $('#view-options').empty();

  generateSortWithHeadersHTML(cleanedData);
  displaySortForm();
  attachLickListeners();
}

function displaySortForm() {
  //add filter and sort form to view so user can select other options if they wish
  const template = Handlebars.compile(document.getElementById('sort-form-template').innerHTML)
  const formHTML = template();

  $('#view-options').html(formHTML);

  $('form#filter-form').on('submit', function(e) {
    e.preventDefault();
    renderLicks();
  });
}

function removeUnwantedSortHeaders(data, filterAndSortParams) {
  //remove unwanted headers from tonality / artist sort lists
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
  //generate HTML for tonality / artist lists (with headers) once unwanted headers have been removed
  const template = Handlebars.compile(document.getElementById('sort-with-headers-template').innerHTML);

  for (let header in data) {
    let licksHTML = `<h4>${header}</h4><ul>`
    licksHTML += template(data[header]);
    licksHTML += `</ul>`
    $('#licks').append(licksHTML);
  }
}

function formatDate(rawDate) {
  //display formatted dates for date-based lists
  if (rawDate) {
    const date = new Date(rawDate);
    let dateInfo = `(${date.getUTCMonth() + 1}/${date.getUTCDate()}/${date.getUTCFullYear()})`;
    return dateInfo;
  };
}

function dateTemplate(sort) {
  //determine which template to use for date-based lists
  if (sort === "Date Last Practiced") {
    return Handlebars.compile(document.getElementById('last-practiced-licks-template').innerHTML);
  } else {
    return Handlebars.compile(document.getElementById('scheduled-practice-licks-template').innerHTML);
  }
}

function attachLickListeners() {
  //attach click event handler to lick list items to trigger show view with AJAX / Handlebars
  $('a.lick-list-items').on('click',function(e) {
    e.preventDefault();
    const id = parseInt(this["dataset"]["id"]);
    const user_id = parseInt(this["dataset"]["user_id"]);
    showLick(id, user_id);
  })
}

function showLick(id, user_id) {
  //display lick#show view by sending AJAX GET request, removing lick#index elements, and adding lick#show elements
  $.getJSON(`/users/${user_id}/licks/${id}`, function(data) {

    //update header directly by replacing with name of lick
    $('#licks-header').html(data["name"]);

    //make a template for "basic information", remove licks#index and replace with specific lick info
    displayBasicLickInfo(data);

    //make a template for "tonalities" of that lick

    //make a template for "backing tracks" of that lick

    // make a template for "show options" that displays the "edit lick" and "delete lick" buttons
  });
}

function displayBasicLickInfo(data) {
  const template = Handlebars.compile(document.getElementById('lick-basic-info').innerHTML);
  const lickHTML = template(data);
  $('#licks').html(lickHTML);
}
