import 'package:fl_ga_mhis_hub/library/common.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final GestureTapCallback? onRefresh;
  final ValueChanged<String>? onChanged;
  final Function()? onPressedClearIcon;
  final Function(ViewMode)? viewMode;
  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onPressedClearIcon,
    this.viewMode,
    this.onRefresh,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController controller = TextEditingController();
  // ViewMode _viewMode = ViewMode.list;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(Icons.search_rounded, color: Colors.grey[500], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText:
                            'Cari berdasarkan nama, posisi, atau departemen...',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: widget.onChanged,
                    ),
                  ),
                  if (controller.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          controller.clear();
                          widget.onPressedClearIcon!();
                        });
                      },
                      icon: Icon(
                        Icons.clear_rounded,
                        color: Colors.grey[500],
                        size: 18,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // View Mode Toggle
          // Container(
          //   padding: const EdgeInsets.all(4),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[100],
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Row(
          //     children: [
          //       // List View Button
          //       GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             _viewMode = ViewMode.list;
          //             widget.viewMode!(_viewMode);
          //           });
          //         },
          //         child: Container(
          //           padding: const EdgeInsets.all(8),
          //           decoration: BoxDecoration(
          //             color: _viewMode == ViewMode.list
          //                 ? Theme.of(context).colorScheme.primary
          //                 : Colors.transparent,
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Icon(
          //             Icons.list_rounded,
          //             color: _viewMode == ViewMode.list
          //                 ? Colors.white
          //                 : Colors.grey[600],
          //             size: 20,
          //           ),
          //         ),
          //       ),
          //       // const SizedBox(width: 4),
          //       // Grid View Button
          //       GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             _viewMode = ViewMode.grid;
          //             widget.viewMode!(_viewMode);
          //           });
          //         },
          //         child: Container(
          //           padding: const EdgeInsets.all(8),
          //           decoration: BoxDecoration(
          //             color: _viewMode == ViewMode.grid
          //                 ? Theme.of(context).colorScheme.primary
          //                 : Colors.transparent,
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Icon(
          //             Icons.grid_view_rounded,
          //             color: _viewMode == ViewMode.grid
          //                 ? Colors.white
          //                 : Colors.grey[600],
          //             size: 20,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: widget.onRefresh,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.refresh, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
