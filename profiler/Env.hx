
package profiler;

class Env {
  static public var env_key = "PROFILER_LISTEN_ADDRESS";
  static public var env_value = "";

  public static function get_host() {
    return "localhost";
  }

  public static function get_port() {
    return 5000;
    // return Sys.getEnv(env_key);
  }

}


