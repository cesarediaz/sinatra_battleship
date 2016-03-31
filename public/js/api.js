var Battleship = function (){};

Battleship.prototype.jq = function(id) {
  return "#" + id.replace( /(:|\.|\[|\]|,)/g, "\\$1" );
};

Battleship.prototype.destroy_ship = function(ship_data) {
  if (ship_data != null) {
    var klass = '.' + ship_data[0];
    $('.mine').find(klass).attr('style', 'background-color: gray; color: gray;');
  }
};

Battleship.prototype.message = function(data) {
  var result = data['result'];
  var result_types = {winner: BootstrapDialog.TYPE_SUCCESS, loser: BootstrapDialog.TYPE_DANGER};
  if (result != '') {
    this.modal(result_types[result], result);
    this.autoclose_modal(2000);
  }
};

Battleship.prototype.modal = function(type, result) {
  BootstrapDialog.show({
    type: type,
    title: 'Result: ',
    message: 'You are the ' + result + '!!!',
    buttons: [{
              label: 'OK',
              action: function(dialogRef){
                  dialogRef.close();
                  location.reload();
              }
            }]
  });
};

Battleship.prototype.autoclose_modal = function(time = 5000) {
  setTimeout(function(){
    $('.modal').modal('hide');
  }, time);
};
