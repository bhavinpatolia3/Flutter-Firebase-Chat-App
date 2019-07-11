class SenderData {
  String message;
  String name;
  int id;

  SenderData({this.message, this.name, this.id});
}

List<SenderData> sendermessages = [
  SenderData(id: 1, name: 'Alexa', message: 'Hiii'),
  SenderData(id: 2, name: 'Home', message: 'Hiii'),
  SenderData(id: 1, name: 'Smith joe', message: 'How are you?'),
  SenderData(id: 2, name: 'Smith joe', message: 'I am fine'),
  SenderData(id: 2, name: 'Smith joe', message: 'And you?'),
  SenderData(id: 1, name: 'Smith joe', message: 'I am also fine'),
  SenderData(id: 2, name: 'Smith joe', message: 'okkk'),
  SenderData(id: 2, name: 'Smith joe', message: 'what About next?'),
];
