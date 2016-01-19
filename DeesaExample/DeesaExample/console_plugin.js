console = {
  log:function(string){
    window.webkit.messageHandlers.Deesa.postMessage({className: 'ConsolePlugin', funcName: 'log', data:string});
  }
}