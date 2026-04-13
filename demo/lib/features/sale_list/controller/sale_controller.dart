import 'package:flutter/material.dart';
import '../model/sale_model.dart';
import '../service/sale_service.dart';

class SaleController extends ChangeNotifier {
  final SaleService _service = SaleService();
  
  final List<SaleModel> _sales = [];
  List<SaleModel> get sales => _sales;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _currentPage = 1;
  final int _itemsPerPage = 20;

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  SaleController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        fetchSales();
      }
    }
  }

  Future<void> fetchSales({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _hasMore = true;
      _sales.clear();
    }

    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final (data, error) = await _service.fetchSales(
      pageNumber: _currentPage,
      itemsPerPage: _itemsPerPage,
      search: searchController.text,
    );

    if (error != null) {
      _hasMore = false;
    } else if (data != null) {
      if (data.length < _itemsPerPage) {
        _hasMore = false;
      }
      _sales.addAll(data);
      _currentPage++;
    } else {
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  void onSearchChanged(String value) {
    
    fetchSales(isRefresh: true);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
