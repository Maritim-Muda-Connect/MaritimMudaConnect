import 'dart:convert';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/job_response.dart';
import 'package:maritimmuda_connect/app/data/services/job_service.dart';


class JobController extends GetxController {
  var jobs = <JobResponse>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading(true);
      var response = await JobService().fetchJob();

      jobs.assignAll(response);
    } catch (e) {
      print('Error fetching jobs: $e');
    } finally {
      isLoading(false);
    }
  }
}

