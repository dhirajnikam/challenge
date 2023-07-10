import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:challenge148/model/device_model.dart';

class DeviceProfileDatabase {
  late Database _db;

  Future<void> openDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, 'device_profiles.db');
    _db = sqlite3.open(dbPath);

    // Create the device_profiles table if it doesn't exist
    _db.execute('''
      CREATE TABLE IF NOT EXISTS device_profiles (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        themeColor TEXT NOT NULL,
        fontSize REAL NOT NULL
      );
    ''');
  }

  Future<void> saveDeviceProfile(DeviceProfile profile) async {
    final stmt = _db.prepare('''
      INSERT INTO device_profiles (name, latitude, longitude, themeColor, fontSize)
      VALUES (?, ?, ?, ?, ?)
    ''');

    // Execute the INSERT query with profile values
    stmt.execute([
      profile.name,
      profile.latitude,
      profile.longitude,
      profile.themeColor,
      profile.fontSize,
    ]);

    stmt.dispose();
  }

  List<DeviceProfile> getAllDeviceProfiles() {
    final resultSet = _db.select('SELECT * FROM device_profiles');
    final deviceProfiles = <DeviceProfile>[];

    // Iterate over the result set and create DeviceProfile objects
    for (final row in resultSet) {
      final deviceProfile = DeviceProfile(
        id: row['id'] as int,
        name: row['name'] as String,
        latitude: row['latitude'] as double,
        longitude: row['longitude'] as double,
        themeColor: row['themeColor'] as String,
        fontSize: row['fontSize'] as double,
      );
      deviceProfiles.add(deviceProfile);
    }

    return deviceProfiles;
  }

  Future<void> deleteDeviceProfile(int id) async {
    final stmt = _db.prepare('DELETE FROM device_profiles WHERE id = ?');
    stmt.execute([id]);
    stmt.dispose();
  }

  void closeDatabase() {
    _db.dispose();
  }
}
