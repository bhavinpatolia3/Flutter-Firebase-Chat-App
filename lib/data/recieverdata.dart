class RecieverData {
  String name;
  String message;
  String time;
  String userimage;
  int recieverid;
  String location;

  RecieverData(
      {this.recieverid, this.name, this.message, this.time, this.userimage,this.location});
}

List<RecieverData> recievermessages = [
  RecieverData(
      recieverid: 1,
      name: 'Roman Sokolov',
      message: 'Nam dapibus nisl vitae elite ',
      time: '22:15',
      location: 'India',
      userimage: 'https://randomuser.me/api/portraits/men/44.jpg'),
  RecieverData(
      recieverid: 2,
      name: 'Gloria Wilson',
      message: 'Son strongle and matphisically',
      time: '15:36',
      location: 'China',
      userimage: 'https://randomuser.me/api/portraits/women/76.jpg'),
  RecieverData(
      recieverid: 3,
      name: 'Denis',
      message: 'Like so good',
      time: '02:51',
      location: "China",
      userimage: 'https://randomuser.me/api/portraits/men/62.jpg'),
  RecieverData(
      recieverid: 4,
      name: 'Ella Filatova',
      message: 'Nam dapibus nisl vitae elite',
      time: '17:52',
      location: "USA",
      userimage: 'https://randomuser.me/api/portraits/women/71.jpg'),
  RecieverData(
      recieverid: 5,
      name: 'Homies',
      message: 'I seem distinctly too',
      time: '06:39',
      location: 'Canada',
      userimage: 'https://randomuser.me/api/portraits/men/58.jpg'),
  RecieverData(
      recieverid: 6,
      name: 'David',
      message: 'Portlan ugh fashiin axe...',
      time: '15:20',
      userimage: 'https://randomuser.me/api/portraits/men/13.jpg'),
  RecieverData(
      recieverid: 7,
      name: 'Aitor',
      message: 'Retro occupy organic',
      time: '19:00',
      location: 'Australia',
      userimage: 'https://randomuser.me/api/portraits/men/35.jpg'),
  RecieverData(
      recieverid: 8,
      name: 'Lorena',
      message: 'I seem distinctly too',
      time: '08:25',
      location: 'India',
      userimage: 'https://randomuser.me/api/portraits/men/70.jpg'),
  RecieverData(
      recieverid: 9,
      name: 'Lina',
      message: 'Nam dapibus nisl vitae elite',
      time: '13:10',
      location: "China",
      userimage: 'https://randomuser.me/api/portraits/men/86.jpg'),
];
