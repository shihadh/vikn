import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/login_controller.dart';
import '../../../core/constants/text_const.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.language, color: Color(0xFF0A7AFF), size: 24),
                        const SizedBox(width: 8),
                        const Text('English', style: TextStyle(color: Colors.white, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                Text(
                  TextConst.login['title']!,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  TextConst.login['subtitle']!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white38,
                  ),
                ),
                const SizedBox(height: 48),
                _buildForm(context),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    TextConst.login['forgotPassword']!,
                    style: const TextStyle(color: Color(0xFF0A7AFF), fontSize: 15),
                  ),
                ),
                // const SizedBox(height: 20),
                _buildSignInButton(context),
                const Spacer(flex: 2),
                _buildSignUpText(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF08131E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildTextField(
            controller: context.read<LoginController>().usernameController,
            hint: TextConst.login['username']!,
            icon: Icons.person_outline,
          ),
          const Divider(color: Color(0xFF1C3347), height: 1),
          Consumer<LoginController>(
            builder: (context, controller, child) {
              return _buildTextField(
                controller: controller.passwordController,
                hint: TextConst.login['password']!,
                icon: Icons.key_outlined,
                isPassword: true,
                obscureText: !controller.isPasswordVisible,
                onSuffixTap: () => controller.togglePasswordVisibility(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.white38, fontSize: 12),
          prefixIcon: Icon(icon, color: Colors.blueAccent, size: 24),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                  onPressed: onSuffixTap,
                )
              : null,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return ElevatedButton(
          onPressed: controller.isLoading
              ? null
              : () async {
                  final error = await controller.login();
                  if (error != null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/main');
                    }
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A7AFF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0,
          ),
          child: controller.isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      TextConst.login['signIn']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildSignUpText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TextConst.login['noAccount']!,
          style: const TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            TextConst.login['signUp']!,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
