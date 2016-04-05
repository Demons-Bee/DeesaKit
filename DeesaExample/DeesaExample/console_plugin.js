console = {
  log: function(info){
    DeesaExec(function(s){}, function(e){}, 'ConsolePlugin', 'log', info);
  }
}