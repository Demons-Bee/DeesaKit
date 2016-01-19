App = {
  testCallback:function(onSuccess,onError){
    DeesaQueue.push(DeesaTask.init(DeesaQueue.length, onSuccess, onError));
    window.webkit.messageHandlers.Deesa.postMessage({className: 'AppPlugin', funcName: 'testCallback', taskId:DeesaQueue.length-1});
  },
  alert:function(args){
    window.webkit.messageHandlers.Deesa.postMessage({className:'AppPlugin',funcName:'alert',data:args});
  },
  testCommand:function(onSuccess, onError, args){
    DeesaQueue.push(DeesaTask.init(DeesaQueue.length, onSuccess, onError));
    window.webkit.messageHandlers.Deesa.postMessage({className:'AppPlugin',funcName:'testCommand',data:args,taskId:DeesaQueue.length-1});
  }
}