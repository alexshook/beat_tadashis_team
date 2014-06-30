(function(){
  console.log('loaded bro!');
  $('#vote').click(startVoting);
  // $('img.meal-pic').css('height', '100%');
})();

function startVoting(){
  $('.show-template').empty();
  $('.vote-template').toggle('slide', {direction: 'right'}, 350);
  var meals = $.ajax({
    method: 'GET',
    url: 'get_meals',
    dataType: 'JSON',
    async: false
  }).done(function(data){
    return data;
  });
  console.log(meals);
  if (meals["responseJSON"] === undefined || meals["responseJSON"].length <= 0){
    $('.vote-template').empty();
    $('.finished-voting').removeClass('finished-voting-show-hide');
    console.log('done, yo');
  } else {
    var mealObject = meals["responseJSON"][0][0];
    var image = meals["responseJSON"][0][1];
    var goalName = meals["responseJSON"][0][2];
    appendMeal(mealObject, image, goalName);
  }
}

function appendMeal(meal, image, goalName){
  $('#vote-meal-pic').empty().append("<img src=" + image + " style='max-width: 50%;' />");
  $('#vote-meal-goalname').append('<p><p>').html("<strong>Goal Category: </strong>" + goalName);
  $('#vote-meal-comment').append('<p></p>').html("<strong>Comment: </strong>" + meal.comment);
  $('#vote-meal-ingredients').append('<p></p>').html("<strong>Description: </strong>" + meal.ingredients);

  $('#vote-meal-nutrition').append('<p></p>').html("<strong>Calories: </strong>" + (meal.calories || "N/A") + "<br>" + "<strong>Fat: </strong>" + (meal.fat || "N/A") + " g<br>" + "<strong>Protein: </strong>" + (meal.protein || "N/A") + " g<br>" + "<strong>Fiber: </strong>" + (meal.fiber || "N/A") + " g<br>" + "<strong>Sugar: </strong>" + (meal.sugar || "N/A") + " g<br>" + "<strong>Carbs: </strong>" + (meal.carbs || "N/A") + " g<br>" + "<strong>Sodium: </strong>" + (meal.sodium || "N/A") + " mg");

  for (var i = 1; i <= 5; i++){
    $('#rating-' + i).attr('onclick', 'addRating(' + i + ', ' + meal.id + ')');
  }
}

function addRating(num, mealID){
  $.ajax({
    method: 'POST',
    url: '/ratings',
    dataType: 'JSON',
    data: {
      rating: num,
      meal_id: mealID
    }
  }).done(function(data){
    $('.vote-template').toggle('slide', {direction: 'left'}, 350);
    window.scrollTo(0, 0);
    startVoting();
  });
}
