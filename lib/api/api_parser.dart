import 'dart:convert';

import 'package:firstapp/api/api_connector.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:http/http.dart';

import '../db/models/class_model.dart';

class ApiParser {
  // Parse the response body from the API call to get a list of classes
  // Returns a list of maps with the following keys:
  // name, hitdice, description
  static parseClasses(String body) async {
    var data = jsonDecode(body);
    var classes = data['results'] as List;

    // for each class, get the hit_dice
    for (var i = 0; i < classes.length; i++) {
      var classUrl = classes[i]['url'];
      var classResponse =
          await get(Uri.parse(ApiConnector.BASE_URL + classUrl));
      var classData = jsonDecode(classResponse.body);
      classes[i]['hit_die'] = classData['hit_die'];
    }
    var out = classes
        .map((e) => {'name': e['name'], 'hit_die': e['hit_die']})
        .toList();
    return out;
  }

  //Cast the list of maps to a list of Class objects
  static castToClass(List<Map<String, dynamic>> classes) {
    return classes
        .map((e) =>
            Class(id: -1, className: e['name'], classHitDie: e['hit_die']))
        .toList();
  }

  static parseFeatures(String body) async {
    var data = jsonDecode(body);
    var features = data['results'] as List;

    // for each feature, get the featureName, level, className, and description
    for (var i = 0; i < features.length; i++) {
      var featureUrl = features[i]['url'];
      var featureResponse = await get(Uri.parse(ApiConnector.BASE_URL + featureUrl));
      var featureData = jsonDecode(featureResponse.body);
      features[i]['level'] = featureData['level'];
      features[i]['class'] = featureData['class'];
      features[i]['desc'] = featureData['desc'].join(' ');
    }

    var out = features
        .map((e) => {
              'name': e['name'],
              'level': e['level'],
              'class': e['class'],
              'desc': e['desc']
            })
        .toList();
    return out;
  }

  static castToFeature(List<Map<String, dynamic>> features) {
    return features
        .map((e) => Feature(
            id: -1,
            featureUsed: -1,
            featureMaxLevel: -1,
            featureName: e['name'],
            featureLevelAcquire: e['level'],
            featurePrimaryClass: 0,
            featureDescription: e['desc']))
        .toList();
  }
}
