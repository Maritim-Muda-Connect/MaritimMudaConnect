import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/response/job_response.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';

import 'package:maritimmuda_connect/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/job_controller.dart';

class JobView extends GetView<JobController> {
  const JobView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        backgroundColor: neutral02Color,
        scrolledUnderElevation: 0,
        title: Text(
          'Available Job',
          style: boldText24,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.jobs.isEmpty) {
          return const Text('tidak ada data');
        } else {
          return ListView.builder(
            itemCount: controller.jobs.length,
            itemBuilder: (context, index) {
              final job = controller.jobs[index];
              return _buildJobCard(context, job);
            },
          );
        }
      }),
    );
  }

  Widget _buildJobCard(BuildContext context, JobResponse job) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: neutral01Color,
      child: InkWell(
        onTap: () => _showJobDetails(context, job),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.positionTitle ?? '',
                overflow: TextOverflow.ellipsis,
                style:
                boldText16
              ),
              const SizedBox(height: 8),
              Text(job.companyName ?? ''),
              const SizedBox(height: 8),
              Text(
                  'Until ${DateFormat('dd MMMM yyyy').format(job.applicationClosedAt ?? DateTime.now())}'),
            ],
          ),
        ),
      ),
    );
  }

  void _showJobDetails(BuildContext context, JobResponse job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          maxChildSize: 0.6,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: _buildJobDetailsContent(context, job),
            );
          },
        );
      },
    );
  }

  Widget _buildJobDetailsContent(BuildContext context, JobResponse job) {
    return Container(
      decoration: BoxDecoration(
        color: neutral02Color,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Job',
                style: regulerText14,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            job.positionTitle ?? '',
            style: boldText20,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(job.companyName ?? ''),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              await launchUrl(
                  Uri.parse(job.link ?? 'https://hub.maritimmuda.id'));
            },
            child: Text('Job Link: ${job.link}'),
          ),
          const SizedBox(height: 48),
          const Text('Job Details',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(job.companyName ?? ''),
          Chip(label: Text(job.type == 1 ? 'Full Time' : 'Contract')),
          const SizedBox(height: 32),
          CustomButton(
              text: 'APPLY',
              onPressed: () async {
                await launchUrl(
                    Uri.parse(job.link ?? 'https://hub.maritimmuda.id'));
              })
        ],
      ),
    );
  }
}
