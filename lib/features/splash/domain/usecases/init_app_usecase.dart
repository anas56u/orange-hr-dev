class InitAppUseCase {
  
  Future<void> execute() async {
   
    await Future.delayed(const Duration(seconds: 2));
  }
}