document.appReady = function (func) {
  document.addEventListener("AppReady", function () {
    func();
  });
};
