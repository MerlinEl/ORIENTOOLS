/* Page scroll to id - version 1.6.4 */
!function(y,O,i,e){var n,I,a,s,l,o,r,c,u,h,t,g,f="mPageScroll2id",x="mPS2id",d={scrollSpeed:1e3,autoScrollSpeed:!0,scrollEasing:"easeInOutQuint",scrollingEasing:"easeOutQuint",pageEndSmoothScroll:!0,layout:"vertical",offset:0,highlightSelector:!1,clickedClass:x+"-clicked",targetClass:x+"-target",highlightClass:x+"-highlight",forceSingleHighlight:!1,keepHighlightUntilNext:!1,highlightByNextTarget:!1,disablePluginBelow:!1,clickEvents:!0,appendHash:!1,onStart:function(){},onComplete:function(){},defaultSelector:!1,live:!0,liveSelector:!1},p=0,_={init:function(e){e=y.extend(!0,{},d,e);if(y(i).data(x,e),I=y(i).data(x),!this.selector){var t="__"+x;this.each(function(){var e=y(this);e.hasClass(t)||e.addClass(t)}),this.selector="."+t}I.liveSelector&&(this.selector+=","+I.liveSelector),n=n?n+","+this.selector:this.selector,I.defaultSelector&&("object"==typeof y(n)&&0!==y(n).length||(n=".m_PageScroll2id,a[rel~='m_PageScroll2id'],.page-scroll-to-id,a[rel~='page-scroll-to-id'],._ps2id")),I.clickEvents&&y(i).undelegate("."+x).delegate(n,"click."+x,function(e){if(m._isDisabled.call(null))m._removeClasses.call(null);else{var t=y(this),n=t.attr("href"),a=t.prop("href").baseVal||t.prop("href");n&&-1!==n.indexOf("#/")||(m._reset.call(null),h=t.data("ps2id-offset")||0,m._isValid.call(null,n,a)&&m._findTarget.call(null,n)&&(e.preventDefault(),s="selector",l=t,m._setClasses.call(null,!0),m._scrollTo.call(null)))}}),y(O).unbind("."+x).bind("scroll."+x+" resize."+x,function(){if(m._isDisabled.call(null))m._removeClasses.call(null);else{var s=y("._"+x+"-t");s.each(function(e){var t=y(this),n=t.attr("id"),a=m._findHighlight.call(null,n);m._setClasses.call(null,!1,t,a),e==s.length-1&&m._extendClasses.call(null)})}}),a=!0,m._setup.call(null),m._live.call(null)},scrollTo:function(e,t){if(m._isDisabled.call(null))m._removeClasses.call(null);else if(e&&void 0!==e){m._isInit.call(null);var n={layout:I.layout,offset:I.offset,clicked:!1};t=y.extend(!0,{},n,t);m._reset.call(null),c=t.layout,u=t.offset,e=-1!==e.indexOf("#")?e:"#"+e,m._isValid.call(null,e)&&m._findTarget.call(null,e)&&(s="scrollTo",(l=t.clicked)&&m._setClasses.call(null,!0),m._scrollTo.call(null))}},destroy:function(){y(O).unbind("."+x),y(i).undelegate("."+x).removeData(x),y("._"+x+"-t").removeData(x),m._removeClasses.call(null,!0)}},m={_isDisabled:function(){var e=O,t="inner",n=I.disablePluginBelow instanceof Array?[I.disablePluginBelow[0]||0,I.disablePluginBelow[1]||0]:[I.disablePluginBelow||0,0];return"innerWidth"in O||(t="client",e=i.documentElement||i.body),e[t+"Width"]<=n[0]||e[t+"Height"]<=n[1]},_isValid:function(e,t){if(e){var n=-1!==(t=t||e).indexOf("#/")?t.split("#/")[0]:t.split("#")[0],a=O.location.toString().split("#")[0];return"#"!==e&&-1!==e.indexOf("#")&&(""===n||decodeURIComponent(n)===decodeURIComponent(a))}},_setup:function(){var l=m._highlightSelector(),o=1,r=0;return y(l).each(function(){var e=y(this),t=e.attr("href"),n=e.prop("href").baseVal||e.prop("href");if(m._isValid.call(null,t,n)){var a=-1!==t.indexOf("#/")?t.split("#/")[1]:t.split("#")[1],s=y("#"+a);if(0<s.length){I.highlightByNextTarget&&s!==r&&(r?r.data(x,{tn:s}):s.data(x,{tn:"0"}),r=s),s.hasClass("_"+x+"-t")||s.addClass("_"+x+"-t"),s.data(x,{i:o}),e.hasClass("_"+x+"-h")||e.addClass("_"+x+"-h");var i=m._findHighlight.call(null,a);m._setClasses.call(null,!1,s,i),p=o,++o==y(l).length&&m._extendClasses.call(null)}}})},_highlightSelector:function(){return I.highlightSelector&&""!==I.highlightSelector?I.highlightSelector:n},_findTarget:function(e){var t=-1!==e.indexOf("#/")?e.split("#/")[1]:e.split("#")[1],n=y("#"+t);if(n.length<1||"fixed"===n.css("position")){if("top"!==t)return;n=y("body")}return o=n,c||(c=I.layout),u=m._setOffset.call(null),(r=[(n.offset().top-u[0]).toString(),(n.offset().left-u[1]).toString()])[0]=r[0]<0?0:r[0],r[1]=r[1]<0?0:r[1],r},_setOffset:function(){var e,t,n,a;switch(u||(u=I.offset?I.offset:0),h&&(u=h),typeof u){case"object":case"string":0<(t=[(e=[u.y?u.y:u,u.x?u.x:u])[0]instanceof jQuery?e[0]:y(e[0]),e[1]instanceof jQuery?e[1]:y(e[1])])[0].length?(n=t[0].height(),"fixed"===t[0].css("position")&&(n+=t[0][0].offsetTop)):n=!isNaN(parseFloat(e[0]))&&isFinite(e[0])?parseInt(e[0]):0,0<t[1].length?(a=t[1].width(),"fixed"===t[1].css("position")&&(a+=t[1][0].offsetLeft)):a=!isNaN(parseFloat(e[1]))&&isFinite(e[1])?parseInt(e[1]):0;break;case"function":(e=u.call(null))instanceof Array?(n=e[0],a=e[1]):n=a=e;break;default:n=a=parseInt(u)}return[n,a]},_findHighlight:function(e){var t=O.location,n=t.toString().split("#")[0],a=t.pathname;return y("._"+x+"-h[href='#"+e+"'],._"+x+"-h[href='"+n+"#"+e+"'],._"+x+"-h[href='"+a+"#"+e+"'],._"+x+"-h[href='#/"+e+"'],._"+x+"-h[href='"+n+"#/"+e+"'],._"+x+"-h[href='"+a+"#/"+e+"']")},_setClasses:function(e,t,n){var a=I.clickedClass,s=I.targetClass,i=I.highlightClass;e&&a&&""!==a?(y("."+a).removeClass(a),l.addClass(a)):t&&s&&""!==s&&n&&i&&""!==i&&(m._currentTarget.call(null,t)?(t.addClass(s),n.addClass(i)):(!I.keepHighlightUntilNext||1<y("."+i).length)&&(t.removeClass(s),n.removeClass(i)))},_extendClasses:function(){var e=I.targetClass,t=I.highlightClass,n=y("."+e),a=y("."+t),s=e+"-first",i=e+"-last",l=t+"-first",o=t+"-last";y("._"+x+"-t").removeClass(s+" "+i),y("._"+x+"-h").removeClass(l+" "+o),I.forceSingleHighlight?I.keepHighlightUntilNext&&1<n.length?(n.slice(0,1).removeClass(e),a.slice(0,1).removeClass(t)):(n.slice(1).removeClass(e),a.slice(1).removeClass(t)):(n.slice(0,1).addClass(s).end().slice(-1).addClass(i),a.slice(0,1).addClass(l).end().slice(-1).addClass(o))},_removeClasses:function(e){y("."+I.clickedClass).removeClass(I.clickedClass),y("."+I.targetClass).removeClass(I.targetClass+" "+I.targetClass+"-first "+I.targetClass+"-last"),y("."+I.highlightClass).removeClass(I.highlightClass+" "+I.highlightClass+"-first "+I.highlightClass+"-last"),e&&(y("._"+x+"-t").removeClass("_"+x+"-t"),y("._"+x+"-h").removeClass("_"+x+"-h"))},_currentTarget:function(e){var t=I["target_"+e.data(x).i],n=e.data("ps2id-target"),a=n&&y(n)[0]?y(n)[0].getBoundingClientRect():e[0].getBoundingClientRect();if(void 0!==t){var s=e.offset().top,i=e.offset().left,l=t.from?t.from+s:s,o=t.to?t.to+s:s,r=t.fromX?t.fromX+i:i,c=t.toX?t.toX+i:i;return a.top>=o&&a.top<=l&&a.left>=c&&a.left<=r}var u=y(O).height(),h=y(O).width(),g=n?y(n).height():e.height(),f=n?y(n).width():e.width(),d=1+g/u,p=d,_=g<u?d*(u/g):d,m=1+f/h,v=m,S=f<h?m*(h/f):m,C=[a.top<=u/p,a.bottom>=u/_,a.left<=h/v,a.right>=h/S];if(I.highlightByNextTarget){var w=e.data(x).tn;if(w){var b=w[0].getBoundingClientRect();"vertical"===I.layout?C=[a.top<=u/2,b.top>u/2,1,1]:"horizontal"===I.layout&&(C=[1,1,a.left<=h/2,b.left>h/2])}}return C[0]&&C[1]&&C[2]&&C[3]},_scrollTo:function(){g=m._scrollSpeed.call(null),r=I.pageEndSmoothScroll?m._pageEndSmoothScroll.call(null):r;var e=y("html,body"),t=I.autoScrollSpeed?m._autoScrollSpeed.call(null):g,n=e.is(":animated")?I.scrollingEasing:I.scrollEasing,a=y(O).scrollTop(),s=y(O).scrollLeft();switch(c){case"horizontal":s!=r[1]&&(m._callbacks.call(null,"onStart"),e.stop().animate({scrollLeft:r[1]},t,n).promise().then(function(){m._callbacks.call(null,"onComplete")}));break;case"auto":var i;if(a!=r[0]||s!=r[1])if(m._callbacks.call(null,"onStart"),navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/))e.stop().animate({pageYOffset:r[0],pageXOffset:r[1]},{duration:t,easing:n,step:function(e,t){"pageXOffset"==t.prop?i=e:"pageYOffset"==t.prop&&O.scrollTo(i,e)}}).promise().then(function(){m._callbacks.call(null,"onComplete")});else e.stop().animate({scrollTop:r[0],scrollLeft:r[1]},t,n).promise().then(function(){m._callbacks.call(null,"onComplete")});break;default:a!=r[0]&&(m._callbacks.call(null,"onStart"),e.stop().animate({scrollTop:r[0]},t,n).promise().then(function(){m._callbacks.call(null,"onComplete")}))}},_pageEndSmoothScroll:function(){var e=y(i).height(),t=y(i).width(),n=y(O).height(),a=y(O).width();return[e-r[0]<n?e-n:r[0],t-r[1]<a?t-a:r[1]]},_scrollSpeed:function(){var a=I.scrollSpeed;return l&&l.length&&l.add(l.parent()).each(function(){var e=y(this);if(e.attr("class")){var t=e.attr("class").split(" ");for(var n in t)if(String(t[n]).match(/^ps2id-speed-\d+$/)){a=t[n].split("ps2id-speed-")[1];break}}}),parseInt(a)},_autoScrollSpeed:function(){var e=y(O).scrollTop(),t=y(O).scrollLeft(),n=y(i).height(),a=y(i).width(),s=[g+g*Math.floor(Math.abs(r[0]-e)/n*100)/100,g+g*Math.floor(Math.abs(r[1]-t)/a*100)/100];return Math.max.apply(Math,s)},_callbacks:function(e){if(I)switch(this[x]={trigger:s,clicked:l,target:o,scrollTo:{y:r[0],x:r[1]}},e){case"onStart":if(I.appendHash&&O.history&&O.history.pushState&&l&&l.length){var t="#"+l.attr("href").split("#")[1];t!==O.location.hash&&history.pushState("","",t)}I.onStart.call(null,this[x]);break;case"onComplete":I.onComplete.call(null,this[x])}},_reset:function(){c=u=h=!1},_isInit:function(){a||_.init.apply(this)},_live:function(){t=setTimeout(function(){I.live?y(m._highlightSelector()).length!==p&&m._setup.call(null):t&&clearTimeout(t),m._live.call(null)},1e3)},_easing:function(){function t(e){var t=7.5625,n=2.75;return e<1/n?t*e*e:e<2/n?t*(e-=1.5/n)*e+.75:e<2.5/n?t*(e-=2.25/n)*e+.9375:t*(e-=2.625/n)*e+.984375}y.easing.easeInQuad=y.easing.easeInQuad||function(e){return e*e},y.easing.easeOutQuad=y.easing.easeOutQuad||function(e){return 1-(1-e)*(1-e)},y.easing.easeInOutQuad=y.easing.easeInOutQuad||function(e){return e<.5?2*e*e:1-Math.pow(-2*e+2,2)/2},y.easing.easeInCubic=y.easing.easeInCubic||function(e){return e*e*e},y.easing.easeOutCubic=y.easing.easeOutCubic||function(e){return 1-Math.pow(1-e,3)},y.easing.easeInOutCubic=y.easing.easeInOutCubic||function(e){return e<.5?4*e*e*e:1-Math.pow(-2*e+2,3)/2},y.easing.easeInQuart=y.easing.easeInQuart||function(e){return e*e*e*e},y.easing.easeOutQuart=y.easing.easeOutQuart||function(e){return 1-Math.pow(1-e,4)},y.easing.easeInOutQuart=y.easing.easeInOutQuart||function(e){return e<.5?8*e*e*e*e:1-Math.pow(-2*e+2,4)/2},y.easing.easeInQuint=y.easing.easeInQuint||function(e){return e*e*e*e*e},y.easing.easeOutQuint=y.easing.easeOutQuint||function(e){return 1-Math.pow(1-e,5)},y.easing.easeInOutQuint=y.easing.easeInOutQuint||function(e){return e<.5?16*e*e*e*e*e:1-Math.pow(-2*e+2,5)/2},y.easing.easeInExpo=y.easing.easeInExpo||function(e){return 0===e?0:Math.pow(2,10*e-10)},y.easing.easeOutExpo=y.easing.easeOutExpo||function(e){return 1===e?1:1-Math.pow(2,-10*e)},y.easing.easeInOutExpo=y.easing.easeInOutExpo||function(e){return 0===e?0:1===e?1:e<.5?Math.pow(2,20*e-10)/2:(2-Math.pow(2,-20*e+10))/2},y.easing.easeInSine=y.easing.easeInSine||function(e){return 1-Math.cos(e*Math.PI/2)},y.easing.easeOutSine=y.easing.easeOutSine||function(e){return Math.sin(e*Math.PI/2)},y.easing.easeInOutSine=y.easing.easeInOutSine||function(e){return-(Math.cos(Math.PI*e)-1)/2},y.easing.easeInCirc=y.easing.easeInCirc||function(e){return 1-Math.sqrt(1-Math.pow(e,2))},y.easing.easeOutCirc=y.easing.easeOutCirc||function(e){return Math.sqrt(1-Math.pow(e-1,2))},y.easing.easeInOutCirc=y.easing.easeInOutCirc||function(e){return e<.5?(1-Math.sqrt(1-Math.pow(2*e,2)))/2:(Math.sqrt(1-Math.pow(-2*e+2,2))+1)/2},y.easing.easeInElastic=y.easing.easeInElastic||function(e){return 0===e?0:1===e?1:-Math.pow(2,10*e-10)*Math.sin((10*e-10.75)*(2*Math.PI/3))},y.easing.easeOutElastic=y.easing.easeOutElastic||function(e){return 0===e?0:1===e?1:Math.pow(2,-10*e)*Math.sin((10*e-.75)*(2*Math.PI/3))+1},y.easing.easeInOutElastic=y.easing.easeInOutElastic||function(e){return 0===e?0:1===e?1:e<.5?-Math.pow(2,20*e-10)*Math.sin((20*e-11.125)*(2*Math.PI/4.5))/2:Math.pow(2,-20*e+10)*Math.sin((20*e-11.125)*(2*Math.PI/4.5))/2+1},y.easing.easeInBack=y.easing.easeInBack||function(e){return 2.70158*e*e*e-1.70158*e*e},y.easing.easeOutBack=y.easing.easeOutBack||function(e){return 1+2.70158*Math.pow(e-1,3)+1.70158*Math.pow(e-1,2)},y.easing.easeInOutBack=y.easing.easeInOutBack||function(e){return e<.5?Math.pow(2*e,2)*(7.189819*e-2.5949095)/2:(Math.pow(2*e-2,2)*(3.5949095*(2*e-2)+2.5949095)+2)/2},y.easing.easeInBounce=y.easing.easeInBounce||function(e){return 1-t(1-e)},y.easing.easeOutBounce=y.easing.easeOutBounce||t,y.easing.easeInOutBounce=y.easing.easeInOutBounce||function(e){return e<.5?(1-t(1-2*e))/2:(1+t(2*e-1))/2}}};m._easing.call(),y.fn[f]=function(e){return _[e]?_[e].apply(this,Array.prototype.slice.call(arguments,1)):"object"!=typeof e&&e?void y.error("Method "+e+" does not exist"):_.init.apply(this,arguments)},y[f]=function(e){return _[e]?_[e].apply(this,Array.prototype.slice.call(arguments,1)):"object"!=typeof e&&e?void y.error("Method "+e+" does not exist"):_.init.apply(this,arguments)},y[f].defaults=d}(jQuery,window,document),function(l){var o="mPS2id",r=mPS2id_params,c=r.shortcode_class,u=location.hash||null,h=function(e,t){try{l(e)}catch(e){return!1}return l(e).length&&(t||l("a[href*='"+e+"']").filter(function(){return 1==l(this).data(o+"Element")}).length)},g=function(e){if(-1===e.indexOf(","))return e;var t=e.split(",");return{y:t[0]||"0",x:t[1]||"0"}},f=function(e){if(-1===e.indexOf(","))return e;var t=e.split(",");return[t[0]||"0",t[1]||"0"]},d=function(e){"horizontal"!==e&&l(window).scrollTop(0),"vertical"!==e&&l(window).scrollLeft(0)},p=function(e,t){for(var n=e.click.length-1;0<=n;n--){var a=e.click[n];a&&"mPS2id"!=a.namespace&&('a[href*="#"]'===a.selector?a.selector='a[href*="#"]:not(._mPS2id-h)':"a[href*=#]:not([href=#])"===a.selector?a.selector="a[href*=#]:not([href=#]):not(._mPS2id-h)":t.off("click",a.handler))}},_="a[data-ps2id-api='true'][href*='#'],.ps2id > a[href*='#'],a.ps2id[href*='#']";l(document).ready(function(){for(var e=0;e<r.total_instances;e++)if("true"===r.instances[o+"_instance_"+e].scrollToHash&&u&&(l(r.instances[o+"_instance_"+e].selector+",."+c+","+_).each(function(){l(this).data(o+"Element",!0)}),h(u,"true"===r.instances[o+"_instance_"+e].scrollToHashForAll))){var t="true"===r.instances[o+"_instance_"+e].scrollToHashRemoveUrlHash?window.location.href.replace(/#.*$/,""):window.location.href.replace(/#.*$/,"#");d(r.instances[o+"_instance_"+e].layout),window.history&&window.history.replaceState?window.history.replaceState("","",t):window.location.href=t}}),l(window).on("load",function(){for(var e=0;e<r.total_instances;e++){var n=l(r.instances[o+"_instance_"+e].selector+",."+c+","+_),t=r.instances[o+"_instance_"+e].autoCorrectScroll,a=0;if(n.mPageScroll2id({scrollSpeed:r.instances[o+"_instance_"+e].scrollSpeed,autoScrollSpeed:"true"===r.instances[o+"_instance_"+e].autoScrollSpeed,scrollEasing:r.instances[o+"_instance_"+e].scrollEasing,scrollingEasing:r.instances[o+"_instance_"+e].scrollingEasing,pageEndSmoothScroll:"true"===r.instances[o+"_instance_"+e].pageEndSmoothScroll,layout:r.instances[o+"_instance_"+e].layout,offset:g(r.instances[o+"_instance_"+e].offset.toString()),highlightSelector:r.instances[o+"_instance_"+e].highlightSelector,clickedClass:r.instances[o+"_instance_"+e].clickedClass,targetClass:r.instances[o+"_instance_"+e].targetClass,highlightClass:r.instances[o+"_instance_"+e].highlightClass,forceSingleHighlight:"true"===r.instances[o+"_instance_"+e].forceSingleHighlight,keepHighlightUntilNext:"true"===r.instances[o+"_instance_"+e].keepHighlightUntilNext,highlightByNextTarget:"true"===r.instances[o+"_instance_"+e].highlightByNextTarget,disablePluginBelow:f(r.instances[o+"_instance_"+e].disablePluginBelow.toString()),appendHash:"true"===r.instances[o+"_instance_"+e].appendHash,onStart:function(){"true"===t&&"selector"===mPS2id.trigger&&a++},onComplete:function(){1==a&&(mPS2id.clicked.length&&mPS2id.clicked.trigger("click.mPS2id"),a=0)}}),"true"===r.instances[o+"_instance_"+e].scrollToHash&&u&&h(u,"true"===r.instances[o+"_instance_"+e].scrollToHashForAll)){d(r.instances[o+"_instance_"+e].layout);var s=r.instances[o+"_instance_"+e].scrollToHashUseElementData,i=l("a._mPS2id-h[href$='"+u+"'][data-ps2id-offset]:not([data-ps2id-offset=''])").last();setTimeout(function(){"true"===s&&i.length?i.trigger("click.mPS2id"):l.mPageScroll2id("scrollTo",u),-1!==window.location.href.indexOf("#")&&(window.history&&window.history.replaceState?window.history.replaceState("","",u):window.location.hash=u)},r.instances[o+"_instance_"+e].scrollToHashDelay)}"true"===r.instances[o+"_instance_"+e].unbindUnrelatedClickEvents&&setTimeout(function(){var e=n.length?l._data(n[0],"events"):null,t=n.length?l._data(l(document)[0],"events"):null;e&&p(e,n),t&&p(t,n)},300),"true"===r.instances[o+"_instance_"+e].normalizeAnchorPointTargets&&l("a._mPS2id-t[id]:empty").css({display:"inline-block","line-height":0,width:0,height:0,border:"none"}),"true"===r.instances[o+"_instance_"+e].stopScrollOnUserAction&&l(document).on("mousewheel DOMMouseScroll touchmove",function(){var e=l("html,body");e.is(":animated")&&e.stop()})}}),l.extend(l.expr[":"],{absolute:l.expr[":"].absolute||function(e){return"absolute"===l(e).css("position")},relative:l.expr[":"].relative||function(e){return"relative"===l(e).css("position")},static:l.expr[":"].static||function(e){return"static"===l(e).css("position")},fixed:l.expr[":"].fixed||function(e){return"fixed"===l(e).css("position")},width:l.expr[":"].width||function(e,t,n){var a=n[3].replace("&lt;","<").replace("&gt;",">");return!!a&&(">"===a.substr(0,1)?l(e).width()>a.substr(1):"<"===a.substr(0,1)?l(e).width()<a.substr(1):l(e).width()===parseInt(a))},height:l.expr[":"].height||function(e,t,n){var a=n[3].replace("&lt;","<").replace("&gt;",">");return!!a&&(">"===a.substr(0,1)?l(e).height()>a.substr(1):"<"===a.substr(0,1)?l(e).height()<a.substr(1):l(e).height()===parseInt(a))}})}(jQuery);