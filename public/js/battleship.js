$( document ).ready(function() {
  $('#opponent').find('.square').on('click', function(){
    var id = this.id;
    if (id != '') {
      var battleship = new Battleship();
      battleship.showPleaseWait();
      $(this).attr('style', 'background-color: red');
      $.ajax({
        type: "POST",
        url: '/shot',
        data: {id: id},
        success: function(data) {
          var coords = data['shot_coordinates'];
          var ship_data = $('.mine').find(battleship.jq(coords)).attr('class').match(/\d+/);
          $('.mine').find(battleship.jq(coords)).attr('style', 'background-color: blue');
          battleship.destroy_ship(ship_data);
          battleship.message(data);
          battleship.hidePleaseWait();
        },
        dataType: 'json'
      });
    }
  });
});
