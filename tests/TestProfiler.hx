
import profiler.Profiler;

class ProfilerTester extends haxe.unit.TestCase {
  override public function setup() {
  }
}

class TestSetsEnv extends ProfilerTester {
  function in_env(key) {
    if (Sys.getEnv(key) != "") {
      return true;
    }
    return false;
  }

  function test_env_set() {
    var main = new Profiler();
    assertEquals(in_env(Globals.env_key), true);
  }

  function test_env_freed() {
    var main = new Profiler();
    Profiler.close();
    assertEquals(in_env(Globals.env_key), false);
  }

  function test_make_url() {
    assertEquals(true, true);
  }

}

class TestProfiler {
  static function main(){
    var r = new haxe.unit.TestRunner();
    r.add(new TestSetsEnv());
    r.run();
  }
}
