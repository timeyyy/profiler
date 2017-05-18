
package profiler;

import profiler.Env;
import profiler.Persist;

typedef Out = {
  var msg:String;
  var code:Bool;
}

typedef Profile = String;


class Backend {
  var api = ["set_active", "get_active", "get_all", "on_change"];

  var msgs:Map<String, Out> = [
    "error_cmd" => {msg:"a command is required", code:false},
    "error_api" => {msg:"command not in api", code:false},
    "bad_args" => {msg:"bad argument supplied", code:false},
    "ok" => {msg:"all good", code:true},
    "get_active" => {msg:"returning active profile", code:true},
    "get_all" => {msg:"returning all profiles", code:true},
    "profile_taken" => {msg:"profile exists", code:false},
    "profile_not_found" => {msg:"profile not found", code:false},
    "cannot_delete" => {msg:"cannot delete active profile", code:false}
  ];

  static var active_profile;

  static function main() {
    var s = new sys.net.Socket();
    var host = Env.get_host();
    var port = Env.get_port();
    s.bind(new sys.net.Host(host), port);
    var max_clients = 100;
    s.listen(max_clients);

    trace("Starting server...");

    while( true ) {
      var c : sys.net.Socket = s.accept();
      handle_client(c);
      trace("Client connected...");
      c.write("hello\n");
      trace(c.input.readLine());
      c.write("your IP is "+c.peer().host.toString()+"\n");
      trace(c.input.readLine());
      c.write("exit\n");
      trace(c.input.readLine());
      c.close();
    }
  }

  function create_profile(profile:Profile) {
    var rv = Persist.insert(profile)
    if (rv) {
      return resp('ok');
    }
    return resp('profile_taken');
  }

  function delete_profile(profile:Profile) {
    var rv = Persist.delete(profile)
    if (rv == 1) {
      return resp('ok');
    }
    else if (rv == 2)
      return resp('profile_not_found');
    }
    else if (rv == 3) {
      return resp('cannot_delete');
    }
  }

  function get_active_profile() {
    return active_profile;
  }

  function set_active_profile(profile) {
    active_profile = profile;
  }

  function get_all_profiles() Array<Profile>{
    return Persist.get_all();
  }

  // Hold the connection open
  // Clients send us a request over the socket
  // They then have to read the return value
  public function handle_client(c) {
    var blob = c.input.read();
    var data = haxe.Json.parse(blob);

    var valid_resp = validate_data(data);
    var cmd = data.get('command');
    if (valid_resp.get('code') == 0) {
      c.write(valid_resp);
    }
    else if (cmd == 'set_active') {
      set_active_profile(data.get('args')[0]);
      c.write(resp('set_active'));
    }
    else if (cmd == 'get_active') {
      var profile = get_active_profile();
      c.write(resp('get_active', profile));
    }
    else if (cmd == 'get_all') {
      var profiles = get_all_profiles();
      var out = haxe.Json.stringify(profiles);
      c.write(resp('get_all', out));
    }
  }

  function validate_data(data) {
    var cmd = data.get('command');
    if (cmd == null) {
      return resp('error_cmd');
    }
    else if (!cmd in api) {
      return resp('error_api');
    }
    else if (cmd == 'set_active') {
      var args = data.get(args);
      if (args.length != 1) {
        return resp('bad_args');
      }
    }
    return resp('ok');
  }

  function resp(key, ?data:String="") {
    var out_map:Map<String, String>;
    var out = msgs.get(key);
    out_map.set('code', out.code);
    out_map.set('msg', out.msg);
    if (data != "") {
      out_map.set('data', data);
    }
    return out_map;
  }
}
