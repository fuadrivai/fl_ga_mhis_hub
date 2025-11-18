import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/page/attendance_screen.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final AttendanceLog? attendance;
  const SuccessScreen({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    final isCheckIn = attendance?.type == "check_in";

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(isCheckIn),
                      const SizedBox(height: 32),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 700) {
                            return _buildDesktopLayout(
                              attendance?.photo,
                              attendance?.time,
                            );
                          } else {
                            return _buildMobileLayout(
                              attendance?.photo,
                              attendance?.time,
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 24),
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isCheckIn) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_rounded,
            size: 48,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isCheckIn ? "Clock In Berhasil!" : "Clock Out Berhasil!",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isCheckIn ? "Kehadiran Anda telah tercatat" : "Sampai jumpa besok!",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(String? photoUrl, String? time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildPhotoSection(photoUrl)),
        const SizedBox(width: 32),
        Expanded(child: _buildDetailSection(time)),
      ],
    );
  }

  Widget _buildMobileLayout(String? photoUrl, String? time) {
    return Column(
      children: [
        SizedBox(width: 250, child: _buildPhotoSection(photoUrl)),
        const SizedBox(height: 24),
        _buildDetailSection(time),
      ],
    );
  }

  Widget _buildPhotoSection(String? photoUrl) {
    return Column(
      children: [
        Text(
          "Foto Absensi",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[100],
            ),
            child: Image.network(
              photoUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildPhotoPlaceholder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_camera, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'Foto tidak tersedia',
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String? time) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Pegawai",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            icon: Icons.person_outline,
            label: "Nama",
            value: attendance?.employee?.personal?.fullname ?? "-",
          ),
          _buildInfoItem(
            icon: Icons.business_outlined,
            label: "Organisasi",
            value: attendance?.employee?.employment?.organizationName ?? "-",
          ),
          _buildInfoItem(
            icon: Icons.work_outline,
            label: "Jabatan",
            value: attendance?.employee?.employment?.jobPositionName ?? "-",
          ),
          _buildInfoItem(
            icon: Icons.access_time_outlined,
            label: "Waktu",
            value: time ?? "-",
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    bool isHighlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12, top: 2),
            child: Icon(
              icon,
              size: 20,
              color: isHighlighted ? Colors.green : Colors.grey[600],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: isHighlighted ? Colors.green : Colors.grey[800],
                    fontWeight: isHighlighted
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AttendanceScreen()),
            (route) => false,
          ),
          icon: const Icon(Icons.arrow_back_rounded, size: 20),
          label: const Text(
            "Kembali ke Beranda",
            style: TextStyle(fontSize: 16),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // const SizedBox(width: 12),
        // OutlinedButton.icon(
        //   onPressed: () {
        //     // Tambahkan aksi screenshot atau print jika diperlukan
        //   },
        //   icon: const Icon(Icons.share_outlined, size: 20),
        //   label: const Text("Bagikan"),
        //   style: OutlinedButton.styleFrom(
        //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
