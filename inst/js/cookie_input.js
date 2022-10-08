// From https://book.javascript-for-r.com/shiny-cookies.html
function getCookies(){
  var res = Cookies.get();
  Shiny.setInputValue('cookies', res);
}

$(document).on('shiny:connected', function(ev){
  getCookies();
})
