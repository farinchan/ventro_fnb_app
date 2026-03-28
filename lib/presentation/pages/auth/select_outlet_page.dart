import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventro_fnb_app/data/datasources/local_datasource.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';
import 'package:ventro_fnb_app/presentation/bloc/outlet_list/outlet_list_bloc.dart';

class SelectOutletPage extends StatefulWidget {
  final UserEntity user;
  static const routeName = '/select-outlet';
  const SelectOutletPage({super.key, required this.user});

  @override
  State<SelectOutletPage> createState() => _SelectOutletPageState();
}

class _SelectOutletPageState extends State<SelectOutletPage> {
  OutletEntity? _selectedOutlet;
  List<StaffEntity>? staff;
  bool _isSubmitting = false;

  @override
  void initState() {
    context.read<OutletListBloc>().add(FetchOutletList());
    super.initState();
  }

  Future<void> _submitSelection() async {
    final selectedOutlet = _selectedOutlet;
    if (selectedOutlet == null || selectedOutlet.id == null || _isSubmitting) {
      return;
    }
    int? outletStaffId;
    outletStaffId = staff?.where((staff) => staff.id == widget.user.id).first.outletStaffId;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await LocalDatasource().saveOutletId(selectedOutlet.id!);
      await LocalDatasource().saveStaffOutletId(outletStaffId!);
      if (!mounted) return;
      context.go('/cashier');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menyimpan outlet. Coba lagi.')));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  int _crossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Outlet')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pilih outlet restoran untuk melanjutkan', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Kamu bisa ganti outlet kapan saja nanti.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BlocBuilder<OutletListBloc, OutletListState>(
                        builder: (context, state) {
                          if (state is OutletListLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (state is OutletListError) {
                            return Center(child: Text('Error: ${state.error.message}'));
                          }

                          if (state is! OutletListLoaded) {
                            return const SizedBox.shrink();
                          }

                          final outlets = state.outlets;
                          if (outlets.isEmpty) {
                            return const Center(child: Text('Belum ada outlet tersedia.'));
                          }

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return GridView.builder(
                                itemCount: outlets.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _crossAxisCount(constraints.maxWidth),
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 1.8,
                                ),
                                itemBuilder: (context, index) {
                                  final outlet = outlets[index];
                                  final isSelected = outlet.id == _selectedOutlet?.id;

                                  return InkWell(
                                    borderRadius: BorderRadius.circular(14),
                                    onTap: () {
                                      setState(() {
                                        _selectedOutlet = outlet;
                                        staff = outlet.staff;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 180),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: isSelected ? const Color(0xFFE8F0FE) : Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: isSelected
                                              ? Theme.of(context).colorScheme.primary
                                              : const Color(0xFFE3E6EA),
                                          width: isSelected ? 2 : 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(isSelected ? 0.12 : 0.05),
                                            blurRadius: isSelected ? 16 : 10,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.storefront,
                                                color: isSelected
                                                    ? Theme.of(context).colorScheme.primary
                                                    : Colors.black54,
                                              ),
                                              const Spacer(),
                                              Icon(
                                                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                                                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            outlet.name ?? 'Unknown Outlet',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            outlet.address ?? 'Alamat tidak tersedia',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, -2))],
              ),
              child: FilledButton(
                onPressed: _selectedOutlet == null || _isSubmitting ? null : _submitSelection,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Pilih Outlet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
