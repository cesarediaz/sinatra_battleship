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
            var ship_data = $('.mine').find(jq(coords)).attr('data')
            $('.mine').find(jq(coords)).attr('style', 'background-color: blue');

            if (ship_data != undefined) {
              console.log('Barco undido');
            }

            if (data['result'] === 'winner') {
              alert('You are the winner!!!');
            }
            if (data['result'] === 'loser') {
              alert('You are the loser!!!');
            }
          },
          dataType: 'json'
        });

      }

    })
});

function jq(id) {
  return "#" + id.replace( /(:|\.|\[|\]|,)/g, "\\$1" );
}
