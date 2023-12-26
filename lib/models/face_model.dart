class FaceModel {
  String image;
  bool isSelect;
  final String name;
  final String age;
  FaceModel({
    required this.image,
    this.isSelect = false,
    required this.age,
    required this.name,
  });
}

List<FaceModel> faceList = [
  FaceModel(
    image: 'assets/baby_face/1.png',
    age: '1 year, 3 months old',
    name: 'Alice Bob',
  ),
  FaceModel(
    image: 'assets/baby_face/2.png',
    age: '1 year, 2 months old',
    name: 'Asher',
  ),
  FaceModel(
    image: 'assets/baby_face/3.png',
    age: '1 year, 4 months old',
    name: 'Aiden',
  ),
  FaceModel(
    image: 'assets/baby_face/4.png',
    age: '',
    name: 'Scarlett',
  ),
  FaceModel(
    image: 'assets/baby_face/5.png',
    age: '1 year, 3 months old',
    name: 'Hazel',
  ),
  FaceModel(
    image: 'assets/baby_face/6.png',
    age: '1 year, 3 months old',
    name: 'Jack Leach',
  ),
  FaceModel(
    image: 'assets/baby_face/7.png',
    age: '1 year, 3 months old',
    name: 'Wyatt',
  ),
  FaceModel(
    image: 'assets/baby_face/8.png',
    age: '1 year, 3 months old',
    name: 'Alice Bob',
  ),
];
