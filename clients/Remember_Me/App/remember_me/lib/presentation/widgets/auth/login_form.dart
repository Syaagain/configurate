import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import 'auth_text_field.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/validators.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with TickerProviderStateMixin {
  late AnimationController _formController;
  late AnimationController _buttonController;
  
  late Animation<double> _formAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<Offset> _slideAnimation;
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isLogin = true;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _formController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _buttonController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _formAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.elasticOut,
    ));
    
    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeOutCubic,
    ));
  }
  
  void _startAnimations() {
    _formController.forward();
  }

  @override
  void dispose() {
    _formController.dispose();
    _buttonController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
    _formController.reset();
    _formController.forward();
    HapticFeedback.lightImpact();
  }

  void _handleAuth() {
    if (!_formKey.currentState!.validate()) return;
    
    _buttonController.forward();
    HapticFeedback.mediumImpact();
    
    if (_isLogin) {
      context.read<AuthBloc>().add(AuthLoginRequested(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    } else {
      context.read<AuthBloc>().add(AuthRegisterRequested(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedBuilder(
        animation: _formAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.8 + (_formAnimation.value * 0.2),
            child: Opacity(
              opacity: _formAnimation.value.clamp(0.0, 1.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildModeToggle(),
                      SizedBox(height: 32),
                      if (!_isLogin) 
                        AuthTextField(
                          controller: _nameController,
                          labelText: AppStrings.fullName,
                          prefixIcon: Icons.person,
                          validator: Validators.validateName,
                        ),
                      AuthTextField(
                        controller: _emailController,
                        labelText: AppStrings.email,
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: 16),
                      AuthTextField(
                        controller: _passwordController,
                        labelText: AppStrings.password,
                        prefixIcon: Icons.lock,
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                            HapticFeedback.lightImpact();
                          },
                        ),
                        validator: (value) => Validators.validatePassword(value, isRegistration: !_isLogin),
                      ),
                      if (!_isLogin) ...[
                        SizedBox(height: 16),
                        AuthTextField(
                          labelText: AppStrings.confirmPassword,
                          prefixIcon: Icons.lock_outline,
                          obscureText: !_isPasswordVisible,
                          validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text),
                        ),
                      ],
                      SizedBox(height: 32),
                      _buildAuthButton(),
                      SizedBox(height: 16),
                      if (_isLogin) _buildForgotPassword(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModeToggle() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _isLogin ? null : _toggleMode,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _isLogin 
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isLogin 
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                ),
              ),
              child: Text(
                AppStrings.login,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: _isLogin ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: !_isLogin ? null : _toggleMode,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !_isLogin 
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: !_isLogin 
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                ),
              ),
              child: Text(
                AppStrings.register,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: !_isLogin ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        
        return AnimatedBuilder(
          animation: _buttonAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _buttonAnimation.value,
              child: Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleAuth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple.shade700,
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.deepPurple.shade700),
                          ),
                        )
                      : Text(
                          _isLogin ? AppStrings.login : AppStrings.register,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwort-Reset wird später implementiert'),
            backgroundColor: Colors.orange,
          ),
        );
      },
      child: Text(
        AppStrings.forgotPassword,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}