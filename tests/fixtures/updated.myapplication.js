
if(exists===undefined){var exists=function(variable){return(variable===undefined)?false:true;};}
if(!exists(doesNotExist)){var doesNotExist=function(variable){return(variable===undefined)?true:false;};}
if(doesNotExist(isTypeof)){var isTypeof=function(type,variable){try{if(doesNotExist(type)){throw new SyntaxError("isTypeof(Type, variable): type is undefined");}
if(doesNotExist(variable)){throw new SyntaxError("isTypeof(Type, variable): variable is undefined");}
return(variable.constructor==type)?true:false;}
catch(error){document.write(error.message);}};}
if(doesNotExist(isNumber)){var isNumber=function(suspect){if(isTypeof(Number,suspect)){return true;}
else{var pattern=/^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;return pattern.test(suspect);}};}
if(doesNotExist(die)){var die=function(last_words){if(doesNotExist(last_words)){lastwords=''}
document.write(lastwords)};}
if(doesNotExist(Object.prototype['method'])){Object.prototype.method=function(name,func){try{if(doesNotExist(name)){throw new SyntaxError("Object.method(name, func): name is undefined");}
if(doesNotExist(func)){throw new SyntaxError("Object.method(name, func): func is undefined");}
if(doesNotExist(this.prototype[name])){this.prototype[name]=func;return this;}}
catch(error){document.write(error.message);}};}
if(doesNotExist(Object.prototype['clone'])){Object.method('clone',function(){if(typeof this!=='object'||this===null){return this;}
if(this instanceof Node||this instanceof NodeList||this instanceof NamedNodeMap){die('You cannot clone a Node, Nodelist or NamedNodeMap');}
var clone=isTypeof(Array,this)?[]:{};for(var prop in this){if(this.hasOwnProperty(prop)){clone[prop]=this[prop];}}
return clone;});}
var JudoModule=function(){};JudoModule.method('actions',function(){});JudoModule.method('run',function(){this.actions();});var JudoApplication=function(){};JudoApplication.method('addModule',function(name){try{if(doesNotExist(name)){throw new SyntaxError("JudoApplication.addModule(name): name is undefined");}
if(exists(this[name])){throw new SyntaxError("JudoApplication.addModule(name): '"+name+"' already declared");}
this[name]=new JudoModule();}
catch(error){document.write(error.message);}});var Judo::Configuration=new JudoApplication();Array.method('is_empty',function(){return(this.length<1)?true:false;});Array.method('not_empty',function(){return(this.length>0)?true:false;});Array.method('each',function(callback){try{if(doesNotExist(callback)){throw new SyntaxError("Array.each(callback): callback is undefined");}
for(var i=0;i<this.length;i++){var args=[this[i],i];callback.apply(this,args);}}
catch(error){document.write(error.message);}});Array.method('contains',function(suspect){var matches=[];this.each(function(value,index){if(value===suspect){matches.push(index);}});return matches.not_empty()?matches:false;});Array.method('shuffle',function(){var clone=this.clone();for(var j,x,i=clone.length;i;j=parseInt(Math.random()*i),x=clone[--i],clone[i]=clone[j],clone[j]=x);return clone;});String.method('is_empty',function(){return(this=='')?true:false;});String.method('not_empty',function(){return(this=='')?false:true;});String.method('is_number',function(){var pattern=/^(\.|-)?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;return pattern.test(this);});String.method('trim',function(){return this.replace(/^\s+|\s+$/g,"");});String.method('ltrim',function(){return this.replace(/^\s+/,"");});String.method('rtrim',function(){return this.replace(/\s+$/,"");});String.method('each',function(callback){try{if(doesNotExist(callback)){throw new SyntaxError("String.each(callback): callback is undefined");}
for(var i=0;i<this.length;i++){var args=[this.charAt(i),i];callback.apply(this,args);}}
catch(error){document.write(error.message);}});String.method('capitalize',function(){return this.substr(0,1).toUpperCase()+this.substr(1);});String.method('reverse',function(){return this.split('').reverse().join('');});String.method('to_n',function(){return parseFloat(this);});String.method('pluck',function(needle){var pattern=new RegExp(needle,'g');return this.replace(pattern,'');});String.method('single_space',function(){var no_hard_spaces=this.replace(/\&nbsp\;/g,' ');return no_hard_spaces.replace(/\s+/g,' ');});String.method('compress',function(){return this.replace(/\s+/g,'');});String.method('shuffle',function(){return this.split('').shuffle().join('');})