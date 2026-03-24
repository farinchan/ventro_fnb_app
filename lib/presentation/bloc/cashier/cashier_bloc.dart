import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/product_entity.dart';
import 'package:ventro_fnb_app/domain/entities/category_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_product_list.dart';

part 'cashier_event.dart';
part 'cashier_state.dart';

class CashierBloc extends Bloc<CashierEvent, CashierState> {
  final GetProductList getProductList;

  CashierBloc({required this.getProductList}) : super(const CashierState()) {
    on<CashierLoadProducts>(_onLoadProducts);
    on<CashierAddToCart>(_onAddToCart);
    on<CashierRemoveFromCart>(_onRemoveFromCart);
    on<CashierIncrementQty>(_onIncrementQty);
    on<CashierDecrementQty>(_onDecrementQty);
    on<CashierUpdateCartItemNote>(_onUpdateCartItemNote);
    on<CashierSearchProducts>(_onSearchProducts);
    on<CashierSelectCategory>(_onSelectCategory);
    on<CashierClearCart>(_onClearCart);
  }

  Future<void> _onLoadProducts(CashierLoadProducts event, Emitter<CashierState> emit) async {
    emit(state.copyWith(status: CashierStatus.loading));
    final result = await getProductList();
    result.fold(
      (error) => emit(state.copyWith(status: CashierStatus.error, error: error)),
      (products) => emit(state.copyWith(status: CashierStatus.loaded, products: products)),
    );
  }

  void _onAddToCart(CashierAddToCart event, Emitter<CashierState> emit) {
    final product = event.product;
    final variant = event.variant;
    final pId = product.id ?? 0;
    final vId = variant.id ?? 0;
    final price = int.tryParse(variant.price ?? '0') ?? 0;

    final updatedCart = List<CartItem>.from(state.cartItems);
    
    final existingIndex = updatedCart.indexWhere((item) => 
        item.productId == pId && 
        item.variantId == vId && 
        (item.notes == null || item.notes!.trim().isEmpty));

    if (existingIndex != -1) {
      final existing = updatedCart[existingIndex];
      updatedCart[existingIndex] = existing.copyWith(qty: existing.qty + 1);
    } else {
      final uniqueId = '${pId}_${vId}_${DateTime.now().millisecondsSinceEpoch}';
      updatedCart.add(CartItem(
        id: uniqueId,
        productId: pId,
        productName: product.name ?? '',
        productImage: product.image,
        variantId: vId,
        variantName: variant.name ?? '',
        qty: 1,
        price: price,
      ));
    }

    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onRemoveFromCart(CashierRemoveFromCart event, Emitter<CashierState> emit) {
    final updatedCart = state.cartItems.where((item) => item.id != event.cartItemId).toList();
    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onIncrementQty(CashierIncrementQty event, Emitter<CashierState> emit) {
    final updatedCart = state.cartItems.map((item) {
      if (item.id == event.cartItemId) {
        return item.copyWith(qty: item.qty + 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onDecrementQty(CashierDecrementQty event, Emitter<CashierState> emit) {
    final updatedCart = <CartItem>[];
    for (final item in state.cartItems) {
      if (item.id == event.cartItemId) {
        if (item.qty > 1) {
          updatedCart.add(item.copyWith(qty: item.qty - 1));
        }
        // If qty == 1, skip adding => effectively removes it
      } else {
        updatedCart.add(item);
      }
    }
    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onSearchProducts(CashierSearchProducts event, Emitter<CashierState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onUpdateCartItemNote(CashierUpdateCartItemNote event, Emitter<CashierState> emit) {
    final updatedCart = state.cartItems.map((item) {
      if (item.id == event.cartItemId) {
        return item.copyWith(notes: event.note);
      }
      return item;
    }).toList();
    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onSelectCategory(CashierSelectCategory event, Emitter<CashierState> emit) {
    emit(state.copyWith(selectedCategory: event.category, clearCategory: event.category == null));
  }

  void _onClearCart(CashierClearCart event, Emitter<CashierState> emit) {
    emit(state.copyWith(cartItems: []));
  }
}
