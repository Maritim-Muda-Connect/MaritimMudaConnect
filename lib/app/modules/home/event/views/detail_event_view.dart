import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/response/event_response.dart';
import 'package:maritimmuda_connect/app/modules/home/event/controllers/event_controller.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

class DetailEventView extends GetView<EventController> {
  final Event eventData;
  const DetailEventView({Key? key, required this.eventData}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String startDate =
        DateFormat('dd/MM/yyyy').format(eventData.startDate!);
    final String endDate = DateFormat('dd/MM/yyyy').format(eventData.endDate!);
    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: neutral02Color,
        title: Text(
          'Detail Event',
          style: boldText24,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.share,
                color: primaryDarkBlueColor,
              ),
              onPressed: () {
                Share.share(
                    "Check this out: \n${eventData.externalUrl ?? "Sorry, this event does not have a URL available!"}",
                    subject: "Event Url");
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Image.network(
                eventData.posterLink!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                eventData.name!,
                textAlign: TextAlign.justify,
                style: boldText24,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Penyelenggara',
                style: boldText16,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(style: regulerText14, eventData.organizerName!),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                style: boldText16,
                'Waktu Mulai',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(style: regulerText14, startDate),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                  style: boldText16,
                  textAlign: TextAlign.start,
                  'Waktu Selesai'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(style: regulerText14, endDate),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: primaryDarkBlueColor),
                  child: Text(
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                      'Daftar'),
                  onPressed: () {
                    _launchURL(eventData.externalUrl ?? " ");
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _BenefitRowItem(IconData icon, String text) {
  return Row(
    children: [
      Icon(
        icon,
        color: primaryBlueColor,
      ),
      SizedBox(
        width: 8.0,
      ),
      Text(
        text,
        style: regulerText14,
      ),
    ],
  );
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red));
  }
}
