//homepage.js
document.addEventListener("touchstart", function() {},false); //enables active states http://alxgbsn.co.uk/2011/10/17/enable-css-active-pseudo-styles-in-mobile-safari/
var winnerText = "I'm the cutest! Loading next battle..."

$(document).ready(function() {
    $(".player1").click(changeWinnerTextPlayer1);
    $(".player2").click(changeWinnerTextPlayer2);
});

function  changeWinnerTextPlayer1() {
	$(".player1 .player-name").addClass("bold")
	$(".player1 .player-name").text(winnerText)
}

function  changeWinnerTextPlayer2() {
	$(".player2 .player-name").addClass("bold")
	$(".player2 .player-name").text(winnerText)
}