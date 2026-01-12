import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:multi_scheduler/api/dio_client.dart';
import 'package:multi_scheduler/data/repositories/auth_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _email;
  String? _name;
  String? _nickname;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final tokenRepo = TokenRepository();
    final token = await tokenRepo.getAccessToken();

    if (token != null && !JwtDecoder.isExpired(token)) {
      try {
        final decoded = JwtDecoder.decode(token);
        // Supabase access token usually contains 'email' field.
        setState(() {
          _email = decoded['email'];
        });

        final response = await dio.get('/users/me');
        setState(() {
          _name = response.data['name'];
          _nickname = response.data['nickname'];
        });
      } catch (e) {
        // Handle error (e.g. invalid token or network error)
        debugPrint('Error loading user info: $e');
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    final tokenRepo = TokenRepository();
    await tokenRepo.deleteTokens();
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'アカウント情報',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('ユーザー名'),
                  subtitle: Text(_name ?? '未取得'),
                ),
                ListTile(
                  leading: const Icon(Icons.face),
                  title: const Text('ニックネーム'),
                  subtitle: Text(_nickname ?? '未取得'),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('メールアドレス'),
                  subtitle: Text(_email ?? '不明'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.login, color: Colors.blue),
                  title: const Text('ログイン'),
                  onTap: () => context.push('/login'),
                ),
                ListTile(
                  leading: const Icon(Icons.person_add, color: Colors.blue),
                  title: const Text('サインアップ'),
                  onTap: () => context.push('/signup'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'ログアウト',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: _logout,
                ),
              ],
            ),
    );
  }
}
