part of 'cashier_bloc.dart';

enum CashierStatus { initial, loading, loaded, error }

class CashierState extends Equatable {
  final CashierStatus status;
  final String? CustomerName;
  final String? customerPhone;
  final String? tableId;
  final String? tableName;
  final List<ProductEntity> products;
  final List<SaleModeEntity> saleModeList;
  final List<CouponEntity> couponList;
  final List<TaxEntity> taxList;
  final List<CartItem> cartItems;
  final String? couponCode;
  final int? couponId;
  final num? discount;
  final String searchQuery;
  final CategoryEntity? selectedCategory;
  final ErrorEntity? error;

  const CashierState({
    this.status = CashierStatus.initial,
    this.CustomerName,
    this.customerPhone,
    this.tableId,
    this.tableName,
    this.products = const [],
    this.saleModeList = const [],
    this.couponList = const [],
    this.taxList = const [],
    this.cartItems = const [],
    this.couponCode,
    this.couponId,
    this.discount,
    this.searchQuery = '',
    this.selectedCategory,
    this.error,
  });

  /// Products filtered by the current search query and selected category.
  List<ProductEntity> get filteredProducts {
    var filtered = products;

    if (selectedCategory != null) {
      filtered = filtered
          .where((p) => p.category?.id == selectedCategory!.id)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      filtered = filtered
          .where((p) => (p.name ?? '').toLowerCase().contains(q))
          .toList();
    }

    return filtered;
  }

  /// Subtotal price of all items in the cart.
  num get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.qty * item.price));

  num get subtotalWithDiscount {
    final result = subtotal - (discount ?? 0);
    return result < 0 ? 0 : result;
  }

  List<TaxEntity> get addTaxValue => taxList.map((tax) {
    return tax.copyWith(
      value:
          (num.tryParse(tax.percent ?? '0') ?? 0) * subtotalWithDiscount / 100,
    );
  }).toList();

  num get total =>
      subtotalWithDiscount +
      addTaxValue.fold(0, (sum, tax) => sum + (tax.value ?? 0));

  CashierState copyWith({
    CashierStatus? status,
    String? CustomerName,
    String? customerPhone,
    String? tableId,
    String? tableName,
    List<ProductEntity>? products,
    List<SaleModeEntity>? saleModeList,
    List<CouponEntity>? couponList,
    List<TaxEntity>? taxList,
    List<CartItem>? cartItems,
    String? couponCode,
    int? couponId,
    num? discount,
    String? searchQuery,
    CategoryEntity? selectedCategory,
    bool clearCategory = false,
    ErrorEntity? error,
  }) {
    return CashierState(
      status: status ?? this.status,
      CustomerName: CustomerName ?? this.CustomerName,
      customerPhone: customerPhone ?? this.customerPhone,
      tableId: tableId ?? this.tableId,
      tableName: tableName ?? this.tableName,
      products: products ?? this.products,
      saleModeList: saleModeList ?? this.saleModeList,
      couponList: couponList ?? this.couponList,
      taxList: taxList ?? this.taxList,
      cartItems: cartItems ?? this.cartItems,
      couponCode: couponCode ?? this.couponCode,
      couponId: couponId ?? this.couponId,
      discount: discount ?? this.discount,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: clearCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    CustomerName,
    customerPhone,
    tableId,
    tableName,
    products,
    saleModeList,
    couponList,
    taxList,
    cartItems,
    couponCode,
    couponId,
    discount,
    searchQuery,
    selectedCategory,
    error,
  ];
}

class CartItem extends Equatable {
  /// Unique id generated from productId + variantId.
  final String id;
  final int productId;
  final String productName;
  final String? productImage;
  final int variantId;
  final String variantName;
  final num qty;
  final num price;
  final String? notes;

  const CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.variantId,
    required this.variantName,
    required this.qty,
    required this.price,
    this.notes,
  });

  CartItem copyWith({num? qty, String? notes}) {
    return CartItem(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      variantId: variantId,
      variantName: variantName,
      qty: qty ?? this.qty,
      price: price,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    productName,
    productImage,
    variantId,
    variantName,
    qty,
    price,
    notes,
  ];
}
