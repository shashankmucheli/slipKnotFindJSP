Clazz.declarePackage ("J.awtjs");
Clazz.load (["J.awtjs2d.Platform"], "J.awtjs.Platform", null, function () {
c$ = Clazz.declareType (J.awtjs, "Platform", J.awtjs2d.Platform);
Clazz.overrideMethod (c$, "drawImage", 
function (g, img, x, y, width, height) {
}, "~O,~O,~N,~N,~N,~N");
Clazz.overrideMethod (c$, "getTextPixels", 
function (text, font3d, gObj, image, width, height, ascent) {
return null;
}, "~S,javajs.awt.Font,~O,~O,~N,~N,~N");
Clazz.overrideMethod (c$, "getGraphics", 
function (image) {
return null;
}, "~O");
Clazz.overrideMethod (c$, "getStaticGraphics", 
function (image, backgroundTransparent) {
return null;
}, "~O,~B");
Clazz.overrideMethod (c$, "newBufferedImage", 
function (image, w, h) {
return null;
}, "~O,~N,~N");
Clazz.overrideMethod (c$, "newOffScreenImage", 
function (w, h) {
return null;
}, "~N,~N");
});
