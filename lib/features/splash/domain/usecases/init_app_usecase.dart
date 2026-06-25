// هذا الكلاس مسؤول فقط عن عملية تهيئة التطبيق الأولية
class InitAppUseCase {
  
  Future<void> execute() async {
   
    await Future.delayed(const Duration(seconds: 2));
  }
}