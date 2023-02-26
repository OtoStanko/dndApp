import 'package:http/http.dart';

import '../db/models/class_model.dart';
import '../db/models/feature_model.dart';
import 'api_parser.dart';

class ApiConnector {
  static const String BASE_URL = "http://www.dnd5eapi.co";
  static const String BASE_URL_API = "http://www.dnd5eapi.co/api";

  // Get list of classes (name, hitdice, (optional description))
  Future<List<Class>> getClasses() async {
    final response = await get(Uri.parse('$BASE_URL_API/classes'));
    var classes = await ApiParser.parseClasses(response.body);
    return ApiParser.castToClass(classes);
  }

  // Get list of features (name, description)
  Future<List<Feature>> getFeatures() async {
    final response = await get(Uri.parse('$BASE_URL_API/features'));
    var features = await ApiParser.parseFeatures(response.body);
    return ApiParser.castToFeature(features);
  }
}
