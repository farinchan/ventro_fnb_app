part of 'cashier_bloc.dart';

sealed class CashierEvent extends Equatable {
  const CashierEvent();

  @override
  List<Object> get props => [];
}

/// Load products from the API.
class CashierLoadProducts extends CashierEvent {
  const CashierLoadProducts();
}

class CashierLoadSaleMode extends CashierEvent {
  const CashierLoadSaleMode();

  @override
  List<Object> get props => [];
}

class CashierLoadTax extends CashierEvent {
  const CashierLoadTax();

  @override
  List<Object> get props => [];
}

class CashierLoadCoupon extends CashierEvent {
  const CashierLoadCoupon();

  @override
  List<Object> get props => [];
}

class CashierApplyCoupon extends CashierEvent {
  final String? couponCode;
  final int? couponId;
  final num discount;

  const CashierApplyCoupon({
    this.couponCode,
    this.couponId,
    required this.discount,
  });
}

/// Add a product variant to the cart, or increment its quantity if already present.
class CashierAddToCart extends CashierEvent {
  final ProductEntity product;
  final VariantEntity variant;

  const CashierAddToCart({required this.product, required this.variant});

  @override
  List<Object> get props => [product, variant];
}

/// Remove a specific cart item entirely.
class CashierRemoveFromCart extends CashierEvent {
  final String cartItemId;

  const CashierRemoveFromCart({required this.cartItemId});

  @override
  List<Object> get props => [cartItemId];
}

/// Increment the quantity of a cart item.
class CashierIncrementQty extends CashierEvent {
  final String cartItemId;

  const CashierIncrementQty({required this.cartItemId});

  @override
  List<Object> get props => [cartItemId];
}

/// Decrement the quantity of a cart item (removes if qty reaches 0).
class CashierDecrementQty extends CashierEvent {
  final String cartItemId;

  const CashierDecrementQty({required this.cartItemId});

  @override
  List<Object> get props => [cartItemId];
}

/// Update the search query to filter displayed products.
class CashierSearchProducts extends CashierEvent {
  final String query;

  const CashierSearchProducts({required this.query});

  @override
  List<Object> get props => [query];
}

/// Update the note of a specific cart item.
class CashierUpdateCartItemNote extends CashierEvent {
  final String cartItemId;
  final String note;

  const CashierUpdateCartItemNote({
    required this.cartItemId,
    required this.note,
  });

  @override
  List<Object> get props => [cartItemId, note];
}

/// Filter products by a specific category (pass null for all).
class CashierSelectCategory extends CashierEvent {
  final CategoryEntity? category;

  const CashierSelectCategory(this.category);

  @override
  List<Object> get props => [if (category != null) category!];
}

/// Clear the entire cart.
class CashierClearCart extends CashierEvent {
  const CashierClearCart();
}
