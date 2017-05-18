
package profiler;

import org.mongodb.Mongo;

class JsonProfile {
  public function new(name) {
    this.name = name;
  }

  public var id : String = HaxeLow.uuid();
  public var name : String;
}


class Persist {
  public static function init_db() {
    var db = new HaxeLow('db.json');
  }

  public static function insert(profile) {
    var mongo = new Mongo("localhost", 27017);

    var instance = {
      name: profile,
      sub_profiles: ""
    };

    mongo.profiles.insert(instance);
    return true;
  }

  public static function delete(profile) {
    var mongo = new Mongo();
    var profiles = mongo.profiles;
    profiles.remove({name:profile});
  }

  public static function get_all() {
    var mongo = new Mongo();
    var profiles = mongo.profiles;
    return profiles.find(number=-1);
  }
}
