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