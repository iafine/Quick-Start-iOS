Queue = [];
Task = {
    id: 0,
    callBack: function(){},
    errorCallBack: function(){},
    init: function(id, callBack, errorCallBack) {
        this.id = id;
        this.callBack = callBack;
        this.errorCallBack = errorCallBack;
        return this;
    }
};
fireTask = function(i, j) {
    Queue[i].callBack(JSON.parse(j));
}
onError = function(i, j) {
    Queue[i].errorCallBack(j);
}
