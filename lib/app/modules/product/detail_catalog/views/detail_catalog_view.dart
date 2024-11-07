import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_catalog_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  const DetailProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Detail Partners'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fajar Elektronik • 14 September 2024 • Electronic',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Toko Dian Listrik: Mitra Terpercaya untuk Kebutuhan Listrik dan Elektronik Anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Menggunakan Image.asset untuk menampilkan gambar
            Image.asset(
              'assets/images/catalog_image.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              'Berlokasi di Sumuranja, Kecamatan Puloampel, Toko Dian Listrik adalah usaha lokal yang mengkhususkan diri dalam penyediaan perlengkapan listrik dan peralatan elektronik. Dengan komitmen untuk melayani kebutuhan daya dan teknologi masyarakat, mereka menawarkan berbagai produk mulai dari komponen listrik dasar hingga perangkat elektronik modern.',
              style: TextStyle(fontSize: 16),
            ),
            // ... (sisa kode tetap sama)
          ],
        ),
      ),
    );
  }
}
