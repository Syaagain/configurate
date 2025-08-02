import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/data/models/media_item_model.dart';
import 'package:remember_me/domain/entities/upload_history_item.dart';
import 'package:remember_me/presentation/widgets/animated_background.dart';
import 'package:remember_me/presentation/widgets/upload/history_tab.dart';
import 'package:remember_me/presentation/widgets/upload/upload_tab.dart';
import '../../blocs/upload/upload_bloc.dart';
import '../../blocs/upload/upload_state.dart';
import '../../blocs/upload/upload_event.dart';
import '../../blocs/media/media_bloc.dart';
import '../../blocs/media/media_event.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/helpers.dart';

class FileUploadPage extends StatefulWidget {
  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadBloc, UploadState>(
      listener: (context, state) {
        if (state is UploadCompleted) {
          _addMediaItemFromUpload(state.uploadId, state.history);
          _showSuccessSnackbar(context, state.uploadId, state.history);
        }
      },
      child: AnimatedBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              AppStrings.fileUpload,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
                HapticFeedback.lightImpact();
              },
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  icon: Icon(Icons.cloud_upload_rounded, size: 24),
                  text: AppStrings.upload,
                ),
                Tab(
                  icon: Icon(Icons.history_rounded, size: 24),
                  text: AppStrings.history,
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              UploadTab(
                onUploadRequested: (type) {
                  context.read<UploadBloc>().add(UploadSimulationRequested(type));
                  _switchToHistoryTab();
                },
              ),
              HistoryTab(),
            ],
          ),
        ),
      ),
    );
  }

  void _addMediaItemFromUpload(String uploadId, List<UploadHistoryItem> history) {
    final uploadItem = history.firstWhere((item) => item.id == uploadId);
    
    final mediaItem = MediaItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: uploadItem.fileName,
      type: uploadItem.type,
      description: 'Mobile Upload - ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
      icon: Helpers.getIconForMediaType(uploadItem.type),
      color: Helpers.getColorForMediaType(uploadItem.type),
      fileSize: uploadItem.fileSize,
      dateAdded: DateTime.now(),
    );

    context.read<MediaBloc>().add(MediaItemAdded(mediaItem));
  }

  void _showSuccessSnackbar(BuildContext context, String uploadId, List<UploadHistoryItem> history) {
    final uploadItem = history.firstWhere((item) => item.id == uploadId);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('${uploadItem.fileName} ${AppStrings.uploadSuccessful}'),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  void _switchToHistoryTab() {
    setState(() {
      _selectedTabIndex = 1;
    });
    _tabController.animateTo(1);
  }
}