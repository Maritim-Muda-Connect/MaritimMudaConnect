import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/scholarship_data.dart';
import 'package:maritimmuda_connect/app/modules/home/scholarship/controllers/scholarship_controller.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/models/response/scholarship_response.dart';

class DetailScholarshipView extends GetView<ScholarshipController> {
  final Scholarship scholarshipData;
  const DetailScholarshipView({Key? key, required this.scholarshipData})
      : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat('dd/MM/yyyy').format(scholarshipData.submissionDeadline!);

    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        title: Text(
          'Detail Scholarship',
          style: boldText24,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [IconButton(
            icon: Icon(Icons.send, color: primaryDarkBlueColor,),
            onPressed: () {
              Share.share("Check this out: \n${scholarshipData.registrationLink ?? "Sorry, this scholarship does not have a URL available!"}" , subject: "Scholarship Url");
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
                "https://lh3.googleusercontent.com/9uRdrnXVbm8VHdRBA7iu0n5BLUBARZVtJw3-u25b7V2d8MEHVqEgfiuJqvTxg6ePAWuylzpRMhF403srp3ogy52--yUue2YcFsTa85N98jVm4V-xglUz8EuvFv0PTSRnyg=w3374",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                scholarshipData.name!,
                style: boldText24,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "ga ada deskripsi wkwkw",
                style: regulerText14,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                style: boldText16,
                'Penyelenggara',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(style: regulerText14, scholarshipData.providerName!),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            //   child: Text(
            //     style: boldText16,
            //     'Benefit',
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 16.0,
            //   ),
            //   child: Text(style: regulerText14, scholarshipData.benefit!),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                  style: boldText16,
                  textAlign: TextAlign.start,
                  'Tanggal Penting'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(style: regulerText14, date),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Color(0xFF086C9E)),
                  child: Text(
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                      'Daftar'),
                  onPressed: () {
                    _launchURL(scholarshipData.registrationLink!);
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
