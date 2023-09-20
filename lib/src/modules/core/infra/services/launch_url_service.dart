abstract class LaunchUrlService {
  Future<bool> canLaunch({required String url});
  Future<void> launch({required String url});
}
