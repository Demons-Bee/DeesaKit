  // 任务队列
DeesaCallbacks = {};
  // 任务对象
DeesaTask = function(successCallback, errorCallback) {
  this.successCallback = successCallback;
  this.errorCallback = errorCallback;
};
  // 成功回调
DeesaOnSuccessCallback = function(callbackId, callbackData) {
  DeesaCallbacks[callbackId].successCallback(JSON.parse(JSON.stringify(callbackData)));
  delete DeesaCallbacks[callbackId];
};
  // 错误回调
DeesaOnErrorCallback = function (callbackId, callbackData) {
  DeesaCallbacks[callbackId].errorCallback(JSON.parse(JSON.stringify(callbackData)));
  delete DeesaCallbacks[callbackId];
};

DeesaExec = function (onSuccess, onError, service, action, args) {
  var callbackId = null;
  
  if (onSuccess || onError) {
    callbackId = Math.floor(Math.random() * 2000000000);
    DeesaCallbacks[callbackId] = new DeesaTask(onSuccess, onError);
  } else {
    callbackId = 'INVALID';
  }
  
  if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.Deesa && window.webkit.messageHandlers.Deesa.postMessage) {
    window.webkit.messageHandlers.Deesa.postMessage({className: service, funcName: action, data: args, callbackId: callbackId});
  } else if (Deesa && Deesa.postMessage) {
    Deesa.postMessage({className: service, funcName: action, data:args, callbackId: callbackId});
  }
};

  // 添加AppReady事件
DeesaDispatchReady = function() {
  setTimeout(function(){
             var event = document.createEvent('Events');
             event.initEvent('AppReady', false, false);
             document.dispatchEvent(event);
             },200);
};

DeesaDispatchReady();
