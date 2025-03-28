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
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.work_off,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Sorry, we don\'t have any job data at the moment.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: neutral01Color,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showJobDetails(context, job),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.positionTitle ?? '',
                          style: boldText16,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              size: 16,
                              color: neutral04Color,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                job.companyName ?? '',
                                style: regulerText14.copyWith(
                                  color: neutral04Color,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryBlueColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      job.type == 1 ? 'Full Time' : 'Contract',
                      style: regulerText12.copyWith(
                        color: primaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: neutral04Color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Until ${DateFormat('dd MMMM yyyy').format(job.applicationClosedAt ?? DateTime.now())}',
                    style: regulerText12.copyWith(
                      color: neutral04Color,
                    ),
                  ),
                ],
              ),
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
          initialChildSize: 0.5,
          minChildSize: 0.3,
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
        color: neutral01Color,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: neutral03Color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: neutral04Color),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            job.positionTitle ?? '',
            style: boldText24,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primaryBlueColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job.type == 1 ? 'Full Time' : 'Contract',
                  style: regulerText14.copyWith(
                    color: primaryBlueColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.calendar_today,
                size: 16,
                color: neutral04Color,
              ),
              const SizedBox(width: 8),
              Text(
                'Until ${DateFormat('dd MMMM yyyy').format(job.applicationClosedAt ?? DateTime.now())}',
                style: regulerText14.copyWith(
                  color: neutral04Color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Company',
            style: boldText16,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.business,
                size: 16,
                color: neutral04Color,
              ),
              const SizedBox(width: 8),
              Text(
                job.companyName ?? '',
                style: regulerText14,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Job Link',
            style: boldText16,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              await launchUrl(
                Uri.parse(job.link ?? 'https://hub.maritimmuda.id'),
              );
            },
            child: Text(
              job.link ?? 'https://hub.maritimmuda.id',
              style: regulerText14.copyWith(
                color: primaryBlueColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'APPLY NOW',
            onPressed: () async {
              await launchUrl(
                Uri.parse(job.link ?? 'https://hub.maritimmuda.id'),
              );
            },
          ),
        ],
      ),
    );
  }
}
