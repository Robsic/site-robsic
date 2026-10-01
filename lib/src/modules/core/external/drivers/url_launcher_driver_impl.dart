import 'package:url_launcher/url_launcher_string.dart';

import '../../infra/drivers/url_launcher_driver.dart';

class UrlLauncherDriverImpl implements UrlLauncherDriver {
  @override
  Future<bool> launchUrl(String url, {bool isNewTab = true}) async {
    try {
      final launched = await launchUrlString(url,
          webOnlyWindowName: isNewTab ? '_blank' : '_self');
      return launched;
    } catch (error) {
      rethrow;
    }
  }
}
