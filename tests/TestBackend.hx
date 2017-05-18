
import profiler.Backend;


class BackendTester extends haxe.unit.TestCase {
  override public function setup() {
  }
}


class TestConnect extends BackendTester {
  function test_connection() {
  }

  function test_multi_connection() {
  }
}


class TestBackend {
  static function main(){
    var r = new haxe.unit.TestRunner();
    r.add(new TestConnect());
    r.run();
  }
}
