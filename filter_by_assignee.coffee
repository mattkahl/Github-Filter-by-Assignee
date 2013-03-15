add_assignee_menu = ->
    unless $( '.filter-by-assignee' ).length
      assignees = []
      # Fetch the ul of sidebar filters
      $sidebarFilters = $('.issues-list-sidebar').find('ul.filter-list').first()
      # Fetch the hidden inputs containing all of the possible assignees
      $assigneeInputs = $('form.js-assignee-picker-form').first().find('input[name="assignment[assignee]"]')
      # The regular expression to grab the issues base URL and URL parameters
      rIssuesUrl = /^(.*\/\/github.com\/.*\/issues).*?(\?.*)?/
      # Grab the start and end of the url
      urlParts = rIssuesUrl.exec(window.location.href)

      # Exit if the URL is not on an issues page incorrect
      if(!urlParts)
          return null

      baseUrl = urlParts[1]
      urlParameters = urlParts[2]

      # Horizontal rule template
      hrTemplate = """
          <li>
              <div class="rule"></div>
              <strong>Assigned To:</strong>
          </li>
      """

      # Add the value of each assignee input to the assignees array
      assignees.push($(input).val()) for input in $assigneeInputs

      # Add a line break
      $sidebarFilters.append(hrTemplate)

      # Append a link to each filter for every possible assignee
      for assignee in assignees
          $sidebarFilters.append """
              <li class="filter-by-assignee">
                  <a href="#{ baseUrl }/assigned/#{ assignee }#{ urlParameters || '' }">
                      <span class="name">#{ assignee }</span>
                  </a>
              </li>
          """

add_assignee_menu()
$( document ).ajaxComplete( add_assignee_menu )

