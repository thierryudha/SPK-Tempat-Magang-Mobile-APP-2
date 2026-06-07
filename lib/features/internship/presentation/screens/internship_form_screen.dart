import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../../data/models/internship_model.dart';
import '../providers/internship_provider.dart';

class InternshipFormScreen extends ConsumerStatefulWidget {
  final int? internshipId;
  const InternshipFormScreen({super.key, this.internshipId});

  @override
  ConsumerState<InternshipFormScreen> createState() => _InternshipFormScreenState();
}

class _InternshipFormScreenState extends ConsumerState<InternshipFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();
  int? _selectedCategoryId;
  bool _isInit = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _websiteCtrl.dispose();
    super.dispose();
  }

  void _initForm(InternshipModel? internship) {
    if (_isInit) return;
    if (internship != null) {
      _nameCtrl.text = internship.name;
      _websiteCtrl.text = internship.websiteLink ?? '';
      _selectedCategoryId = internship.categoryId;
    }
    _isInit = true;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih kategori terlebih dahulu')),
      );
      return;
    }

    final data = {
      'name': _nameCtrl.text.trim(),
      'category_id': _selectedCategoryId,
      'website_link': _websiteCtrl.text.trim().isNotEmpty ? _websiteCtrl.text.trim() : null,
    };

    try {
      if (widget.internshipId == null) {
        await ref.read(internshipActionProvider.notifier).createInternship(data);
      } else {
        await ref.read(internshipActionProvider.notifier).updateInternship(widget.internshipId!, data);
      }
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(internshipActionProvider);
    final isLoading = actionState.isLoading;

    final categoriesAsync = ref.watch(categoriesProvider);

    // If editing, watch the detail
    AsyncValue<InternshipModel>? detailAsync;
    if (widget.internshipId != null) {
      detailAsync = ref.watch(internshipDetailProvider(widget.internshipId!));
      detailAsync?.whenData((data) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() => _initForm(data));
        });
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.internshipId == null ? 'Tambah Magang' : 'Edit Magang'),
      ),
      body: detailAsync != null && detailAsync.isLoading
          ? const LoadingWidget(message: 'Memuat data...')
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Nama
                      const Text(
                        'Nama Tempat Magang',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Contoh: PT Teknologi Indonesia',
                          prefixIcon: Icon(Icons.business_outlined, size: 20),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Nama tidak boleh kosong';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Kategori
                      const Text(
                        'Kategori',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      categoriesAsync.when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (err, _) => Text('Gagal memuat kategori: $err', style: const TextStyle(color: Colors.red)),
                        data: (categories) {
                          // Validate if selected category still exists
                          if (_selectedCategoryId != null && !categories.any((c) => c.id == _selectedCategoryId)) {
                            _selectedCategoryId = null;
                          }

                          return DropdownButtonFormField<int>(
                            value: _selectedCategoryId,
                            hint: const Text('Pilih kategori'),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.category_outlined, size: 20),
                            ),
                            items: categories.map((cat) {
                              return DropdownMenuItem(
                                value: cat.id,
                                child: Text(cat.name),
                              );
                            }).toList(),
                            onChanged: (v) => setState(() => _selectedCategoryId = v),
                            validator: (v) => v == null ? 'Pilih kategori' : null,
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Website Link
                      const Text(
                        'Website Link (Opsional)',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _websiteCtrl,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          hintText: 'https://...',
                          prefixIcon: Icon(Icons.language_outlined, size: 20),
                        ),
                        validator: (v) {
                          if (v != null && v.isNotEmpty && !Uri.parse(v).isAbsolute) {
                            return 'Format URL tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Submit
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submit,
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Simpan'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
