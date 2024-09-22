import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigProvider extends ChangeNotifier {
  bool showDiscountedPrice = false; // Default value

  RemoteConfigProvider() {
    fetchRemoteConfig(); // Fetch remote config when the provider is initialized
  }

  // Fetch the Remote Config value from Firebase
  Future<void> fetchRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 20),
        minimumFetchInterval: const Duration(seconds: 20),
      ));
      await remoteConfig
          .fetchAndActivate(); // Fetch and activate the latest values from Firebase
      showDiscountedPrice = remoteConfig.getBool('showDiscountedPrice');
      notifyListeners(); // Notify listeners about the change
    } catch (e) {
      print("Error fetching remote config: $e");
    }
  }
}
