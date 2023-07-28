/*! For license information please see 1622.js.LICENSE.txt */
"use strict";(self.webpackChunk_npwd_nui=self.webpackChunk_npwd_nui||[]).push([[1622],{17782:function(e,t,r){var n=r(53182),o=r(52960),s=r(24141),c=r(74227),a=r(61250);t.Z=function(e){const{children:t,theme:r}=e,u=(0,s.Z)(),f=n.useMemo((()=>{const e=null===u?r:function(e,t){return"function"==typeof t?t(e):{...e,...t}}(u,r);return null!=e&&(e[c.Z]=null!==u),e}),[r,u]);return(0,a.jsx)(o.Z.Provider,{value:f,children:t})}},11622:function(e,t,r){r.r(t),r.d(t,{ServerStyleSheets:function(){return y},StylesContext:function(){return p.NU},StylesProvider:function(){return p.ZP},ThemeProvider:function(){return $.Z},createGenerateClassName:function(){return n.Z},createStyles:function(){return o},getThemeProps:function(){return c},jssPreset:function(){return a.Z},makeStyles:function(){return u.Z},mergeClasses:function(){return f.Z},propsToClassKey:function(){return w.Z},sheetsManager:function(){return p.tP},styled:function(){return P},useTheme:function(){return g.Z},useThemeVariants:function(){return T},withStyles:function(){return C},withTheme:function(){return M},withThemeCreator:function(){return N}});var n=r(1162);function o(e){return e}var s=r(63223);function c(e){const{theme:t,name:r,props:n}=e;if(!(t&&t.components&&t.components[r]&&t.components[r].defaultProps))return n;const o=(0,s.Z)({},n),c=t.components[r].defaultProps;let a;for(a in c)void 0===o[a]&&(o[a]=c[a]);return o}var a=r(23148),u=r(47264),f=r(23529),i=r(53182),l=r(46385),p=r(51249),m=r(61250);class y{constructor(e={}){this.options=e}collect(e){const t=new Map;this.sheetsRegistry=new l.xE;const r=(0,n.Z)();return(0,m.jsx)(p.ZP,(0,s.Z)({sheetsManager:t,serverGenerateClassName:r,sheetsRegistry:this.sheetsRegistry},this.options,{children:e}))}toString(){return this.sheetsRegistry?this.sheetsRegistry.toString():""}getStyleElement(e){return i.createElement("style",(0,s.Z)({id:"jss-server-side",key:"jss-server-side",dangerouslySetInnerHTML:{__html:this.toString()}},e))}}var d=r(10262),h=r(14517),S=r(10063),Z=r.n(S);const b=["name"],v=["children","className","clone","component"];function P(e){return(t,r={})=>{const{name:n}=r,o=(0,d.Z)(r,b);let c=n;const a="function"==typeof t?e=>({root:r=>t((0,s.Z)({theme:e},r))}):{root:t},f=(0,u.Z)(a,(0,s.Z)({Component:e,name:n||e.displayName,classNamePrefix:c},o));let l,p={};t.filterProps&&(l=t.filterProps,delete t.filterProps),t.propTypes&&(t.propTypes,delete t.propTypes);const y=i.forwardRef((function(t,r){const{children:n,className:o,clone:c,component:a}=t,u=(0,d.Z)(t,v),p=f(t),y=(0,h.Z)(p.root,o);let S=u;if(l&&(S=function(e,t){const r={};return Object.keys(e).forEach((n=>{-1===t.indexOf(n)&&(r[n]=e[n])})),r}(S,l)),c)return i.cloneElement(n,(0,s.Z)({className:(0,h.Z)(n.props.className,y)},S));if("function"==typeof n)return n((0,s.Z)({className:y},S));const Z=a||e;return(0,m.jsx)(Z,(0,s.Z)({ref:r,className:y},S,{children:n}))}));return Z()(y,e),y}}var $=r(17782),g=r(32978),w=r(95845),T=(e,t)=>{const{classes:r={}}=e,n=(0,g.Z)();let o="";return n&&n.components&&n.components[t]&&n.components[t].variants&&n.components[t].variants.forEach((t=>{let n=!0;Object.keys(t.props).forEach((r=>{e[r]!==t.props[r]&&(n=!1)})),n&&(o=`${o}${r[(0,w.Z)(t.props)]} `)})),o};const x=["defaultTheme","withTheme","name"],j=["classes"];var C=(e,t={})=>r=>{const{defaultTheme:n,withTheme:o=!1,name:a}=t,f=(0,d.Z)(t,x);let l=a;const p=(0,u.Z)(e,(0,s.Z)({defaultTheme:n,Component:r,name:a||r.displayName,classNamePrefix:l},f)),y=i.forwardRef((function(e,t){const u=(0,d.Z)(e,j),f=p((0,s.Z)({},r.defaultProps,e));let i,l=u;return("string"==typeof a||o)&&(i=(0,g.Z)()||n,a&&(l=c({theme:i,name:a,props:u})),o&&!l.theme&&(l.theme=i)),(0,m.jsx)(r,(0,s.Z)({ref:t,classes:f},l))}));return Z()(y,r),y};function N(e={}){const{defaultTheme:t}=e;return e=>{const r=i.forwardRef((function(r,n){const o=(0,g.Z)()||t;return(0,m.jsx)(e,(0,s.Z)({theme:o,ref:n},r))}));return Z()(r,e),r}}var M=N()},10063:function(e,t,r){var n=r(99415),o={childContextTypes:!0,contextType:!0,contextTypes:!0,defaultProps:!0,displayName:!0,getDefaultProps:!0,getDerivedStateFromError:!0,getDerivedStateFromProps:!0,mixins:!0,propTypes:!0,type:!0},s={name:!0,length:!0,prototype:!0,caller:!0,callee:!0,arguments:!0,arity:!0},c={$$typeof:!0,compare:!0,defaultProps:!0,displayName:!0,propTypes:!0,type:!0},a={};function u(e){return n.isMemo(e)?c:a[e.$$typeof]||o}a[n.ForwardRef]={$$typeof:!0,render:!0,defaultProps:!0,displayName:!0,propTypes:!0},a[n.Memo]=c;var f=Object.defineProperty,i=Object.getOwnPropertyNames,l=Object.getOwnPropertySymbols,p=Object.getOwnPropertyDescriptor,m=Object.getPrototypeOf,y=Object.prototype;e.exports=function e(t,r,n){if("string"!=typeof r){if(y){var o=m(r);o&&o!==y&&e(t,o,n)}var c=i(r);l&&(c=c.concat(l(r)));for(var a=u(t),d=u(r),h=0;h<c.length;++h){var S=c[h];if(!(s[S]||n&&n[S]||d&&d[S]||a&&a[S])){var Z=p(r,S);try{f(t,S,Z)}catch(e){}}}}return t}},4507:function(e,t){var r="function"==typeof Symbol&&Symbol.for,n=r?Symbol.for("react.element"):60103,o=r?Symbol.for("react.portal"):60106,s=r?Symbol.for("react.fragment"):60107,c=r?Symbol.for("react.strict_mode"):60108,a=r?Symbol.for("react.profiler"):60114,u=r?Symbol.for("react.provider"):60109,f=r?Symbol.for("react.context"):60110,i=r?Symbol.for("react.async_mode"):60111,l=r?Symbol.for("react.concurrent_mode"):60111,p=r?Symbol.for("react.forward_ref"):60112,m=r?Symbol.for("react.suspense"):60113,y=r?Symbol.for("react.suspense_list"):60120,d=r?Symbol.for("react.memo"):60115,h=r?Symbol.for("react.lazy"):60116,S=r?Symbol.for("react.block"):60121,Z=r?Symbol.for("react.fundamental"):60117,b=r?Symbol.for("react.responder"):60118,v=r?Symbol.for("react.scope"):60119;function P(e){if("object"==typeof e&&null!==e){var t=e.$$typeof;switch(t){case n:switch(e=e.type){case i:case l:case s:case a:case c:case m:return e;default:switch(e=e&&e.$$typeof){case f:case p:case h:case d:case u:return e;default:return t}}case o:return t}}}function $(e){return P(e)===l}t.AsyncMode=i,t.ConcurrentMode=l,t.ContextConsumer=f,t.ContextProvider=u,t.Element=n,t.ForwardRef=p,t.Fragment=s,t.Lazy=h,t.Memo=d,t.Portal=o,t.Profiler=a,t.StrictMode=c,t.Suspense=m,t.isAsyncMode=function(e){return $(e)||P(e)===i},t.isConcurrentMode=$,t.isContextConsumer=function(e){return P(e)===f},t.isContextProvider=function(e){return P(e)===u},t.isElement=function(e){return"object"==typeof e&&null!==e&&e.$$typeof===n},t.isForwardRef=function(e){return P(e)===p},t.isFragment=function(e){return P(e)===s},t.isLazy=function(e){return P(e)===h},t.isMemo=function(e){return P(e)===d},t.isPortal=function(e){return P(e)===o},t.isProfiler=function(e){return P(e)===a},t.isStrictMode=function(e){return P(e)===c},t.isSuspense=function(e){return P(e)===m},t.isValidElementType=function(e){return"string"==typeof e||"function"==typeof e||e===s||e===l||e===a||e===c||e===m||e===y||"object"==typeof e&&null!==e&&(e.$$typeof===h||e.$$typeof===d||e.$$typeof===u||e.$$typeof===f||e.$$typeof===p||e.$$typeof===Z||e.$$typeof===b||e.$$typeof===v||e.$$typeof===S)},t.typeOf=P},99415:function(e,t,r){e.exports=r(4507)}}]);