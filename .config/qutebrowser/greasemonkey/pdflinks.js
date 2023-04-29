// ==UserScript==
// @name replace all PDF links
// @namespace http://pdf.com
// @version 0.4
// @description
// @include http://*
// @include https://*
// ==/UserScript==

document.body.addEventListener('mouseup', function(e) {
  if (e.target.tagName != "A") return;
  var anchor = e.target;
  var target=anchor.href;
  function func(){ // change the URL back
    anchor.href = target;
  }
  if (anchor.href.search(/.pdf$/i) != -1) { // change to temporary URL
    setTimeout(func, 1000); // after 1 second
    anchor.href = anchor.href.replace( /http/, "pdf" );
  }
});
