import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/class_model.dart';

class Classes {
  Future<Map<int, Class>> _loadClasses() async {
    var loadedClasses = await Database().characterClasses();
    Map<int, Class> classes = <int, Class>{};
    for (var c in loadedClasses) {
      classes.putIfAbsent(c.id, () => c);
    }
    return classes;
  }

  Future<Map<int, Class>> getClasses() async {
    return await _loadClasses();
  }

  set classes(Map<int, Class> newClasses) {
    classes = newClasses;
  }

  Future<List<String>> getClassesNames() async {
    var classes = await _loadClasses();
    var c = classes.values.map((e) => e.className).toList();
    return [...c, "Default"];
  }

  getClass(toFind) async {
    var classes = await _loadClasses();
    return classes.values.firstWhere((element) => element.className == toFind);
  }

  getClassById(id) async {
    var classes = await _loadClasses();
    return classes[id];
  }
}
