cordova.define("cordova-plugin-helloPlugin.HelloPlugin", function(require, exports, module) {
var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, "HelloPlugin", "coolMethod", [arg0]);
};

});
