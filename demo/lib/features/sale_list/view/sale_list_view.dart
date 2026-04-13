import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/sale_controller.dart';
import '../../../core/constants/color_const.dart';
import '../../../core/constants/text_const.dart';

class SaleListView extends StatefulWidget {
  const SaleListView({super.key});

  @override
  State<SaleListView> createState() => _SaleListViewState();
}

class _SaleListViewState extends State<SaleListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SaleController>().fetchSales(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConst.saleList['title']!),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(context),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff08131E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: context.read<SaleController>().searchController,
                decoration: InputDecoration(
                  fillColor:Color(0xff08131E),
                  hintText: TextConst.saleList['search']!,
                  prefixIcon: const Icon(Icons.search, color: Colors.white38),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xff1C3347)),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xff1C3347)),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                ),
                onChanged: (val) => context.read<SaleController>().onSearchChanged(val),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildFilterButton(context),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/filter'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: ColorConst.cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.filter_list, color: ColorConst.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              TextConst.saleList['filters']!,
              style: const TextStyle(color: ColorConst.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SaleController>(
      builder: (context, controller, child) {
        if (controller.sales.isEmpty && controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.sales.isEmpty) {
          return const Center(child: Text('No invoices found', style: TextStyle(color: Colors.white38)));
        }

        return ListView.separated(
          controller: controller.scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: controller.sales.length + (controller.hasMore ? 1 : 0),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index < controller.sales.length) {
              final sale = controller.sales[index];
              return _buildSaleItem(sale);
            } else {
              return const Center(child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ));
            }
          },
        );
      },
    );
  }

  Widget _buildSaleItem(sale) {
    Color statusColor;
    switch (sale.status.toLowerCase()) {
      case 'invoiced': statusColor = Colors.blue; break;
      case 'cancelled': statusColor = Colors.red; break;
      default: statusColor = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConst.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${sale.orderNo}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                sale.customerName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sale.status,
                style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                'SAR ${sale.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
