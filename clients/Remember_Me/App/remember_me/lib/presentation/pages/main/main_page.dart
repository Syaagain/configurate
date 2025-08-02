import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/presentation/pages/media/media_sections_page.dart';
import 'package:remember_me/presentation/pages/upload/file_upload_page.dart';
import '../../blocs/upload/upload_bloc.dart';
import '../../blocs/upload/upload_event.dart';
import '../../../core/constants/strings.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load initial data
    context.read<UploadBloc>().add(UploadHistoryLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MediaSectionsPage(),
          FileUploadPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurple.shade600,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Medien',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload_rounded),
              activeIcon: Icon(Icons.cloud_upload_rounded),
              label: AppStrings.upload,
            ),
          ],
        ),
      ),
    );
  }
}