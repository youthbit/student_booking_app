enum PartType {
  body(key: 'body', title: 'Body'),
  head(key: 'head', title: 'Head'),
  face(key: 'face', title: 'Face'),
  facialHair(key: 'facial-hair', title: 'Facial hair'),
  accessories(key: 'accessories', title: 'Eye accessories'),
  background(key: 'background', title: 'Background');

  const PartType({
    required this.key,
    required this.title,
  });

  final String key;
  final String title;
}

extension PartGetters<T> on Map<PartType, T> {
  T get body => this[PartType.body] as T;
  T get head => this[PartType.head] as T;
  T get face => this[PartType.face] as T;
  T get facialHair => this[PartType.facialHair] as T;
  T get accessories => this[PartType.accessories] as T;
  T get background => this[PartType.background] as T;
}
