$(function() {
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

  renderLicks();
});

function renderLicks() {
  // pull user ID from the url for JSON request
  const userId = window.location.href.match(/\/users\/\d\/licks/)[0].match(/\d/)[0];
  const filterAndSortParams = {
    filter: $('select#filter')[0].value,
    sort: $('select#sort')[0].value
  }
  $.getJSON(`/users/${userId}/licks`, filterAndSortParams, function(data){
     const template = Handlebars.compile(document.getElementById('licks-template').innerHTML);
     const licksHTML = template(data);
     $('#licks').html(licksHTML);
  });
}
