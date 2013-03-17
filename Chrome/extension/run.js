// Create a script tag
var script = document.createElement( 'script' );
// Point the script tag to filter script
script.src = chrome.extension.getURL( 'filter_by_assignee.js' );
// Inject the script tag into the DOM
document.documentElement.appendChild( script );