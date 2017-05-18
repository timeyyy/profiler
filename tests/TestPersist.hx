
import org.mongodb.Mongo;

import profiler.Persist;
// import profiler.Profiler;


class PersistTester extends haxe.unit.TestCase {
  override public function setup() {
    var profile:Profile = 'default';
  }

  public function get_all_data() {
    var mongo = new Mongo();
    return mongo.find(number=-1);
  }
}


class AndTesting extends PersistTester {
  function test_create() {
    var rv = Persist.insert(profile);
    assertEquals(rv, true);

    var data = get_all_data();
    assertEquals(data.profiles, profile);

    rv = Persist.insert(profile);
    assertEquals(rv, false);
  }
}


class TestPersist {
  static function main(){
    var r = new haxe.unit.TestRunner();
    r.add(new AndTesting());
    r.run();
  }
}
