// 任务队列数组
DeesaQueue = [];
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
DeesaOnSuccessCallback = function(i, j) {
  DeesaQueue[i].successCallback(JSON.parse(j));
};
// 错误回调
DeesaOnErrorCallback = function (i, j) {
  DeesaQueue[i].errorCallback(j);
};

DeesaExec = function (onSuccess, onError, service, action, args) {
  var taskId = null;
  if (onSuccess || onError) {
    DeesaQueue.push(DeesaTask.init(DeesaQueue.length, onSuccess, onError));
    taskId = DeesaQueue.length-1
  } else {
    taskId = 'INVALID';
  }
  if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.Deesa && window.webkit.messageHandlers.Deesa.postMessage) {
    window.webkit.messageHandlers.Deesa.postMessage({className: service, funcName: action, data: args, taskId: DeesaQueue.length-1});
  } else if (Deesa && Deesa.postMessage) {
    Deesa.postMessage({className: service, funcName: action, data:args, taskId: taskId});
  }
};