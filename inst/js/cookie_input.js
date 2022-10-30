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
  Shiny.setInputValue('cookies', res);
}

Shiny.addCustomMessageHandler('cookie-set', function(msg){
  Cookies.set(msg.name, msg.value, msg.attributes);
  getCookies();
})

Shiny.addCustomMessageHandler('cookie-remove', function(msg){
  Cookies.remove(msg.name);
  getCookies();
})


$(document).on('shiny:connected', function(ev){
  getCookies();
})
