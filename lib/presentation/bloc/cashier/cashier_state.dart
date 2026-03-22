part of 'cashier_bloc.dart';

enum CashierStatus { initial, loading, loaded, error }

class CashierState extends Equatable {
  final CashierStatus status;
  final List<ProductEntity> products;
  final List<CartItem> cartItems;
  final String searchQuery;
  final CategoryEntity? selectedCategory;
  final ErrorEntity? error;

  const CashierState({
    this.status = CashierStatus.initial,
    this.products = const [],
    this.cartItems = const [],
    this.searchQuery = '',
    this.selectedCategory,
    this.error,
  });

  /// Products filtered by the current search query and selected category.
  List<ProductEntity> get filteredProducts {
    var filtered = products;

    if (selectedCategory != null) {
      filtered = filtered.where((p) => p.category?.id == selectedCategory!.id).toList();
    }

    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      filtered = filtered.where((p) => (p.name ?? '').toLowerCase().contains(q)).toList();
    }

    return filtered;
  }

  /// Subtotal price of all items in the cart.
  int get subtotal => cartItems.fold(0, (sum, item) => sum + (item.qty * item.price));

  CashierState copyWith({
    CashierStatus? status,
    List<ProductEntity>? products,
    List<CartItem>? cartItems,
    String? searchQuery,
    CategoryEntity? selectedCategory,
    bool clearCategory = false,
    ErrorEntity? error,
  }) {
    return CashierState(
      status: status ?? this.status,
      products: products ?? this.products,
      cartItems: cartItems ?? this.cartItems,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, products, cartItems, searchQuery, selectedCategory, error];
}

class CartItem extends Equatable {
  /// Unique id generated from productId + variantId.
  final String id;
  final int productId;
  final String productName;
  final String? productImage;
  final int variantId;
  final String variantName;
  final int qty;
  final int price;

  const CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.variantId,
    required this.variantName,
    required this.qty,
    required this.price,
  });

  CartItem copyWith({int? qty}) {
    return CartItem(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      variantId: variantId,
      variantName: variantName,
      qty: qty ?? this.qty,
      price: price,
    );
  }

  @override
  List<Object?> get props => [id, productId, productName, productImage, variantId, variantName, qty, price];
}
