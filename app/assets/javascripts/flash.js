$(document).on("turbolinks:load", bindFlashClose);

function bindFlashClose() {
  if (document.getElementsByClassName('close')[0]) {
    var el = document.getElementsByClassName('close')[0];
    el.addEventListener('click', function(e) { document.getElementsByClassName('alert')[0].remove(); }, false);
  }
}