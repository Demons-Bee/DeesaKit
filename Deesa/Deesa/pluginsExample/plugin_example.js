page = {
  setStatusBar: function(args) {
    window.webkit.messageHandlers.Deesa.postMessage({className:'ExamplePlugin',funcName:'setStatusBar',data:args});
  },
  setTitleBar: function(args) {
    window.webkit.messageHandlers.Deesa.postMessage({className:'ExamplePlugin',funcName:'setTitleBar',data:args});
  },
  setTabBar: function(args) {
    window.webkit.messageHandlers.Deesa.postMessage({className:'ExamplePlugin',funcName:'setTabBar',data:args});
  },
  closeWindow: function(args) {
    window.webkit.messageHandlers.Deesa.postMessage({className:'ExamplePlugin',funcName:'closeWindow',data:args});
  }
}