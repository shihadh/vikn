import 'package:flutter/material.dart';
import '../widgets/revenue_chart.dart';
import '../../../core/constants/color_const.dart';
import '../../../core/constants/text_const.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildRevenueSection(),
              const SizedBox(height: 30),
              _buildNavCard(
                icon: Icons.access_time,
                title: TextConst.dashboard['bookings']!,
                subtitle1: '123',
                subtitle2: 'Reserved',
                color: const Color(0xFFF6EFED),
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildNavCard(
                icon: Icons.receipt_long,
                title: TextConst.dashboard['invoices']!,
                subtitle1: '10,232.00',
                subtitle2: 'Rupees',
                color: const Color(0xFFA9C9C5),
                onTap: () => Navigator.pushNamed(context, '/sale-list'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.apps, color: ColorConst.primary, size: 30),
        const SizedBox(width: 10),
        const Text(
          'CabZing',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const CircleAvatar(
          radius: 20,
          backgroundColor: ColorConst.profileIconBg,
          child: Icon(Icons.person, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildRevenueSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConst.cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${TextConst.dashboard['sar']!} ',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '2,78,000.00',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorConst.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        '+21% ',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                      const Text(
                        'than last month ',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                'Revenue',
                style: TextStyle(color: ColorConst.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const RevenueChart(),
          const SizedBox(height: 10),
          const Text('September 2023', style: TextStyle(color: ColorConst.white)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(8, (index) => _buildDateChip((index + 1).toString(), index == 1)),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? ColorConst.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        date.padLeft(2, '0'),
        style: TextStyle(
          color: isSelected ? Colors.white : ColorConst.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildNavCard({
    required IconData icon,
    required String title,
    required String subtitle1,
    required String subtitle2,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorConst.cardBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 40,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: ColorConst.black,size: 20,),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: ColorConst.white)),
                Text(subtitle1, style: const TextStyle(color:ColorConst.white , fontSize: 14)),
                Text(subtitle2, style: const TextStyle(color: Colors.white38, fontSize: 14)),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF131313),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_forward, color: ColorConst.white)),
          ],
        ),
      ),
    );
  }

  }

