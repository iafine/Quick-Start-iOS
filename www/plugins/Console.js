console = {
  log: function (string) {
    window.webkit.messageHandlers.HY.postMessage({className: 'Console', functionName: 'log', data: string});
  }
}
