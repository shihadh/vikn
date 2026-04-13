import 'package:flutter/material.dart';
import '../../../core/constants/color_const.dart';
import '../../../core/constants/text_const.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String selectedStatus = 'Pending';
  String selectedRange = 'This Month';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConst.filter['title']!),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(Icons.visibility_outlined , color: ColorConst.primary,)),
          TextButton(
            onPressed: () {},
            child: Text(
              TextConst.filter['filter']!,
              style: const TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDropdown(selectedRange, (val) => setState(() => selectedRange = val!)),
            const SizedBox(height: 20),
            _buildDateRange(),
            const SizedBox(height: 30),
            _buildStatusChips(),
            const SizedBox(height: 30),
            _buildCustomerDropdown(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ColorConst.cardBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: ColorConst.cardBg,
        items: ['This Month', 'Last Month', 'Custom Range']
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateRange() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDateField('12/09/2023'),
        const SizedBox(width: 12),
        _buildDateField('12/09/2023'),
      ],
    );
  }

  Widget _buildDateField(String date) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xff1B2B30),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_outlined, color: Colors.blueAccent, size: 16),
          const SizedBox(width: 5,),
          Text(date, style: const TextStyle(fontSize: 14,color: ColorConst.white)),
        ],
      ),
    );
  }

  Widget _buildStatusChips() {
    final statuses = ['Pending', 'Invoiced', 'Cancelled'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: statuses.map((status) {
        final isSelected = selectedStatus == status;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(status),
            selected: isSelected,
            onSelected: (val) => setState(() => selectedStatus = status),
            selectedColor: ColorConst.primary,
            backgroundColor: ColorConst.cardBg,
            labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white38),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCustomerDropdown() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color:const Color(0xff08131E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xff1C3347))
          ),
          child: Row(
            children: [
              Text(TextConst.filter['customer']!, style: const TextStyle(color: Colors.white70)),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: ColorConst.white),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xff1B2B30),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('savad farooque', style: TextStyle(color: ColorConst.white, fontSize: 13)),
                SizedBox(width: 6),
                Icon(Icons.close, color: ColorConst.primary, size: 14),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
