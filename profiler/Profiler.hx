// This is a frontend for the profiler

// package profiler;

// import profiler.Backend;

class Globals {
  static public var env_key = "PROFILER_LISTEN_ADDRESS";
  static public var env_value = "";
}

class Profiler {
  var cnx;

  public function new() {
    main();
  }

  public function main() {
    set_env();
    backend_connect();
    frontend_start();
  }

  // TODO How to make this get called ??
  static public function close() {
    Sys.putEnv(Globals.env_key, "");
    Globals.env_value = "";
  }

  static public function set_env() {
    var url = make_url();
    Sys.putEnv(Globals.env_key, url);
    Globals.env_value = url;
  }

  static public function make_url() {
    return "http://localhost:8710";
  }

  function backend_connect() {
    cnx = sys.net.Socket()Globals.env_value);
  }

  function get_active() : String {
    return cnx.Backend.get_active.call();
  }

  function set_active(profile:String) {
    cnx.Backend.set_active.call([profile]);
  }

  function get_all() {
    return cnx.Backend.get_all.call();
  }
}
