import 'package:robsic/src/modules/core/core.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrlServiceImpl implements LaunchUrlService {
  @override
  Future<bool> canLaunch({required String url}) async {
    Uri parsedUrl = Uri.parse(url);
    return await canLaunchUrl(parsedUrl);
  }

  @override
  Future<void> launch({required String url}) async {
    bool launch = await canLaunch(url: url);
    if (launch) {
      Uri parsedUrl = Uri.parse(url);
      await launchUrl(parsedUrl);
    } else {
      throw const UnableLaunchUrlFailure();
    }
  }
}
