import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ventro_fnb_app/data/datasources/local_datasource.dart';
import 'package:ventro_fnb_app/data/models/req/transaction_model.dart';
import 'package:ventro_fnb_app/presentation/bloc/bloc/transaction_bloc.dart';

import 'package:ventro_fnb_app/presentation/bloc/cashier/cashier_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/table_list/table_list_bloc.dart';
import 'package:ventro_fnb_app/presentation/pages/pos/cashier_page.dart';
import 'package:ventro_fnb_app/presentation/widgets/text_field_custom.dart';

class ProcessPage extends StatefulWidget {
  static const String routeName = 'process';
  final CashierState cashierState;

  const ProcessPage({super.key, required this.cashierState});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  String? _selectedPaymentMethod;
  final TextEditingController _payAmountController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneController = TextEditingController();
  int? tableId;
  String? tableName;
  num _changeAmount = 0;

  void _handleSaveTransaction() async {
    var stafOutletId = await LocalDatasource().getStaffOutletId();
    if (!mounted) return;
    context.read<TransactionBloc>().add(
      TransactionSave(
        transactionReqModel: TransactionReqModel(
          fnbOutletStaffId: stafOutletId,
          customerName: _customerNameController.text,
          customerPhone: _customerPhoneController.text,
          fnbTableId: tableId,
          fnbCouponId: widget.cashierState.couponId,
          fnbSaleModeOutletId: widget.cashierState.selectedSaleModeId,
          paidAmount: int.tryParse(_payAmountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
          // paymentMethod: "cash",
          taxes: widget.cashierState.taxList.map((tax) => tax.id).whereType<int>().toList(),
          fnbSaleItems: widget.cashierState.cartItems
              .map(
                (cartItem) => FnbSaleItem(
                  fnbProductVariantId: cartItem.variantId,
                  quantity: cartItem.qty.toInt(),
                  note: cartItem.notes,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TableListBloc>().add(FetchTableList());
    _payAmountController.addListener(_calculateChange);
    _customerNameController.addListener(_onCustomerNameChanged);
  }

  @override
  void dispose() {
    _payAmountController.removeListener(_calculateChange);
    _customerNameController.removeListener(_onCustomerNameChanged);
    _payAmountController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    super.dispose();
  }

  void _calculateChange() {
    final paid = num.tryParse(_payAmountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    setState(() {
      _changeAmount = paid - widget.cashierState.total;
    });
  }

  void _onCustomerNameChanged() {
    setState(() {});
  }

  String _currency(num value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(value);
  }

  Widget _buildPaymentMethodCard({
    required ThemeData theme,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isSelected = _selectedPaymentMethod == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.colorScheme.surface,
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAmountChip(String label, num amount) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        final formatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
        _payAmountController.text = formatter.format(amount).trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            width: 400,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.primary, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(children: [Icon(Icons.payment), SizedBox(width: 12), Text('Proses')]),
                          ),
                          SizedBox(height: 12),
                          TextFieldCustom(
                            labelText: 'Nama Customer*',
                            hintText: 'Contoh: fajri',
                            controller: _customerNameController,
                            prefixIcon: Icons.person_outline,
                          ),
                          SizedBox(height: 12),
                          TextFieldCustom(
                            labelText: 'No Whatsapp (Opsional)',
                            hintText: 'Contoh: 08123456789',
                            controller: _customerPhoneController,
                            prefixIcon: Icons.phone,
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final selectedTable = await showDialog<dynamic>(
                                  context: context,
                                  builder: (dialogContext) {
                                    return AlertDialog(
                                      title: const Text("Pilih Meja"),
                                      content: BlocProvider.value(
                                        value: context.read<TableListBloc>(),
                                        child: BlocConsumer<TableListBloc, TableListState>(
                                          listener: (ctx, state) {
                                            if (state is TableListError) {
                                              Navigator.pop(dialogContext);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(state.error.message ?? "Terjadi kesalahan")),
                                              );
                                            }
                                          },
                                          builder: (ctx, state) {
                                            if (state is TableListLoading) {
                                              return const SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Center(child: CircularProgressIndicator()),
                                              );
                                            }
                                            if (state is TableListLoaded) {
                                              final locations = state.tableList;
                                              if (locations.isEmpty) {
                                                return const SizedBox(
                                                  height: 50,
                                                  child: Center(child: Text("Tidak ada meja tersedia.")),
                                                );
                                              }
                                              return SizedBox(
                                                width: double.maxFinite,
                                                height: 400,
                                                child: DefaultTabController(
                                                  length: locations.length,
                                                  child: Column(
                                                    children: [
                                                      TabBar(
                                                        isScrollable: true,
                                                        tabAlignment: TabAlignment.start,
                                                        tabs: locations.map((loc) {
                                                          return Tab(text: loc.location ?? "-");
                                                        }).toList(),
                                                      ),
                                                      Expanded(
                                                        child: TabBarView(
                                                          children: locations.map((loc) {
                                                            final tables = loc.tables ?? [];
                                                            if (tables.isEmpty) {
                                                              return const Center(
                                                                child: Text("Tidak ada meja di lokasi ini"),
                                                              );
                                                            }
                                                            return GridView.builder(
                                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount: 5,
                                                                    crossAxisSpacing: 8,
                                                                    mainAxisSpacing: 8,
                                                                    childAspectRatio: 1.2,
                                                                  ),
                                                              itemCount: tables.length,
                                                              itemBuilder: (context, index) {
                                                                final table = tables[index];
                                                                final isAvailable =
                                                                    table.status?.toLowerCase() == 'available';
                                                                return InkWell(
                                                                  onTap: isAvailable
                                                                      ? () {
                                                                          Navigator.pop(dialogContext, table);
                                                                        }
                                                                      : null,
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      color: isAvailable
                                                                          ? theme.colorScheme.surface
                                                                          : theme.colorScheme.surfaceContainerHighest,
                                                                      border: Border.all(
                                                                        color: isAvailable
                                                                            ? theme.colorScheme.primary
                                                                            : theme.colorScheme.outlineVariant,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    child: Center(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.table_restaurant,
                                                                            color: isAvailable
                                                                                ? theme.colorScheme.primary
                                                                                : theme.colorScheme.onSurfaceVariant,
                                                                          ),
                                                                          const SizedBox(height: 4),
                                                                          Text(
                                                                            table.name ?? "-",
                                                                            style: TextStyle(
                                                                              color: isAvailable
                                                                                  ? theme.colorScheme.primary
                                                                                  : theme.colorScheme.onSurfaceVariant,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            textAlign: TextAlign.center,
                                                                          ),
                                                                          if (!isAvailable)
                                                                            Text(
                                                                              'Terisi',
                                                                              style: TextStyle(
                                                                                fontSize: 10,
                                                                                color: theme.colorScheme.error,
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                            return const SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Center(child: CircularProgressIndicator()),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                                if (selectedTable != null) {
                                  setState(() {
                                    tableId = selectedTable.id;
                                    tableName = selectedTable.name;
                                  });
                                }
                              },
                              label: Text(tableName != null ? 'Meja: $tableName' : 'Pilih Meja (Opsional)'),
                              icon: Icon(Icons.table_restaurant),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: theme.colorScheme.primary),
                                backgroundColor: theme.colorScheme.onPrimary,
                                foregroundColor: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: Divider(thickness: 2)),
                              SizedBox(width: 12),
                              Text('Ringkasan Pesanan'),
                              SizedBox(width: 12),
                              Expanded(child: Divider(thickness: 2)),
                            ],
                          ),
                          SizedBox(height: 12),

                          ...widget.cashierState.cartItems.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${item.qty}"),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${item.productName} (${item.variantName})"),
                                        if (item.notes != null && item.notes!.isNotEmpty) Text("* ${item.notes}"),
                                      ],
                                    ),
                                  ),
                                  Text(_currency(item.price)),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Spacer(),
                              Expanded(child: Divider(thickness: 2)),
                            ],
                          ),
                          SizedBox(height: 8),

                          Row(
                            children: [
                              Expanded(child: Text("Subtotal")),
                              Text(_currency(widget.cashierState.subtotal)),
                            ],
                          ),
                          if (widget.cashierState.discount != null && widget.cashierState.discount! > 0)
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Kupon - ${widget.cashierState.couponCode ?? ''}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Text(_currency(-(widget.cashierState.discount ?? 0))),
                              ],
                            ),

                          ...widget.cashierState.addTaxValue.map((tax) {
                            return Row(
                              children: [
                                Expanded(child: Text('${tax.name} (${tax.percent}%)')),
                                Text(_currency(tax.value ?? 0)),
                              ],
                            );
                          }),
                          Row(
                            children: [
                              Expanded(child: Text("Total")),
                              Text(_currency(widget.cashierState.total)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.goNamed(CashierPage.routeName);
                      }
                    },
                    label: Text("Edit Pesanan"),
                    icon: Icon(Icons.edit),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: _customerNameController.text.isEmpty ? null : _handleSaveTransaction,
                    label: Text("Simpan & Proses dulu bayar nanti"),
                    icon: Icon(Icons.timer),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.primary, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [Icon(Icons.payment), SizedBox(width: 12), Text('Pembayaran')]),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(fontSize: 14, color: theme.colorScheme.onPrimaryContainer),
                              ),
                              SizedBox(height: 4),
                              Text(
                                _currency(widget.cashierState.total),
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        // Metode Pembayaran
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Metode Pembayaran', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(height: 8),
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: MediaQuery.of(context).size.width < 600 ? 1 : 2,
                          children: [
                            _buildPaymentMethodCard(theme: theme, icon: Icons.money, label: 'Cash', value: 'cash'),
                            _buildPaymentMethodCard(theme: theme, icon: Icons.qr_code, label: 'QRIS', value: 'qris'),
                            _buildPaymentMethodCard(theme: theme, icon: Icons.credit_card, label: 'EDC', value: 'edc'),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Input nominal bayar (hanya untuk cash)
                        if (_selectedPaymentMethod == 'cash') ...[
                          TextFieldCustom(
                            labelText: 'Nominal Bayar',
                            hintText: 'Masukkan nominal',
                            controller: _payAmountController,
                            prefixIcon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                            currency: true,
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildQuickAmountChip('Uang Pas', widget.cashierState.total),
                              // _buildQuickAmountChip('50.000', 50000),
                              _buildQuickAmountChip('100.000', 100000),
                              _buildQuickAmountChip('200.000', 200000),
                              _buildQuickAmountChip('500.000', 500000),
                            ],
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _changeAmount >= 0
                                  ? Colors.green.withValues(alpha: 0.1)
                                  : Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: _changeAmount >= 0 ? Colors.green : Colors.red),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Kembalian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                Text(
                                  _currency(_changeAmount < 0 ? 0 : _changeAmount),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: _changeAmount >= 0 ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: _selectedPaymentMethod == null
                                ? null
                                : () {
                                    // TODO: proses pembayaran
                                  },
                            icon: Icon(Icons.check_circle),
                            label: Text('Bayar Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Total yang harus dibayar

                  // Tombol Bayar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
