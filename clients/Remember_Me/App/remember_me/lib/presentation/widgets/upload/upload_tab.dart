import 'package:flutter/material.dart';
import 'package:remember_me/domain/enums.dart';
import 'upload_card.dart';
import 'format_info_card.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/app_constants.dart';

class UploadTab extends StatefulWidget {
  final Function(MediaType) onUploadRequested;

  const UploadTab({Key? key, required this.onUploadRequested}) : super(key: key);

  @override
  _UploadTabState createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab>
    with TickerProviderStateMixin {
  late AnimationController _uploadController;
  late AnimationController _cardController;
  
  late Animation<double> _uploadAnimation;
  late Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _uploadController = AnimationController(
      duration: AppConstants.normalAnimation,
      vsync: this,
    );
    
    _cardController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    _uploadAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _uploadController,
      curve: Curves.easeOutCubic,
    ));
    
    _cardAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutCubic,
    ));
  }
  
  void _startAnimations() {
    _uploadController.forward();
    _cardController.forward();
  }

  @override
  void dispose() {
    _uploadController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _uploadAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (_uploadAnimation.value * 0.1),
          child: Opacity(
            opacity: _uploadAnimation.value.clamp(0.0, 1.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppConstants.largePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _buildMobileUploadOptions(),
                  SizedBox(height: 24),
                  _buildQuickAccessGrid(),
                  SizedBox(height: 24),
                  FormatInfoCard(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileUploadOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.mobileUpload,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: UploadCard(
                title: AppStrings.camera,
                icon: Icons.camera_alt_rounded,
                subtitle: 'Foto/Video aufnehmen',
                color: Colors.blue.shade400,
                onTap: () => _openCamera(),
                animation: _cardAnimation,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: UploadCard(
                title: AppStrings.gallery,
                icon: Icons.photo_library_rounded,
                subtitle: 'Aus Galerie wählen',
                color: Colors.green.shade400,
                onTap: () => _openGallery(),
                animation: _cardAnimation,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.quickAccess,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.2,
          children: [
            _buildQuickAccessButton(AppStrings.videos, Icons.videocam_rounded, Colors.red.shade400, MediaType.video),
            _buildQuickAccessButton('Fotos', Icons.image_rounded, Colors.green.shade400, MediaType.image),
            _buildQuickAccessButton(AppStrings.audio, Icons.audiotrack_rounded, Colors.purple.shade400, MediaType.audio),
            _buildQuickAccessButton(AppStrings.documents, Icons.description_rounded, Colors.blue.shade400, MediaType.document),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessButton(String label, IconData icon, Color color, MediaType type) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: InkWell(
          onTap: () => _pickSpecificMediaType(type),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openCamera() => widget.onUploadRequested(MediaType.image);
  void _openGallery() => widget.onUploadRequested(MediaType.image);
  void _pickSpecificMediaType(MediaType type) => widget.onUploadRequested(type);
}