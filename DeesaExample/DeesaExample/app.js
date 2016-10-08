document.appReady = function (func) {
  document.addEventListener("AppReady", function () {
    func();
  });
};

// 添加AppReady事件
if (DeesaDispatchReady != null || DeesaDispatchReady != undefine) {
  DeesaDispatchReady = function() {
    setTimeout(function(){
               var event = document.createEvent('Events');
               event.initEvent('AppReady', false, false);
               document.dispatchEvent(event);
               },200);
  };
  
  DeesaDispatchReady();
}
