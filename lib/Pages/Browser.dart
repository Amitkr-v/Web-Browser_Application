import 'package:browser/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimpleWebBrowser extends StatefulWidget {
  final String url;
  final String searchEngineBase; // Retain the selected search engine

  SimpleWebBrowser(
      {Key? key, required this.url, required this.searchEngineBase})
      : super(key: key);
  @override
  _SimpleWebBrowserState createState() => _SimpleWebBrowserState();
}

class _SimpleWebBrowserState extends State<SimpleWebBrowser> {
  late final WebViewController _controller;
  late TextEditingController _urlController;
  ValueNotifier<bool> _isLoading = ValueNotifier(false);

  Future<void> _handleBackNavigation() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
    } else {
      Navigator.pop(context); // Exit WebView if no history
    }
  }

  // Handle Forward Navigation
  Future<void> _handleForwardNavigation() async {
    if (await _controller.canGoForward()) {
      _controller.goForward();
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController with settings
    _urlController = TextEditingController(text: widget.url);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            _isLoading.value = true; // Show loading indicator
          },
          onPageFinished: (_) {
            _isLoading.value = false; // Hide loading indicator
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _navigateToUrl(String input) {
    String url;
    if (!input.startsWith('http')) {
      url = widget.searchEngineBase + Uri.encodeQueryComponent(input);
    } else {
      url = input;
    }
    _urlController.text = url;
    _controller.loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: WebViewWidget(controller: _controller),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (context, isLoading, child) {
                  return isLoading
                      ? LinearProgressIndicator(
                          backgroundColor: Colors.grey[300],
                          color: Colors.blue,
                          minHeight: 2,
                        )
                      : SizedBox(
                          height:
                              4); // Placeholder to maintain consistent height
                },
              ),
              Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 10, 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: Icon(
                            Icons.home,
                            size: 36,
                            color: Colors.grey, // Home icon style
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 5),
                        child: GestureDetector(
                          onTap: _handleBackNavigation,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 5),
                        child: GestureDetector(
                          onTap: _handleForwardNavigation,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _urlController,
                          style: TextStyle(
                            color: Colors.grey, // Input text color
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Set the border radius for rounded corners
                              borderSide: BorderSide(
                                color: Colors
                                    .grey, // Outline color for enabled state
                              ),
                            ),
                            hintText: 'Enter URL or search...',
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                          ),
                          onSubmitted: _navigateToUrl,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 12, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () => _navigateToUrl(_urlController.text),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
