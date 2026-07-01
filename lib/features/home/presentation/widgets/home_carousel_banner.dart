import 'dart:async'; // 1. إضافة المكتبة
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';

class HomeCarouselBanner extends StatefulWidget {
  const HomeCarouselBanner({super.key});

  @override
  State<HomeCarouselBanner> createState() => _HomeCarouselBannerState();
}

class _HomeCarouselBannerState extends State<HomeCarouselBanner> {
  late final PageController _pageController;
  Timer? _timer; // 2. تعريف الـ Timer
  
  final List<String> _bannerImages = [
    'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=1000',
    'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=1000',
    'https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=1000',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoPlay(); 
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        
        if (nextPage >= _bannerImages.length) {
          nextPage = 0;
        }
        
        // حركة تمرير ناعمة للصفحة التالية
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 4. إيقاف الـ Timer لتجنب تسريب الذاكرة
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AspectRatio(
            aspectRatio: 16 / 8, 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: _bannerImages.length,
                onPageChanged: (index) {
                  context.read<HomeProvider>().updateBannerIndex(index);
                },
                itemBuilder: (context, index) {
                  return _buildImageItem(_bannerImages[index]);
                },
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        _buildDotsIndicator(),
      ],
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[100],
          child: const Center(
            child: CircularProgressIndicator(color: Colors.orange),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[100],
          child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
        );
      },
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_bannerImages.length, (index) {
        return Selector<HomeProvider, int>(
          selector: (context, provider) => provider.currentBannerIndex,
          builder: (context, currentIndex, child) {
            bool isActive = currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: isActive ? 24.0 : 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: isActive ? Colors.orange : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
            );
          },
        );
      }),
    );
  }
}