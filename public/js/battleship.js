$( document ).ready(function() {
    $(function(){
      var hash = {};
      Object.keys(hash).forEach(function (key) {
        console.log(hash[key]);
      })
    });

    $('.square').on('click', function(){
      var id = this.id;

      if (id != '') {
        $(this).attr('style', 'background-color: red');

        $.ajax({
          type: "POST",
          url: '/shot',
          data: {id: id},
          success: function(data) {
            var coords = data['shot_coordinates'];
            var ship_data = $('.mine').find(jq(coords)).attr('class').match(/\d+/);
            $('.mine').find(jq(coords)).attr('style', 'background-color: blue');
            destroy_ship(ship_data);
            message(data);
          },
          dataType: 'json'
        });

      }

    })
});

function jq(id) {
  return "#" + id.replace( /(:|\.|\[|\]|,)/g, "\\$1" );
}

function destroy_ship(ship_data) {
  if (ship_data != null) {
    var klass = '.' + ship_data[0];
    $('.mine').find(klass).attr('style', 'background-color: gray; color: gray;');
  }
}

function message(data) {
  if (data['result'] === 'winner') {
    $('#result').html('You are the winner!!!');
  }
  if (data['result'] === 'loser') {
    $('#result').html('You are the loser!!!');
  }
}
