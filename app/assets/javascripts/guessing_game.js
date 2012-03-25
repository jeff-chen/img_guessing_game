$(document).ready(function() {
  answer = $('.true_answer')[0].attributes['secret_answer'].firstChild.wholeText.toLowerCase();
  //show one image at random
  addNextImage();
  $('button#guesser').click(function(){
	  var guessword = $('input.funtimes')[0].value;
	  if(guessword.length == 0){
	  	$('.infowars')[0].innerHTML = ("Please enter a guess.");
	  } else {
	  	if (guessword.toLowerCase() == answer) {
	  		$('.infowars')[0].innerHTML = ("Congratulations, you win!");
	  	} else {
	  		bad_message = "Incorrect."
	  		//count the number of guesses remaining
	  		var remaining = parseInt($('span.remainder')[0].innerHTML);
	  		remaining = remaining - 1;
	  		if(remaining == 0){
	  			bad_message = bad_message + "\nThe answer was " + answer;
	  		} else {
	  			//add the next image
	  			addNextImage();
	  		}
	  		$('span.remainder')[0].innerHTML = remaining;
	  		$('.infowars')[0].innerHTML = (bad_message);
	  	}
	  }
  });

	function addNextImage(){
		var images_remaining = $('.omg').size();
		var picked = Math.floor(Math.random()*images_remaining);
		var image_url = $('input.omg')[picked].attributes['secret_key'].firstChild.wholeText;
		unsafe_image = "<image src=" + image_url + " width=\"400px\">";
		$('input.omg')[picked].removeAttribute('class');
		$('#clues').prepend(unsafe_image);
	}
})

