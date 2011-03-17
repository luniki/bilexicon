/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, plusplus: true, bitwise: true, newcap: true */

/* ------------------------------------------------------------------------
 * Special FX
 * ------------------------------------------------------------------------ */
Effect.SelfHealingFade = function (element) {
  element = $(element);
  return new Effect.Parallel(
    [
      new Effect.Fade(element,  { sync: true }),
      new Effect.BlindUp(element, { sync: true })
    ],
    arguments[1] || { duration: 0.1 }
  );
};

Effect.SelfHealingAppear = function (element) {
  element = $(element);
  return new Effect.Parallel(
    [
      new Effect.Appear(element,  { sync: true }),
      new Effect.BlindDown(element, { sync: true })
    ],
    arguments[1] || { duration: 0.25 }
  );
};
