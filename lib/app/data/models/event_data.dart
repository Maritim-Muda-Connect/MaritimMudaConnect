class EventData {
  String? title;
  String? description;
  String? descriptionDetail;
  String? imageUrl;
  String? organizer;
  String? time;
  String? date;
  String? views;
  String? likes;
  String? send;
  List<String?> benefit;
  String? url;

  EventData({
    this.title,
    this.description,
    this.descriptionDetail,
    this.imageUrl,
    this.organizer,
    this.time,
    this.date,
    this.views,
    this.likes,
    this.send,
    required this.benefit,
    this.url,
  });
}

var eventList = [
  EventData(
      title: 'Kick Off Meeting Penyusunan RKP Tahun 2024',
      description: 'Museum Kebaharian Jakarta, dan Maritim Muda Nusantara....',
      descriptionDetail:
          ' Kementerian PPN/Bappenas akan melaksanakan Kick Off Meeting Penyusunan RKP Tahun 2024 dengan tema Mempercepat Transformasi Ekonomi yang Inklusif dan Berkelanjutan bersama Menteri PPN/Kepala Bappenas @suharsomonoarfa '
          '\n \nKegiatan akan membahas arah kebijakan pembangunan sebagai bahan acuan dalam menyusun dokumen perencanaan termasuk menyampaikan tema, sasaran, arah kebijakan, dan prioritas pembangunan RKP Tahun 2024',

      // imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsK4WL4kqFGb5VjZUC02f14-Ycix0Ujpnq-Q&s',
      imageUrl: 'https://pbs.twimg.com/media/FLXpTawaIAIeCqV.jpg:large',
      time: '13.00',
      organizer: 'Bappenas',
      date: '21-27 Agustus',
      views: '105',
      likes: '53',
      send: '103',
      url: 'https://media.maritimmuda.id/kick-off-meeting-penyusunan-rkp-tahun-2024/',
      benefit: ['Makan Siang', 'Ball Room', 'Doorprize']),
  EventData(
      title: 'Lomba Video Gagasan Futuristik Kemaritiman (LetSea) 2024',
      description: 'Museum Kebaharian Jakarta, dan Maritim Muda Nusantara....',
      descriptionDetail:
          ' Kementerian PPN/Bappenas akan melaksanakan Kick Off Meeting Penyusunan RKP Tahun 2024 dengan tema Mempercepat Transformasi Ekonomi yang Inklusif dan Berkelanjutan bersama Menteri PPN/Kepala Bappenas @suharsomonoarfa '
          '\nKegiatan akan membahas arah kebijakan pembangunan sebagai bahan acuan dalam menyusun dokumen perencanaan termasuk menyampaikan tema, sasaran, arah kebijakan, dan prioritas pembangunan RKP Tahun 2024',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsK4WL4kqFGb5VjZUC02f14-Ycix0Ujpnq-Q&s',
      time: '13.00',
      organizer: 'Museum Bahari Jakarta',
      date: '5 September',
      views: '5230',
      likes: '768',
      send: '52',
      url: 'https://media.maritimmuda.id/kick-off-meeting-penyusunan-rkp-tahun-2024/',
      benefit: ['Makan Siang', 'Ball Room', 'Doorprize']),
  EventData(
      title: 'Lomba Video Gagasan Futuristik Kemaritiman (LetSea) 2024',
      description: 'Museum Kebaharian Jakarta, dan Maritim Muda Nusantara....',
      descriptionDetail:
          ' Kementerian PPN/Bappenas akan melaksanakan Kick Off Meeting Penyusunan RKP Tahun 2024 dengan tema Mempercepat Transformasi Ekonomi yang Inklusif dan Berkelanjutan bersama Menteri PPN/Kepala Bappenas @suharsomonoarfa '
          '\nKegiatan akan membahas arah kebijakan pembangunan sebagai bahan acuan dalam menyusun dokumen perencanaan termasuk menyampaikan tema, sasaran, arah kebijakan, dan prioritas pembangunan RKP Tahun 2024',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsK4WL4kqFGb5VjZUC02f14-Ycix0Ujpnq-Q&s',
      time: '13.00',
      organizer: 'Museum Bahari Jakarta',
      date: '5 September',
      views: '5230',
      likes: '768',
      send: '52',
      url: 'https://media.maritimmuda.id/kick-off-meeting-penyusunan-rkp-tahun-2024/',
      benefit: ['Makan Siang', 'Ball Room', 'Doorprize']),
  EventData(
      title: 'Lomba Video Gagasan Futuristik Kemaritiman (LetSea) 2024',
      description: 'Museum Kebaharian Jakarta, dan Maritim Muda Nusantara....',
      descriptionDetail:
          ' Kementerian PPN/Bappenas akan melaksanakan Kick Off Meeting Penyusunan RKP Tahun 2024 dengan tema Mempercepat Transformasi Ekonomi yang Inklusif dan Berkelanjutan bersama Menteri PPN/Kepala Bappenas @suharsomonoarfa '
          '\nKegiatan akan membahas arah kebijakan pembangunan sebagai bahan acuan dalam menyusun dokumen perencanaan termasuk menyampaikan tema, sasaran, arah kebijakan, dan prioritas pembangunan RKP Tahun 2024',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsK4WL4kqFGb5VjZUC02f14-Ycix0Ujpnq-Q&s',
      time: '13.00',
      organizer: 'Museum Bahari Jakarta',
      date: '5 September',
      views: '5230',
      likes: '768',
      send: '52',
      url: 'https://media.maritimmuda.id/kick-off-meeting-penyusunan-rkp-tahun-2024/',
      benefit: ['Makan Siang', 'Ball Room', 'Doorprize']),
  EventData(
      title: 'Lomba Video Gagasan Futuristik Kemaritiman (LetSea) 2024',
      description: 'Museum Kebaharian Jakarta, dan Maritim Muda Nusantara....',
      descriptionDetail:
          ' Kementerian PPN/Bappenas akan melaksanakan Kick Off Meeting Penyusunan RKP Tahun 2024 dengan tema Mempercepat Transformasi Ekonomi yang Inklusif dan Berkelanjutan bersama Menteri PPN/Kepala Bappenas @suharsomonoarfa '
          '\nKegiatan akan membahas arah kebijakan pembangunan sebagai bahan acuan dalam menyusun dokumen perencanaan termasuk menyampaikan tema, sasaran, arah kebijakan, dan prioritas pembangunan RKP Tahun 2024',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsK4WL4kqFGb5VjZUC02f14-Ycix0Ujpnq-Q&s',
      time: '13.00',
      organizer: 'Museum Bahari Jakarta',
      date: '5 September',
      views: '5230',
      likes: '768',
      send: '52',
      url: 'https://media.maritimmuda.id/kick-off-meeting-penyusunan-rkp-tahun-2024/',
      benefit: ['Makan Siang', 'Ball Room', 'Doorprize']),
];
