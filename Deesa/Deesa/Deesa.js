// 任务队列
DeesaCallbacks = {};
// 任务对象
DeesaTask = {
  id: 0,
  successCallback: function(data){},
  errorCallback: function(data){},
  init: function(id, successCallback, errorCallback) {
    this.id = id;
    this.successCallback = successCallback;
    this.errorCallback = errorCallback;
    return this
  }
};
// 成功回调
DeesaOnSuccessCallback = function(callbackId, callbackData) {
  DeesaCallbacks[callbackId].successCallback(JSON.parse(callbackData));
  delete DeesaCallbacks[callbackId];
};
// 错误回调
DeesaOnErrorCallback = function (callbackId, callbackData) {
  DeesaCallbacks[callbackId].errorCallback(callbackData);
  delete DeesaCallbacks[callbackId];
};

DeesaExec = function (onSuccess, onError, service, action, args) {
  var callbackId = null;
  if (onSuccess || onError) {
    callbackId = Math.floor(Math.random() * 2000000000)
    DeesaCallbacks[callbackId] = (DeesaTask.init(callbackId, onSuccess, onError));
  } else {
    callbackId = 'INVALID';
  }
  if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.Deesa && window.webkit.messageHandlers.Deesa.postMessage) {
    window.webkit.messageHandlers.Deesa.postMessage({className: service, funcName: action, data: args, callbackId: callbackId});
  } else if (Deesa && Deesa.postMessage) {
    Deesa.postMessage({className: service, funcName: action, data:args, callbackId: callbackId});
  }
};