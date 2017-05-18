ass Client {
  static function main() {
    var cnx = haxe.remoting.HttpAsyncConnection.urlConnect("http://localhost2000/remoting.n");
    cnx.setErrorHandler( function(err) trace('Error: $err'); } );
    cnx.Server.foo.call([1,2], function(data) trace('Result: $data'););
  }
}
