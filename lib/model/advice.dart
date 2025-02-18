class Advice {
  final String id;
  final String illnessName ;
  final String imgPath ;
  final List<String> advices;

  Advice( {
    required this.id,
    required this.illnessName,
    required this.imgPath,
    required this.advices,
  });

  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(
      id: json['id'],
      illnessName: json['illnessName'],
      imgPath: json['imgPath'],
      advices: List<String>.from(json['advices']),
    );
  }
}