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
  
  final List<String> _bannerImages = [
    'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=1000',
    'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=1000',
    'https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=1000',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
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
                physics: const BouncingScrollPhysics(), // حركة تمرير ناعمة
                itemCount: _bannerImages.length,
                // هنا نربط الـ PageView بالـ Provider
                onPageChanged: (index) {
                  // نستخدم read لأننا نرسل أمر التحديث فقط ولا نريد إعادة بناء الـ PageView نفسه
                  context.read<HomeProvider>().updateBannerIndex(index);
                },
                itemBuilder: (context, index) {
                  return _buildImageItem(_bannerImages[index]);
                },
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12), // مسافة بين الصورة والنقاط
        
        // 2. مؤشر النقاط (Dots Indicator)
        _buildDotsIndicator(),
      ],
    );
  }

  // ويدجت بناء الصورة المفردة
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

  // ويدجت بناء النقاط السفلية (عالي الأداء)
  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // نقوم بتوليد النقاط بناءً على عدد الصور
      children: List.generate(_bannerImages.length, (index) {
        // سر الأداء العالي: نستخدم Selector هنا لكي نعيد بناء "النقطة" فقط وليس الشاشة 
        // عند تغير الرقم في الـ Provider
        return Selector<HomeProvider, int>(
          selector: (context, provider) => provider.currentBannerIndex,
          builder: (context, currentIndex, child) {
            bool isActive = currentIndex == index;
            // حركة (Animation) ناعمة جداً عند تغير النقطة النشطة
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: isActive ? 24.0 : 8.0, // النقطة النشطة تكون أعرض قليلاً حسب التصاميم العصرية
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