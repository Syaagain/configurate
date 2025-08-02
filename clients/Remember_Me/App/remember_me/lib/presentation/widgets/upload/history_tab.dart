import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/domain/entities/upload_history_item.dart';
import 'package:remember_me/presentation/widgets/upload/upload_history_item.dart';
import '../../blocs/upload/upload_bloc.dart';
import '../../blocs/upload/upload_state.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/app_constants.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab>
    with TickerProviderStateMixin {
  late AnimationController _cardController;
  late Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _cardController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    _cardAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startAnimations() {
    _cardController.forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (_cardAnimation.value * 0.05),
          child: Opacity(
            opacity: _cardAnimation.value.clamp(0.0, 1.0),
            child: Container(
              padding: EdgeInsets.all(AppConstants.largePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.history_rounded, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Text(
                        AppStrings.uploadHistory,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<UploadBloc, UploadState>(
                      builder: (context, state) {
                        if (state is UploadLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is UploadHistoryLoaded || 
                                   state is UploadInProgress || 
                                   state is UploadCompleted) {
                          List<UploadHistoryItem> history = [];
                          
                          if (state is UploadHistoryLoaded) {
                            history = state.history;
                          } else if (state is UploadInProgress) {
                            history = state.history;
                          } else if (state is UploadCompleted) {
                            history = state.history;
                          }
                          
                          if (history.isEmpty) {
                            return _buildEmptyHistory();
                          }
                          
                          return ListView.builder(
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              return UploadHistoryItemWidget(
                                item: history[index],
                                index: index,
                                animation: _cardAnimation,
                              );
                            },
                          );
                        } else if (state is UploadError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.largePadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history_rounded,
              size: 64,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 24),
          Text(
            AppStrings.noUploadHistory,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            AppStrings.noUploadHistoryDescription,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}