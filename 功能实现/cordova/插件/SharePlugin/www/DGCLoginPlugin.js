               var exec = require('cordova/exec');
               var argscheck = require('cordova/argscheck');
               var shareModel = {};
               
               
               shareModel.login = function(success,fail,options){
               argscheck.checkArgs('fFO', 'shareModel.login', arguments);
               options = options || {};
               var getValue = argscheck.getValue;
               var title = getValue(options.title,40);
               var content = getValue(options.content,"abc");
               var imgUrl = getValue(options.imgUrl,"http://www.baidu.com");
               var shareUrl = getValue(options.shareUrl,"http://www.baidu.com");
               var args = [title,content,imgUrl,shareUrl];
               exec(success, fail, "SharePlugin", "login",args);
               }
               
               module.exports = shareModel;

