import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class UserForm extends StatefulWidget {
  final User? user;

  final Future<void> Function({
    required String username,
    required String password,
    required String fullName,
    required String role,
    required bool isActive,
  }) onSave;

  const UserForm({
    super.key,
    this.user,
    required this.onSave,
  });

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  late String _role;
  late bool _isActive;

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    _role = widget.user?.role ?? 'cashier';
    _isActive = widget.user?.isActive ?? true;

    if (widget.user != null) {
      _usernameController.text = widget.user!.username;
      _passwordController.text = widget.user!.passwordHash;
      _fullNameController.text = widget.user!.fullName;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
    });

    await widget.onSave(
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      fullName: _fullNameController.text.trim(),
      role: _role,
      isActive: _isActive,
    );

    if (!mounted) return;

    setState(() {
      _saving = false;
    });

    // لا تستدعِ Navigator.pop هنا
    // الصفحة الرئيسية ستغلق الـ BottomSheet بعد نجاح العملية.
  }

  InputDecoration input(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.user == null ? 'Add User' : 'Edit User',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _fullNameController,
                decoration: input('Full Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _usernameController,
                decoration: input('Username'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _passwordController,
                decoration: input('Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  if (value.length < 4) {
                    return 'Minimum 4 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _role,
                decoration: input('Role'),
                items: const [
                  DropdownMenuItem(
                    value: 'owner',
                    child: Text('Owner'),
                  ),
                  DropdownMenuItem(
                    value: 'manager',
                    child: Text('Manager'),
                  ),
                  DropdownMenuItem(
                    value: 'cashier',
                    child: Text('Cashier'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _role = value;
                  });
                },
              ),

              const SizedBox(height: 12),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _isActive,
                title: const Text('Active'),
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          widget.user == null
                              ? 'Add User'
                              : 'Update User',
                        ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}