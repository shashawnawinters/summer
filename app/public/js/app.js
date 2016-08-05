arr = []


//variable to store data from ajax
var Data;
//ajax request to load results from eventbrite api
$('.search').on("click", function(event) {
  event.preventDefault(),
  $.ajax({
    type: 'get',
    // async: false,
    url: 'https://www.eventbriteapi.com/v3/events/search/?venue.city=chicago&price=0&q=' + $('.searchinput').val(),
    beforeSend: function (request) {
      request.setRequestHeader("Authorization", "Bearer 4UFJIOZKIUA72WMHQGQI")
    },
    dataType: 'json',
    success: function(data) {
      Data = data;


      console.log(data)





      




      for (var i = 0; i < data.events.length; i++) {
        // console.log(data.events[i], 'this is data.events[i]')
        $('.results').append('<li value="' + i + '"><a id="event' + i + '"href="#">' + data.events[i].name.text + '</a></li>').on('click', 'a', function(e){
          e.preventDefault();
          var myData = data.events.filter(function(event, j) {
            return event.name.text === data[i].name.text;
          });
          console.log(myData, 'FILTERED');
          var event = myData[0];
          $('#details').append('<h1>' + event.name + '</h1>');
          $('#details').append('<p>' + event.capacity + '</p>');
          $('#details').append('<p>' + event.currency + '</p>');
          // var myData = grabData()
        
          var number = $(this)
          var date = myData.events[number.context.parentNode.value].start.local.substr(0, 10).split('-');
          var b = date.shift()
          date.push(b);
          date = date.join('-');
          var t = myData.events[number.context.parentNode.value].start.local.substr(10, 9).split('T');
          t.shift();
          time = t.toString();

          // console.log(number.context.parentNode.value)
          console.log('-----------------OBJECT NAME--------------------------')
          console.log(myData.events[number.context.parentNode.value].name.text)
          console.log('-----------------OBJECT DESCRIPTION--------------------------')
          console.log(myData.events[number.context.parentNode.value].description.text)
          console.log('-----------------OBJECT IMAGE_URL--------------------------')
          console.log(myData.events[number.context.parentNode.value].logo.url)
          console.log('-----------------OBJECT DATE--------------------------')
          console.log(date)
          console.log('-----------------OBJECT TIME--------------------------')
          console.log(time)
          console.log('-----------------OBJECT CATEGORY--------------------------')
          console.log(myData.events[number.context.parentNode.value].category_id)
          console.log('-----------------OBJECT LOCATION--------------------------')
    
        })
      }
      
    },
    error: function(err) {
      console.log(err);
    }
  });
  // console.log(data.events[0])
});

  
function grabData(){
  return Data;
}


