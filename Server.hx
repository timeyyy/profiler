class Server {
  function new() { }
  function foo(x, y) { return x + y; }

  static function main() {
    var ctx = new haxe.remoting.Context();
    ctx.addObject("Server", new Server());

    if(haxe.remoting.HttpConnection.handleRequest(ctx))
    {
      return;
    }

    // handle normal request
    trace("This is a remoting server !");
  } 
}
