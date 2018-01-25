# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
  - Navigating through the "My Licks" index, all the licks can be clicked and are loaded via AJAX GET
  requests, JSON responses, and the Handlebars templating engine.
  - The JSON responses are generated using the Active Model Serializer called LickSerializer (which
    also returns associated data for: tonalities, backing tracks, and notes).
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
  - The licks#index view (via the "My Licks" link in the header), is rendered using jQuery and an Active
  Model Serialization (LickSerializer). Furthermore, the various filter and sort options are requested
  and rendered via AJAX, as well.
  - Also, on the licks#show view (via "My Licks"), the notes#index portion of the page is generated using the associated data returned for each lick (which have a has_many / belongs_to relationship with notes).
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
  - Notes have a has_many / belongs_to relationship with licks and they are rendered via JSON on the
  licks#show view, if reached via links on licks#index.
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.
  - On each licks#show view, notes are created via an AJAX POST request to the notes#create action and the corresponding JSON response is then inserted into the DOM using jQuery.
- [x] Translate JSON responses into js model objects.
  - JSON responses are used to instantiate Post and Note model objects, both of which have methods attached
  to their prototypes that help with formatting and rendering data.
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
  - Both Lick.prototype and Note.prototype have methods added to them.

Confirm
- [x] You have a large number of small Git commits
  - 117 commits for this project, at this time.
- [x] Your commit messages are meaningful
  - If anything, they are slightly TOO verbose.
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
