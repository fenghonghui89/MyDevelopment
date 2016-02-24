cordova.define("cordova-plugin-sharePlugin.SharePlugin", function(require, exports, module) {
var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, "SharePlugin", "coolMethod", [arg0]);
};

});
