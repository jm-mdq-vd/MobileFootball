abstract class Deserializable {
  Deserializable Function(Map<String, dynamic> object) get deserialize;
}