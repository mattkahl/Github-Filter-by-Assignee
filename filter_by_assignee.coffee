# Adds the assignees menu into the DOM
addAssigneesMenu = ->
    # Create a url parser
    url = document.createElement('a');
    url.href = window.location.href;

    # The selector to be applied to all assignee filters
    assigneeClass = 'filter-by-assignee'

    # Continue if there aren't already assignee filters and this is a valid issues page
    unless $( '.'+assigneeClass ).length
        assignees = []
        # Default the issues path to the current path
        issuesPath = url.pathname
        isFilteringByAssignee = false
        filterType
        filteredUsername

        # Fetch the ul of sidebar filters
        $sidebarFilters = $('.issues-list-sidebar').find('ul.filter-list').first()
        # Fetch the hidden inputs containing all of the possible assignees
        $assigneeInputs = $('form.js-assignee-picker-form').first().find('input[name="assignment[assignee]"]')
        # Fetch the "Assigned to you" anchor
        $assignedToYou = $sidebarFilters.find('a:contains("Assigned to you")')

        # Determine, if any, the filter type and user (in addition, parse the issues path)
        rFilteredUri = /(.*)\/(assigned|created_by|mentioned)\/(\w*)/
        pathParts = rFilteredUri.exec(url.pathname)

        if pathParts
            # Parse filter type
            filterType = pathParts[2]
            isFilteringByAssignee = true if pathParts[2] == 'assigned'
            filteredUsername = pathParts[3]
            # Redefine issues path
            issuesPath = pathParts[1]

        # Determine the logged in user based on the "Assigned to you" href
        loggedInUsername = rFilteredUri.exec($assignedToYou[0].pathname)[3]

        # Remove the 'selected' class from the 'assigned to you link' if a different user is being filtered
        $assignedToYou.removeClass('selected') unless filteredUsername == loggedInUsername

        # Horizontal rule template
        hrTemplate = """
            <div class="rule"></div>
        """

        noAssigneesTemplate = """
            <li>
                No issues for <strong>#{ filteredUsername }</strong>.
                <a href="#{ $assignedToYou.attr('href') }">Try issues assigned to you.</a>
            </li>
        """

        # Create the container for the assignee filters
        $assigneeFilters = $ """
            <ul class="small filter-list assignee-filter-list">
                <h4>Assignees</h4>
            </ul>
        """


        # Add the value of each assignee input to the assignees array
        assignees.push($(input).val()) for input in $assigneeInputs

        # Add a line break and the assignee filters ul container
        $sidebarFilters.after(hrTemplate,$assigneeFilters)

        # If unable to scrape assignees
        # TODO: Could be better by storing previously scraped assignees to localStorage
        if !assignees.length
            # Insert filler text
            $assigneeFilters.append(noAssigneesTemplate)
            # Don't continue
            return null

        # Append a link to each filter for every possible assignee
        for assignee in assignees
            # Generate the url
            href = "#{ issuesPath }/assigned/#{ assignee }#{ url.search || '' }"
            # Check if assignee is currently being filtered
            isCurrentlyFiltered = isFilteringByAssignee && assignee == filteredUsername

            # All list elements get this class
            anchorClasses = assigneeClass + " filter-item "
            # Add 'selected' class if the page is already being filtered
            anchorClasses += " selected" if window.location.href.indexOf(href) > -1

            $assigneeFilters.append """
              <li id=#{ assignee }>
                  <a href="#{ href }" class="#{ anchorClasses }">
                      <span class="name">#{ assignee }</span>
                  </a>
              </li>
            """

$ =>
    # Initially add the assignee list
    addAssigneesMenu()
    # Re-add the assignee list after $.ajaxComplete
    $( document ).ajaxComplete( addAssigneesMenu )