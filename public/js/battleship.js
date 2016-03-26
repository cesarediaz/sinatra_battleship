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
