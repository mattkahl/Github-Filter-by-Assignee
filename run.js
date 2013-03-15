window.onload = function(){
  var script = document.createElement( 'script' );
  script.src = chrome.extension.getURL( 'filter_by_assignee.js' )
  document.documentElement.appendChild( script );
};

