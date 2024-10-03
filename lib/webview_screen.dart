import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController controller;

  final String videoUrl =
      "https://www.tiktok.com/player/v1/7414836358868503816";

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.startsWith("http")) {
              return NavigationDecision.navigate;
            } else if (await canLaunchUrl(Uri.parse(request.url))) {
              await launchUrl(Uri.parse(request.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.prevent;
          },
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.loadRequest(Uri.parse(videoUrl));
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
