// Create a script tag
var script = document.createElement( 'script' );
// Point the script tag to filter script
script.src = safari.extension.baseURI + 'filter_by_assignee.min.js';
// Inject the script tag into the DOM
document.documentElement.appendChild( script );