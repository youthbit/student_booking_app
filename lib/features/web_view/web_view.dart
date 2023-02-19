import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../authentication/data/auth_repository.dart';

class WebView extends ConsumerStatefulWidget {
  final String title;
  final String page;

  const WebView(this.title, this.page, {super.key});

  @override
  ConsumerState<WebView> createState() => _WebViewState();
}

class _WebViewState extends ConsumerState<WebView> {
  late WebViewController _controller;
  @override
  void initState() {
    super.initState();

    final token = ref.read(authRepositoryProvider).currentUser?.token;
    final uri = Uri.parse('https://xn--d1agcrrehbhc.xn--p1ai/profile?auth_token=r:c6f8894cb27834404e209a4395b8be31');

    print(uri);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..clearCache()
      ..clearLocalStorage()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
            // return NavigationDecision.prevent;
          },
        ),
      )
      ..enableZoom(false)
      ..loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: WebViewWidget(controller: _controller),
    );
  }
}
