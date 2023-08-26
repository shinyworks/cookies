/*
 * Make cookies available in Shiny input.
 * Adapted with permission from
 * https://book.javascript-for-r.com/shiny-cookies.html
 *
 * This is most useful for cookies that will change during a user session.
 *
 */

function getCookies(){
  var res = Cookies.get();
  /*res.map(function(cookie) {

  }); */
  Shiny.setInputValue('cookies', res);
}

Shiny.addCustomMessageHandler('cookie-set', function(msg){
  try {
    Cookies.set(msg.name, msg.value, msg.attributes);
    let cookie = Cookies.get(msg.name);
    if (cookie === undefined) {
      throw "Failed to set cookie '" + msg.name + "'.";
    }
    getCookies();
  } catch (error) {
    Shiny.setInputValue("cookie_set_error", error);
    console.log(error);
  }
});

Shiny.addCustomMessageHandler('cookie-remove', function(msg){
  try {
    Cookies.remove(msg.name);
    let cookie = Cookies.get(msg.name);
    if (cookie !== undefined) {
      throw "Failed to remove cookie '" + msg.name + "'.";
    }
    getCookies();
  } catch (error) {
    Shiny.setInputValue("cookie_remove_error", error);
    console.log(error);
  }
});


$(document).on('shiny:connected', function(ev){
  let jsCookiesStart = Cookies.get();
  Shiny.setInputValue('cookies_start', jsCookiesStart);
  getCookies();
  Shiny.setInputValue('cookies_ready', true);
});

window.addEventListener('focus', function() {
  getCookies();
});
