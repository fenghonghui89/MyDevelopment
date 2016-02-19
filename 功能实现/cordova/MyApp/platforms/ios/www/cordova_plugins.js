cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/cordova-plugin-device/www/device.js",
        "id": "cordova-plugin-device.device",
        "pluginId": "cordova-plugin-device",
        "clobbers": [
            "device"
        ]
    },
    {
        "file": "plugins/cordova-plugin-helloPlugin/www/HelloPlugin.js",
        "id": "cordova-plugin-helloPlugin.HelloPlugin",
        "pluginId": "cordova-plugin-helloPlugin",
        "clobbers": [
            "cordova.plugins.HelloPlugin"
        ]
    },
    {
        "file": "plugins/cordova-plugin-echoPlugin/www/Echo.js",
        "id": "cordova-plugin-echoPlugin.Echo",
        "pluginId": "cordova-plugin-echoPlugin",
        "clobbers": [
            "Echo"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{}
// BOTTOM OF METADATA
});