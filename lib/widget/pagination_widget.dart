import 'package:fl_ga_mhis_hub/library/common.dart';
import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  final int currentPage;
  final int totalPage;
  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int currentPage = 1;
  @override
  void initState() {
    currentPage = widget.currentPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_left_rounded),
            style: IconButton.styleFrom(backgroundColor: Colors.grey[100]),
          ),
          const SizedBox(width: 8),

          // Page numbers
          Row(
            children: Common.buildPageNumbers(
              currentPage: currentPage,
              totalPage: widget.totalPage,
            ),
          ),

          const SizedBox(width: 8),

          // Next button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right_rounded),
            style: IconButton.styleFrom(backgroundColor: Colors.grey[100]),
          ),
        ],
      ),
    );
  }

  // void _goToPage(int page) {
  //   if (page >= 1 && page <= widget.totalPage) {
  //     setState(() {
  //       currentPage = page;
  //     });
  //   }
  // }

  // void _nextPage() {
  //   if (currentPage < widget.totalPage) {
  //     setState(() {
  //       currentPage++;
  //     });
  //   }
  // }

  // void _previousPage() {
  //   if (currentPage > 1) {
  //     setState(() {
  //       currentPage--;
  //     });
  //   }
  // }
}
