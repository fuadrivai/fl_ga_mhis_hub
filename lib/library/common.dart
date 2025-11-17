import 'package:fl_ga_mhis_hub/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Common {
  Common._();

  static String getCurrentDate() {
    final now = DateTime.now();
    return Jiffy.parseFromDateTime(now).format(pattern: 'EEEE, dd MMMM yyyy');
  }

  static List<Widget> buildPageNumbers({
    required int currentPage,
    required int totalPage,
  }) {
    final List<Widget> pages = [];

    int startPage = currentPage - 2;
    int endPage = currentPage + 2;

    if (startPage < 1) {
      endPage += 1 - startPage;
      startPage = 1;
    }

    if (endPage > totalPage) {
      startPage -= endPage - totalPage;
      endPage = totalPage;
    }

    startPage = startPage.clamp(1, totalPage);
    endPage = endPage.clamp(1, totalPage);

    // First page
    if (startPage > 1) {
      pages.add(PageNumberWidget(page: 1));
      if (startPage > 2) {
        pages.add(const Text('...', style: TextStyle(color: Colors.grey)));
      }
    }

    // Page numbers
    for (int i = startPage; i <= endPage; i++) {
      pages.add(PageNumberWidget(page: i));
    }

    // Last page
    if (endPage < totalPage) {
      if (endPage < totalPage - 1) {
        pages.add(const Text('...', style: TextStyle(color: Colors.grey)));
      }
      pages.add(PageNumberWidget(page: totalPage));
    }

    return pages;
  }
}

enum ViewMode { list, grid }
