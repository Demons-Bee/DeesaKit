App = {
  testCallback: function(successCallback, errorCallback){
    DeesaExec(successCallback, errorCallback, 'AppPlugin', 'testCallback', {});
  },
  
  alert: function(args){
    DeesaExec(function(s){}, function(e){}, 'AppPlugin', 'alert', args);
  },
  
  testCommand: function(successCallback, errorCallback, args){
    DeesaExec(successCallback, errorCallback, 'AppPlugin', 'testCommand', args);
  }
  
}