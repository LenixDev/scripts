(function () {
  const a = document.createElement("link").relList;
  if (a && a.supports && a.supports("modulepreload")) {
    return;
  }
  for (const a of document.querySelectorAll("link[rel=\"modulepreload\"]")) {
    c(a);
  }
  new MutationObserver(d => {
    for (const e of d) {
      if (e.type === "childList") {
        for (const a of e.addedNodes) {
          if (a.tagName === "LINK" && a.rel === "modulepreload") {
            c(a);
          }
        }
      }
    }
  }).observe(document, {
    childList: true,
    subtree: true
  });
  function f(a) {
    const b = {};
    if (a.integrity) {
      b.integrity = a.integrity;
    }
    if (a.referrerPolicy) {
      b.referrerPolicy = a.referrerPolicy;
    }
    if (a.crossOrigin === "use-credentials") {
      b.credentials = "include";
    } else if (a.crossOrigin === "anonymous") {
      b.credentials = "omit";
    } else {
      b.credentials = "same-origin";
    }
    return b;
  }
  function c(a) {
    if (a.ep) {
      return;
    }
    a.ep = true;
    const b = f(a);
    fetch(a.href, b);
  }
})();
const Ha = (c, a) => c === a;
const Ie = Symbol("solid-proxy");
const Wh = Symbol("solid-track");
const a = Symbol("solid-dev-component");
const al = {
  equals: Ha
};
let d = K;
const zp = 1;
const f = 2;
const c = {
  owned: null,
  cleanups: null,
  context: null,
  owner: null
};
var h = null;
let b = null;
let i = null;
let e = null;
let j = null;
let g = 0;
const [k, l] = Cr(false);
function n(k, a) {
  const b = i;
  const d = h;
  const e = k.length === 0;
  const f = e ? c : {
    owned: null,
    cleanups: null,
    context: null,
    owner: a === undefined ? d : a
  };
  const g = e ? k : () => k(() => q(() => O(f)));
  h = f;
  i = null;
  try {
    return H(g, true);
  } finally {
    i = b;
    h = d;
  }
}
function Cr(c, a) {
  a = a ? Object.assign({}, al, a) : al;
  const d = {
    value: c,
    observers: null,
    observerSlots: null,
    comparator: a.equals || undefined
  };
  const e = b => {
    if (typeof b == "function") {
      b = b(d.value);
    }
    return B(d, b);
  };
  return [A.bind(d), e];
}
function Dr(e, a, b) {
  const c = E(e, a, true, zp);
  C(c);
}
function p(e, a, b) {
  const c = E(e, a, false, zp);
  C(c);
}
function o(e, a, b) {
  d = L;
  const c = E(e, a, false, zp);
  if (!b || !b.render) {
    c.user = true;
  }
  if (j) {
    j.push(c);
  } else {
    C(c);
  }
}
function s(d, a, b) {
  b = b ? Object.assign({}, al, b) : al;
  const e = E(d, a, true, 0);
  e.observers = null;
  e.observerSlots = null;
  e.comparator = b.equals || undefined;
  C(e);
  return A.bind(e);
}
function m(b) {
  return H(b, false);
}
function q(c) {
  if (i === null) {
    return c();
  }
  const a = i;
  i = null;
  try {
    return c();
  } finally {
    i = a;
  }
}
function r(b) {
  o(() => q(b));
}
function t(b) {
  if (h !== null) {
    if (h.cleanups === null) {
      h.cleanups = [b];
    } else {
      h.cleanups.push(b);
    }
  }
  return b;
}
function u() {
  return i;
}
function v(b) {
  const a = i;
  const c = h;
  return Promise.resolve().then(() => {
    i = a;
    h = c;
    let d;
    H(b, false);
    i = h = null;
    if (d) {
      return d.done;
    } else {
      return undefined;
    }
  });
}
function w() {
  return [k, v];
}
function x(c, a) {
  const b = Symbol("context");
  return {
    id: b,
    Provider: S(b),
    defaultValue: c
  };
}
function y(b) {
  let a;
  if ((a = Q(h, b.id)) !== undefined) {
    return a;
  } else {
    return b.defaultValue;
  }
}
function z(b) {
  const a = s(b);
  const e = s(() => R(a()));
  e.toArray = () => {
    const a = e();
    if (Array.isArray(a)) {
      return a;
    } else if (a != null) {
      return [a];
    } else {
      return [];
    }
  };
  return e;
}
function A() {
  if (this.sources && this.state) {
    if (this.state === zp) {
      C(this);
    } else {
      const b = e;
      e = null;
      H(() => M(this), false);
      e = b;
    }
  }
  if (i) {
    const a = this.observers ? this.observers.length : 0;
    if (i.sources) {
      i.sources.push(this);
      i.sourceSlots.push(a);
    } else {
      i.sources = [this];
      i.sourceSlots = [a];
    }
    if (this.observers) {
      this.observers.push(i);
      this.observerSlots.push(i.sources.length - 1);
    } else {
      this.observers = [i];
      this.observerSlots = [i.sources.length - 1];
    }
  }
  return this.value;
}
function B(f, a, d) {
  let c = f.value;
  if (!f.comparator || !f.comparator(c, a)) {
    f.value = a;
    if (f.observers && f.observers.length) {
      H(() => {
        for (let a = 0; a < f.observers.length; a += 1) {
          const c = f.observers[a];
          const d = b && b.running;
          if (d) {
            b.disposed.has(c);
          }
          if (d ? !c.tState : !c.state) {
            if (c.pure) {
              e.push(c);
            } else {
              j.push(c);
            }
            if (c.observers) {
              N(c);
            }
          }
          if (!d) {
            c.state = zp;
          }
        }
        if (e.length > 1000000) {
          e = [];
          throw new Error();
        }
      }, false);
    }
  }
  return a;
}
function C(b) {
  if (!b.fn) {
    return;
  }
  O(b);
  const a = h;
  const c = i;
  const d = g;
  i = h = b;
  D(b, b.value, d);
  i = c;
  h = a;
}
function D(d, a, f) {
  let b;
  try {
    b = d.fn(a);
  } catch (a) {
    if (d.pure) {
      d.state = zp;
      if (d.owned) {
        d.owned.forEach(O);
      }
      d.owned = null;
    }
    d.updatedAt = f + 1;
    return P(a);
  }
  if (!d.updatedAt || d.updatedAt <= f) {
    if (d.updatedAt != null && "observers" in d) {
      B(d, b);
    } else {
      d.value = b;
    }
    d.updatedAt = f;
  }
}
function E(f, a, b, g = undefined, i) {
  if (g === undefined) g = zp;
  const e = {
    fn: f,
    state: g,
    updatedAt: null,
    owned: null,
    sources: null,
    sourceSlots: null,
    cleanups: null,
    value: a,
    owner: h,
    context: null,
    pure: b
  };
  if (h !== null) {
    if (h !== c) {
      if (h.owned) {
        h.owned.push(e);
      } else {
        h.owned = [e];
      }
    }
  }
  return e;
}
function G(b) {
  if (b.state === 0) {
    return;
  }
  if (b.state === f) {
    return M(b);
  }
  if (b.suspense && q(b.suspense.inFallback)) {
    return b.suspense.effects.push(b);
  }
  const h = [b];
  while ((b = b.owner) && (!b.updatedAt || b.updatedAt < g)) {
    if (b.state) {
      h.push(b);
    }
  }
  for (let a = h.length - 1; a >= 0; a--) {
    b = h[a];
    if (b.state === zp) {
      C(b);
    } else if (b.state === f) {
      const a = e;
      e = null;
      H(() => M(b, h[0]), false);
      e = a;
    }
  }
}
function H(d, a) {
  if (e) {
    return d();
  }
  let f = false;
  if (!a) {
    e = [];
  }
  if (j) {
    f = true;
  } else {
    j = [];
  }
  g++;
  try {
    const a = d();
    I(f);
    return a;
  } catch (b) {
    if (!f) {
      j = null;
    }
    e = null;
    P(b);
  }
}
function I(b) {
  if (e) {
    K(e);
    e = null;
  }
  if (b) {
    return;
  }
  const a = j;
  j = null;
  if (a.length) {
    H(() => d(a), false);
  }
}
function K(b) {
  for (let a = 0; a < b.length; a++) {
    G(b[a]);
  }
}
function L(b) {
  let a;
  let f = 0;
  for (a = 0; a < b.length; a++) {
    const c = b[a];
    if (c.user) {
      b[f++] = c;
    } else {
      G(c);
    }
  }
  for (a = 0; a < f; a++) {
    G(b[a]);
  }
}
function M(c, a) {
  c.state = 0;
  for (let b = 0; b < c.sources.length; b += 1) {
    const d = c.sources[b];
    if (d.sources) {
      const b = d.state;
      if (b === zp) {
        if (d !== a && (!d.updatedAt || d.updatedAt < g)) {
          G(d);
        }
      } else if (b === f) {
        M(d, a);
      }
    }
  }
}
function N(b) {
  for (let a = 0; a < b.observers.length; a += 1) {
    const c = b.observers[a];
    if (!c.state) {
      c.state = f;
      if (c.pure) {
        e.push(c);
      } else {
        j.push(c);
      }
      if (c.observers) {
        N(c);
      }
    }
  }
}
function O(b) {
  let a;
  if (b.sources) {
    while (b.sources.length) {
      const g = b.sources.pop();
      const c = b.sourceSlots.pop();
      const d = g.observers;
      if (d && d.length) {
        const b = d.pop();
        const a = g.observerSlots.pop();
        if (c < d.length) {
          b.sourceSlots[a] = c;
          d[c] = b;
          g.observerSlots[c] = a;
        }
      }
    }
  }
  if (b.owned) {
    for (a = b.owned.length - 1; a >= 0; a--) {
      O(b.owned[a]);
    }
    b.owned = null;
  }
  if (b.cleanups) {
    for (a = b.cleanups.length - 1; a >= 0; a--) {
      b.cleanups[a]();
    }
    b.cleanups = null;
  }
  b.state = 0;
  b.context = null;
}
function P(b) {
  throw b;
}
function Q(c, a) {
  if (c) {
    if (c.context && c.context[a] !== undefined) {
      return c.context[a];
    } else {
      return Q(c.owner, a);
    }
  } else {
    return undefined;
  }
}
function R(b) {
  if (typeof b == "function" && !b.length) {
    return R(b());
  }
  if (Array.isArray(b)) {
    const a = [];
    for (let c = 0; c < b.length; c++) {
      const d = R(b[c]);
      if (Array.isArray(d)) {
        a.push.apply(a, d);
      } else {
        a.push(d);
      }
    }
    return a;
  }
  return b;
}
function S(c, a) {
  return function (a) {
    let b;
    p(() => b = q(() => {
      h.context = {
        [c]: a.value
      };
      return z(() => a.children);
    }), undefined);
    return b;
  };
}
const T = Symbol("fallback");
function U(b) {
  for (let a = 0; a < b.length; a++) {
    b[a]();
  }
}
function V(b, k, c = undefined) {
  if (c === undefined) c = {};
  let a = [];
  let w = [];
  let m = [];
  let x = 0;
  let y = k.length > 1 ? [] : null;
  t(() => U(m));
  return () => {
    let d = b() || [];
    let e;
    let f;
    d[Wh];
    return q(() => {
      let h = d.length;
      let b;
      let i;
      let j;
      let k;
      let l;
      let q;
      let z;
      let A;
      let B;
      if (h === 0) {
        if (x !== 0) {
          U(m);
          m = [];
          a = [];
          w = [];
          x = 0;
          y &&= [];
        }
        if (c.fallback) {
          a = [T];
          w[0] = n(b => {
            m[0] = b;
            return c.fallback();
          });
          x = 1;
        }
      } else if (x === 0) {
        w = new Array(h);
        f = 0;
        for (; f < h; f++) {
          a[f] = d[f];
          w[f] = n(g);
        }
        x = h;
      } else {
        j = new Array(h);
        k = new Array(h);
        if (y) {
          l = new Array(h);
        }
        q = 0;
        z = Math.min(x, h);
        for (; q < z && a[q] === d[q]; q++);
        z = x - 1;
        A = h - 1;
        for (; z >= q && A >= q && a[z] === d[A]; z--, A--) {
          j[A] = w[z];
          k[A] = m[z];
          if (y) {
            l[A] = y[z];
          }
        }
        b = new Map();
        i = new Array(A + 1);
        f = A;
        for (; f >= q; f--) {
          B = d[f];
          e = b.get(B);
          i[f] = e === undefined ? -1 : e;
          b.set(B, f);
        }
        for (e = q; e <= z; e++) {
          B = a[e];
          f = b.get(B);
          if (f !== undefined && f !== -1) {
            j[f] = w[e];
            k[f] = m[e];
            if (y) {
              l[f] = y[e];
            }
            f = i[f];
            b.set(B, f);
          } else {
            m[e]();
          }
        }
        for (f = q; f < h; f++) {
          if (f in j) {
            w[f] = j[f];
            m[f] = k[f];
            if (y) {
              y[f] = l[f];
              y[f](f);
            }
          } else {
            w[f] = n(g);
          }
        }
        w = w.slice(0, x = h);
        a = d.slice(0);
      }
      return w;
    });
    function g(b) {
      m[f] = b;
      if (y) {
        const [c, a] = Cr(f);
        y[f] = a;
        return k(d[f], c);
      }
      return k(d[f]);
    }
  };
}
function W(b, l, c = undefined) {
  if (c === undefined) c = {};
  let a = [];
  let m = [];
  let o = [];
  let p = [];
  let r = 0;
  let s;
  t(() => U(o));
  return () => {
    const e = b() || [];
    e[Wh];
    return q(() => {
      if (e.length === 0) {
        if (r !== 0) {
          U(o);
          o = [];
          a = [];
          m = [];
          r = 0;
          p = [];
        }
        if (c.fallback) {
          a = [T];
          m[0] = n(b => {
            o[0] = b;
            return c.fallback();
          });
          r = 1;
        }
        return m;
      }
      if (a[0] === T) {
        o[0]();
        o = [];
        a = [];
        m = [];
        r = 0;
      }
      s = 0;
      for (; s < e.length; s++) {
        if (s < a.length && a[s] !== e[s]) {
          p[s](() => e[s]);
        } else if (s >= a.length) {
          m[s] = n(d);
        }
      }
      for (; s < a.length; s++) {
        o[s]();
      }
      r = p.length = o.length = e.length;
      a = e.slice(0);
      return m = m.slice(0, r);
    });
    function d(c) {
      o[s] = c;
      const [a, b] = Cr(e[s]);
      p[s] = b;
      return l(a, s);
    }
  };
}
function X(c, a) {
  return q(() => c(a || {}));
}
function Z() {
  return true;
}
const $ = {
  get(a, b, c) {
    if (b === Ie) {
      return c;
    } else {
      return a.get(b);
    }
  },
  has(a, b) {
    if (b === Ie) {
      return true;
    } else {
      return a.has(b);
    }
  },
  set: Z,
  deleteProperty: Z,
  getOwnPropertyDescriptor(c, a) {
    return {
      configurable: true,
      enumerable: true,
      get() {
        return c.get(a);
      },
      set: Z,
      deleteProperty: Z
    };
  },
  ownKeys(b) {
    return b.keys();
  }
};
function F(b) {
  if (b = typeof b == "function" ? b() : b) {
    return b;
  } else {
    return {};
  }
}
function _() {
  for (let c = 0, a = this.length; c < a; ++c) {
    const a = this[c]();
    if (a !== undefined) {
      return a;
    }
  }
}
function aa(...i) {
  let a = false;
  for (let b = 0; b < i.length; b++) {
    const c = i[b];
    a = a || !!c && Ie in c;
    i[b] = typeof c == "function" ? (a = true, s(c)) : c;
  }
  if (a) {
    return new Proxy({
      get(b) {
        for (let a = i.length - 1; a >= 0; a--) {
          const c = F(i[a])[b];
          if (c !== undefined) {
            return c;
          }
        }
      },
      has(b) {
        for (let a = i.length - 1; a >= 0; a--) {
          if (b in F(i[a])) {
            return true;
          }
        }
        return false;
      },
      keys() {
        const a = [];
        for (let b = 0; b < i.length; b++) {
          a.push(...Object.keys(F(i[b])));
        }
        return [...new Set(a)];
      }
    }, $);
  }
  const c = {};
  const e = {};
  let b = false;
  for (let f = i.length - 1; f >= 0; f--) {
    const j = i[f];
    if (!j) {
      continue;
    }
    const d = Object.getOwnPropertyNames(j);
    b = b || f !== 0 && !!d.length;
    for (let f = 0, a = d.length; f < a; f++) {
      const h = d[f];
      if (h !== "__proto__" && h !== "constructor") {
        if (h in c) {
          const b = e[h];
          const a = Object.getOwnPropertyDescriptor(j, h);
          if (b) {
            if (a.get) {
              b.push(a.get.bind(j));
            } else if (a.value !== undefined) {
              b.push(() => a.value);
            }
          } else if (c[h] === undefined) {
            c[h] = a.value;
          }
        } else {
          const b = Object.getOwnPropertyDescriptor(j, h);
          if (b.get) {
            Object.defineProperty(c, h, {
              enumerable: true,
              configurable: true,
              get: _.bind(e[h] = [b.get.bind(j)])
            });
          } else {
            c[h] = b.value;
          }
        }
      }
    }
  }
  return c;
}
function ia(d, ...i) {
  if (Ie in d) {
    const f = new Set(i.length > 1 ? i.flat() : i[0]);
    const a = i.map(b => new Proxy({
      get(a) {
        if (b.includes(a)) {
          return d[a];
        } else {
          return undefined;
        }
      },
      has(a) {
        return b.includes(a) && a in d;
      },
      keys() {
        return b.filter(b => b in d);
      }
    }, $));
    a.push(new Proxy({
      get(a) {
        if (f.has(a)) {
          return undefined;
        } else {
          return d[a];
        }
      },
      has(a) {
        if (f.has(a)) {
          return false;
        } else {
          return a in d;
        }
      },
      keys() {
        return Object.keys(d).filter(a => !f.has(a));
      }
    }, $));
    return a;
  }
  const b = {};
  const c = i.map(() => ({}));
  for (const e of Object.getOwnPropertyNames(d)) {
    const a = Object.getOwnPropertyDescriptor(d, e);
    const f = !a.get && !a.set && a.enumerable && a.writable && a.configurable;
    let g = false;
    let h = 0;
    for (const d of i) {
      if (d.includes(e)) {
        g = true;
        if (f) {
          c[h][e] = a.value;
        } else {
          Object.defineProperty(c[h], e, a);
        }
      }
      ++h;
    }
    if (!g) {
      if (f) {
        b[e] = a.value;
      } else {
        Object.defineProperty(b, e, a);
      }
    }
  }
  return [...c, b];
}
const ra = b => "Stale read from <" + b + ">.";
function sa(b) {
  const a = "fallback" in b && {
    fallback: () => b.fallback
  };
  return s(V(() => b.each, b.children, a || undefined));
}
function va(b) {
  const a = "fallback" in b && {
    fallback: () => b.fallback
  };
  return s(W(() => b.each, b.children, a || undefined));
}
function Ma(e) {
  const g = e.keyed;
  const a = s(() => e.when, undefined, {
    equals: (c, a) => g ? c === a : !c == !a
  });
  return s(() => {
    const c = a();
    if (c) {
      const d = e.children;
      if (typeof d == "function" && d.length > 0) {
        return q(() => d(g ? c : () => {
          if (!q(a)) {
            throw ra("Show");
          }
          return e.when;
        }));
      } else {
        return d;
      }
    }
    return e.fallback;
  }, undefined, undefined);
}
function Ua(b) {
  let j = false;
  const a = (c, a) => c[0] === a[0] && (j ? c[1] === a[1] : !c[1] == !a[1]) && c[2] === a[2];
  const g = z(() => b.children);
  const d = s(() => {
    let a = g();
    if (!Array.isArray(a)) {
      a = [a];
    }
    for (let c = 0; c < a.length; c++) {
      const b = a[c].when;
      if (b) {
        j = !!a[c].keyed;
        return [c, b, a[c]];
      }
    }
    return [-1];
  }, undefined, {
    equals: a
  });
  return s(() => {
    const [a, c, e] = d();
    if (a < 0) {
      return b.fallback;
    }
    const f = e.children;
    if (typeof f == "function" && f.length > 0) {
      return q(() => f(j ? c : () => {
        if (q(d)[0] !== a) {
          throw ra("Match");
        }
        return e.when;
      }));
    } else {
      return f;
    }
  }, undefined, undefined);
}
function _a(b) {
  return b;
}
const ab = ["allowfullscreen", "async", "autofocus", "autoplay", "checked", "controls", "default", "disabled", "formnovalidate", "hidden", "indeterminate", "ismap", "loop", "multiple", "muted", "nomodule", "novalidate", "open", "playsinline", "readonly", "required", "reversed", "seamless", "selected"];
const bb = new Set(["className", "value", "readOnly", "formNoValidate", "isMap", "noModule", "playsInline", ...ab]);
const cb = new Set(["innerHTML", "textContent", "innerText", "children"]);
const db = Object.assign(Object.create(null), {
  className: "class",
  htmlFor: "for"
});
const eb = Object.assign(Object.create(null), {
  class: "className",
  formnovalidate: {
    $: "formNoValidate",
    BUTTON: 1,
    INPUT: 1
  },
  ismap: {
    $: "isMap",
    IMG: 1
  },
  nomodule: {
    $: "noModule",
    SCRIPT: 1
  },
  playsinline: {
    $: "playsInline",
    VIDEO: 1
  },
  readonly: {
    $: "readOnly",
    INPUT: 1,
    TEXTAREA: 1
  }
});
function fb(c, a) {
  const b = eb[c];
  if (typeof b == "object") {
    if (b[a]) {
      return b.$;
    } else {
      return undefined;
    }
  } else {
    return b;
  }
}
const gb = new Set(["beforeinput", "click", "dblclick", "contextmenu", "focusin", "focusout", "input", "keydown", "keyup", "mousedown", "mousemove", "mouseout", "mouseover", "mouseup", "pointerdown", "pointermove", "pointerout", "pointerover", "pointerup", "touchend", "touchmove", "touchstart"]);
const hb = new Set(["altGlyph", "altGlyphDef", "altGlyphItem", "animate", "animateColor", "animateMotion", "animateTransform", "circle", "clipPath", "color-profile", "cursor", "defs", "desc", "ellipse", "feBlend", "feColorMatrix", "feComponentTransfer", "feComposite", "feConvolveMatrix", "feDiffuseLighting", "feDisplacementMap", "feDistantLight", "feFlood", "feFuncA", "feFuncB", "feFuncG", "feFuncR", "feGaussianBlur", "feImage", "feMerge", "feMergeNode", "feMorphology", "feOffset", "fePointLight", "feSpecularLighting", "feSpotLight", "feTile", "feTurbulence", "filter", "font", "font-face", "font-face-format", "font-face-name", "font-face-src", "font-face-uri", "foreignObject", "g", "glyph", "glyphRef", "hkern", "image", "line", "linearGradient", "marker", "mask", "metadata", "missing-glyph", "mpath", "path", "pattern", "polygon", "polyline", "radialGradient", "rect", "set", "stop", "svg", "switch", "symbol", "text", "textPath", "tref", "tspan", "use", "view", "vkern"]);
const ib = {
  xlink: "http://www.w3.org/1999/xlink",
  xml: "http://www.w3.org/XML/1998/namespace"
};
function jb(d, a, l) {
  let c = l.length;
  let b = a.length;
  let n = c;
  let o = 0;
  let p = 0;
  let e = a[b - 1].nextSibling;
  let q = null;
  while (o < b || p < n) {
    if (a[o] === l[p]) {
      o++;
      p++;
      continue;
    }
    while (a[b - 1] === l[n - 1]) {
      b--;
      n--;
    }
    if (b === o) {
      const a = n < c ? p ? l[p - 1].nextSibling : l[n - p] : e;
      while (p < n) {
        d.insertBefore(l[p++], a);
      }
    } else if (n === p) {
      while (o < b) {
        if (!q || !q.has(a[o])) {
          a[o].remove();
        }
        o++;
      }
    } else if (a[o] === l[n - 1] && l[p] === a[b - 1]) {
      const c = a[--b].nextSibling;
      d.insertBefore(l[p++], a[o++].nextSibling);
      d.insertBefore(l[--n], c);
      a[b] = l[n];
    } else {
      if (!q) {
        q = new Map();
        let b = p;
        while (b < n) {
          q.set(l[b], b++);
        }
      }
      const c = q.get(a[o]);
      if (c != null) {
        if (p < c && c < n) {
          let e = o;
          let f = 1;
          let g;
          while (++e < b && e < n && (g = q.get(a[e])) != null && g === c + f) {
            f++;
          }
          if (f > c - p) {
            const b = a[o];
            while (p < c) {
              d.insertBefore(l[p++], b);
            }
          } else {
            d.replaceChild(l[p++], a[o++]);
          }
        } else {
          o++;
        }
      } else {
        a[o++].remove();
      }
    }
  }
}
const kb = "_$DX_DELEGATE";
function lb(e, a, b, c = undefined) {
  if (c === undefined) c = {};
  let g;
  n(c => {
    g = c;
    if (a === document) {
      e();
    } else {
      oa(a, e(), a.firstChild ? null : undefined, b);
    }
  }, c.owner);
  return () => {
    g();
    a.textContent = "";
  };
}
function mb(h, a, b) {
  let c;
  const d = () => {
    const a = document.createElement("template");
    a.innerHTML = h;
    if (b) {
      return a.content.firstChild.firstChild;
    } else {
      return a.content.firstChild;
    }
  };
  const f = a ? () => q(() => document.importNode(c ||= d(), true)) : () => (c ||= d()).cloneNode(true);
  f.cloneNode = f;
  return f;
}
function nb(c, a = undefined) {
  if (a === undefined) a = window.document;
  const g = a[kb] ||= new Set();
  for (let b = 0, d = c.length; b < d; b++) {
    const d = c[b];
    if (!g.has(d)) {
      g.add(d);
      a.addEventListener(d, Ab);
    }
  }
}
function ob(d, a, b) {
  if (b == null) {
    d.removeAttribute(a);
  } else {
    d.setAttribute(a, b);
  }
}
function pb(e, a, b, c) {
  if (c == null) {
    e.removeAttributeNS(a, b);
  } else {
    e.setAttributeNS(a, b, c);
  }
}
function qb(c, a) {
  if (a == null) {
    c.removeAttribute("class");
  } else {
    c.className = a;
  }
}
function rb(e, a, f, b) {
  if (b) {
    if (Array.isArray(f)) {
      e["$$" + a] = f[0];
      e["$$" + a + "Data"] = f[1];
    } else {
      e["$$" + a] = f;
    }
  } else if (Array.isArray(f)) {
    const c = f[0];
    e.addEventListener(a, f[0] = a => c.call(e, f[1], a));
  } else {
    e.addEventListener(a, f);
  }
}
function sb(d, a, b = undefined) {
  if (b === undefined) b = {};
  const i = Object.keys(a || {});
  const j = Object.keys(b);
  let k;
  let e;
  k = 0;
  e = j.length;
  for (; k < e; k++) {
    const c = j[k];
    if (!!c && c !== "undefined" && !a[c]) {
      yb(d, c, false);
      delete b[c];
    }
  }
  k = 0;
  e = i.length;
  for (; k < e; k++) {
    const c = i[k];
    const e = !!a[c];
    if (!!c && c !== "undefined" && b[c] !== e && !!e) {
      yb(d, c, true);
      b[c] = e;
    }
  }
  return b;
}
function tb(d, a, h) {
  if (!a) {
    if (h) {
      return ob(d, "style");
    } else {
      return a;
    }
  }
  const i = d.style;
  if (typeof a == "string") {
    return i.cssText = a;
  }
  if (typeof h == "string") {
    i.cssText = h = undefined;
  }
  h ||= {};
  a ||= {};
  let e;
  let j;
  for (j in h) {
    if (a[j] == null) {
      i.removeProperty(j);
    }
    delete h[j];
  }
  for (j in a) {
    e = a[j];
    if (e !== h[j]) {
      i.setProperty(j, e);
      h[j] = e;
    }
  }
  return h;
}
function ub(e, a = undefined, g, c) {
  if (a === undefined) a = {};
  const d = {};
  if (!c) {
    p(() => d.children = Bb(e, a.children, d.children));
  }
  p(() => a.ref && a.ref(e));
  p(() => wb(e, a, g, true, d, true));
  return d;
}
function vb(d, a, b) {
  return q(() => d(a, b));
}
function oa(e, a, b, c) {
  if (b !== undefined && !c) {
    c = [];
  }
  if (typeof a != "function") {
    return Bb(e, a, c, b);
  }
  p(c => Bb(e, a(), c, b), c);
}
function wb(g, a, j, c, d = undefined, k = false) {
  if (d === undefined) d = {};
  a ||= {};
  for (const b in d) {
    if (!(b in a)) {
      if (b === "children") {
        continue;
      }
      d[b] = zb(g, b, null, d[b], j, k);
    }
  }
  for (const b in a) {
    if (b === "children") {
      if (!c) {
        Bb(g, a.children);
      }
      continue;
    }
    const e = a[b];
    d[b] = zb(g, b, e, d[b], j, k);
  }
}
function xb(b) {
  return b.toLowerCase().replace(/-([a-z])/g, (c, a) => a.toUpperCase());
}
function yb(d, a, b) {
  const c = a.trim().split(/\s+/);
  for (let e = 0, f = c.length; e < f; e++) {
    d.classList.toggle(c[e], b);
  }
}
function zb(g, a, m, c, n, d) {
  let e;
  let f;
  let o;
  let p;
  let q;
  if (a === "style") {
    return tb(g, m, c);
  }
  if (a === "classList") {
    return sb(g, m, c);
  }
  if (m === c) {
    return c;
  }
  if (a === "ref") {
    if (!d) {
      m(g);
    }
  } else if (a.slice(0, 3) === "on:") {
    const b = a.slice(3);
    if (c) {
      g.removeEventListener(b, c);
    }
    if (m) {
      g.addEventListener(b, m);
    }
  } else if (a.slice(0, 10) === "oncapture:") {
    const b = a.slice(10);
    if (c) {
      g.removeEventListener(b, c, true);
    }
    if (m) {
      g.addEventListener(b, m, true);
    }
  } else if (a.slice(0, 2) === "on") {
    const d = a.slice(2).toLowerCase();
    const b = gb.has(d);
    if (!b && c) {
      const a = Array.isArray(c) ? c[0] : c;
      g.removeEventListener(d, a);
    }
    if (b || m) {
      rb(g, d, m, b);
      if (b) {
        nb([d]);
      }
    }
  } else if (a.slice(0, 5) === "attr:") {
    ob(g, a.slice(5), m);
  } else if ((q = a.slice(0, 5) === "prop:") || (o = cb.has(a)) || !n && ((p = fb(a, g.tagName)) || (f = bb.has(a))) || (e = g.nodeName.includes("-"))) {
    if (q) {
      a = a.slice(5);
      f = true;
    }
    if (a === "class" || a === "className") {
      qb(g, m);
    } else if (e && !f && !o) {
      g[xb(a)] = m;
    } else {
      g[p || a] = m;
    }
  } else {
    const b = n && a.indexOf(":") > -1 && ib[a.split(":")[0]];
    if (b) {
      pb(g, b, a, m);
    } else {
      ob(g, db[a] || a, m);
    }
  }
  return m;
}
function Ab(b) {
  const a = "$$" + b.type;
  let c = b.composedPath && b.composedPath()[0] || b.target;
  if (b.target !== c) {
    Object.defineProperty(b, "target", {
      configurable: true,
      value: c
    });
  }
  Object.defineProperty(b, "currentTarget", {
    configurable: true,
    get() {
      return c || document;
    }
  });
  while (c) {
    const d = c[a];
    if (d && !c.disabled) {
      const e = c[a + "Data"];
      if (e !== undefined) {
        d.call(c, e, b);
      } else {
        d.call(c, b);
      }
      if (b.cancelBubble) {
        return;
      }
    }
    c = c._$host || c.parentNode || c.host;
  }
}
function Bb(f, j, k, i, d) {
  while (typeof k == "function") {
    k = k();
  }
  if (j === k) {
    return k;
  }
  const e = typeof j;
  const g = i !== undefined;
  f = g && k[0] && k[0].parentNode || f;
  if (e === "string" || e === "number") {
    if (e === "number") {
      j = j.toString();
    }
    if (g) {
      let a = k[0];
      if (a && a.nodeType === 3) {
        a.data = j;
      } else {
        a = document.createTextNode(j);
      }
      k = Eb(f, k, i, a);
    } else if (k !== "" && typeof k == "string") {
      k = f.firstChild.data = j;
    } else {
      k = f.textContent = j;
    }
  } else if (j == null || e === "boolean") {
    k = Eb(f, k, i);
  } else {
    if (e === "function") {
      p(() => {
        let a = j();
        while (typeof a == "function") {
          a = a();
        }
        k = Bb(f, a, k, i);
      });
      return () => k;
    }
    if (Array.isArray(j)) {
      const a = [];
      const b = k && Array.isArray(k);
      if (Cb(a, j, k, d)) {
        p(() => k = Bb(f, a, k, i, true));
        return () => k;
      }
      if (a.length === 0) {
        k = Eb(f, k, i);
        if (g) {
          return k;
        }
      } else if (b) {
        if (k.length === 0) {
          Db(f, a, i);
        } else {
          jb(f, k, a);
        }
      } else {
        if (k) {
          Eb(f);
        }
        Db(f, a);
      }
      k = a;
    } else if (j.nodeType) {
      if (Array.isArray(k)) {
        if (g) {
          return k = Eb(f, k, i, j);
        }
        Eb(f, k, null, j);
      } else if (k == null || k === "" || !f.firstChild) {
        f.appendChild(j);
      } else {
        f.replaceChild(j, f.firstChild);
      }
      k = j;
    } else {
      console.warn("Unrecognized value. Skipped inserting", j);
    }
  }
  return k;
}
function Cb(e, a, b, c) {
  let d = false;
  for (let f = 0, g = a.length; f < g; f++) {
    let g = a[f];
    let h = b && b[f];
    let i;
    if (g != null && g !== true && g !== false) {
      if ((i = typeof g) == "object" && g.nodeType) {
        e.push(g);
      } else if (Array.isArray(g)) {
        d = Cb(e, g, h) || d;
      } else if (i === "function") {
        if (c) {
          while (typeof g == "function") {
            g = g();
          }
          d = Cb(e, Array.isArray(g) ? g : [g], Array.isArray(h) ? h : [h]) || d;
        } else {
          e.push(g);
          d = true;
        }
      } else {
        const a = String(g);
        if (h && h.nodeType === 3 && h.data === a) {
          e.push(h);
        } else {
          e.push(document.createTextNode(a));
        }
      }
    }
  }
  return d;
}
function Db(d, a, b = null) {
  for (let c = 0, e = a.length; c < e; c++) {
    d.insertBefore(a[c], b);
  }
}
function Eb(e, a, b, c) {
  if (b === undefined) {
    return e.textContent = "";
  }
  const i = c || document.createTextNode("");
  if (a.length) {
    let c = false;
    for (let d = a.length - 1; d >= 0; d--) {
      const f = a[d];
      if (i !== f) {
        const a = f.parentNode === e;
        if (!c && !d) {
          if (a) {
            e.replaceChild(i, f);
          } else {
            e.insertBefore(i, b);
          }
        } else if (a) {
          f.remove();
        }
      } else {
        c = true;
      }
    }
  } else {
    e.insertBefore(i, b);
  }
  return [i];
}
const ja = "http://www.w3.org/2000/svg";
function Fb(c, a = false) {
  if (a) {
    return document.createElementNS(ja, c);
  } else {
    return document.createElement(c);
  }
}
function Gb(b) {
  const [c, g] = ia(b, ["component"]);
  const e = s(() => c.component);
  return s(() => {
    const c = e();
    switch (typeof c) {
      case "function":
        Object.assign(c, {
          [a]: true
        });
        return q(() => c(g));
      case "string":
        const d = hb.has(c);
        const b = Fb(c, d);
        ub(b, g, d);
        return b;
    }
  });
}
var Hb = typeof globalThis !== "undefined" ? globalThis : typeof window !== "undefined" ? window : typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : {};
function Ib(b) {
  if (b && b.__esModule && Object.prototype.hasOwnProperty.call(b, "default")) {
    return b.default;
  } else {
    return b;
  }
}
var Jb = {};
var Kb = {
  byteLength: Pb,
  toByteArray: Rb,
  fromByteArray: Ub
};
var Lb = [];
var Za = [];
var la = typeof Uint8Array !== "undefined" ? Uint8Array : Array;
var Mb = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
for (var Nb = 0, Ob = Mb.length; Nb < Ob; ++Nb) {
  Lb[Nb] = Mb[Nb];
  Za[Mb.charCodeAt(Nb)] = Nb;
}
Za["-".charCodeAt(0)] = 62;
Za["_".charCodeAt(0)] = 63;
function pa(b) {
  var a = b.length;
  if (a % 4 > 0) {
    throw new Error("Invalid string. Length must be a multiple of 4");
  }
  var c = b.indexOf("=");
  if (c === -1) {
    c = a;
  }
  var f = c === a ? 0 : 4 - c % 4;
  return [c, f];
}
function Pb(e) {
  var a = pa(e);
  var b = a[0];
  var c = a[1];
  return (b + c) * 3 / 4 - c;
}
function Qb(d, a, b) {
  return (a + b) * 3 / 4 - b;
}
function Rb(b) {
  var a;
  var k = pa(b);
  var d = k[0];
  var e = k[1];
  var f = new la(Qb(b, d, e));
  var g = 0;
  var l = e > 0 ? d - 4 : d;
  var i;
  for (i = 0; i < l; i += 4) {
    a = Za[b.charCodeAt(i)] << 18 | Za[b.charCodeAt(i + 1)] << 12 | Za[b.charCodeAt(i + 2)] << 6 | Za[b.charCodeAt(i + 3)];
    f[g++] = a >> 16 & 255;
    f[g++] = a >> 8 & 255;
    f[g++] = a & 255;
  }
  if (e === 2) {
    a = Za[b.charCodeAt(i)] << 2 | Za[b.charCodeAt(i + 1)] >> 4;
    f[g++] = a & 255;
  }
  if (e === 1) {
    a = Za[b.charCodeAt(i)] << 10 | Za[b.charCodeAt(i + 1)] << 4 | Za[b.charCodeAt(i + 2)] >> 2;
    f[g++] = a >> 8 & 255;
    f[g++] = a & 255;
  }
  return f;
}
function Sb(b) {
  return Lb[b >> 18 & 63] + Lb[b >> 12 & 63] + Lb[b >> 6 & 63] + Lb[b & 63];
}
function Tb(d, a, b) {
  var c;
  var h = [];
  for (var f = a; f < b; f += 3) {
    c = (d[f] << 16 & 16711680) + (d[f + 1] << 8 & 65280) + (d[f + 2] & 255);
    h.push(Sb(c));
  }
  return h.join("");
}
function Ub(b) {
  var a;
  var j = b.length;
  var d = j % 3;
  var e = [];
  for (var f = 16383, g = 0, k = j - d; g < k; g += f) {
    e.push(Tb(b, g, g + f > k ? k : g + f));
  }
  if (d === 1) {
    a = b[j - 1];
    e.push(Lb[a >> 2] + Lb[a << 4 & 63] + "==");
  } else if (d === 2) {
    a = (b[j - 2] << 8) + b[j - 1];
    e.push(Lb[a >> 10] + Lb[a >> 4 & 63] + Lb[a << 2 & 63] + "=");
  }
  return e.join("");
}
var Vb = {};
Vb.read = function (f, a, b, c, d) {
  var e;
  var p;
  var q = d * 8 - c - 1;
  var i = (1 << q) - 1;
  var j = i >> 1;
  var k = -7;
  var r = b ? d - 1 : 0;
  var s = b ? -1 : 1;
  var n = f[a + r];
  r += s;
  e = n & (1 << -k) - 1;
  n >>= -k;
  k += q;
  for (; k > 0; k -= 8) {
    e = e * 256 + f[a + r];
    r += s;
  }
  p = e & (1 << -k) - 1;
  e >>= -k;
  k += c;
  for (; k > 0; k -= 8) {
    p = p * 256 + f[a + r];
    r += s;
  }
  if (e === 0) {
    e = 1 - j;
  } else {
    if (e === i) {
      if (p) {
        return NaN;
      } else {
        return (n ? -1 : 1) * Infinity;
      }
    }
    p = p + Math.pow(2, c);
    e = e - j;
  }
  return (n ? -1 : 1) * p * Math.pow(2, e - c);
};
Vb.write = function (g, a, r, c, d, s) {
  var f;
  var t;
  var u;
  var v = s * 8 - d - 1;
  var w = (1 << v) - 1;
  var l = w >> 1;
  var m = d === 23 ? Math.pow(2, -24) - Math.pow(2, -77) : 0;
  var n = c ? 0 : s - 1;
  var x = c ? 1 : -1;
  var p = a < 0 || a === 0 && 1 / a < 0 ? 1 : 0;
  a = Math.abs(a);
  if (isNaN(a) || a === Infinity) {
    t = isNaN(a) ? 1 : 0;
    f = w;
  } else {
    f = Math.floor(Math.log(a) / Math.LN2);
    if (a * (u = Math.pow(2, -f)) < 1) {
      f--;
      u *= 2;
    }
    if (f + l >= 1) {
      a += m / u;
    } else {
      a += m * Math.pow(2, 1 - l);
    }
    if (a * u >= 2) {
      f++;
      u /= 2;
    }
    if (f + l >= w) {
      t = 0;
      f = w;
    } else if (f + l >= 1) {
      t = (a * u - 1) * Math.pow(2, d);
      f = f + l;
    } else {
      t = a * Math.pow(2, l - 1) * Math.pow(2, d);
      f = 0;
    }
  }
  for (; d >= 8; d -= 8) {
    g[r + n] = t & 255;
    n += x;
    t /= 256;
  }
  f = f << d | t;
  v += d;
  for (; v > 0; v -= 8) {
    g[r + n] = f & 255;
    n += x;
    f /= 256;
  }
  g[r + n - x] |= p * 128;
};
(function (b) {
  var _ = Kb;
  var aa = Vb;
  var a = typeof Symbol == "function" && typeof Symbol.for == "function" ? Symbol.for("nodejs.util.inspect.custom") : null;
  b.Buffer = ca;
  b.SlowBuffer = o;
  b.INSPECT_MAX_BYTES = 50;
  var c = 2147483647;
  b.kMaxLength = c;
  ca.TYPED_ARRAY_SUPPORT = d();
  if (!ca.TYPED_ARRAY_SUPPORT && typeof console !== "undefined" && typeof console.error == "function") {
    console.error("This browser lacks typed array (Uint8Array) support which is required by `buffer` v5.x. Use `buffer` v4.x if you require old browser support.");
  }
  function d() {
    try {
      var a = new Uint8Array(1);
      var b = {
        foo: function () {
          return 42;
        }
      };
      Object.setPrototypeOf(b, Uint8Array.prototype);
      Object.setPrototypeOf(a, b);
      return a.foo() === 42;
    } catch {
      return false;
    }
  }
  Object.defineProperty(ca.prototype, "parent", {
    enumerable: true,
    get: function () {
      if (ca.isBuffer(this)) {
        return this.buffer;
      }
    }
  });
  Object.defineProperty(ca.prototype, "offset", {
    enumerable: true,
    get: function () {
      if (ca.isBuffer(this)) {
        return this.byteOffset;
      }
    }
  });
  function ba(b) {
    if (b > c) {
      throw new RangeError("The value \"" + b + "\" is invalid for option \"size\"");
    }
    var a = new Uint8Array(b);
    Object.setPrototypeOf(a, ca.prototype);
    return a;
  }
  function ca(b, a, c) {
    if (typeof b == "number") {
      if (typeof a == "string") {
        throw new TypeError("The \"string\" argument must be of type string. Received type number");
      }
      return h(b);
    }
    return e(b, a, c);
  }
  ca.poolSize = 8192;
  function e(b, a, c) {
    if (typeof b == "string") {
      return i(b, a);
    }
    if (ArrayBuffer.isView(b)) {
      return k(b);
    }
    if (b == null) {
      throw new TypeError("The first argument must be one of type string, Buffer, ArrayBuffer, Array, or Array-like Object. Received type " + typeof b);
    }
    if (T(b, ArrayBuffer) || b && T(b.buffer, ArrayBuffer) || typeof SharedArrayBuffer !== "undefined" && (T(b, SharedArrayBuffer) || b && T(b.buffer, SharedArrayBuffer))) {
      return l(b, a, c);
    }
    if (typeof b == "number") {
      throw new TypeError("The \"value\" argument must not be of type number. Received type number");
    }
    var d = b.valueOf && b.valueOf();
    if (d != null && d !== b) {
      return ca.from(d, a, c);
    }
    var e = m(b);
    if (e) {
      return e;
    }
    if (typeof Symbol !== "undefined" && Symbol.toPrimitive != null && typeof b[Symbol.toPrimitive] == "function") {
      return ca.from(b[Symbol.toPrimitive]("string"), a, c);
    }
    throw new TypeError("The first argument must be one of type string, Buffer, ArrayBuffer, Array, or Array-like Object. Received type " + typeof b);
  }
  ca.from = function (d, a, b) {
    return e(d, a, b);
  };
  Object.setPrototypeOf(ca.prototype, Uint8Array.prototype);
  Object.setPrototypeOf(ca, Uint8Array);
  function f(b) {
    if (typeof b != "number") {
      throw new TypeError("\"size\" argument must be of type number");
    }
    if (b < 0) {
      throw new RangeError("The value \"" + b + "\" is invalid for option \"size\"");
    }
  }
  function g(b, a, c) {
    f(b);
    if (b <= 0) {
      return ba(b);
    } else if (a !== undefined) {
      if (typeof c == "string") {
        return ba(b).fill(a, c);
      } else {
        return ba(b).fill(a);
      }
    } else {
      return ba(b);
    }
  }
  ca.alloc = function (d, a, b) {
    return g(d, a, b);
  };
  function h(b) {
    f(b);
    return ba(b < 0 ? 0 : n(b) | 0);
  }
  ca.allocUnsafe = function (b) {
    return h(b);
  };
  ca.allocUnsafeSlow = function (b) {
    return h(b);
  };
  function i(b, a) {
    if (typeof a != "string" || a === "") {
      a = "utf8";
    }
    if (!ca.isEncoding(a)) {
      throw new TypeError("Unknown encoding: " + a);
    }
    var d = p(b, a) | 0;
    var e = ba(d);
    var h = e.write(b, a);
    if (h !== d) {
      e = e.slice(0, h);
    }
    return e;
  }
  function j(b) {
    for (var a = b.length < 0 ? 0 : n(b.length) | 0, c = ba(a), d = 0; d < a; d += 1) {
      c[d] = b[d] & 255;
    }
    return c;
  }
  function k(b) {
    if (T(b, Uint8Array)) {
      var a = new Uint8Array(b);
      return l(a.buffer, a.byteOffset, a.byteLength);
    }
    return j(b);
  }
  function l(b, a, c) {
    if (a < 0 || b.byteLength < a) {
      throw new RangeError("\"offset\" is outside of buffer bounds");
    }
    if (b.byteLength < a + (c || 0)) {
      throw new RangeError("\"length\" is outside of buffer bounds");
    }
    var d;
    if (a === undefined && c === undefined) {
      d = new Uint8Array(b);
    } else if (c === undefined) {
      d = new Uint8Array(b, a);
    } else {
      d = new Uint8Array(b, a, c);
    }
    Object.setPrototypeOf(d, ca.prototype);
    return d;
  }
  function m(b) {
    if (ca.isBuffer(b)) {
      var a = n(b.length) | 0;
      var c = ba(a);
      if (c.length !== 0) {
        b.copy(c, 0, 0, a);
      }
      return c;
    }
    if (b.length !== undefined) {
      if (typeof b.length != "number" || U(b.length)) {
        return ba(0);
      } else {
        return j(b);
      }
    }
    if (b.type === "Buffer" && Array.isArray(b.data)) {
      return j(b.data);
    }
  }
  function n(b) {
    if (b >= c) {
      throw new RangeError("Attempt to allocate Buffer larger than maximum size: 0x" + c.toString(16) + " bytes");
    }
    return b | 0;
  }
  function o(b) {
    if (+b != b) {
      b = 0;
    }
    return ca.alloc(+b);
  }
  ca.isBuffer = function (b) {
    return b != null && b._isBuffer === true && b !== ca.prototype;
  };
  ca.compare = function (b, d) {
    if (T(b, Uint8Array)) {
      b = ca.from(b, b.offset, b.byteLength);
    }
    if (T(d, Uint8Array)) {
      d = ca.from(d, d.offset, d.byteLength);
    }
    if (!ca.isBuffer(b) || !ca.isBuffer(d)) {
      throw new TypeError("The \"buf1\", \"buf2\" arguments must be one of type Buffer or Uint8Array");
    }
    if (b === d) {
      return 0;
    }
    var i = b.length;
    var j = d.length;
    for (var k = 0, l = Math.min(i, j); k < l; ++k) {
      if (b[k] !== d[k]) {
        i = b[k];
        j = d[k];
        break;
      }
    }
    if (i < j) {
      return -1;
    } else if (j < i) {
      return 1;
    } else {
      return 0;
    }
  };
  ca.isEncoding = function (b) {
    switch (String(b).toLowerCase()) {
      case "hex":
      case "utf8":
      case "utf-8":
      case "ascii":
      case "latin1":
      case "binary":
      case "base64":
      case "ucs2":
      case "ucs-2":
      case "utf16le":
      case "utf-16le":
        return true;
      default:
        return false;
    }
  };
  ca.concat = function (b, a) {
    if (!Array.isArray(b)) {
      throw new TypeError("\"list\" argument must be an Array of Buffers");
    }
    if (b.length === 0) {
      return ca.alloc(0);
    }
    var d;
    if (a === undefined) {
      a = 0;
      d = 0;
      for (; d < b.length; ++d) {
        a += b[d].length;
      }
    }
    var i = ca.allocUnsafe(a);
    var f = 0;
    for (d = 0; d < b.length; ++d) {
      var j = b[d];
      if (T(j, Uint8Array)) {
        if (f + j.length > i.length) {
          ca.from(j).copy(i, f);
        } else {
          Uint8Array.prototype.set.call(i, j, f);
        }
      } else if (ca.isBuffer(j)) {
        j.copy(i, f);
      } else {
        throw new TypeError("\"list\" argument must be an Array of Buffers");
      }
      f += j.length;
    }
    return i;
  };
  function p(b, a) {
    if (ca.isBuffer(b)) {
      return b.length;
    }
    if (ArrayBuffer.isView(b) || T(b, ArrayBuffer)) {
      return b.byteLength;
    }
    if (typeof b != "string") {
      throw new TypeError("The \"string\" argument must be one of type string, Buffer, or ArrayBuffer. Received type " + typeof b);
    }
    var d = b.length;
    var e = arguments.length > 2 && arguments[2] === true;
    if (!e && d === 0) {
      return 0;
    }
    var f = false;
    while (true) {
      switch (a) {
        case "ascii":
        case "latin1":
        case "binary":
          return d;
        case "utf8":
        case "utf-8":
          return O(b).length;
        case "ucs2":
        case "ucs-2":
        case "utf16le":
        case "utf-16le":
          return d * 2;
        case "hex":
          return d >>> 1;
        case "base64":
          return R(b).length;
        default:
          if (f) {
            if (e) {
              return -1;
            } else {
              return O(b).length;
            }
          }
          a = ("" + a).toLowerCase();
          f = true;
      }
    }
  }
  ca.byteLength = p;
  function q(b, e, g) {
    var h = false;
    if (e === undefined || e < 0) {
      e = 0;
    }
    if (e > this.length || ((g === undefined || g > this.length) && (g = this.length), g <= 0) || (g >>>= 0, e >>>= 0, g <= e)) {
      return "";
    }
    for (b ||= "utf8";;) {
      switch (b) {
        case "hex":
          return F(this, e, g);
        case "utf8":
        case "utf-8":
          return A(this, e, g);
        case "ascii":
          return D(this, e, g);
        case "latin1":
        case "binary":
          return E(this, e, g);
        case "base64":
          return z(this, e, g);
        case "ucs2":
        case "ucs-2":
        case "utf16le":
        case "utf-16le":
          return G(this, e, g);
        default:
          if (h) {
            throw new TypeError("Unknown encoding: " + b);
          }
          b = (b + "").toLowerCase();
          h = true;
      }
    }
  }
  ca.prototype._isBuffer = true;
  function r(e, a, b) {
    var c = e[a];
    e[a] = e[b];
    e[b] = c;
  }
  ca.prototype.swap16 = function () {
    var a = this.length;
    if (a % 2 !== 0) {
      throw new RangeError("Buffer size must be a multiple of 16-bits");
    }
    for (var b = 0; b < a; b += 2) {
      r(this, b, b + 1);
    }
    return this;
  };
  ca.prototype.swap32 = function () {
    var a = this.length;
    if (a % 4 !== 0) {
      throw new RangeError("Buffer size must be a multiple of 32-bits");
    }
    for (var b = 0; b < a; b += 4) {
      r(this, b, b + 3);
      r(this, b + 1, b + 2);
    }
    return this;
  };
  ca.prototype.swap64 = function () {
    var a = this.length;
    if (a % 8 !== 0) {
      throw new RangeError("Buffer size must be a multiple of 64-bits");
    }
    for (var b = 0; b < a; b += 8) {
      r(this, b, b + 7);
      r(this, b + 1, b + 6);
      r(this, b + 2, b + 5);
      r(this, b + 3, b + 4);
    }
    return this;
  };
  ca.prototype.toString = function () {
    var a = this.length;
    if (a === 0) {
      return "";
    } else if (arguments.length === 0) {
      return A(this, 0, a);
    } else {
      return q.apply(this, arguments);
    }
  };
  ca.prototype.toLocaleString = ca.prototype.toString;
  ca.prototype.equals = function (b) {
    if (!ca.isBuffer(b)) {
      throw new TypeError("Argument must be a Buffer");
    }
    if (this === b) {
      return true;
    } else {
      return ca.compare(this, b) === 0;
    }
  };
  ca.prototype.inspect = function () {
    var a = "";
    var c = b.INSPECT_MAX_BYTES;
    a = this.toString("hex", 0, c).replace(/(.{2})/g, "$1 ").trim();
    if (this.length > c) {
      a += " ... ";
    }
    return "<Buffer " + a + ">";
  };
  if (a) {
    ca.prototype[a] = ca.prototype.inspect;
  }
  ca.prototype.compare = function (b, g, i, o, p) {
    if (T(b, Uint8Array)) {
      b = ca.from(b, b.offset, b.byteLength);
    }
    if (!ca.isBuffer(b)) {
      throw new TypeError("The \"target\" argument must be one of type Buffer or Uint8Array. Received type " + typeof b);
    }
    if (g === undefined) {
      g = 0;
    }
    if (i === undefined) {
      i = b ? b.length : 0;
    }
    if (o === undefined) {
      o = 0;
    }
    if (p === undefined) {
      p = this.length;
    }
    if (g < 0 || i > b.length || o < 0 || p > this.length) {
      throw new RangeError("out of range index");
    }
    if (o >= p && g >= i) {
      return 0;
    }
    if (o >= p) {
      return -1;
    }
    if (g >= i) {
      return 1;
    }
    g >>>= 0;
    i >>>= 0;
    o >>>= 0;
    p >>>= 0;
    if (this === b) {
      return 0;
    }
    var q = p - o;
    var r = i - g;
    for (var s = Math.min(q, r), k = this.slice(o, p), l = b.slice(g, i), m = 0; m < s; ++m) {
      if (k[m] !== l[m]) {
        q = k[m];
        r = l[m];
        break;
      }
    }
    if (q < r) {
      return -1;
    } else if (r < q) {
      return 1;
    } else {
      return 0;
    }
  };
  function s(b, a, g, h, i) {
    if (b.length === 0) {
      return -1;
    }
    if (typeof g == "string") {
      h = g;
      g = 0;
    } else if (g > 2147483647) {
      g = 2147483647;
    } else if (g < -2147483648) {
      g = -2147483648;
    }
    g = +g;
    if (U(g)) {
      g = i ? 0 : b.length - 1;
    }
    if (g < 0) {
      g = b.length + g;
    }
    if (g >= b.length) {
      if (i) {
        return -1;
      }
      g = b.length - 1;
    } else if (g < 0) {
      if (i) {
        g = 0;
      } else {
        return -1;
      }
    }
    if (typeof a == "string") {
      a = ca.from(a, h);
    }
    if (ca.isBuffer(a)) {
      if (a.length === 0) {
        return -1;
      } else {
        return t(b, a, g, h, i);
      }
    }
    if (typeof a == "number") {
      a = a & 255;
      if (typeof Uint8Array.prototype.indexOf == "function") {
        if (i) {
          return Uint8Array.prototype.indexOf.call(b, a, g);
        } else {
          return Uint8Array.prototype.lastIndexOf.call(b, a, g);
        }
      } else {
        return t(b, [a], g, h, i);
      }
    }
    throw new TypeError("val must be string, number or Buffer");
  }
  function t(b, a, c, g, p) {
    var f = 1;
    var q = b.length;
    var r = a.length;
    if (g !== undefined && (g = String(g).toLowerCase(), g === "ucs2" || g === "ucs-2" || g === "utf16le" || g === "utf-16le")) {
      if (b.length < 2 || a.length < 2) {
        return -1;
      }
      f = 2;
      q /= 2;
      r /= 2;
      c /= 2;
    }
    function s(c, a) {
      if (f === 1) {
        return c[a];
      } else {
        return c.readUInt16BE(a * f);
      }
    }
    var k;
    if (p) {
      var t = -1;
      for (k = c; k < q; k++) {
        if (s(b, k) === s(a, t === -1 ? 0 : k - t)) {
          if (t === -1) {
            t = k;
          }
          if (k - t + 1 === r) {
            return t * f;
          }
        } else {
          if (t !== -1) {
            k -= k - t;
          }
          t = -1;
        }
      }
    } else {
      if (c + r > q) {
        c = q - r;
      }
      k = c;
      for (; k >= 0; k--) {
        var u = true;
        for (var v = 0; v < r; v++) {
          if (s(b, k + v) !== s(a, v)) {
            u = false;
            break;
          }
        }
        if (u) {
          return k;
        }
      }
    }
    return -1;
  }
  ca.prototype.includes = function (d, a, b) {
    return this.indexOf(d, a, b) !== -1;
  };
  ca.prototype.indexOf = function (d, a, b) {
    return s(this, d, a, b, true);
  };
  ca.prototype.lastIndexOf = function (d, a, b) {
    return s(this, d, a, b, false);
  };
  function u(b, a, c, f) {
    c = Number(c) || 0;
    var k = b.length - c;
    if (f) {
      f = Number(f);
      if (f > k) {
        f = k;
      }
    } else {
      f = k;
    }
    var g = a.length;
    if (f > g / 2) {
      f = g / 2;
    }
    for (var h = 0; h < f; ++h) {
      var l = parseInt(a.substr(h * 2, 2), 16);
      if (U(l)) {
        return h;
      }
      b[c + h] = l;
    }
    return h;
  }
  function v(b, a, c, d) {
    return S(O(a, b.length - c), b, c, d);
  }
  function w(e, a, b, c) {
    return S(P(a), e, b, c);
  }
  function x(e, a, b, c) {
    return S(R(a), e, b, c);
  }
  function y(b, a, c, d) {
    return S(Q(a, b.length - c), b, c, d);
  }
  ca.prototype.write = function (b, a, f, i) {
    if (a === undefined) {
      i = "utf8";
      f = this.length;
      a = 0;
    } else if (f === undefined && typeof a == "string") {
      i = a;
      f = this.length;
      a = 0;
    } else if (isFinite(a)) {
      a = a >>> 0;
      if (isFinite(f)) {
        f = f >>> 0;
        if (i === undefined) {
          i = "utf8";
        }
      } else {
        i = f;
        f = undefined;
      }
    } else {
      throw new Error("Buffer.write(string, encoding, offset[, length]) is no longer supported");
    }
    var j = this.length - a;
    if (f === undefined || f > j) {
      f = j;
    }
    if (b.length > 0 && (f < 0 || a < 0) || a > this.length) {
      throw new RangeError("Attempt to write outside buffer bounds");
    }
    i ||= "utf8";
    var g = false;
    while (true) {
      switch (i) {
        case "hex":
          return u(this, b, a, f);
        case "utf8":
        case "utf-8":
          return v(this, b, a, f);
        case "ascii":
        case "latin1":
        case "binary":
          return w(this, b, a, f);
        case "base64":
          return x(this, b, a, f);
        case "ucs2":
        case "ucs-2":
        case "utf16le":
        case "utf-16le":
          return y(this, b, a, f);
        default:
          if (g) {
            throw new TypeError("Unknown encoding: " + i);
          }
          i = ("" + i).toLowerCase();
          g = true;
      }
    }
  };
  ca.prototype.toJSON = function () {
    return {
      type: "Buffer",
      data: Array.prototype.slice.call(this._arr || this, 0)
    };
  };
  function z(b, a, c) {
    if (a === 0 && c === b.length) {
      return _.fromByteArray(b);
    } else {
      return _.fromByteArray(b.slice(a, c));
    }
  }
  function A(b, a, c) {
    c = Math.min(b.length, c);
    var e = [];
    for (var f = a; f < c;) {
      var o = b[f];
      var p = null;
      var q = o > 239 ? 4 : o > 223 ? 3 : o > 191 ? 2 : 1;
      if (f + q <= c) {
        var r;
        var s;
        var t;
        var u;
        switch (q) {
          case 1:
            if (o < 128) {
              p = o;
            }
            break;
          case 2:
            r = b[f + 1];
            if ((r & 192) === 128) {
              u = (o & 31) << 6 | r & 63;
              if (u > 127) {
                p = u;
              }
            }
            break;
          case 3:
            r = b[f + 1];
            s = b[f + 2];
            if ((r & 192) === 128 && (s & 192) === 128) {
              u = (o & 15) << 12 | (r & 63) << 6 | s & 63;
              if (u > 2047 && (u < 55296 || u > 57343)) {
                p = u;
              }
            }
            break;
          case 4:
            r = b[f + 1];
            s = b[f + 2];
            t = b[f + 3];
            if ((r & 192) === 128 && (s & 192) === 128 && (t & 192) === 128) {
              u = (o & 15) << 18 | (r & 63) << 12 | (s & 63) << 6 | t & 63;
              if (u > 65535 && u < 1114112) {
                p = u;
              }
            }
        }
      }
      if (p === null) {
        p = 65533;
        q = 1;
      } else if (p > 65535) {
        p -= 65536;
        e.push(p >>> 10 & 1023 | 55296);
        p = p & 1023 | 56320;
      }
      e.push(p);
      f += q;
    }
    return C(e);
  }
  var B = 4096;
  function C(b) {
    var a = b.length;
    if (a <= B) {
      return String.fromCharCode.apply(String, b);
    }
    var c = "";
    for (var d = 0; d < a;) {
      c += String.fromCharCode.apply(String, b.slice(d, d += B));
    }
    return c;
  }
  function D(b, a, c) {
    var e = "";
    c = Math.min(b.length, c);
    for (var h = a; h < c; ++h) {
      e += String.fromCharCode(b[h] & 127);
    }
    return e;
  }
  function E(b, a, c) {
    var e = "";
    c = Math.min(b.length, c);
    for (var h = a; h < c; ++h) {
      e += String.fromCharCode(b[h]);
    }
    return e;
  }
  function F(b, a, e) {
    var i = b.length;
    if (!a || a < 0) {
      a = 0;
    }
    if (!e || e < 0 || e > i) {
      e = i;
    }
    var f = "";
    for (var j = a; j < e; ++j) {
      f += V[b[j]];
    }
    return f;
  }
  function G(b, a, c) {
    for (var d = b.slice(a, c), e = "", f = 0; f < d.length - 1; f += 2) {
      e += String.fromCharCode(d[f] + d[f + 1] * 256);
    }
    return e;
  }
  ca.prototype.slice = function (b, d) {
    var g = this.length;
    b = ~~b;
    d = d === undefined ? g : ~~d;
    if (b < 0) {
      b += g;
      if (b < 0) {
        b = 0;
      }
    } else if (b > g) {
      b = g;
    }
    if (d < 0) {
      d += g;
      if (d < 0) {
        d = 0;
      }
    } else if (d > g) {
      d = g;
    }
    if (d < b) {
      d = b;
    }
    var e = this.subarray(b, d);
    Object.setPrototypeOf(e, ca.prototype);
    return e;
  };
  function H(b, a, c) {
    if (b % 1 !== 0 || b < 0) {
      throw new RangeError("offset is not uint");
    }
    if (b + a > c) {
      throw new RangeError("Trying to access beyond buffer length");
    }
  }
  ca.prototype.readUintLE = ca.prototype.readUIntLE = function (b, e, i) {
    b = b >>> 0;
    e = e >>> 0;
    if (!i) {
      H(b, e, this.length);
    }
    var d = this[b];
    for (var j = 1, k = 0; ++k < e && (j *= 256);) {
      d += this[b + k] * j;
    }
    return d;
  };
  ca.prototype.readUintBE = ca.prototype.readUIntBE = function (b, e, h) {
    b = b >>> 0;
    e = e >>> 0;
    if (!h) {
      H(b, e, this.length);
    }
    var d = this[b + --e];
    for (var i = 1; e > 0 && (i *= 256);) {
      d += this[b + --e] * i;
    }
    return d;
  };
  ca.prototype.readUint8 = ca.prototype.readUInt8 = function (c, d) {
    c = c >>> 0;
    if (!d) {
      H(c, 1, this.length);
    }
    return this[c];
  };
  ca.prototype.readUint16LE = ca.prototype.readUInt16LE = function (c, d) {
    c = c >>> 0;
    if (!d) {
      H(c, 2, this.length);
    }
    return this[c] | this[c + 1] << 8;
  };
  ca.prototype.readUint16BE = ca.prototype.readUInt16BE = function (c, d) {
    c = c >>> 0;
    if (!d) {
      H(c, 2, this.length);
    }
    return this[c] << 8 | this[c + 1];
  };
  ca.prototype.readUint32LE = ca.prototype.readUInt32LE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 4, this.length);
    }
    return (this[b] | this[b + 1] << 8 | this[b + 2] << 16) + this[b + 3] * 16777216;
  };
  ca.prototype.readUint32BE = ca.prototype.readUInt32BE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 4, this.length);
    }
    return this[b] * 16777216 + (this[b + 1] << 16 | this[b + 2] << 8 | this[b + 3]);
  };
  ca.prototype.readIntLE = function (b, e, i) {
    b = b >>> 0;
    e = e >>> 0;
    if (!i) {
      H(b, e, this.length);
    }
    var d = this[b];
    for (var j = 1, k = 0; ++k < e && (j *= 256);) {
      d += this[b + k] * j;
    }
    j *= 128;
    if (d >= j) {
      d -= Math.pow(2, e * 8);
    }
    return d;
  };
  ca.prototype.readIntBE = function (b, e, i) {
    b = b >>> 0;
    e = e >>> 0;
    if (!i) {
      H(b, e, this.length);
    }
    for (var d = e, j = 1, k = this[b + --d]; d > 0 && (j *= 256);) {
      k += this[b + --d] * j;
    }
    j *= 128;
    if (k >= j) {
      k -= Math.pow(2, e * 8);
    }
    return k;
  };
  ca.prototype.readInt8 = function (c, d) {
    c = c >>> 0;
    if (!d) {
      H(c, 1, this.length);
    }
    if (this[c] & 128) {
      return (255 - this[c] + 1) * -1;
    } else {
      return this[c];
    }
  };
  ca.prototype.readInt16LE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 2, this.length);
    }
    var c = this[b] | this[b + 1] << 8;
    if (c & 32768) {
      return c | 4294901760;
    } else {
      return c;
    }
  };
  ca.prototype.readInt16BE = function (d, e) {
    d = d >>> 0;
    if (!e) {
      H(d, 2, this.length);
    }
    var b = this[d + 1] | this[d] << 8;
    if (b & 32768) {
      return b | 4294901760;
    } else {
      return b;
    }
  };
  ca.prototype.readInt32LE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 4, this.length);
    }
    return this[b] | this[b + 1] << 8 | this[b + 2] << 16 | this[b + 3] << 24;
  };
  ca.prototype.readInt32BE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 4, this.length);
    }
    return this[b] << 24 | this[b + 1] << 16 | this[b + 2] << 8 | this[b + 3];
  };
  ca.prototype.readFloatLE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 4, this.length);
    }
    return aa.read(this, b, true, 23, 4);
  };
  ca.prototype.readFloatBE = function (c, d) {
    c = c >>> 0;
    if (!d) {
      H(c, 4, this.length);
    }
    return aa.read(this, c, false, 23, 4);
  };
  ca.prototype.readDoubleLE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 8, this.length);
    }
    return aa.read(this, b, true, 52, 8);
  };
  ca.prototype.readDoubleBE = function (b, d) {
    b = b >>> 0;
    if (!d) {
      H(b, 8, this.length);
    }
    return aa.read(this, b, false, 52, 8);
  };
  function I(b, a, c, d, e, f) {
    if (!ca.isBuffer(b)) {
      throw new TypeError("\"buffer\" argument must be a Buffer instance");
    }
    if (a > e || a < f) {
      throw new RangeError("\"value\" argument is out of bounds");
    }
    if (c + d > b.length) {
      throw new RangeError("Index out of range");
    }
  }
  ca.prototype.writeUintLE = ca.prototype.writeUIntLE = function (b, f, j, k) {
    b = +b;
    f = f >>> 0;
    j = j >>> 0;
    if (!k) {
      var e = Math.pow(2, j * 8) - 1;
      I(this, b, f, j, e, 0);
    }
    var g = 1;
    var l = 0;
    for (this[f] = b & 255; ++l < j && (g *= 256);) {
      this[f + l] = b / g & 255;
    }
    return f + j;
  };
  ca.prototype.writeUintBE = ca.prototype.writeUIntBE = function (h, i, j, k) {
    h = +h;
    i = i >>> 0;
    j = j >>> 0;
    if (!k) {
      var d = Math.pow(2, j * 8) - 1;
      I(this, h, i, j, d, 0);
    }
    var e = j - 1;
    var l = 1;
    for (this[i + e] = h & 255; --e >= 0 && (l *= 256);) {
      this[i + e] = h / l & 255;
    }
    return i + j;
  };
  ca.prototype.writeUint8 = ca.prototype.writeUInt8 = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 1, 255, 0);
    }
    this[e] = d & 255;
    return e + 1;
  };
  ca.prototype.writeUint16LE = ca.prototype.writeUInt16LE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 2, 65535, 0);
    }
    this[e] = d & 255;
    this[e + 1] = d >>> 8;
    return e + 2;
  };
  ca.prototype.writeUint16BE = ca.prototype.writeUInt16BE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 2, 65535, 0);
    }
    this[e] = d >>> 8;
    this[e + 1] = d & 255;
    return e + 2;
  };
  ca.prototype.writeUint32LE = ca.prototype.writeUInt32LE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 4, 4294967295, 0);
    }
    this[e + 3] = d >>> 24;
    this[e + 2] = d >>> 16;
    this[e + 1] = d >>> 8;
    this[e] = d & 255;
    return e + 4;
  };
  ca.prototype.writeUint32BE = ca.prototype.writeUInt32BE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 4, 4294967295, 0);
    }
    this[e] = d >>> 24;
    this[e + 1] = d >>> 16;
    this[e + 2] = d >>> 8;
    this[e + 3] = d & 255;
    return e + 4;
  };
  ca.prototype.writeIntLE = function (b, f, k, d) {
    b = +b;
    f = f >>> 0;
    if (!d) {
      var e = Math.pow(2, k * 8 - 1);
      I(this, b, f, k, e - 1, -e);
    }
    var g = 0;
    var l = 1;
    var m = 0;
    for (this[f] = b & 255; ++g < k && (l *= 256);) {
      if (b < 0 && m === 0 && this[f + g - 1] !== 0) {
        m = 1;
      }
      this[f + g] = (b / l >> 0) - m & 255;
    }
    return f + k;
  };
  ca.prototype.writeIntBE = function (b, f, k, d) {
    b = +b;
    f = f >>> 0;
    if (!d) {
      var e = Math.pow(2, k * 8 - 1);
      I(this, b, f, k, e - 1, -e);
    }
    var g = k - 1;
    var l = 1;
    var m = 0;
    for (this[f + g] = b & 255; --g >= 0 && (l *= 256);) {
      if (b < 0 && m === 0 && this[f + g + 1] !== 0) {
        m = 1;
      }
      this[f + g] = (b / l >> 0) - m & 255;
    }
    return f + k;
  };
  ca.prototype.writeInt8 = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 1, 127, -128);
    }
    if (d < 0) {
      d = 255 + d + 1;
    }
    this[e] = d & 255;
    return e + 1;
  };
  ca.prototype.writeInt16LE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 2, 32767, -32768);
    }
    this[e] = d & 255;
    this[e + 1] = d >>> 8;
    return e + 2;
  };
  ca.prototype.writeInt16BE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 2, 32767, -32768);
    }
    this[e] = d >>> 8;
    this[e + 1] = d & 255;
    return e + 2;
  };
  ca.prototype.writeInt32LE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 4, 2147483647, -2147483648);
    }
    this[e] = d & 255;
    this[e + 1] = d >>> 8;
    this[e + 2] = d >>> 16;
    this[e + 3] = d >>> 24;
    return e + 4;
  };
  ca.prototype.writeInt32BE = function (d, e, f) {
    d = +d;
    e = e >>> 0;
    if (!f) {
      I(this, d, e, 4, 2147483647, -2147483648);
    }
    if (d < 0) {
      d = 4294967295 + d + 1;
    }
    this[e] = d >>> 24;
    this[e + 1] = d >>> 16;
    this[e + 2] = d >>> 8;
    this[e + 3] = d & 255;
    return e + 4;
  };
  function J(b, a, c, d, e, f) {
    if (c + d > b.length) {
      throw new RangeError("Index out of range");
    }
    if (c < 0) {
      throw new RangeError("Index out of range");
    }
  }
  function K(b, a, d, h, f) {
    a = +a;
    d = d >>> 0;
    if (!f) {
      J(b, a, d, 4);
    }
    aa.write(b, a, d, h, 23, 4);
    return d + 4;
  }
  ca.prototype.writeFloatLE = function (d, a, b) {
    return K(this, d, a, true, b);
  };
  ca.prototype.writeFloatBE = function (d, a, b) {
    return K(this, d, a, false, b);
  };
  function L(b, a, d, h, f) {
    a = +a;
    d = d >>> 0;
    if (!f) {
      J(b, a, d, 8);
    }
    aa.write(b, a, d, h, 52, 8);
    return d + 8;
  }
  ca.prototype.writeDoubleLE = function (d, a, b) {
    return L(this, d, a, true, b);
  };
  ca.prototype.writeDoubleBE = function (d, a, b) {
    return L(this, d, a, false, b);
  };
  ca.prototype.copy = function (b, a, f, h) {
    if (!ca.isBuffer(b)) {
      throw new TypeError("argument should be a Buffer");
    }
    f ||= 0;
    if (!h && h !== 0) {
      h = this.length;
    }
    if (a >= b.length) {
      a = b.length;
    }
    a ||= 0;
    if (h > 0 && h < f) {
      h = f;
    }
    if (h === f || b.length === 0 || this.length === 0) {
      return 0;
    }
    if (a < 0) {
      throw new RangeError("targetStart out of bounds");
    }
    if (f < 0 || f >= this.length) {
      throw new RangeError("Index out of range");
    }
    if (h < 0) {
      throw new RangeError("sourceEnd out of bounds");
    }
    if (h > this.length) {
      h = this.length;
    }
    if (b.length - a < h - f) {
      h = b.length - a + f;
    }
    var i = h - f;
    if (this === b && typeof Uint8Array.prototype.copyWithin == "function") {
      this.copyWithin(a, f, h);
    } else {
      Uint8Array.prototype.set.call(b, this.subarray(f, h), a);
    }
    return i;
  };
  ca.prototype.fill = function (b, f, i, l) {
    if (typeof b == "string") {
      if (typeof f == "string") {
        l = f;
        f = 0;
        i = this.length;
      } else if (typeof i == "string") {
        l = i;
        i = this.length;
      }
      if (l !== undefined && typeof l != "string") {
        throw new TypeError("encoding must be a string");
      }
      if (typeof l == "string" && !ca.isEncoding(l)) {
        throw new TypeError("Unknown encoding: " + l);
      }
      if (b.length === 1) {
        var m = b.charCodeAt(0);
        if (l === "utf8" && m < 128 || l === "latin1") {
          b = m;
        }
      }
    } else if (typeof b == "number") {
      b = b & 255;
    } else if (typeof b == "boolean") {
      b = Number(b);
    }
    if (f < 0 || this.length < f || this.length < i) {
      throw new RangeError("Out of range index");
    }
    if (i <= f) {
      return this;
    }
    f = f >>> 0;
    i = i === undefined ? this.length : i >>> 0;
    b ||= 0;
    var g;
    if (typeof b == "number") {
      for (g = f; g < i; ++g) {
        this[g] = b;
      }
    } else {
      var n = ca.isBuffer(b) ? b : ca.from(b, l);
      var j = n.length;
      if (j === 0) {
        throw new TypeError("The value \"" + b + "\" is invalid for argument \"value\"");
      }
      for (g = 0; g < i - f; ++g) {
        this[g + f] = n[g % j];
      }
    }
    return this;
  };
  var M = /[^+/0-9A-Za-z-_]/g;
  function N(b) {
    b = b.split("=")[0];
    b = b.trim().replace(M, "");
    if (b.length < 2) {
      return "";
    }
    while (b.length % 4 !== 0) {
      b = b + "=";
    }
    return b;
  }
  function O(b, a) {
    a = a || Infinity;
    var d;
    for (var j = b.length, f = null, k = [], h = 0; h < j; ++h) {
      d = b.charCodeAt(h);
      if (d > 55295 && d < 57344) {
        if (!f) {
          if (d > 56319) {
            if ((a -= 3) > -1) {
              k.push(239, 191, 189);
            }
            continue;
          } else if (h + 1 === j) {
            if ((a -= 3) > -1) {
              k.push(239, 191, 189);
            }
            continue;
          }
          f = d;
          continue;
        }
        if (d < 56320) {
          if ((a -= 3) > -1) {
            k.push(239, 191, 189);
          }
          f = d;
          continue;
        }
        d = (f - 55296 << 10 | d - 56320) + 65536;
      } else if (f && (a -= 3) > -1) {
        k.push(239, 191, 189);
      }
      f = null;
      if (d < 128) {
        if ((a -= 1) < 0) {
          break;
        }
        k.push(d);
      } else if (d < 2048) {
        if ((a -= 2) < 0) {
          break;
        }
        k.push(d >> 6 | 192, d & 63 | 128);
      } else if (d < 65536) {
        if ((a -= 3) < 0) {
          break;
        }
        k.push(d >> 12 | 224, d >> 6 & 63 | 128, d & 63 | 128);
      } else if (d < 1114112) {
        if ((a -= 4) < 0) {
          break;
        }
        k.push(d >> 18 | 240, d >> 12 & 63 | 128, d >> 6 & 63 | 128, d & 63 | 128);
      } else {
        throw new Error("Invalid code point");
      }
    }
    return k;
  }
  function P(b) {
    var a = [];
    for (var c = 0; c < b.length; ++c) {
      a.push(b.charCodeAt(c) & 255);
    }
    return a;
  }
  function Q(b, a) {
    var d;
    var j;
    var k;
    var l = [];
    for (var h = 0; h < b.length && (a -= 2) >= 0; ++h) {
      d = b.charCodeAt(h);
      j = d >> 8;
      k = d % 256;
      l.push(k);
      l.push(j);
    }
    return l;
  }
  function R(b) {
    return _.toByteArray(N(b));
  }
  function S(b, a, c, d) {
    for (var e = 0; e < d && e + c < a.length && e < b.length; ++e) {
      a[e + c] = b[e];
    }
    return e;
  }
  function T(b, a) {
    return b instanceof a || b != null && b.constructor != null && b.constructor.name != null && b.constructor.name === a.name;
  }
  function U(b) {
    return b !== b;
  }
  var V = function () {
    var a = "0123456789abcdef";
    var b = new Array(256);
    for (var c = 0; c < 16; ++c) {
      var d = c * 16;
      for (var h = 0; h < 16; ++h) {
        b[d + h] = a[c] + a[h];
      }
    }
    return b;
  }();
})(Jb);
var Wb = {};
var Xb;
var Yb;
function Zb() {
  throw new Error("setTimeout has not been defined");
}
function $b() {
  throw new Error("clearTimeout has not been defined");
}
(function () {
  try {
    if (typeof setTimeout == "function") {
      Xb = setTimeout;
    } else {
      Xb = Zb;
    }
  } catch {
    Xb = Zb;
  }
  try {
    if (typeof clearTimeout == "function") {
      Yb = clearTimeout;
    } else {
      Yb = $b;
    }
  } catch {
    Yb = $b;
  }
})();
function _b(b) {
  if (Xb === setTimeout) {
    return setTimeout(b, 0);
  }
  if ((Xb === Zb || !Xb) && setTimeout) {
    Xb = setTimeout;
    return setTimeout(b, 0);
  }
  try {
    return Xb(b, 0);
  } catch {
    try {
      return Xb.call(null, b, 0);
    } catch {
      return Xb.call(this, b, 0);
    }
  }
}
function Wa(b) {
  if (Yb === clearTimeout) {
    return clearTimeout(b);
  }
  if ((Yb === $b || !Yb) && clearTimeout) {
    Yb = clearTimeout;
    return clearTimeout(b);
  }
  try {
    return Yb(b);
  } catch {
    try {
      return Yb.call(null, b);
    } catch {
      return Yb.call(this, b);
    }
  }
}
var Va = [];
var jc = false;
var qc;
var xc = -1;
function Gc() {
  if (!!jc && !!qc) {
    jc = false;
    if (qc.length) {
      Va = qc.concat(Va);
    } else {
      xc = -1;
    }
    if (Va.length) {
      Hc();
    }
  }
}
function Hc() {
  if (!jc) {
    var a = _b(Gc);
    jc = true;
    for (var b = Va.length; b;) {
      qc = Va;
      Va = [];
      while (++xc < b) {
        if (qc) {
          qc[xc].run();
        }
      }
      xc = -1;
      b = Va.length;
    }
    qc = null;
    jc = false;
    Wa(a);
  }
}
Wb.nextTick = function (b) {
  var a = new Array(arguments.length - 1);
  if (arguments.length > 1) {
    for (var c = 1; c < arguments.length; c++) {
      a[c - 1] = arguments[c];
    }
  }
  Va.push(new Jc(b, a));
  if (Va.length === 1 && !jc) {
    _b(Hc);
  }
};
function Jc(c, a) {
  this.fun = c;
  this.array = a;
}
Jc.prototype.run = function () {
  this.fun.apply(null, this.array);
};
Wb.title = "browser";
Wb.browser = true;
Wb.env = {};
Wb.argv = [];
Wb.version = "";
Wb.versions = {};
function Kc() {}
Wb.on = Kc;
Wb.addListener = Kc;
Wb.once = Kc;
Wb.off = Kc;
Wb.removeListener = Kc;
Wb.removeAllListeners = Kc;
Wb.emit = Kc;
Wb.prependListener = Kc;
Wb.prependOnceListener = Kc;
Wb.listeners = function (b) {
  return [];
};
Wb.binding = function (b) {
  throw new Error("process.binding is not supported");
};
Wb.cwd = function () {
  return "/";
};
Wb.chdir = function (b) {
  throw new Error("process.chdir is not supported");
};
Wb.umask = function () {
  return 0;
};
var Mc = function (b) {
  function a() {
    var a = this || self;
    delete b.prototype.__magic__;
    return a;
  }
  if (typeof globalThis == "object") {
    return globalThis;
  }
  if (this) {
    return a();
  }
  b.defineProperty(b.prototype, "__magic__", {
    configurable: true,
    get: a
  });
  var c = __magic__;
  return c;
}(Object);
var Pc = Mc;
var Qc;
(function (g) {
  g.assertEqual = b => b;
  function a(b) {}
  g.assertIs = a;
  function b(b) {
    throw new Error();
  }
  g.assertNever = b;
  g.arrayToEnum = d => {
    const a = {};
    for (const b of d) {
      a[b] = b;
    }
    return a;
  };
  g.getValidEnumValues = b => {
    const c = g.objectKeys(b).filter(c => typeof b[b[c]] != "number");
    const d = {};
    for (const e of c) {
      d[e] = b[e];
    }
    return g.objectValues(d);
  };
  g.objectValues = c => g.objectKeys(c).map(function (b) {
    return c[b];
  });
  g.objectKeys = typeof Object.keys == "function" ? b => Object.keys(b) : c => {
    const a = [];
    for (const d in c) {
      if (Object.prototype.hasOwnProperty.call(c, d)) {
        a.push(d);
      }
    }
    return a;
  };
  g.find = (d, a) => {
    for (const b of d) {
      if (a(b)) {
        return b;
      }
    }
  };
  g.isInteger = typeof Number.isInteger == "function" ? b => Number.isInteger(b) : b => typeof b == "number" && isFinite(b) && Math.floor(b) === b;
  function c(b, a = " | ") {
    return b.map(b => typeof b == "string" ? "'" + b + "'" : b).join(a);
  }
  g.joinValues = c;
  g.jsonStringifyReplacer = (b, a) => typeof a == "bigint" ? a.toString() : a;
})(Qc ||= {});
var Uc;
(function (b) {
  b.mergeShapes = (c, a) => ({
    ...c,
    ...a
  });
})(Uc ||= {});
const Vc = Qc.arrayToEnum(["string", "nan", "number", "integer", "float", "boolean", "date", "bigint", "symbol", "function", "undefined", "null", "array", "object", "unknown", "promise", "void", "never", "map", "set"]);
const Wc = b => {
  switch (typeof b) {
    case "undefined":
      return Vc.undefined;
    case "string":
      return Vc.string;
    case "number":
      if (isNaN(b)) {
        return Vc.nan;
      } else {
        return Vc.number;
      }
    case "boolean":
      return Vc.boolean;
    case "function":
      return Vc.function;
    case "bigint":
      return Vc.bigint;
    case "symbol":
      return Vc.symbol;
    case "object":
      if (Array.isArray(b)) {
        return Vc.array;
      } else if (b === null) {
        return Vc.null;
      } else if (b.then && typeof b.then == "function" && b.catch && typeof b.catch == "function") {
        return Vc.promise;
      } else if (typeof Map !== "undefined" && b instanceof Map) {
        return Vc.map;
      } else if (typeof Set !== "undefined" && b instanceof Set) {
        return Vc.set;
      } else if (typeof Date !== "undefined" && b instanceof Date) {
        return Vc.date;
      } else {
        return Vc.object;
      }
    default:
      return Vc.unknown;
  }
};
const qa = Qc.arrayToEnum(["invalid_type", "invalid_literal", "custom", "invalid_union", "invalid_union_discriminator", "invalid_enum_value", "unrecognized_keys", "invalid_arguments", "invalid_return_type", "invalid_date", "invalid_string", "too_small", "too_big", "invalid_intersection_types", "not_multiple_of", "not_finite"]);
const Xc = b => JSON.stringify(b, null, 2).replace(/"([^"]+)":/g, "$1:");
class Yc extends Error {
  constructor(b) {
    super();
    this.issues = [];
    this.addIssue = b => {
      this.issues = [...this.issues, b];
    };
    this.addIssues = (b = undefined) => {
      if (b === undefined) b = [];
      this.issues = [...this.issues, ...b];
    };
    const a = new.target.prototype;
    if (Object.setPrototypeOf) {
      Object.setPrototypeOf(this, a);
    } else {
      this.__proto__ = a;
    }
    this.name = "ZodError";
    this.issues = b;
  }
  get errors() {
    return this.issues;
  }
  format(e) {
    const g = e || function (b) {
      return b.message;
    };
    const b = {
      _errors: []
    };
    const a = c => {
      for (const e of c.issues) {
        if (e.code === "invalid_union") {
          e.unionErrors.map(a);
        } else if (e.code === "invalid_return_type") {
          a(e.returnTypeError);
        } else if (e.code === "invalid_arguments") {
          a(e.argumentsError);
        } else if (e.path.length === 0) {
          b._errors.push(g(e));
        } else {
          let f = b;
          let a = 0;
          while (a < e.path.length) {
            const b = e.path[a];
            if (a === e.path.length - 1) {
              f[b] = f[b] || {
                _errors: []
              };
              f[b]._errors.push(g(e));
            } else {
              f[b] = f[b] || {
                _errors: []
              };
            }
            f = f[b];
            a++;
          }
        }
      }
    };
    a(this);
    return b;
  }
  toString() {
    return this.message;
  }
  get message() {
    return JSON.stringify(this.issues, Qc.jsonStringifyReplacer, 2);
  }
  get isEmpty() {
    return this.issues.length === 0;
  }
  flatten(b = undefined) {
    if (b === undefined) b = b => b.message;
    const f = {};
    const c = [];
    for (const a of this.issues) {
      if (a.path.length > 0) {
        f[a.path[0]] = f[a.path[0]] || [];
        f[a.path[0]].push(b(a));
      } else {
        c.push(b(a));
      }
    }
    return {
      formErrors: c,
      fieldErrors: f
    };
  }
  get formErrors() {
    return this.flatten();
  }
}
Yc.create = b => new Yc(b);
const Y = (c, a) => {
  let b;
  switch (c.code) {
    case qa.invalid_type:
      if (c.received === Vc.undefined) {
        b = "Required";
      } else {
        b = "Expected " + c.expected + ", received " + c.received;
      }
      break;
    case qa.invalid_literal:
      b = "Invalid literal value, expected " + JSON.stringify(c.expected, Qc.jsonStringifyReplacer);
      break;
    case qa.unrecognized_keys:
      b = "Unrecognized key(s) in object: " + Qc.joinValues(c.keys, ", ");
      break;
    case qa.invalid_union:
      b = "Invalid input";
      break;
    case qa.invalid_union_discriminator:
      b = "Invalid discriminator value. Expected " + Qc.joinValues(c.options);
      break;
    case qa.invalid_enum_value:
      b = "Invalid enum value. Expected " + Qc.joinValues(c.options) + ", received '" + c.received + "'";
      break;
    case qa.invalid_arguments:
      b = "Invalid function arguments";
      break;
    case qa.invalid_return_type:
      b = "Invalid function return type";
      break;
    case qa.invalid_date:
      b = "Invalid date";
      break;
    case qa.invalid_string:
      if (typeof c.validation == "object") {
        if ("includes" in c.validation) {
          b = "Invalid input: must include \"" + c.validation.includes + "\"";
          if (typeof c.validation.position == "number") {
            b = b + " at one or more positions greater than or equal to " + c.validation.position;
          }
        } else if ("startsWith" in c.validation) {
          b = "Invalid input: must start with \"" + c.validation.startsWith + "\"";
        } else if ("endsWith" in c.validation) {
          b = "Invalid input: must end with \"" + c.validation.endsWith + "\"";
        } else {
          Qc.assertNever(c.validation);
        }
      } else if (c.validation !== "regex") {
        b = "Invalid " + c.validation;
      } else {
        b = "Invalid";
      }
      break;
    case qa.too_small:
      if (c.type === "array") {
        b = "Array must contain " + (c.exact ? "exactly" : c.inclusive ? "at least" : "more than") + " " + c.minimum + " element(s)";
      } else if (c.type === "string") {
        b = "String must contain " + (c.exact ? "exactly" : c.inclusive ? "at least" : "over") + " " + c.minimum + " character(s)";
      } else if (c.type === "number") {
        b = "Number must be " + (c.exact ? "exactly equal to " : c.inclusive ? "greater than or equal to " : "greater than ") + c.minimum;
      } else if (c.type === "date") {
        b = "Date must be " + (c.exact ? "exactly equal to " : c.inclusive ? "greater than or equal to " : "greater than ") + new Date(Number(c.minimum));
      } else {
        b = "Invalid input";
      }
      break;
    case qa.too_big:
      if (c.type === "array") {
        b = "Array must contain " + (c.exact ? "exactly" : c.inclusive ? "at most" : "less than") + " " + c.maximum + " element(s)";
      } else if (c.type === "string") {
        b = "String must contain " + (c.exact ? "exactly" : c.inclusive ? "at most" : "under") + " " + c.maximum + " character(s)";
      } else if (c.type === "number") {
        b = "Number must be " + (c.exact ? "exactly" : c.inclusive ? "less than or equal to" : "less than") + " " + c.maximum;
      } else if (c.type === "bigint") {
        b = "BigInt must be " + (c.exact ? "exactly" : c.inclusive ? "less than or equal to" : "less than") + " " + c.maximum;
      } else if (c.type === "date") {
        b = "Date must be " + (c.exact ? "exactly" : c.inclusive ? "smaller than or equal to" : "smaller than") + " " + new Date(Number(c.maximum));
      } else {
        b = "Invalid input";
      }
      break;
    case qa.custom:
      b = "Invalid input";
      break;
    case qa.invalid_intersection_types:
      b = "Intersection results could not be merged";
      break;
    case qa.not_multiple_of:
      b = "Number must be a multiple of " + c.multipleOf;
      break;
    case qa.not_finite:
      b = "Number must be finite";
      break;
    default:
      b = a.defaultError;
      Qc.assertNever(c);
  }
  return {
    message: b
  };
};
let Zc = Y;
function ce(b) {
  Zc = b;
}
function ee() {
  return Zc;
}
const ge = b => {
  const {
    data: a,
    path: c,
    errorMaps: d,
    issueData: e
  } = b;
  const f = [...c, ...(e.path || [])];
  const g = {
    ...e,
    path: f
  };
  let h = "";
  const k = d.filter(b => !!b).slice().reverse();
  for (const c of k) {
    h = c(g, {
      data: a,
      defaultError: h
    }).message;
  }
  return {
    ...e,
    path: f,
    message: e.message || h
  };
};
const he = [];
function ie(c, a) {
  const b = ge({
    issueData: a,
    data: c.data,
    path: c.path,
    errorMaps: [c.common.contextualErrorMap, c.schemaErrorMap, ee(), Y].filter(b => !!b)
  });
  c.common.issues.push(b);
}
class ne {
  constructor() {
    this.value = "valid";
  }
  dirty() {
    if (this.value === "valid") {
      this.value = "dirty";
    }
  }
  abort() {
    if (this.value !== "aborted") {
      this.value = "aborted";
    }
  }
  static mergeArray(c, a) {
    const b = [];
    for (const d of a) {
      if (d.status === "aborted") {
        return oe;
      }
      if (d.status === "dirty") {
        c.dirty();
      }
      b.push(d.value);
    }
    return {
      status: c.value,
      value: b
    };
  }
  static async mergeObjectAsync(c, a) {
    const b = [];
    for (const d of a) {
      b.push({
        key: await d.key,
        value: await d.value
      });
    }
    return ne.mergeObjectSync(c, b);
  }
  static mergeObjectSync(c, a) {
    const e = {};
    for (const d of a) {
      const {
        key: a,
        value: b
      } = d;
      if (a.status === "aborted" || b.status === "aborted") {
        return oe;
      }
      if (a.status === "dirty") {
        c.dirty();
      }
      if (b.status === "dirty") {
        c.dirty();
      }
      if (typeof b.value !== "undefined" || d.alwaysSet) {
        e[a.value] = b.value;
      }
    }
    return {
      status: c.value,
      value: e
    };
  }
}
const oe = Object.freeze({
  status: "aborted"
});
const qe = b => ({
  status: "dirty",
  value: b
});
const re = b => ({
  status: "valid",
  value: b
});
const fe = b => b.status === "aborted";
const se = b => b.status === "dirty";
const te = b => b.status === "valid";
const Ka = b => typeof Promise !== "undefined" && b instanceof Promise;
var Ga;
(function (b) {
  b.errToObj = b => typeof b == "string" ? {
    message: b
  } : b || {};
  b.toString = b => typeof b == "string" ? b : b?.message;
})(Ga ||= {});
class ue {
  constructor(e, a, b, c) {
    this._cachedPath = [];
    this.parent = e;
    this.data = a;
    this._path = b;
    this._key = c;
  }
  get path() {
    if (!this._cachedPath.length) {
      if (this._key instanceof Array) {
        this._cachedPath.push(...this._path, ...this._key);
      } else {
        this._cachedPath.push(...this._path, this._key);
      }
    }
    return this._cachedPath;
  }
}
const we = (c, a) => {
  if (te(a)) {
    return {
      success: true,
      data: a.value
    };
  }
  if (!c.common.issues.length) {
    throw new Error("Validation failed but no issues detected.");
  }
  return {
    success: false,
    get error() {
      if (this._error) {
        return this._error;
      }
      const a = new Yc(c.common.issues);
      this._error = a;
      return this._error;
    }
  };
};
function ae(b) {
  if (!b) {
    return {};
  }
  const {
    errorMap: a,
    invalid_type_error: g,
    required_error: d,
    description: c
  } = b;
  if (a && (g || d)) {
    throw new Error("Can't use \"invalid_type_error\" or \"required_error\" in conjunction with custom error map.");
  }
  if (a) {
    return {
      errorMap: a,
      description: c
    };
  } else {
    return {
      errorMap: (b, a) => b.code !== "invalid_type" ? {
        message: a.defaultError
      } : typeof a.data === "undefined" ? {
        message: d ?? a.defaultError
      } : {
        message: g ?? a.defaultError
      },
      description: c
    };
  }
}
class xe {
  constructor(b) {
    this.spa = this.safeParseAsync;
    this._def = b;
    this.parse = this.parse.bind(this);
    this.safeParse = this.safeParse.bind(this);
    this.parseAsync = this.parseAsync.bind(this);
    this.safeParseAsync = this.safeParseAsync.bind(this);
    this.spa = this.spa.bind(this);
    this.refine = this.refine.bind(this);
    this.refinement = this.refinement.bind(this);
    this.superRefine = this.superRefine.bind(this);
    this.optional = this.optional.bind(this);
    this.nullable = this.nullable.bind(this);
    this.nullish = this.nullish.bind(this);
    this.array = this.array.bind(this);
    this.promise = this.promise.bind(this);
    this.or = this.or.bind(this);
    this.and = this.and.bind(this);
    this.transform = this.transform.bind(this);
    this.brand = this.brand.bind(this);
    this.default = this.default.bind(this);
    this.catch = this.catch.bind(this);
    this.describe = this.describe.bind(this);
    this.pipe = this.pipe.bind(this);
    this.isNullable = this.isNullable.bind(this);
    this.isOptional = this.isOptional.bind(this);
  }
  get description() {
    return this._def.description;
  }
  _getType(b) {
    return Wc(b.data);
  }
  _getOrReturnCtx(c, a) {
    return a || {
      common: c.parent.common,
      data: c.data,
      parsedType: Wc(c.data),
      schemaErrorMap: this._def.errorMap,
      path: c.path,
      parent: c.parent
    };
  }
  _processInputParams(b) {
    return {
      status: new ne(),
      ctx: {
        common: b.parent.common,
        data: b.data,
        parsedType: Wc(b.data),
        schemaErrorMap: this._def.errorMap,
        path: b.path,
        parent: b.parent
      }
    };
  }
  _parseSync(b) {
    const a = this._parse(b);
    if (Ka(a)) {
      throw new Error("Synchronous parse encountered promise.");
    }
    return a;
  }
  _parseAsync(b) {
    const a = this._parse(b);
    return Promise.resolve(a);
  }
  parse(c, a) {
    const b = this.safeParse(c, a);
    if (b.success) {
      return b.data;
    }
    throw b.error;
  }
  safeParse(c, a) {
    const b = {
      common: {
        issues: [],
        async: a?.async ?? false,
        contextualErrorMap: a?.errorMap
      },
      path: a?.path || [],
      schemaErrorMap: this._def.errorMap,
      parent: null,
      data: c,
      parsedType: Wc(c)
    };
    const d = this._parseSync({
      data: c,
      path: b.path,
      parent: b
    });
    return we(b, d);
  }
  async parseAsync(c, a) {
    const b = await this.safeParseAsync(c, a);
    if (b.success) {
      return b.data;
    }
    throw b.error;
  }
  async safeParseAsync(c, a) {
    const b = {
      common: {
        issues: [],
        contextualErrorMap: a?.errorMap,
        async: true
      },
      path: a?.path || [],
      schemaErrorMap: this._def.errorMap,
      parent: null,
      data: c,
      parsedType: Wc(c)
    };
    const d = this._parse({
      data: c,
      path: b.path,
      parent: b
    });
    const e = await (Ka(d) ? d : Promise.resolve(d));
    return we(b, e);
  }
  refine(c, e) {
    const a = b => typeof e == "string" || typeof e === "undefined" ? {
      message: e
    } : typeof e == "function" ? e(b) : e;
    return this._refinement((d, b) => {
      const e = c(d);
      const f = () => b.addIssue({
        code: qa.custom,
        ...a(d)
      });
      if (typeof Promise !== "undefined" && e instanceof Promise) {
        return e.then(b => b ? true : (f(), false));
      } else if (e) {
        return true;
      } else {
        f();
        return false;
      }
    });
  }
  refinement(c, a) {
    return this._refinement((b, d) => c(b) ? true : (d.addIssue(typeof a == "function" ? a(b, d) : a), false));
  }
  _refinement(b) {
    return new xg({
      schema: this,
      typeName: Ig.ZodEffects,
      effect: {
        type: "refinement",
        refinement: b
      }
    });
  }
  superRefine(b) {
    return this._refinement(b);
  }
  optional() {
    return yg.create(this, this._def);
  }
  nullable() {
    return zg.create(this, this._def);
  }
  nullish() {
    return this.nullable().optional();
  }
  array() {
    return hg.create(this, this._def);
  }
  promise() {
    return wg.create(this, this._def);
  }
  or(b) {
    return kg.create([this, b], this._def);
  }
  and(b) {
    return ng.create(this, b, this._def);
  }
  transform(b) {
    return new xg({
      ...ae(this._def),
      schema: this,
      typeName: Ig.ZodEffects,
      effect: {
        type: "transform",
        transform: b
      }
    });
  }
  default(b) {
    const a = typeof b == "function" ? b : () => b;
    return new Ag({
      ...ae(this._def),
      innerType: this,
      defaultValue: a,
      typeName: Ig.ZodDefault
    });
  }
  brand() {
    return new Eg({
      typeName: Ig.ZodBranded,
      type: this,
      ...ae(this._def)
    });
  }
  catch(b) {
    const a = typeof b == "function" ? b : () => b;
    return new Bg({
      ...ae(this._def),
      innerType: this,
      catchValue: a,
      typeName: Ig.ZodCatch
    });
  }
  describe(b) {
    const a = this.constructor;
    return new a({
      ...this._def,
      description: b
    });
  }
  pipe(b) {
    return Fg.create(this, b);
  }
  isOptional() {
    return this.safeParse(undefined).success;
  }
  isNullable() {
    return this.safeParse(null).success;
  }
}
const ze = /^c[^\s-]{8,}$/i;
const Ae = /^[a-z][a-z0-9]*$/;
const pe = /[0-9A-HJKMNP-TV-Z]{26}/;
const Be = /^([a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[a-f0-9]{4}-[a-f0-9]{12}|00000000-0000-0000-0000-000000000000)$/i;
const De = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\])|(\[IPv6:(([a-f0-9]{1,4}:){7}|::([a-f0-9]{1,4}:){0,6}|([a-f0-9]{1,4}:){1}:([a-f0-9]{1,4}:){0,5}|([a-f0-9]{1,4}:){2}:([a-f0-9]{1,4}:){0,4}|([a-f0-9]{1,4}:){3}:([a-f0-9]{1,4}:){0,3}|([a-f0-9]{1,4}:){4}:([a-f0-9]{1,4}:){0,2}|([a-f0-9]{1,4}:){5}:([a-f0-9]{1,4}:){0,1})([a-f0-9]{1,4}|(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2})))\])|([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])*(\.[A-Za-z]{2,})+))$/;
const Fe = /^(\p{Extended_Pictographic}|\p{Emoji_Component})+$/u;
const Je = /^(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))$/;
const Me = /^(([a-f0-9]{1,4}:){7}|::([a-f0-9]{1,4}:){0,6}|([a-f0-9]{1,4}:){1}:([a-f0-9]{1,4}:){0,5}|([a-f0-9]{1,4}:){2}:([a-f0-9]{1,4}:){0,4}|([a-f0-9]{1,4}:){3}:([a-f0-9]{1,4}:){0,3}|([a-f0-9]{1,4}:){4}:([a-f0-9]{1,4}:){0,2}|([a-f0-9]{1,4}:){5}:([a-f0-9]{1,4}:){0,1})([a-f0-9]{1,4}|(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2})))$/;
const Ne = b => b.precision ? b.offset ? new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{" + b.precision + "}(([+-]\\d{2}(:?\\d{2})?)|Z)$") : new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{" + b.precision + "}Z$") : b.precision === 0 ? b.offset ? new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(([+-]\\d{2}(:?\\d{2})?)|Z)$") : new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z$") : b.offset ? new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(([+-]\\d{2}(:?\\d{2})?)|Z)$") : new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?Z$");
function Oe(c, a) {
  return (a === "v4" || !!!a) && !!Je.test(c) || (a === "v6" || !!!a) && !!Me.test(c);
}
class Pe extends xe {
  constructor() {
    super(...arguments);
    this._regex = (a, b, c) => this.refinement(b => a.test(b), {
      validation: b,
      code: qa.invalid_string,
      ...Ga.errToObj(c)
    });
    this.nonempty = a => this.min(1, Ga.errToObj(a));
    this.trim = () => new Pe({
      ...this._def,
      checks: [...this._def.checks, {
        kind: "trim"
      }]
    });
    this.toLowerCase = () => new Pe({
      ...this._def,
      checks: [...this._def.checks, {
        kind: "toLowerCase"
      }]
    });
    this.toUpperCase = () => new Pe({
      ...this._def,
      checks: [...this._def.checks, {
        kind: "toUpperCase"
      }]
    });
  }
  _parse(b) {
    if (this._def.coerce) {
      b.data = String(b.data);
    }
    if (this._getType(b) !== Vc.string) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.string,
        received: a.parsedType
      });
      return oe;
    }
    const a = new ne();
    let c;
    for (const d of this._def.checks) {
      if (d.kind === "min") {
        if (b.data.length < d.value) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.too_small,
            minimum: d.value,
            type: "string",
            inclusive: true,
            exact: false,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "max") {
        if (b.data.length > d.value) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.too_big,
            maximum: d.value,
            type: "string",
            inclusive: true,
            exact: false,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "length") {
        const e = b.data.length > d.value;
        const f = b.data.length < d.value;
        if (e || f) {
          c = this._getOrReturnCtx(b, c);
          if (e) {
            ie(c, {
              code: qa.too_big,
              maximum: d.value,
              type: "string",
              inclusive: true,
              exact: true,
              message: d.message
            });
          } else if (f) {
            ie(c, {
              code: qa.too_small,
              minimum: d.value,
              type: "string",
              inclusive: true,
              exact: true,
              message: d.message
            });
          }
          a.dirty();
        }
      } else if (d.kind === "email") {
        if (!De.test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "email",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "emoji") {
        if (!Fe.test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "emoji",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "uuid") {
        if (!Be.test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "uuid",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "cuid") {
        if (!ze.test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "cuid",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "cuid2") {
        if (!Ae.test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "cuid2",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "ulid") {
        if (!pe.test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "ulid",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "url") {
        try {
          new URL(b.data);
        } catch {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "url",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "regex") {
        d.regex.lastIndex = 0;
        if (!d.regex.test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "regex",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "trim") {
        b.data = b.data.trim();
      } else if (d.kind === "includes") {
        if (!b.data.includes(d.value, d.position)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.invalid_string,
            validation: {
              includes: d.value,
              position: d.position
            },
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "toLowerCase") {
        b.data = b.data.toLowerCase();
      } else if (d.kind === "toUpperCase") {
        b.data = b.data.toUpperCase();
      } else if (d.kind === "startsWith") {
        if (!b.data.startsWith(d.value)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.invalid_string,
            validation: {
              startsWith: d.value
            },
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "endsWith") {
        if (!b.data.endsWith(d.value)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.invalid_string,
            validation: {
              endsWith: d.value
            },
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "datetime") {
        if (!Ne(d).test(b.data)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.invalid_string,
            validation: "datetime",
            message: d.message
          });
          a.dirty();
        }
      } else if (d.kind === "ip") {
        if (!Oe(b.data, d.version)) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            validation: "ip",
            code: qa.invalid_string,
            message: d.message
          });
          a.dirty();
        }
      } else {
        Qc.assertNever(d);
      }
    }
    return {
      status: a.value,
      value: b.data
    };
  }
  _addCheck(b) {
    return new Pe({
      ...this._def,
      checks: [...this._def.checks, b]
    });
  }
  email(b) {
    return this._addCheck({
      kind: "email",
      ...Ga.errToObj(b)
    });
  }
  url(b) {
    return this._addCheck({
      kind: "url",
      ...Ga.errToObj(b)
    });
  }
  emoji(b) {
    return this._addCheck({
      kind: "emoji",
      ...Ga.errToObj(b)
    });
  }
  uuid(b) {
    return this._addCheck({
      kind: "uuid",
      ...Ga.errToObj(b)
    });
  }
  cuid(b) {
    return this._addCheck({
      kind: "cuid",
      ...Ga.errToObj(b)
    });
  }
  cuid2(b) {
    return this._addCheck({
      kind: "cuid2",
      ...Ga.errToObj(b)
    });
  }
  ulid(b) {
    return this._addCheck({
      kind: "ulid",
      ...Ga.errToObj(b)
    });
  }
  ip(b) {
    return this._addCheck({
      kind: "ip",
      ...Ga.errToObj(b)
    });
  }
  datetime(b) {
    if (typeof b == "string") {
      return this._addCheck({
        kind: "datetime",
        precision: null,
        offset: false,
        message: b
      });
    } else {
      return this._addCheck({
        kind: "datetime",
        precision: typeof b?.precision === "undefined" ? null : b?.precision,
        offset: b?.offset ?? false,
        ...Ga.errToObj(b?.message)
      });
    }
  }
  regex(c, a) {
    return this._addCheck({
      kind: "regex",
      regex: c,
      ...Ga.errToObj(a)
    });
  }
  includes(c, a) {
    return this._addCheck({
      kind: "includes",
      value: c,
      position: a?.position,
      ...Ga.errToObj(a?.message)
    });
  }
  startsWith(c, a) {
    return this._addCheck({
      kind: "startsWith",
      value: c,
      ...Ga.errToObj(a)
    });
  }
  endsWith(c, a) {
    return this._addCheck({
      kind: "endsWith",
      value: c,
      ...Ga.errToObj(a)
    });
  }
  min(c, a) {
    return this._addCheck({
      kind: "min",
      value: c,
      ...Ga.errToObj(a)
    });
  }
  max(c, a) {
    return this._addCheck({
      kind: "max",
      value: c,
      ...Ga.errToObj(a)
    });
  }
  length(c, a) {
    return this._addCheck({
      kind: "length",
      value: c,
      ...Ga.errToObj(a)
    });
  }
  get isDatetime() {
    return !!this._def.checks.find(a => a.kind === "datetime");
  }
  get isEmail() {
    return !!this._def.checks.find(a => a.kind === "email");
  }
  get isURL() {
    return !!this._def.checks.find(a => a.kind === "url");
  }
  get isEmoji() {
    return !!this._def.checks.find(a => a.kind === "emoji");
  }
  get isUUID() {
    return !!this._def.checks.find(a => a.kind === "uuid");
  }
  get isCUID() {
    return !!this._def.checks.find(a => a.kind === "cuid");
  }
  get isCUID2() {
    return !!this._def.checks.find(a => a.kind === "cuid2");
  }
  get isULID() {
    return !!this._def.checks.find(a => a.kind === "ulid");
  }
  get isIP() {
    return !!this._def.checks.find(a => a.kind === "ip");
  }
  get minLength() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "min" && (a === null || b.value > a)) {
        a = b.value;
      }
    }
    return a;
  }
  get maxLength() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "max" && (a === null || b.value < a)) {
        a = b.value;
      }
    }
    return a;
  }
}
Pe.create = b => {
  return new Pe({
    checks: [],
    typeName: Ig.ZodString,
    coerce: b?.coerce ?? false,
    ...ae(b)
  });
};
function Se(c, a) {
  const b = (c.toString().split(".")[1] || "").length;
  const d = (a.toString().split(".")[1] || "").length;
  const e = b > d ? b : d;
  const f = parseInt(c.toFixed(e).replace(".", ""));
  const g = parseInt(a.toFixed(e).replace(".", ""));
  return f % g / Math.pow(10, e);
}
class Xe extends xe {
  constructor() {
    super(...arguments);
    this.min = this.gte;
    this.max = this.lte;
    this.step = this.multipleOf;
  }
  _parse(b) {
    if (this._def.coerce) {
      b.data = Number(b.data);
    }
    if (this._getType(b) !== Vc.number) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.number,
        received: a.parsedType
      });
      return oe;
    }
    let a;
    const f = new ne();
    for (const c of this._def.checks) {
      if (c.kind === "int") {
        if (!Qc.isInteger(b.data)) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.invalid_type,
            expected: "integer",
            received: "float",
            message: c.message
          });
          f.dirty();
        }
      } else if (c.kind === "min") {
        if (c.inclusive ? b.data < c.value : b.data <= c.value) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.too_small,
            minimum: c.value,
            type: "number",
            inclusive: c.inclusive,
            exact: false,
            message: c.message
          });
          f.dirty();
        }
      } else if (c.kind === "max") {
        if (c.inclusive ? b.data > c.value : b.data >= c.value) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.too_big,
            maximum: c.value,
            type: "number",
            inclusive: c.inclusive,
            exact: false,
            message: c.message
          });
          f.dirty();
        }
      } else if (c.kind === "multipleOf") {
        if (Se(b.data, c.value) !== 0) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.not_multiple_of,
            multipleOf: c.value,
            message: c.message
          });
          f.dirty();
        }
      } else if (c.kind === "finite") {
        if (!Number.isFinite(b.data)) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.not_finite,
            message: c.message
          });
          f.dirty();
        }
      } else {
        Qc.assertNever(c);
      }
    }
    return {
      status: f.value,
      value: b.data
    };
  }
  gte(c, a) {
    return this.setLimit("min", c, true, Ga.toString(a));
  }
  gt(c, a) {
    return this.setLimit("min", c, false, Ga.toString(a));
  }
  lte(c, a) {
    return this.setLimit("max", c, true, Ga.toString(a));
  }
  lt(c, a) {
    return this.setLimit("max", c, false, Ga.toString(a));
  }
  setLimit(e, a, b, c) {
    return new Xe({
      ...this._def,
      checks: [...this._def.checks, {
        kind: e,
        value: a,
        inclusive: b,
        message: Ga.toString(c)
      }]
    });
  }
  _addCheck(b) {
    return new Xe({
      ...this._def,
      checks: [...this._def.checks, b]
    });
  }
  int(b) {
    return this._addCheck({
      kind: "int",
      message: Ga.toString(b)
    });
  }
  positive(b) {
    return this._addCheck({
      kind: "min",
      value: 0,
      inclusive: false,
      message: Ga.toString(b)
    });
  }
  negative(b) {
    return this._addCheck({
      kind: "max",
      value: 0,
      inclusive: false,
      message: Ga.toString(b)
    });
  }
  nonpositive(b) {
    return this._addCheck({
      kind: "max",
      value: 0,
      inclusive: true,
      message: Ga.toString(b)
    });
  }
  nonnegative(b) {
    return this._addCheck({
      kind: "min",
      value: 0,
      inclusive: true,
      message: Ga.toString(b)
    });
  }
  multipleOf(c, a) {
    return this._addCheck({
      kind: "multipleOf",
      value: c,
      message: Ga.toString(a)
    });
  }
  finite(b) {
    return this._addCheck({
      kind: "finite",
      message: Ga.toString(b)
    });
  }
  safe(b) {
    return this._addCheck({
      kind: "min",
      inclusive: true,
      value: Number.MIN_SAFE_INTEGER,
      message: Ga.toString(b)
    })._addCheck({
      kind: "max",
      inclusive: true,
      value: Number.MAX_SAFE_INTEGER,
      message: Ga.toString(b)
    });
  }
  get minValue() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "min" && (a === null || b.value > a)) {
        a = b.value;
      }
    }
    return a;
  }
  get maxValue() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "max" && (a === null || b.value < a)) {
        a = b.value;
      }
    }
    return a;
  }
  get isInt() {
    return !!this._def.checks.find(a => a.kind === "int" || a.kind === "multipleOf" && Qc.isInteger(a.value));
  }
  get isFinite() {
    let a = null;
    let e = null;
    for (const b of this._def.checks) {
      if (b.kind === "finite" || b.kind === "int" || b.kind === "multipleOf") {
        return true;
      }
      if (b.kind === "min") {
        if (e === null || b.value > e) {
          e = b.value;
        }
      } else if (b.kind === "max" && (a === null || b.value < a)) {
        a = b.value;
      }
    }
    return Number.isFinite(e) && Number.isFinite(a);
  }
}
Xe.create = b => new Xe({
  checks: [],
  typeName: Ig.ZodNumber,
  coerce: b?.coerce || false,
  ...ae(b)
});
class Ye extends xe {
  constructor() {
    super(...arguments);
    this.min = this.gte;
    this.max = this.lte;
  }
  _parse(b) {
    if (this._def.coerce) {
      b.data = BigInt(b.data);
    }
    if (this._getType(b) !== Vc.bigint) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.bigint,
        received: a.parsedType
      });
      return oe;
    }
    let a;
    const f = new ne();
    for (const c of this._def.checks) {
      if (c.kind === "min") {
        if (c.inclusive ? b.data < c.value : b.data <= c.value) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.too_small,
            type: "bigint",
            minimum: c.value,
            inclusive: c.inclusive,
            message: c.message
          });
          f.dirty();
        }
      } else if (c.kind === "max") {
        if (c.inclusive ? b.data > c.value : b.data >= c.value) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.too_big,
            type: "bigint",
            maximum: c.value,
            inclusive: c.inclusive,
            message: c.message
          });
          f.dirty();
        }
      } else if (c.kind === "multipleOf") {
        if (b.data % c.value !== BigInt(0)) {
          a = this._getOrReturnCtx(b, a);
          ie(a, {
            code: qa.not_multiple_of,
            multipleOf: c.value,
            message: c.message
          });
          f.dirty();
        }
      } else {
        Qc.assertNever(c);
      }
    }
    return {
      status: f.value,
      value: b.data
    };
  }
  gte(c, a) {
    return this.setLimit("min", c, true, Ga.toString(a));
  }
  gt(c, a) {
    return this.setLimit("min", c, false, Ga.toString(a));
  }
  lte(c, a) {
    return this.setLimit("max", c, true, Ga.toString(a));
  }
  lt(c, a) {
    return this.setLimit("max", c, false, Ga.toString(a));
  }
  setLimit(e, a, b, c) {
    return new Ye({
      ...this._def,
      checks: [...this._def.checks, {
        kind: e,
        value: a,
        inclusive: b,
        message: Ga.toString(c)
      }]
    });
  }
  _addCheck(b) {
    return new Ye({
      ...this._def,
      checks: [...this._def.checks, b]
    });
  }
  positive(b) {
    return this._addCheck({
      kind: "min",
      value: BigInt(0),
      inclusive: false,
      message: Ga.toString(b)
    });
  }
  negative(b) {
    return this._addCheck({
      kind: "max",
      value: BigInt(0),
      inclusive: false,
      message: Ga.toString(b)
    });
  }
  nonpositive(b) {
    return this._addCheck({
      kind: "max",
      value: BigInt(0),
      inclusive: true,
      message: Ga.toString(b)
    });
  }
  nonnegative(b) {
    return this._addCheck({
      kind: "min",
      value: BigInt(0),
      inclusive: true,
      message: Ga.toString(b)
    });
  }
  multipleOf(c, a) {
    return this._addCheck({
      kind: "multipleOf",
      value: c,
      message: Ga.toString(a)
    });
  }
  get minValue() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "min" && (a === null || b.value > a)) {
        a = b.value;
      }
    }
    return a;
  }
  get maxValue() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "max" && (a === null || b.value < a)) {
        a = b.value;
      }
    }
    return a;
  }
}
Ye.create = b => {
  return new Ye({
    checks: [],
    typeName: Ig.ZodBigInt,
    coerce: b?.coerce ?? false,
    ...ae(b)
  });
};
class $e extends xe {
  _parse(b) {
    if (this._def.coerce) {
      b.data = !!b.data;
    }
    if (this._getType(b) !== Vc.boolean) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.boolean,
        received: a.parsedType
      });
      return oe;
    }
    return re(b.data);
  }
}
$e.create = b => new $e({
  typeName: Ig.ZodBoolean,
  coerce: b?.coerce || false,
  ...ae(b)
});
class _e extends xe {
  _parse(b) {
    if (this._def.coerce) {
      b.data = new Date(b.data);
    }
    if (this._getType(b) !== Vc.date) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.date,
        received: a.parsedType
      });
      return oe;
    }
    if (isNaN(b.data.getTime())) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_date
      });
      return oe;
    }
    const a = new ne();
    let c;
    for (const d of this._def.checks) {
      if (d.kind === "min") {
        if (b.data.getTime() < d.value) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.too_small,
            message: d.message,
            inclusive: true,
            exact: false,
            minimum: d.value,
            type: "date"
          });
          a.dirty();
        }
      } else if (d.kind === "max") {
        if (b.data.getTime() > d.value) {
          c = this._getOrReturnCtx(b, c);
          ie(c, {
            code: qa.too_big,
            message: d.message,
            inclusive: true,
            exact: false,
            maximum: d.value,
            type: "date"
          });
          a.dirty();
        }
      } else {
        Qc.assertNever(d);
      }
    }
    return {
      status: a.value,
      value: new Date(b.data.getTime())
    };
  }
  _addCheck(b) {
    return new _e({
      ...this._def,
      checks: [...this._def.checks, b]
    });
  }
  min(c, a) {
    return this._addCheck({
      kind: "min",
      value: c.getTime(),
      message: Ga.toString(a)
    });
  }
  max(c, a) {
    return this._addCheck({
      kind: "max",
      value: c.getTime(),
      message: Ga.toString(a)
    });
  }
  get minDate() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "min" && (a === null || b.value > a)) {
        a = b.value;
      }
    }
    if (a != null) {
      return new Date(a);
    } else {
      return null;
    }
  }
  get maxDate() {
    let a = null;
    for (const b of this._def.checks) {
      if (b.kind === "max" && (a === null || b.value < a)) {
        a = b.value;
      }
    }
    if (a != null) {
      return new Date(a);
    } else {
      return null;
    }
  }
}
_e.create = b => new _e({
  checks: [],
  coerce: b?.coerce || false,
  typeName: Ig.ZodDate,
  ...ae(b)
});
class ag extends xe {
  _parse(b) {
    if (this._getType(b) !== Vc.symbol) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.symbol,
        received: a.parsedType
      });
      return oe;
    }
    return re(b.data);
  }
}
ag.create = b => new ag({
  typeName: Ig.ZodSymbol,
  ...ae(b)
});
class bg extends xe {
  _parse(b) {
    if (this._getType(b) !== Vc.undefined) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.undefined,
        received: a.parsedType
      });
      return oe;
    }
    return re(b.data);
  }
}
bg.create = b => new bg({
  typeName: Ig.ZodUndefined,
  ...ae(b)
});
class cg extends xe {
  _parse(b) {
    if (this._getType(b) !== Vc.null) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.null,
        received: a.parsedType
      });
      return oe;
    }
    return re(b.data);
  }
}
cg.create = b => new cg({
  typeName: Ig.ZodNull,
  ...ae(b)
});
class dg extends xe {
  constructor() {
    super(...arguments);
    this._any = true;
  }
  _parse(b) {
    return re(b.data);
  }
}
dg.create = b => new dg({
  typeName: Ig.ZodAny,
  ...ae(b)
});
class eg extends xe {
  constructor() {
    super(...arguments);
    this._unknown = true;
  }
  _parse(b) {
    return re(b.data);
  }
}
eg.create = b => new eg({
  typeName: Ig.ZodUnknown,
  ...ae(b)
});
class fg extends xe {
  _parse(b) {
    const a = this._getOrReturnCtx(b);
    ie(a, {
      code: qa.invalid_type,
      expected: Vc.never,
      received: a.parsedType
    });
    return oe;
  }
}
fg.create = b => new fg({
  typeName: Ig.ZodNever,
  ...ae(b)
});
class gg extends xe {
  _parse(b) {
    if (this._getType(b) !== Vc.undefined) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.void,
        received: a.parsedType
      });
      return oe;
    }
    return re(b.data);
  }
}
gg.create = b => new gg({
  typeName: Ig.ZodVoid,
  ...ae(b)
});
class hg extends xe {
  _parse(b) {
    const {
      ctx: g,
      status: c
    } = this._processInputParams(b);
    const h = this._def;
    if (g.parsedType !== Vc.array) {
      ie(g, {
        code: qa.invalid_type,
        expected: Vc.array,
        received: g.parsedType
      });
      return oe;
    }
    if (h.exactLength !== null) {
      const b = g.data.length > h.exactLength.value;
      const a = g.data.length < h.exactLength.value;
      if (b || a) {
        ie(g, {
          code: b ? qa.too_big : qa.too_small,
          minimum: a ? h.exactLength.value : undefined,
          maximum: b ? h.exactLength.value : undefined,
          type: "array",
          inclusive: true,
          exact: true,
          message: h.exactLength.message
        });
        c.dirty();
      }
    }
    if (h.minLength !== null && g.data.length < h.minLength.value) {
      ie(g, {
        code: qa.too_small,
        minimum: h.minLength.value,
        type: "array",
        inclusive: true,
        exact: false,
        message: h.minLength.message
      });
      c.dirty();
    }
    if (h.maxLength !== null && g.data.length > h.maxLength.value) {
      ie(g, {
        code: qa.too_big,
        maximum: h.maxLength.value,
        type: "array",
        inclusive: true,
        exact: false,
        message: h.maxLength.message
      });
      c.dirty();
    }
    if (g.common.async) {
      return Promise.all([...g.data].map((b, a) => h.type._parseAsync(new ue(g, b, g.path, a)))).then(b => ne.mergeArray(c, b));
    }
    const a = [...g.data].map((b, a) => h.type._parseSync(new ue(g, b, g.path, a)));
    return ne.mergeArray(c, a);
  }
  get element() {
    return this._def.type;
  }
  min(c, a) {
    return new hg({
      ...this._def,
      minLength: {
        value: c,
        message: Ga.toString(a)
      }
    });
  }
  max(c, a) {
    return new hg({
      ...this._def,
      maxLength: {
        value: c,
        message: Ga.toString(a)
      }
    });
  }
  length(c, a) {
    return new hg({
      ...this._def,
      exactLength: {
        value: c,
        message: Ga.toString(a)
      }
    });
  }
  nonempty(b) {
    return this.min(1, b);
  }
}
hg.create = (c, a) => new hg({
  type: c,
  minLength: null,
  maxLength: null,
  exactLength: null,
  typeName: Ig.ZodArray,
  ...ae(a)
});
function ig(b) {
  if (b instanceof jg) {
    const a = {};
    for (const c in b.shape) {
      const d = b.shape[c];
      a[c] = yg.create(ig(d));
    }
    return new jg({
      ...b._def,
      shape: () => a
    });
  } else if (b instanceof hg) {
    return new hg({
      ...b._def,
      type: ig(b.element)
    });
  } else if (b instanceof yg) {
    return yg.create(ig(b.unwrap()));
  } else if (b instanceof zg) {
    return zg.create(ig(b.unwrap()));
  } else if (b instanceof ca) {
    return ca.create(b.items.map(b => ig(b)));
  } else {
    return b;
  }
}
class jg extends xe {
  constructor() {
    super(...arguments);
    this._cached = null;
    this.nonstrict = this.passthrough;
    this.augment = this.extend;
  }
  _getCached() {
    if (this._cached !== null) {
      return this._cached;
    }
    const a = this._def.shape();
    const b = Qc.objectKeys(a);
    return this._cached = {
      shape: a,
      keys: b
    };
  }
  _parse(b) {
    if (this._getType(b) !== Vc.object) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.object,
        received: a.parsedType
      });
      return oe;
    }
    const {
      status: i,
      ctx: j
    } = this._processInputParams(b);
    const {
      shape: d,
      keys: e
    } = this._getCached();
    const f = [];
    if (!(this._def.catchall instanceof fg) || this._def.unknownKeys !== "strip") {
      for (const b in j.data) {
        if (!e.includes(b)) {
          f.push(b);
        }
      }
    }
    const g = [];
    for (const h of e) {
      const b = d[h];
      const a = j.data[h];
      g.push({
        key: {
          status: "valid",
          value: h
        },
        value: b._parse(new ue(j, a, j.path, h)),
        alwaysSet: h in j.data
      });
    }
    if (this._def.catchall instanceof fg) {
      const b = this._def.unknownKeys;
      if (b === "passthrough") {
        for (const b of f) {
          g.push({
            key: {
              status: "valid",
              value: b
            },
            value: {
              status: "valid",
              value: j.data[b]
            }
          });
        }
      } else if (b === "strict") {
        if (f.length > 0) {
          ie(j, {
            code: qa.unrecognized_keys,
            keys: f
          });
          i.dirty();
        }
      } else if (b !== "strip") {
        throw new Error("Internal ZodObject error: invalid unknownKeys value.");
      }
    } else {
      const b = this._def.catchall;
      for (const a of f) {
        const c = j.data[a];
        g.push({
          key: {
            status: "valid",
            value: a
          },
          value: b._parse(new ue(j, c, j.path, a)),
          alwaysSet: a in j.data
        });
      }
    }
    if (j.common.async) {
      return Promise.resolve().then(async () => {
        const a = [];
        for (const c of g) {
          const b = await c.key;
          a.push({
            key: b,
            value: await c.value,
            alwaysSet: c.alwaysSet
          });
        }
        return a;
      }).then(b => ne.mergeObjectSync(i, b));
    } else {
      return ne.mergeObjectSync(i, g);
    }
  }
  get shape() {
    return this._def.shape();
  }
  strict(b) {
    Ga.errToObj;
    return new jg({
      ...this._def,
      unknownKeys: "strict",
      ...(b !== undefined ? {
        errorMap: (a, c) => {
          var d;
          var e;
          const i = ((e = (d = this._def).errorMap) === null || e === undefined ? undefined : e.call(d, a, c).message) ?? c.defaultError;
          if (a.code === "unrecognized_keys") {
            return {
              message: Ga.errToObj(b).message ?? i
            };
          } else {
            return {
              message: i
            };
          }
        }
      } : {})
    });
  }
  strip() {
    return new jg({
      ...this._def,
      unknownKeys: "strip"
    });
  }
  passthrough() {
    return new jg({
      ...this._def,
      unknownKeys: "passthrough"
    });
  }
  extend(b) {
    return new jg({
      ...this._def,
      shape: () => ({
        ...this._def.shape(),
        ...b
      })
    });
  }
  merge(b) {
    return new jg({
      unknownKeys: b._def.unknownKeys,
      catchall: b._def.catchall,
      shape: () => ({
        ...this._def.shape(),
        ...b._def.shape()
      }),
      typeName: Ig.ZodObject
    });
  }
  setKey(c, a) {
    return this.augment({
      [c]: a
    });
  }
  catchall(b) {
    return new jg({
      ...this._def,
      catchall: b
    });
  }
  pick(b) {
    const a = {};
    Qc.objectKeys(b).forEach(c => {
      if (b[c] && this.shape[c]) {
        a[c] = this.shape[c];
      }
    });
    return new jg({
      ...this._def,
      shape: () => a
    });
  }
  omit(d) {
    const a = {};
    Qc.objectKeys(this.shape).forEach(c => {
      if (!d[c]) {
        a[c] = this.shape[c];
      }
    });
    return new jg({
      ...this._def,
      shape: () => a
    });
  }
  deepPartial() {
    return ig(this);
  }
  partial(b) {
    const a = {};
    Qc.objectKeys(this.shape).forEach(c => {
      const d = this.shape[c];
      if (b && !b[c]) {
        a[c] = d;
      } else {
        a[c] = d.optional();
      }
    });
    return new jg({
      ...this._def,
      shape: () => a
    });
  }
  required(b) {
    const e = {};
    Qc.objectKeys(this.shape).forEach(c => {
      if (b && !b[c]) {
        e[c] = this.shape[c];
      } else {
        let b = this.shape[c];
        while (b instanceof yg) {
          b = b._def.innerType;
        }
        e[c] = b;
      }
    });
    return new jg({
      ...this._def,
      shape: () => e
    });
  }
  keyof() {
    return tg(Qc.objectKeys(this.shape));
  }
}
jg.create = (c, a) => new jg({
  shape: () => c,
  unknownKeys: "strip",
  catchall: fg.create(),
  typeName: Ig.ZodObject,
  ...ae(a)
});
jg.strictCreate = (c, a) => new jg({
  shape: () => c,
  unknownKeys: "strict",
  catchall: fg.create(),
  typeName: Ig.ZodObject,
  ...ae(a)
});
jg.lazycreate = (c, a) => new jg({
  shape: c,
  unknownKeys: "strip",
  catchall: fg.create(),
  typeName: Ig.ZodObject,
  ...ae(a)
});
class kg extends xe {
  _parse(b) {
    const {
      ctx: h
    } = this._processInputParams(b);
    const c = this._def.options;
    function a(c) {
      for (const a of c) {
        if (a.result.status === "valid") {
          return a.result;
        }
      }
      for (const a of c) {
        if (a.result.status === "dirty") {
          h.common.issues.push(...a.ctx.common.issues);
          return a.result;
        }
      }
      const a = c.map(b => new Yc(b.ctx.common.issues));
      ie(h, {
        code: qa.invalid_union,
        unionErrors: a
      });
      return oe;
    }
    if (h.common.async) {
      return Promise.all(c.map(async b => {
        const a = {
          ...h,
          common: {
            ...h.common,
            issues: []
          },
          parent: null
        };
        return {
          result: await b._parseAsync({
            data: h.data,
            path: h.path,
            parent: a
          }),
          ctx: a
        };
      })).then(a);
    }
    {
      let b;
      const a = [];
      for (const e of c) {
        const c = {
          ...h,
          common: {
            ...h.common,
            issues: []
          },
          parent: null
        };
        const d = e._parseSync({
          data: h.data,
          path: h.path,
          parent: c
        });
        if (d.status === "valid") {
          return d;
        }
        if (d.status === "dirty" && !b) {
          b = {
            result: d,
            ctx: c
          };
        }
        if (c.common.issues.length) {
          a.push(c.common.issues);
        }
      }
      if (b) {
        h.common.issues.push(...b.ctx.common.issues);
        return b.result;
      }
      const d = a.map(b => new Yc(b));
      ie(h, {
        code: qa.invalid_union,
        unionErrors: d
      });
      return oe;
    }
  }
  get options() {
    return this._def.options;
  }
}
kg.create = (c, a) => new kg({
  options: c,
  typeName: Ig.ZodUnion,
  ...ae(a)
});
const lg = b => b instanceof rg ? lg(b.schema) : b instanceof xg ? lg(b.innerType()) : b instanceof sg ? [b.value] : b instanceof ug ? b.options : b instanceof vg ? Object.keys(b.enum) : b instanceof Ag ? lg(b._def.innerType) : b instanceof bg ? [undefined] : b instanceof cg ? [null] : null;
class Re extends xe {
  _parse(b) {
    const {
      ctx: a
    } = this._processInputParams(b);
    if (a.parsedType !== Vc.object) {
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.object,
        received: a.parsedType
      });
      return oe;
    }
    const c = this.discriminator;
    const d = a.data[c];
    const e = this.optionsMap.get(d);
    if (e) {
      if (a.common.async) {
        return e._parseAsync({
          data: a.data,
          path: a.path,
          parent: a
        });
      } else {
        return e._parseSync({
          data: a.data,
          path: a.path,
          parent: a
        });
      }
    } else {
      ie(a, {
        code: qa.invalid_union_discriminator,
        options: Array.from(this.optionsMap.keys()),
        path: [c]
      });
      return oe;
    }
  }
  get discriminator() {
    return this._def.discriminator;
  }
  get options() {
    return this._def.options;
  }
  get optionsMap() {
    return this._def.optionsMap;
  }
  static create(d, a, b) {
    const g = new Map();
    for (const e of a) {
      const a = lg(e.shape[d]);
      if (!a) {
        throw new Error("A discriminator value for key `" + d + "` could not be extracted from all schema options");
      }
      for (const b of a) {
        if (g.has(b)) {
          throw new Error("Discriminator property " + String(d) + " has duplicate value " + String(b));
        }
        g.set(b, e);
      }
    }
    return new Re({
      typeName: Ig.ZodDiscriminatedUnion,
      discriminator: d,
      options: a,
      optionsMap: g,
      ...ae(b)
    });
  }
}
function mg(c, a) {
  const b = Wc(c);
  const d = Wc(a);
  if (c === a) {
    return {
      valid: true,
      data: c
    };
  }
  if (b === Vc.object && d === Vc.object) {
    const b = Qc.objectKeys(a);
    const g = Qc.objectKeys(c).filter(c => b.indexOf(c) !== -1);
    const h = {
      ...c,
      ...a
    };
    for (const b of g) {
      const d = mg(c[b], a[b]);
      if (!d.valid) {
        return {
          valid: false
        };
      }
      h[b] = d.data;
    }
    return {
      valid: true,
      data: h
    };
  } else if (b === Vc.array && d === Vc.array) {
    if (c.length !== a.length) {
      return {
        valid: false
      };
    }
    const b = [];
    for (let d = 0; d < c.length; d++) {
      const e = c[d];
      const f = a[d];
      const g = mg(e, f);
      if (!g.valid) {
        return {
          valid: false
        };
      }
      b.push(g.data);
    }
    return {
      valid: true,
      data: b
    };
  } else if (b === Vc.date && d === Vc.date && +c == +a) {
    return {
      valid: true,
      data: c
    };
  } else {
    return {
      valid: false
    };
  }
}
class ng extends xe {
  _parse(b) {
    const {
      status: f,
      ctx: a
    } = this._processInputParams(b);
    const c = (b, c) => {
      if (fe(b) || fe(c)) {
        return oe;
      }
      const d = mg(b.value, c.value);
      if (d.valid) {
        if (se(b) || se(c)) {
          f.dirty();
        }
        return {
          status: f.value,
          value: d.data
        };
      } else {
        ie(a, {
          code: qa.invalid_intersection_types
        });
        return oe;
      }
    };
    if (a.common.async) {
      return Promise.all([this._def.left._parseAsync({
        data: a.data,
        path: a.path,
        parent: a
      }), this._def.right._parseAsync({
        data: a.data,
        path: a.path,
        parent: a
      })]).then(([d, a]) => c(d, a));
    } else {
      return c(this._def.left._parseSync({
        data: a.data,
        path: a.path,
        parent: a
      }), this._def.right._parseSync({
        data: a.data,
        path: a.path,
        parent: a
      }));
    }
  }
}
ng.create = (d, a, b) => new ng({
  left: d,
  right: a,
  typeName: Ig.ZodIntersection,
  ...ae(b)
});
class ca extends xe {
  _parse(b) {
    const {
      status: f,
      ctx: g
    } = this._processInputParams(b);
    if (g.parsedType !== Vc.array) {
      ie(g, {
        code: qa.invalid_type,
        expected: Vc.array,
        received: g.parsedType
      });
      return oe;
    }
    if (g.data.length < this._def.items.length) {
      ie(g, {
        code: qa.too_small,
        minimum: this._def.items.length,
        inclusive: true,
        exact: false,
        type: "array"
      });
      return oe;
    }
    if (!this._def.rest && g.data.length > this._def.items.length) {
      ie(g, {
        code: qa.too_big,
        maximum: this._def.items.length,
        inclusive: true,
        exact: false,
        type: "array"
      });
      f.dirty();
    }
    const a = [...g.data].map((b, a) => {
      const c = this._def.items[a] || this._def.rest;
      if (c) {
        return c._parse(new ue(g, b, g.path, a));
      } else {
        return null;
      }
    }).filter(b => !!b);
    if (g.common.async) {
      return Promise.all(a).then(b => ne.mergeArray(f, b));
    } else {
      return ne.mergeArray(f, a);
    }
  }
  get items() {
    return this._def.items;
  }
  rest(b) {
    return new ca({
      ...this._def,
      rest: b
    });
  }
}
ca.create = (c, a) => {
  if (!Array.isArray(c)) {
    throw new Error("You must pass an array of schemas to z.tuple([ ... ])");
  }
  return new ca({
    items: c,
    typeName: Ig.ZodTuple,
    rest: null,
    ...ae(a)
  });
};
class Xa extends xe {
  get keySchema() {
    return this._def.keyType;
  }
  get valueSchema() {
    return this._def.valueType;
  }
  _parse(b) {
    const {
      status: a,
      ctx: h
    } = this._processInputParams(b);
    if (h.parsedType !== Vc.object) {
      ie(h, {
        code: qa.invalid_type,
        expected: Vc.object,
        received: h.parsedType
      });
      return oe;
    }
    const d = [];
    const e = this._def.keyType;
    const f = this._def.valueType;
    for (const a in h.data) {
      d.push({
        key: e._parse(new ue(h, a, h.path, a)),
        value: f._parse(new ue(h, h.data[a], h.path, a))
      });
    }
    if (h.common.async) {
      return ne.mergeObjectAsync(a, d);
    } else {
      return ne.mergeObjectSync(a, d);
    }
  }
  get element() {
    return this._def.valueType;
  }
  static create(d, a, b) {
    if (a instanceof xe) {
      return new Xa({
        keyType: d,
        valueType: a,
        typeName: Ig.ZodRecord,
        ...ae(b)
      });
    } else {
      return new Xa({
        keyType: Pe.create(),
        valueType: d,
        typeName: Ig.ZodRecord,
        ...ae(a)
      });
    }
  }
}
class og extends xe {
  _parse(b) {
    const {
      status: h,
      ctx: i
    } = this._processInputParams(b);
    if (i.parsedType !== Vc.map) {
      ie(i, {
        code: qa.invalid_type,
        expected: Vc.map,
        received: i.parsedType
      });
      return oe;
    }
    const d = this._def.keyType;
    const e = this._def.valueType;
    const c = [...i.data.entries()].map(([b, a], c) => ({
      key: d._parse(new ue(i, b, i.path, [c, "key"])),
      value: e._parse(new ue(i, a, i.path, [c, "value"]))
    }));
    if (i.common.async) {
      const d = new Map();
      return Promise.resolve().then(async () => {
        for (const a of c) {
          const b = await a.key;
          const c = await a.value;
          if (b.status === "aborted" || c.status === "aborted") {
            return oe;
          }
          if (b.status === "dirty" || c.status === "dirty") {
            h.dirty();
          }
          d.set(b.value, c.value);
        }
        return {
          status: h.value,
          value: d
        };
      });
    } else {
      const b = new Map();
      for (const a of c) {
        const c = a.key;
        const d = a.value;
        if (c.status === "aborted" || d.status === "aborted") {
          return oe;
        }
        if (c.status === "dirty" || d.status === "dirty") {
          h.dirty();
        }
        b.set(c.value, d.value);
      }
      return {
        status: h.value,
        value: b
      };
    }
  }
}
og.create = (d, a, b) => new og({
  valueType: a,
  keyType: d,
  typeName: Ig.ZodMap,
  ...ae(b)
});
class pg extends xe {
  _parse(b) {
    const {
      status: i,
      ctx: j
    } = this._processInputParams(b);
    if (j.parsedType !== Vc.set) {
      ie(j, {
        code: qa.invalid_type,
        expected: Vc.set,
        received: j.parsedType
      });
      return oe;
    }
    const a = this._def;
    if (a.minSize !== null && j.data.size < a.minSize.value) {
      ie(j, {
        code: qa.too_small,
        minimum: a.minSize.value,
        type: "set",
        inclusive: true,
        exact: false,
        message: a.minSize.message
      });
      i.dirty();
    }
    if (a.maxSize !== null && j.data.size > a.maxSize.value) {
      ie(j, {
        code: qa.too_big,
        maximum: a.maxSize.value,
        type: "set",
        inclusive: true,
        exact: false,
        message: a.maxSize.message
      });
      i.dirty();
    }
    const d = this._def.valueType;
    function c(c) {
      const a = new Set();
      for (const d of c) {
        if (d.status === "aborted") {
          return oe;
        }
        if (d.status === "dirty") {
          i.dirty();
        }
        a.add(d.value);
      }
      return {
        status: i.value,
        value: a
      };
    }
    const e = [...j.data.values()].map((b, a) => d._parse(new ue(j, b, j.path, a)));
    if (j.common.async) {
      return Promise.all(e).then(b => c(b));
    } else {
      return c(e);
    }
  }
  min(c, a) {
    return new pg({
      ...this._def,
      minSize: {
        value: c,
        message: Ga.toString(a)
      }
    });
  }
  max(c, a) {
    return new pg({
      ...this._def,
      maxSize: {
        value: c,
        message: Ga.toString(a)
      }
    });
  }
  size(c, a) {
    return this.min(c, a).max(c, a);
  }
  nonempty(b) {
    return this.min(1, b);
  }
}
pg.create = (c, a) => new pg({
  valueType: c,
  minSize: null,
  maxSize: null,
  typeName: Ig.ZodSet,
  ...ae(a)
});
class qg extends xe {
  constructor() {
    super(...arguments);
    this.validate = this.implement;
  }
  _parse(b) {
    const {
      ctx: h
    } = this._processInputParams(b);
    if (h.parsedType !== Vc.function) {
      ie(h, {
        code: qa.invalid_type,
        expected: Vc.function,
        received: h.parsedType
      });
      return oe;
    }
    function c(b, a) {
      return ge({
        data: b,
        path: h.path,
        errorMaps: [h.common.contextualErrorMap, h.schemaErrorMap, ee(), Y].filter(b => !!b),
        issueData: {
          code: qa.invalid_arguments,
          argumentsError: a
        }
      });
    }
    function d(b, a) {
      return ge({
        data: b,
        path: h.path,
        errorMaps: [h.common.contextualErrorMap, h.schemaErrorMap, ee(), Y].filter(b => !!b),
        issueData: {
          code: qa.invalid_return_type,
          returnTypeError: a
        }
      });
    }
    const e = {
      errorMap: h.common.contextualErrorMap
    };
    const f = h.data;
    if (this._def.returns instanceof wg) {
      return re(async (...g) => {
        const k = new Yc([]);
        const a = await this._def.args.parseAsync(g, e).catch(a => {
          k.addIssue(c(g, a));
          throw k;
        });
        const b = await f(...a);
        return await this._def.returns._def.type.parseAsync(b, e).catch(c => {
          k.addIssue(d(b, c));
          throw k;
        });
      });
    } else {
      return re((...b) => {
        const a = this._def.args.safeParse(b, e);
        if (!a.success) {
          throw new Yc([c(b, a.error)]);
        }
        const g = f(...a.data);
        const h = this._def.returns.safeParse(g, e);
        if (!h.success) {
          throw new Yc([d(g, h.error)]);
        }
        return h.data;
      });
    }
  }
  parameters() {
    return this._def.args;
  }
  returnType() {
    return this._def.returns;
  }
  args(...b) {
    return new qg({
      ...this._def,
      args: ca.create(b).rest(eg.create())
    });
  }
  returns(b) {
    return new qg({
      ...this._def,
      returns: b
    });
  }
  implement(b) {
    return this.parse(b);
  }
  strictImplement(b) {
    return this.parse(b);
  }
  static create(d, a, b) {
    return new qg({
      args: d || ca.create([]).rest(eg.create()),
      returns: a || eg.create(),
      typeName: Ig.ZodFunction,
      ...ae(b)
    });
  }
}
class rg extends xe {
  get schema() {
    return this._def.getter();
  }
  _parse(b) {
    const {
      ctx: a
    } = this._processInputParams(b);
    return this._def.getter()._parse({
      data: a.data,
      path: a.path,
      parent: a
    });
  }
}
rg.create = (c, a) => new rg({
  getter: c,
  typeName: Ig.ZodLazy,
  ...ae(a)
});
class sg extends xe {
  _parse(b) {
    if (b.data !== this._def.value) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        received: a.data,
        code: qa.invalid_literal,
        expected: this._def.value
      });
      return oe;
    }
    return {
      status: "valid",
      value: b.data
    };
  }
  get value() {
    return this._def.value;
  }
}
sg.create = (c, a) => new sg({
  value: c,
  typeName: Ig.ZodLiteral,
  ...ae(a)
});
function tg(c, a) {
  return new ug({
    values: c,
    typeName: Ig.ZodEnum,
    ...ae(a)
  });
}
class ug extends xe {
  _parse(b) {
    if (typeof b.data != "string") {
      const a = this._getOrReturnCtx(b);
      const c = this._def.values;
      ie(a, {
        expected: Qc.joinValues(c),
        received: a.parsedType,
        code: qa.invalid_type
      });
      return oe;
    }
    if (this._def.values.indexOf(b.data) === -1) {
      const a = this._getOrReturnCtx(b);
      const c = this._def.values;
      ie(a, {
        received: a.data,
        code: qa.invalid_enum_value,
        options: c
      });
      return oe;
    }
    return re(b.data);
  }
  get options() {
    return this._def.values;
  }
  get enum() {
    const a = {};
    for (const b of this._def.values) {
      a[b] = b;
    }
    return a;
  }
  get Values() {
    const a = {};
    for (const b of this._def.values) {
      a[b] = b;
    }
    return a;
  }
  get Enum() {
    const a = {};
    for (const b of this._def.values) {
      a[b] = b;
    }
    return a;
  }
  extract(b) {
    return ug.create(b);
  }
  exclude(b) {
    return ug.create(this.options.filter(a => !b.includes(a)));
  }
}
ug.create = tg;
class vg extends xe {
  _parse(b) {
    const e = Qc.getValidEnumValues(this._def.values);
    const c = this._getOrReturnCtx(b);
    if (c.parsedType !== Vc.string && c.parsedType !== Vc.number) {
      const b = Qc.objectValues(e);
      ie(c, {
        expected: Qc.joinValues(b),
        received: c.parsedType,
        code: qa.invalid_type
      });
      return oe;
    }
    if (e.indexOf(b.data) === -1) {
      const b = Qc.objectValues(e);
      ie(c, {
        received: c.data,
        code: qa.invalid_enum_value,
        options: b
      });
      return oe;
    }
    return re(b.data);
  }
  get enum() {
    return this._def.values;
  }
}
vg.create = (c, a) => new vg({
  values: c,
  typeName: Ig.ZodNativeEnum,
  ...ae(a)
});
class wg extends xe {
  unwrap() {
    return this._def.type;
  }
  _parse(b) {
    const {
      ctx: e
    } = this._processInputParams(b);
    if (e.parsedType !== Vc.promise && e.common.async === false) {
      ie(e, {
        code: qa.invalid_type,
        expected: Vc.promise,
        received: e.parsedType
      });
      return oe;
    }
    const a = e.parsedType === Vc.promise ? e.data : Promise.resolve(e.data);
    return re(a.then(b => this._def.type.parseAsync(b, {
      path: e.path,
      errorMap: e.common.contextualErrorMap
    })));
  }
}
wg.create = (c, a) => new wg({
  type: c,
  typeName: Ig.ZodPromise,
  ...ae(a)
});
class xg extends xe {
  innerType() {
    return this._def.schema;
  }
  sourceType() {
    if (this._def.schema._def.typeName === Ig.ZodEffects) {
      return this._def.schema.sourceType();
    } else {
      return this._def.schema;
    }
  }
  _parse(b) {
    const {
      status: h,
      ctx: c
    } = this._processInputParams(b);
    const d = this._def.effect || null;
    if (d.type === "preprocess") {
      const b = d.transform(c.data);
      if (c.common.async) {
        return Promise.resolve(b).then(b => this._def.schema._parseAsync({
          data: b,
          path: c.path,
          parent: c
        }));
      } else {
        return this._def.schema._parseSync({
          data: b,
          path: c.path,
          parent: c
        });
      }
    }
    const e = {
      addIssue: b => {
        ie(c, b);
        if (b.fatal) {
          h.abort();
        } else {
          h.dirty();
        }
      },
      get path() {
        return c.path;
      }
    };
    e.addIssue = e.addIssue.bind(e);
    if (d.type === "refinement") {
      const b = b => {
        const a = d.refinement(b, e);
        if (c.common.async) {
          return Promise.resolve(a);
        }
        if (a instanceof Promise) {
          throw new Error("Async refinement encountered during synchronous parse operation. Use .parseAsync instead.");
        }
        return b;
      };
      if (c.common.async === false) {
        const a = this._def.schema._parseSync({
          data: c.data,
          path: c.path,
          parent: c
        });
        if (a.status === "aborted") {
          return oe;
        } else {
          if (a.status === "dirty") {
            h.dirty();
          }
          b(a.value);
          return {
            status: h.value,
            value: a.value
          };
        }
      } else {
        return this._def.schema._parseAsync({
          data: c.data,
          path: c.path,
          parent: c
        }).then(a => a.status === "aborted" ? oe : (a.status === "dirty" && h.dirty(), b(a.value).then(() => ({
          status: h.value,
          value: a.value
        }))));
      }
    }
    if (d.type === "transform") {
      if (c.common.async === false) {
        const b = this._def.schema._parseSync({
          data: c.data,
          path: c.path,
          parent: c
        });
        if (!te(b)) {
          return b;
        }
        const a = d.transform(b.value, e);
        if (a instanceof Promise) {
          throw new Error("Asynchronous transform encountered during synchronous parse operation. Use .parseAsync instead.");
        }
        return {
          status: h.value,
          value: a
        };
      } else {
        return this._def.schema._parseAsync({
          data: c.data,
          path: c.path,
          parent: c
        }).then(b => te(b) ? Promise.resolve(d.transform(b.value, e)).then(b => ({
          status: h.value,
          value: b
        })) : b);
      }
    }
    Qc.assertNever(d);
  }
}
xg.create = (d, a, b) => new xg({
  schema: d,
  typeName: Ig.ZodEffects,
  effect: a,
  ...ae(b)
});
xg.createWithPreprocess = (d, a, b) => new xg({
  schema: a,
  effect: {
    type: "preprocess",
    transform: d
  },
  typeName: Ig.ZodEffects,
  ...ae(b)
});
class yg extends xe {
  _parse(b) {
    if (this._getType(b) === Vc.undefined) {
      return re(undefined);
    } else {
      return this._def.innerType._parse(b);
    }
  }
  unwrap() {
    return this._def.innerType;
  }
}
yg.create = (c, a) => new yg({
  innerType: c,
  typeName: Ig.ZodOptional,
  ...ae(a)
});
class zg extends xe {
  _parse(b) {
    if (this._getType(b) === Vc.null) {
      return re(null);
    } else {
      return this._def.innerType._parse(b);
    }
  }
  unwrap() {
    return this._def.innerType;
  }
}
zg.create = (c, a) => new zg({
  innerType: c,
  typeName: Ig.ZodNullable,
  ...ae(a)
});
class Ag extends xe {
  _parse(b) {
    const {
      ctx: a
    } = this._processInputParams(b);
    let c = a.data;
    if (a.parsedType === Vc.undefined) {
      c = this._def.defaultValue();
    }
    return this._def.innerType._parse({
      data: c,
      path: a.path,
      parent: a
    });
  }
  removeDefault() {
    return this._def.innerType;
  }
}
Ag.create = (c, a) => new Ag({
  innerType: c,
  typeName: Ig.ZodDefault,
  defaultValue: typeof a.default == "function" ? a.default : () => a.default,
  ...ae(a)
});
class Bg extends xe {
  _parse(b) {
    const {
      ctx: a
    } = this._processInputParams(b);
    const c = {
      ...a,
      common: {
        ...a.common,
        issues: []
      }
    };
    const d = this._def.innerType._parse({
      data: c.data,
      path: c.path,
      parent: {
        ...c
      }
    });
    if (Ka(d)) {
      return d.then(b => ({
        status: "valid",
        value: b.status === "valid" ? b.value : this._def.catchValue({
          get error() {
            return new Yc(c.common.issues);
          },
          input: c.data
        })
      }));
    } else {
      return {
        status: "valid",
        value: d.status === "valid" ? d.value : this._def.catchValue({
          get error() {
            return new Yc(c.common.issues);
          },
          input: c.data
        })
      };
    }
  }
  removeCatch() {
    return this._def.innerType;
  }
}
Bg.create = (c, a) => new Bg({
  innerType: c,
  typeName: Ig.ZodCatch,
  catchValue: typeof a.catch == "function" ? a.catch : () => a.catch,
  ...ae(a)
});
class Cg extends xe {
  _parse(b) {
    if (this._getType(b) !== Vc.nan) {
      const a = this._getOrReturnCtx(b);
      ie(a, {
        code: qa.invalid_type,
        expected: Vc.nan,
        received: a.parsedType
      });
      return oe;
    }
    return {
      status: "valid",
      value: b.data
    };
  }
}
Cg.create = b => new Cg({
  typeName: Ig.ZodNaN,
  ...ae(b)
});
const Dg = Symbol("zod_brand");
class Eg extends xe {
  _parse(b) {
    const {
      ctx: a
    } = this._processInputParams(b);
    const c = a.data;
    return this._def.type._parse({
      data: c,
      path: a.path,
      parent: a
    });
  }
  unwrap() {
    return this._def.type;
  }
}
class Fg extends xe {
  _parse(b) {
    const {
      status: f,
      ctx: c
    } = this._processInputParams(b);
    if (c.common.async) {
      return (async () => {
        const a = await this._def.in._parseAsync({
          data: c.data,
          path: c.path,
          parent: c
        });
        if (a.status === "aborted") {
          return oe;
        } else if (a.status === "dirty") {
          f.dirty();
          return qe(a.value);
        } else {
          return this._def.out._parseAsync({
            data: a.value,
            path: c.path,
            parent: c
          });
        }
      })();
    }
    {
      const b = this._def.in._parseSync({
        data: c.data,
        path: c.path,
        parent: c
      });
      if (b.status === "aborted") {
        return oe;
      } else if (b.status === "dirty") {
        f.dirty();
        return {
          status: "dirty",
          value: b.value
        };
      } else {
        return this._def.out._parseSync({
          data: b.value,
          path: c.path,
          parent: c
        });
      }
    }
  }
  static create(c, a) {
    return new Fg({
      in: c,
      out: a,
      typeName: Ig.ZodPipeline
    });
  }
}
const Gg = (d, g = undefined, i) => {
  if (g === undefined) g = {};
  if (d) {
    return dg.create().superRefine((b, c) => {
      if (!d(b)) {
        const e = typeof g == "function" ? g(b) : typeof g == "string" ? {
          message: g
        } : g;
        const a = e.fatal ?? i ?? true;
        const d = typeof e == "string" ? {
          message: e
        } : e;
        c.addIssue({
          code: "custom",
          ...d,
          fatal: a
        });
      }
    });
  } else {
    return dg.create();
  }
};
const Hg = {
  object: jg.lazycreate
};
var Ig;
(function (b) {
  b.ZodString = "ZodString";
  b.ZodNumber = "ZodNumber";
  b.ZodNaN = "ZodNaN";
  b.ZodBigInt = "ZodBigInt";
  b.ZodBoolean = "ZodBoolean";
  b.ZodDate = "ZodDate";
  b.ZodSymbol = "ZodSymbol";
  b.ZodUndefined = "ZodUndefined";
  b.ZodNull = "ZodNull";
  b.ZodAny = "ZodAny";
  b.ZodUnknown = "ZodUnknown";
  b.ZodNever = "ZodNever";
  b.ZodVoid = "ZodVoid";
  b.ZodArray = "ZodArray";
  b.ZodObject = "ZodObject";
  b.ZodUnion = "ZodUnion";
  b.ZodDiscriminatedUnion = "ZodDiscriminatedUnion";
  b.ZodIntersection = "ZodIntersection";
  b.ZodTuple = "ZodTuple";
  b.ZodRecord = "ZodRecord";
  b.ZodMap = "ZodMap";
  b.ZodSet = "ZodSet";
  b.ZodFunction = "ZodFunction";
  b.ZodLazy = "ZodLazy";
  b.ZodLiteral = "ZodLiteral";
  b.ZodEnum = "ZodEnum";
  b.ZodEffects = "ZodEffects";
  b.ZodNativeEnum = "ZodNativeEnum";
  b.ZodOptional = "ZodOptional";
  b.ZodNullable = "ZodNullable";
  b.ZodDefault = "ZodDefault";
  b.ZodCatch = "ZodCatch";
  b.ZodPromise = "ZodPromise";
  b.ZodBranded = "ZodBranded";
  b.ZodPipeline = "ZodPipeline";
})(Ig ||= {});
const Jg = (c, a = undefined) => {
  if (a === undefined) a = {
    message: "Input not instance of " + c.name
  };
  return Gg(a => a instanceof c, a);
};
const Kg = Pe.create;
const le = Xe.create;
const Lg = Cg.create;
const Mg = Ye.create;
const Ng = $e.create;
const Og = _e.create;
const Pg = ag.create;
const Qg = bg.create;
const Rg = cg.create;
const Sg = dg.create;
const Tg = eg.create;
const Ug = fg.create;
const Vg = gg.create;
const Wg = hg.create;
const Xg = jg.create;
const Yg = jg.strictCreate;
const Zg = kg.create;
const $g = Re.create;
const _g = ng.create;
const ci = ca.create;
const ni = Xa.create;
const ti = og.create;
const wi = pg.create;
const yi = qg.create;
const zi = rg.create;
const Ai = sg.create;
const Bi = ug.create;
const Di = vg.create;
const Fi = wg.create;
const Ii = xg.create;
const Li = yg.create;
const Mi = zg.create;
const Ni = xg.createWithPreprocess;
const Oi = Fg.create;
const Pi = () => Kg().optional();
const Ri = () => le().optional();
const Si = () => Ng().optional();
const Ti = {
  string: b => Pe.create({
    ...b,
    coerce: true
  }),
  number: b => Xe.create({
    ...b,
    coerce: true
  }),
  boolean: b => $e.create({
    ...b,
    coerce: true
  }),
  bigint: b => Ye.create({
    ...b,
    coerce: true
  }),
  date: b => _e.create({
    ...b,
    coerce: true
  })
};
const Ui = oe;
var $i = Object.freeze({
  "__proto__": null,
  defaultErrorMap: Y,
  setErrorMap: ce,
  getErrorMap: ee,
  makeIssue: ge,
  EMPTY_PATH: he,
  addIssueToContext: ie,
  ParseStatus: ne,
  INVALID: oe,
  DIRTY: qe,
  OK: re,
  isAborted: fe,
  isDirty: se,
  isValid: te,
  isAsync: Ka,
  get util() {
    return Qc;
  },
  get objectUtil() {
    return Uc;
  },
  ZodParsedType: Vc,
  getParsedType: Wc,
  ZodType: xe,
  ZodString: Pe,
  ZodNumber: Xe,
  ZodBigInt: Ye,
  ZodBoolean: $e,
  ZodDate: _e,
  ZodSymbol: ag,
  ZodUndefined: bg,
  ZodNull: cg,
  ZodAny: dg,
  ZodUnknown: eg,
  ZodNever: fg,
  ZodVoid: gg,
  ZodArray: hg,
  ZodObject: jg,
  ZodUnion: kg,
  ZodDiscriminatedUnion: Re,
  ZodIntersection: ng,
  ZodTuple: ca,
  ZodRecord: Xa,
  ZodMap: og,
  ZodSet: pg,
  ZodFunction: qg,
  ZodLazy: rg,
  ZodLiteral: sg,
  ZodEnum: ug,
  ZodNativeEnum: vg,
  ZodPromise: wg,
  ZodEffects: xg,
  ZodTransformer: xg,
  ZodOptional: yg,
  ZodNullable: zg,
  ZodDefault: Ag,
  ZodCatch: Bg,
  ZodNaN: Cg,
  BRAND: Dg,
  ZodBranded: Eg,
  ZodPipeline: Fg,
  custom: Gg,
  Schema: xe,
  ZodSchema: xe,
  late: Hg,
  get ZodFirstPartyTypeKind() {
    return Ig;
  },
  coerce: Ti,
  any: Sg,
  array: Wg,
  bigint: Mg,
  boolean: Ng,
  date: Og,
  discriminatedUnion: $g,
  effect: Ii,
  enum: Bi,
  function: yi,
  instanceof: Jg,
  intersection: _g,
  lazy: zi,
  literal: Ai,
  map: ti,
  nan: Lg,
  nativeEnum: Di,
  never: Ug,
  null: Rg,
  nullable: Mi,
  number: le,
  object: Xg,
  oboolean: Si,
  onumber: Ri,
  optional: Li,
  ostring: Pi,
  pipeline: Oi,
  preprocess: Ni,
  promise: Fi,
  record: ni,
  set: wi,
  strictObject: Yg,
  string: Kg,
  symbol: Pg,
  transformer: Ii,
  tuple: ci,
  undefined: Qg,
  union: Zg,
  unknown: Tg,
  void: Vg,
  NEVER: Ui,
  ZodIssueCode: qa,
  quotelessJson: Xc,
  ZodError: Yc
});
var aj = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/;
var bj = $i.object({
  codename: $i.string(),
  version: $i.string().regex(aj),
  permissions: $i.string().array()
});
bj.omit({
  permissions: true
});
$i.object({
  API_URL: $i.string().url(),
  API_KEY: $i.string(),
  KEYS: $i.string().array()
});
$i.object({
  id: $i.number(),
  origin: $i.string()
});
$i.tuple([$i.boolean(), $i.any()]);
$i.object({
  resolve: $i.function().args($i.any()).returns($i.void()),
  reject: $i.function().args($i.any()).returns($i.void()),
  timeout: $i.number()
});
$i.object({
  id: $i.number(),
  resource: $i.string()
});
$i.tuple([$i.boolean(), $i.any()]);
$i.object({
  resolve: $i.function().args($i.any()).returns($i.void()),
  reject: $i.function().args($i.any()).returns($i.void()),
  timeout: $i.number()
});
let me;
const cj = new Uint8Array(16);
function dj() {
  if (!me && (me = typeof crypto !== "undefined" && crypto.getRandomValues && crypto.getRandomValues.bind(crypto), !me)) {
    throw new Error("crypto.getRandomValues() not supported. See https://github.com/uuidjs/uuid#getrandomvalues-not-supported");
  }
  return me(cj);
}
const ui = /^(?:[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}|00000000-0000-0000-0000-000000000000)$/i;
function ej(b) {
  return typeof b == "string" && ui.test(b);
}
const fj = [];
for (let a = 0; a < 256; ++a) {
  fj.push((a + 256).toString(16).slice(1));
}
function gj(c, a = 0) {
  return (fj[c[a + 0]] + fj[c[a + 1]] + fj[c[a + 2]] + fj[c[a + 3]] + "-" + fj[c[a + 4]] + fj[c[a + 5]] + "-" + fj[c[a + 6]] + fj[c[a + 7]] + "-" + fj[c[a + 8]] + fj[c[a + 9]] + "-" + fj[c[a + 10]] + fj[c[a + 11]] + fj[c[a + 12]] + fj[c[a + 13]] + fj[c[a + 14]] + fj[c[a + 15]]).toLowerCase();
}
function hj(b) {
  if (!ej(b)) {
    throw TypeError("Invalid UUID");
  }
  let a;
  const e = new Uint8Array(16);
  e[0] = (a = parseInt(b.slice(0, 8), 16)) >>> 24;
  e[1] = a >>> 16 & 255;
  e[2] = a >>> 8 & 255;
  e[3] = a & 255;
  e[4] = (a = parseInt(b.slice(9, 13), 16)) >>> 8;
  e[5] = a & 255;
  e[6] = (a = parseInt(b.slice(14, 18), 16)) >>> 8;
  e[7] = a & 255;
  e[8] = (a = parseInt(b.slice(19, 23), 16)) >>> 8;
  e[9] = a & 255;
  e[10] = (a = parseInt(b.slice(24, 36), 16)) / 1099511627776 & 255;
  e[11] = a / 4294967296 & 255;
  e[12] = a >>> 24 & 255;
  e[13] = a >>> 16 & 255;
  e[14] = a >>> 8 & 255;
  e[15] = a & 255;
  return e;
}
function je(b) {
  b = unescape(encodeURIComponent(b));
  const e = [];
  for (let a = 0; a < b.length; ++a) {
    e.push(b.charCodeAt(a));
  }
  return e;
}
const ij = "6ba7b810-9dad-11d1-80b4-00c04fd430c8";
const jj = "6ba7b811-9dad-11d1-80b4-00c04fd430c8";
function kj(d, g, b) {
  function a(c, i, j, e) {
    if (typeof c == "string") {
      c = je(c);
    }
    if (typeof i == "string") {
      i = hj(i);
    }
    if (i?.length !== 16) {
      throw TypeError("Namespace must be array-like (16 iterable integer values, 0-255)");
    }
    let k = new Uint8Array(16 + c.length);
    k.set(i);
    k.set(c, i.length);
    k = b(k);
    k[6] = k[6] & 15 | g;
    k[8] = k[8] & 63 | 128;
    if (j) {
      e = e || 0;
      for (let b = 0; b < 16; ++b) {
        j[e + b] = k[b];
      }
      return j;
    }
    return gj(k);
  }
  try {
    a.name = d;
  } catch {}
  a.DNS = ij;
  a.URL = jj;
  return a;
}
const lj = typeof crypto !== "undefined" && crypto.randomUUID && crypto.randomUUID.bind(crypto);
const mj = {
  randomUUID: lj
};
function nj(d, f, b) {
  if (mj.randomUUID && !f && !d) {
    return mj.randomUUID();
  }
  d = d || {};
  const g = d.random || (d.rng || dj)();
  g[6] = g[6] & 15 | 64;
  g[8] = g[8] & 63 | 128;
  if (f) {
    b = b || 0;
    for (let c = 0; c < 16; ++c) {
      f[b + c] = g[c];
    }
    return f;
  }
  return gj(g);
}
function oj(e, a, b, c) {
  switch (e) {
    case 0:
      return a & b ^ ~a & c;
    case 1:
      return a ^ b ^ c;
    case 2:
      return a & b ^ a & c ^ b & c;
    case 3:
      return a ^ b ^ c;
  }
}
function pj(c, a) {
  return c << a | c >>> 32 - a;
}
function ed(h) {
  const b = [1518500249, 1859775393, 2400959708, 3395469782];
  const c = [1732584193, 4023233417, 2562383102, 271733878, 3285377520];
  if (typeof h == "string") {
    const a = unescape(encodeURIComponent(h));
    h = [];
    for (let b = 0; b < a.length; ++b) {
      h.push(a.charCodeAt(b));
    }
  } else if (!Array.isArray(h)) {
    h = Array.prototype.slice.call(h);
  }
  h.push(128);
  const d = h.length / 4 + 2;
  const i = Math.ceil(d / 16);
  const f = new Array(i);
  for (let a = 0; a < i; ++a) {
    const b = new Uint32Array(16);
    for (let c = 0; c < 16; ++c) {
      b[c] = h[a * 64 + c * 4] << 24 | h[a * 64 + c * 4 + 1] << 16 | h[a * 64 + c * 4 + 2] << 8 | h[a * 64 + c * 4 + 3];
    }
    f[a] = b;
  }
  f[i - 1][14] = (h.length - 1) * 8 / Math.pow(2, 32);
  f[i - 1][14] = Math.floor(f[i - 1][14]);
  f[i - 1][15] = (h.length - 1) * 8 & 4294967295;
  for (let d = 0; d < i; ++d) {
    const l = new Uint32Array(80);
    for (let a = 0; a < 16; ++a) {
      l[a] = f[d][a];
    }
    for (let a = 16; a < 80; ++a) {
      l[a] = pj(l[a - 3] ^ l[a - 8] ^ l[a - 14] ^ l[a - 16], 1);
    }
    let a = c[0];
    let m = c[1];
    let h = c[2];
    let i = c[3];
    let j = c[4];
    for (let c = 0; c < 80; ++c) {
      const d = Math.floor(c / 20);
      const e = pj(a, 5) + oj(d, m, h, i) + j + b[d] + l[c] >>> 0;
      j = i;
      i = h;
      h = pj(m, 30) >>> 0;
      m = a;
      a = e;
    }
    c[0] = c[0] + a >>> 0;
    c[1] = c[1] + m >>> 0;
    c[2] = c[2] + h >>> 0;
    c[3] = c[3] + i >>> 0;
    c[4] = c[4] + j >>> 0;
  }
  return [c[0] >> 24 & 255, c[0] >> 16 & 255, c[0] >> 8 & 255, c[0] & 255, c[1] >> 24 & 255, c[1] >> 16 & 255, c[1] >> 8 & 255, c[1] & 255, c[2] >> 24 & 255, c[2] >> 16 & 255, c[2] >> 8 & 255, c[2] & 255, c[3] >> 24 & 255, c[3] >> 16 & 255, c[3] >> 8 & 255, c[3] & 255, c[4] >> 24 & 255, c[4] >> 16 & 255, c[4] >> 8 & 255, c[4] & 255];
}
const td = kj("v5", 80, ed);
const ga = td;
const nd = 4;
const rd = 0;
const qj = 1;
const id = 2;
function rj(c) {
  let a = c.length;
  while (--a >= 0) {
    c[a] = 0;
  }
}
const sj = 0;
const ad = 1;
const tj = 2;
const sd = 3;
const uj = 258;
const od = 29;
const ld = 256;
const cd = ld + 1 + od;
const vj = 30;
const ri = 19;
const wj = cd * 2 + 1;
const xj = 15;
const yj = 16;
const zj = 7;
const Aj = 256;
const ma = 16;
const ud = 17;
const Bj = 18;
const Cj = new Uint8Array([0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0]);
const Dj = new Uint8Array([0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13]);
const Ej = new Uint8Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 7]);
const Ya = new Uint8Array([16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15]);
const xi = 512;
const dd = new Array((cd + 2) * 2);
rj(dd);
const Fj = new Array(vj * 2);
rj(Fj);
const fd = new Array(xi);
rj(fd);
const Gj = new Array(uj - sd + 1);
rj(Gj);
const Hj = new Array(od);
rj(Hj);
const Ij = new Array(vj);
rj(Ij);
function Jj(f, a, b, c, d) {
  this.static_tree = f;
  this.extra_bits = a;
  this.extra_base = b;
  this.elems = c;
  this.max_length = d;
  this.has_stree = f && f.length;
}
let Kj;
let Hi;
let ya;
function Lj(c, a) {
  this.dyn_tree = c;
  this.max_code = 0;
  this.stat_desc = a;
}
const Mj = b => b < 256 ? fd[b] : fd[256 + (b >>> 7)];
const Nj = (c, a) => {
  c.pending_buf[c.pending++] = a & 255;
  c.pending_buf[c.pending++] = a >>> 8 & 255;
};
const wa = (d, a, b) => {
  if (d.bi_valid > yj - b) {
    d.bi_buf |= a << d.bi_valid & 65535;
    Nj(d, d.bi_buf);
    d.bi_buf = a >> yj - d.bi_valid;
    d.bi_valid += b - yj;
  } else {
    d.bi_buf |= a << d.bi_valid & 65535;
    d.bi_valid += b;
  }
};
const Oj = (d, a, b) => {
  wa(d, b[a * 2], b[a * 2 + 1]);
};
const Pj = (d, e) => {
  let f = 0;
  do {
    f |= d & 1;
    d >>>= 1;
    f <<= 1;
  } while (--e > 0);
  return f >>> 1;
};
const Qj = b => {
  if (b.bi_valid === 16) {
    Nj(b, b.bi_buf);
    b.bi_buf = 0;
    b.bi_valid = 0;
  } else if (b.bi_valid >= 8) {
    b.pending_buf[b.pending++] = b.bi_buf & 255;
    b.bi_buf >>= 8;
    b.bi_valid -= 8;
  }
};
const Rj = (c, a) => {
  const b = a.dyn_tree;
  const d = a.max_code;
  const e = a.stat_desc.static_tree;
  const f = a.stat_desc.has_stree;
  const g = a.stat_desc.extra_bits;
  const h = a.stat_desc.extra_base;
  const i = a.stat_desc.max_length;
  let j;
  let r;
  let s;
  let t;
  let u;
  let v;
  let w = 0;
  for (t = 0; t <= xj; t++) {
    c.bl_count[t] = 0;
  }
  b[c.heap[c.heap_max] * 2 + 1] = 0;
  j = c.heap_max + 1;
  for (; j < wj; j++) {
    r = c.heap[j];
    t = b[b[r * 2 + 1] * 2 + 1] + 1;
    if (t > i) {
      t = i;
      w++;
    }
    b[r * 2 + 1] = t;
    if (r <= d) {
      c.bl_count[t]++;
      u = 0;
      if (r >= h) {
        u = g[r - h];
      }
      v = b[r * 2];
      c.opt_len += v * (t + u);
      if (f) {
        c.static_len += v * (e[r * 2 + 1] + u);
      }
    }
  }
  if (w !== 0) {
    do {
      for (t = i - 1; c.bl_count[t] === 0;) {
        t--;
      }
      c.bl_count[t]--;
      c.bl_count[t + 1] += 2;
      c.bl_count[i]--;
      w -= 2;
    } while (w > 0);
    for (t = i; t !== 0; t--) {
      for (r = c.bl_count[t]; r !== 0;) {
        s = c.heap[--j];
        if (s <= d) {
          if (b[s * 2 + 1] !== t) {
            c.opt_len += (t - b[s * 2 + 1]) * b[s * 2];
            b[s * 2 + 1] = t;
          }
          r--;
        }
      }
    }
  }
};
const Sj = (h, a, b) => {
  const c = new Array(xj + 1);
  let d = 0;
  let i;
  let j;
  for (i = 1; i <= xj; i++) {
    d = d + b[i - 1] << 1;
    c[i] = d;
  }
  for (j = 0; j <= a; j++) {
    let a = h[j * 2 + 1];
    if (a !== 0) {
      h[j * 2] = Pj(c[a]++, a);
    }
  }
};
const hd = () => {
  let g;
  let h;
  let i;
  let j;
  let k;
  const l = new Array(xj + 1);
  i = 0;
  j = 0;
  for (; j < od - 1; j++) {
    Hj[j] = i;
    g = 0;
    for (; g < 1 << Cj[j]; g++) {
      Gj[i++] = j;
    }
  }
  Gj[i - 1] = j;
  k = 0;
  j = 0;
  for (; j < 16; j++) {
    Ij[j] = k;
    g = 0;
    for (; g < 1 << Dj[j]; g++) {
      fd[k++] = j;
    }
  }
  for (k >>= 7; j < vj; j++) {
    Ij[j] = k << 7;
    g = 0;
    for (; g < 1 << Dj[j] - 7; g++) {
      fd[256 + k++] = j;
    }
  }
  for (h = 0; h <= xj; h++) {
    l[h] = 0;
  }
  for (g = 0; g <= 143;) {
    dd[g * 2 + 1] = 8;
    g++;
    l[8]++;
  }
  while (g <= 255) {
    dd[g * 2 + 1] = 9;
    g++;
    l[9]++;
  }
  while (g <= 279) {
    dd[g * 2 + 1] = 7;
    g++;
    l[7]++;
  }
  while (g <= 287) {
    dd[g * 2 + 1] = 8;
    g++;
    l[8]++;
  }
  Sj(dd, cd + 1, l);
  g = 0;
  for (; g < vj; g++) {
    Fj[g * 2 + 1] = 5;
    Fj[g * 2] = Pj(g, 5);
  }
  Kj = new Jj(dd, Cj, ld + 1, cd, xj);
  Hi = new Jj(Fj, Dj, 0, vj, xj);
  ya = new Jj(new Array(0), Ej, 0, ri, zj);
};
const vd = b => {
  let a;
  for (a = 0; a < cd; a++) {
    b.dyn_ltree[a * 2] = 0;
  }
  for (a = 0; a < vj; a++) {
    b.dyn_dtree[a * 2] = 0;
  }
  for (a = 0; a < ri; a++) {
    b.bl_tree[a * 2] = 0;
  }
  b.dyn_ltree[Aj * 2] = 1;
  b.opt_len = b.static_len = 0;
  b.sym_next = b.matches = 0;
};
const Tj = b => {
  if (b.bi_valid > 8) {
    Nj(b, b.bi_buf);
  } else if (b.bi_valid > 0) {
    b.pending_buf[b.pending++] = b.bi_buf;
  }
  b.bi_buf = 0;
  b.bi_valid = 0;
};
const _d = (g, a, b, c) => {
  const d = a * 2;
  const e = b * 2;
  return g[d] < g[e] || g[d] === g[e] && c[a] <= c[b];
};
const Uj = (d, a, b) => {
  const g = d.heap[b];
  let e = b << 1;
  while (e <= d.heap_len && (e < d.heap_len && _d(a, d.heap[e + 1], d.heap[e], d.depth) && e++, !_d(a, g, d.heap[e], d.depth))) {
    d.heap[b] = d.heap[e];
    b = e;
    e <<= 1;
  }
  d.heap[b] = g;
};
const Vj = (d, a, b) => {
  let c;
  let j;
  let k = 0;
  let l;
  let m;
  if (d.sym_next !== 0) {
    do {
      c = d.pending_buf[d.sym_buf + k++] & 255;
      c += (d.pending_buf[d.sym_buf + k++] & 255) << 8;
      j = d.pending_buf[d.sym_buf + k++];
      if (c === 0) {
        Oj(d, j, a);
      } else {
        l = Gj[j];
        Oj(d, l + ld + 1, a);
        m = Cj[l];
        if (m !== 0) {
          j -= Hj[l];
          wa(d, j, m);
        }
        c--;
        l = Mj(c);
        Oj(d, l, b);
        m = Dj[l];
        if (m !== 0) {
          c -= Ij[l];
          wa(d, c, m);
        }
      }
    } while (k < d.sym_next);
  }
  Oj(d, Aj, a);
};
const Wj = (c, a) => {
  const b = a.dyn_tree;
  const d = a.stat_desc.static_tree;
  const e = a.stat_desc.has_stree;
  const f = a.stat_desc.elems;
  let g;
  let l;
  let m = -1;
  let n;
  c.heap_len = 0;
  c.heap_max = wj;
  g = 0;
  for (; g < f; g++) {
    if (b[g * 2] !== 0) {
      c.heap[++c.heap_len] = m = g;
      c.depth[g] = 0;
    } else {
      b[g * 2 + 1] = 0;
    }
  }
  while (c.heap_len < 2) {
    n = c.heap[++c.heap_len] = m < 2 ? ++m : 0;
    b[n * 2] = 1;
    c.depth[n] = 0;
    c.opt_len--;
    if (e) {
      c.static_len -= d[n * 2 + 1];
    }
  }
  a.max_code = m;
  g = c.heap_len >> 1;
  for (; g >= 1; g--) {
    Uj(c, b, g);
  }
  n = f;
  do {
    g = c.heap[1];
    c.heap[1] = c.heap[c.heap_len--];
    Uj(c, b, 1);
    l = c.heap[1];
    c.heap[--c.heap_max] = g;
    c.heap[--c.heap_max] = l;
    b[n * 2] = b[g * 2] + b[l * 2];
    c.depth[n] = (c.depth[g] >= c.depth[l] ? c.depth[g] : c.depth[l]) + 1;
    b[g * 2 + 1] = b[l * 2 + 1] = n;
    c.heap[1] = n++;
    Uj(c, b, 1);
  } while (c.heap_len >= 2);
  c.heap[--c.heap_max] = c.heap[1];
  Rj(c, a);
  Sj(b, m, c.bl_count);
};
const xa = (d, a, b) => {
  let c;
  let l = -1;
  let m;
  let n = a[1];
  let o = 0;
  let p = 7;
  let q = 4;
  if (n === 0) {
    p = 138;
    q = 3;
  }
  a[(b + 1) * 2 + 1] = 65535;
  c = 0;
  for (; c <= b; c++) {
    m = n;
    n = a[(c + 1) * 2 + 1];
    if (++o >= p || m !== n) {
      if (o < q) {
        d.bl_tree[m * 2] += o;
      } else if (m !== 0) {
        if (m !== l) {
          d.bl_tree[m * 2]++;
        }
        d.bl_tree[ma * 2]++;
      } else if (o <= 10) {
        d.bl_tree[ud * 2]++;
      } else {
        d.bl_tree[Bj * 2]++;
      }
      o = 0;
      l = m;
      if (n === 0) {
        p = 138;
        q = 3;
      } else if (m === n) {
        p = 6;
        q = 3;
      } else {
        p = 7;
        q = 4;
      }
    }
  }
};
const Xj = (d, a, b) => {
  let c;
  let l = -1;
  let m;
  let n = a[1];
  let o = 0;
  let p = 7;
  let q = 4;
  if (n === 0) {
    p = 138;
    q = 3;
  }
  c = 0;
  for (; c <= b; c++) {
    m = n;
    n = a[(c + 1) * 2 + 1];
    if (++o >= p || m !== n) {
      if (o < q) {
        do {
          Oj(d, m, d.bl_tree);
        } while (--o !== 0);
      } else if (m !== 0) {
        if (m !== l) {
          Oj(d, m, d.bl_tree);
          o--;
        }
        Oj(d, ma, d.bl_tree);
        wa(d, o - 3, 2);
      } else if (o <= 10) {
        Oj(d, ud, d.bl_tree);
        wa(d, o - 3, 3);
      } else {
        Oj(d, Bj, d.bl_tree);
        wa(d, o - 11, 7);
      }
      o = 0;
      l = m;
      if (n === 0) {
        p = 138;
        q = 3;
      } else if (m === n) {
        p = 6;
        q = 3;
      } else {
        p = 7;
        q = 4;
      }
    }
  }
};
const Ja = b => {
  let a;
  xa(b, b.dyn_ltree, b.l_desc.max_code);
  xa(b, b.dyn_dtree, b.d_desc.max_code);
  Wj(b, b.bl_desc);
  a = ri - 1;
  for (; a >= 3 && b.bl_tree[Ya[a] * 2 + 1] === 0; a--);
  b.opt_len += (a + 1) * 3 + 5 + 5 + 4;
  return a;
};
const Yj = (e, a, b, c) => {
  let d;
  wa(e, a - 257, 5);
  wa(e, b - 1, 5);
  wa(e, c - 4, 4);
  d = 0;
  for (; d < c; d++) {
    wa(e, e.bl_tree[Ya[d] * 2 + 1], 3);
  }
  Xj(e, e.dyn_ltree, a - 1);
  Xj(e, e.dyn_dtree, b - 1);
};
const Zj = b => {
  let a = 4093624447;
  let e;
  for (e = 0; e <= 31; e++, a >>>= 1) {
    if (a & 1 && b.dyn_ltree[e * 2] !== 0) {
      return rd;
    }
  }
  if (b.dyn_ltree[18] !== 0 || b.dyn_ltree[20] !== 0 || b.dyn_ltree[26] !== 0) {
    return qj;
  }
  for (e = 32; e < ld; e++) {
    if (b.dyn_ltree[e * 2] !== 0) {
      return qj;
    }
  }
  return rd;
};
let pd = false;
const gd = b => {
  if (!pd) {
    hd();
    pd = true;
  }
  b.l_desc = new Lj(b.dyn_ltree, Kj);
  b.d_desc = new Lj(b.dyn_dtree, Hi);
  b.bl_desc = new Lj(b.bl_tree, ya);
  b.bi_buf = 0;
  b.bi_valid = 0;
  vd(b);
};
const md = (e, a, b, c) => {
  wa(e, (sj << 1) + (c ? 1 : 0), 3);
  Tj(e);
  Nj(e, b);
  Nj(e, ~b);
  if (b) {
    e.pending_buf.set(e.window.subarray(a, a + b), e.pending);
  }
  e.pending += b;
};
const $j = b => {
  wa(b, ad << 1, 3);
  Oj(b, Aj, dd);
  Qj(b);
};
const yd = (e, a, b, c) => {
  let d;
  let i;
  let j = 0;
  if (e.level > 0) {
    if (e.strm.data_type === id) {
      e.strm.data_type = Zj(e);
    }
    Wj(e, e.l_desc);
    Wj(e, e.d_desc);
    j = Ja(e);
    d = e.opt_len + 3 + 7 >>> 3;
    i = e.static_len + 3 + 7 >>> 3;
    if (i <= d) {
      d = i;
    }
  } else {
    d = i = b + 5;
  }
  if (b + 4 <= d && a !== -1) {
    md(e, a, b, c);
  } else if (e.strategy === nd || i === d) {
    wa(e, (ad << 1) + (c ? 1 : 0), 3);
    Vj(e, dd, Fj);
  } else {
    wa(e, (tj << 1) + (c ? 1 : 0), 3);
    Yj(e, e.l_desc.max_code + 1, e.d_desc.max_code + 1, j + 1);
    Vj(e, e.dyn_ltree, e.dyn_dtree);
  }
  vd(e);
  if (c) {
    Tj(e);
  }
};
const _j = (d, a, e) => {
  d.pending_buf[d.sym_buf + d.sym_next++] = a;
  d.pending_buf[d.sym_buf + d.sym_next++] = a >> 8;
  d.pending_buf[d.sym_buf + d.sym_next++] = e;
  if (a === 0) {
    d.dyn_ltree[e * 2]++;
  } else {
    d.matches++;
    a--;
    d.dyn_ltree[(Gj[e] + ld + 1) * 2]++;
    d.dyn_dtree[Mj(a) * 2]++;
  }
  return d.sym_next === d.sym_end;
};
var wd = gd;
var xd = md;
var bd = yd;
var Cd = _j;
var kd = $j;
var Ed = {
  _tr_init: wd,
  _tr_stored_block: xd,
  _tr_flush_block: bd,
  _tr_tally: Cd,
  _tr_align: kd
};
const Sd = (h, a, b, i) => {
  let j = h & 65535 | 0;
  let k = h >>> 16 & 65535 | 0;
  let l = 0;
  while (b !== 0) {
    l = b > 2000 ? 2000 : b;
    b -= l;
    do {
      j = j + a[i++] | 0;
      k = k + j | 0;
    } while (--l);
    j %= 65521;
    k %= 65521;
  }
  return j | k << 16 | 0;
};
var Ad = Sd;
const $d = () => {
  let e;
  let f = [];
  for (var b = 0; b < 256; b++) {
    e = b;
    for (var g = 0; g < 8; g++) {
      e = e & 1 ? e >>> 1 ^ 3988292384 : e >>> 1;
    }
    f[b] = e;
  }
  return f;
};
const Td = new Uint32Array($d());
const ak = (h, i, b, c) => {
  const d = Td;
  const e = c + b;
  h ^= -1;
  for (let a = c; a < e; a++) {
    h = h >>> 8 ^ d[(h ^ i[a]) & 255];
  }
  return h ^ -1;
};
var Bd = ak;
var Id = {
  2: "need dictionary",
  1: "stream end",
  0: "",
  "-1": "file error",
  "-2": "stream error",
  "-3": "data error",
  "-4": "insufficient memory",
  "-5": "buffer error",
  "-6": "incompatible version"
};
var Dd = {
  Z_NO_FLUSH: 0,
  Z_PARTIAL_FLUSH: 1,
  Z_SYNC_FLUSH: 2,
  Z_FULL_FLUSH: 3,
  Z_FINISH: 4,
  Z_BLOCK: 5,
  Z_TREES: 6,
  Z_OK: 0,
  Z_STREAM_END: 1,
  Z_NEED_DICT: 2,
  Z_ERRNO: -1,
  Z_STREAM_ERROR: -2,
  Z_DATA_ERROR: -3,
  Z_MEM_ERROR: -4,
  Z_BUF_ERROR: -5,
  Z_NO_COMPRESSION: 0,
  Z_BEST_SPEED: 1,
  Z_BEST_COMPRESSION: 9,
  Z_DEFAULT_COMPRESSION: -1,
  Z_FILTERED: 1,
  Z_HUFFMAN_ONLY: 2,
  Z_RLE: 3,
  Z_FIXED: 4,
  Z_DEFAULT_STRATEGY: 0,
  Z_BINARY: 0,
  Z_TEXT: 1,
  Z_UNKNOWN: 2,
  Z_DEFLATED: 8
};
const {
  _tr_init: He,
  _tr_stored_block: bk,
  _tr_flush_block: ck,
  _tr_tally: Ld,
  _tr_align: Qa
} = Ed;
const {
  Z_NO_FLUSH: Od,
  Z_PARTIAL_FLUSH: dk,
  Z_FULL_FLUSH: zd,
  Z_FINISH: ek,
  Z_BLOCK: Fd,
  Z_OK: Rd,
  Z_STREAM_END: fk,
  Z_STREAM_ERROR: gk,
  Z_DATA_ERROR: Ze,
  Z_BUF_ERROR: hk,
  Z_DEFAULT_COMPRESSION: ik,
  Z_FILTERED: Nd,
  Z_HUFFMAN_ONLY: ba,
  Z_RLE: Pd,
  Z_FIXED: Md,
  Z_DEFAULT_STRATEGY: di,
  Z_UNKNOWN: Ud,
  Z_DEFLATED: Hd
} = Dd;
const jd = 9;
const Zd = 15;
const ua = 8;
const Wd = 29;
const Vd = 256;
const qd = Vd + 1 + Wd;
const Kd = 30;
const Gd = 19;
const jk = qd * 2 + 1;
const Xd = 15;
const Yd = 3;
const Jd = 258;
const Qd = Jd + Yd + 1;
const be = 32;
const kk = 42;
const lk = 57;
const mk = 69;
const nk = 73;
const ok = 91;
const pk = 103;
const qk = 113;
const rk = 666;
const sk = 1;
const tk = 2;
const uk = 3;
const vk = 4;
const wk = 3;
const xk = (c, a) => {
  c.msg = Id[a];
  return a;
};
const yk = b => b * 2 - (b > 4 ? 9 : 0);
const zk = b => {
  let a = b.length;
  while (--a >= 0) {
    b[a] = 0;
  }
};
const Ak = b => {
  let a;
  let g;
  let h;
  let i = b.w_size;
  a = b.hash_size;
  h = a;
  do {
    g = b.head[--h];
    b.head[h] = g >= i ? g - i : 0;
  } while (--a);
  a = i;
  h = a;
  do {
    g = b.prev[--h];
    b.prev[h] = g >= i ? g - i : 0;
  } while (--a);
};
let Bk = (d, a, b) => (a << d.hash_shift ^ b) & d.hash_mask;
let Ck = Bk;
const Dk = b => {
  const a = b.state;
  let c = a.pending;
  if (c > b.avail_out) {
    c = b.avail_out;
  }
  if (c !== 0) {
    b.output.set(a.pending_buf.subarray(a.pending_out, a.pending_out + c), b.next_out);
    b.next_out += c;
    a.pending_out += c;
    b.total_out += c;
    b.avail_out -= c;
    a.pending -= c;
    if (a.pending === 0) {
      a.pending_out = 0;
    }
  }
};
const Ek = (c, a) => {
  ck(c, c.block_start >= 0 ? c.block_start : -1, c.strstart - c.block_start, a);
  c.block_start = c.strstart;
  Dk(c.strm);
};
const Fk = (c, a) => {
  c.pending_buf[c.pending++] = a;
};
const Gk = (c, a) => {
  c.pending_buf[c.pending++] = a >>> 8 & 255;
  c.pending_buf[c.pending++] = a & 255;
};
const Hk = (e, a, b, c) => {
  let d = e.avail_in;
  if (d > c) {
    d = c;
  }
  if (d === 0) {
    return 0;
  } else {
    e.avail_in -= d;
    a.set(e.input.subarray(e.next_in, e.next_in + d), b);
    if (e.state.wrap === 1) {
      e.adler = Ad(e.adler, a, d, b);
    } else if (e.state.wrap === 2) {
      e.adler = Bd(e.adler, a, d, b);
    }
    e.next_in += d;
    e.total_in += d;
    return d;
  }
};
const Te = (c, a) => {
  let q = c.max_chain_length;
  let r = c.strstart;
  let s;
  let t;
  let u = c.prev_length;
  let v = c.nice_match;
  const w = c.strstart > c.w_size - Qd ? c.strstart - (c.w_size - Qd) : 0;
  const j = c.window;
  const k = c.w_mask;
  const l = c.prev;
  const m = c.strstart + Jd;
  let n = j[r + u - 1];
  let x = j[r + u];
  if (c.prev_length >= c.good_match) {
    q >>= 2;
  }
  if (v > c.lookahead) {
    v = c.lookahead;
  }
  do {
    s = a;
    if (j[s + u] === x && j[s + u - 1] === n && j[s] === j[r] && j[++s] === j[r + 1]) {
      r += 2;
      s++;
      do ; while (j[++r] === j[++s] && j[++r] === j[++s] && j[++r] === j[++s] && j[++r] === j[++s] && j[++r] === j[++s] && j[++r] === j[++s] && j[++r] === j[++s] && j[++r] === j[++s] && r < m);
      t = Jd - (m - r);
      r = m - Jd;
      if (t > u) {
        c.match_start = a;
        u = t;
        if (t >= v) {
          break;
        }
        n = j[r + u - 1];
        x = j[r + u];
      }
    }
  } while ((a = l[a & k]) > w && --q !== 0);
  if (u <= c.lookahead) {
    return u;
  } else {
    return c.lookahead;
  }
};
const Ik = b => {
  const a = b.w_size;
  let c;
  let g;
  let h;
  do {
    g = b.window_size - b.lookahead - b.strstart;
    if (b.strstart >= a + (a - Qd)) {
      b.window.set(b.window.subarray(a, a + a - g), 0);
      b.match_start -= a;
      b.strstart -= a;
      b.block_start -= a;
      if (b.insert > b.strstart) {
        b.insert = b.strstart;
      }
      Ak(b);
      g += a;
    }
    if (b.strm.avail_in === 0) {
      break;
    }
    c = Hk(b.strm, b.window, b.strstart + b.lookahead, g);
    b.lookahead += c;
    if (b.lookahead + b.insert >= Yd) {
      h = b.strstart - b.insert;
      b.ins_h = b.window[h];
      b.ins_h = Ck(b, b.ins_h, b.window[h + 1]);
      while (b.insert && (b.ins_h = Ck(b, b.ins_h, b.window[h + Yd - 1]), b.prev[h & b.w_mask] = b.head[b.ins_h], b.head[b.ins_h] = h, h++, b.insert--, b.lookahead + b.insert >= Yd));
    }
  } while (b.lookahead < Qd && b.strm.avail_in !== 0);
};
const Jk = (c, a) => {
  let b = c.pending_buf_size - 5 > c.w_size ? c.w_size : c.pending_buf_size - 5;
  let j;
  let k;
  let l;
  let m = 0;
  let n = c.strm.avail_in;
  do {
    j = 65535;
    l = c.bi_valid + 42 >> 3;
    if (c.strm.avail_out < l || (l = c.strm.avail_out - l, k = c.strstart - c.block_start, j > k + c.strm.avail_in && (j = k + c.strm.avail_in), j > l && (j = l), j < b && (j === 0 && a !== ek || a === Od || j !== k + c.strm.avail_in))) {
      break;
    }
    m = a === ek && j === k + c.strm.avail_in ? 1 : 0;
    bk(c, 0, 0, m);
    c.pending_buf[c.pending - 4] = j;
    c.pending_buf[c.pending - 3] = j >> 8;
    c.pending_buf[c.pending - 2] = ~j;
    c.pending_buf[c.pending - 1] = ~j >> 8;
    Dk(c.strm);
    if (k) {
      if (k > j) {
        k = j;
      }
      c.strm.output.set(c.window.subarray(c.block_start, c.block_start + k), c.strm.next_out);
      c.strm.next_out += k;
      c.strm.avail_out -= k;
      c.strm.total_out += k;
      c.block_start += k;
      j -= k;
    }
    if (j) {
      Hk(c.strm, c.strm.output, c.strm.next_out, j);
      c.strm.next_out += j;
      c.strm.avail_out -= j;
      c.strm.total_out += j;
    }
  } while (m === 0);
  n -= c.strm.avail_in;
  if (n) {
    if (n >= c.w_size) {
      c.matches = 2;
      c.window.set(c.strm.input.subarray(c.strm.next_in - c.w_size, c.strm.next_in), 0);
      c.strstart = c.w_size;
      c.insert = c.strstart;
    } else {
      if (c.window_size - c.strstart <= n) {
        c.strstart -= c.w_size;
        c.window.set(c.window.subarray(c.w_size, c.w_size + c.strstart), 0);
        if (c.matches < 2) {
          c.matches++;
        }
        if (c.insert > c.strstart) {
          c.insert = c.strstart;
        }
      }
      c.window.set(c.strm.input.subarray(c.strm.next_in - n, c.strm.next_in), c.strstart);
      c.strstart += n;
      c.insert += n > c.w_size - c.insert ? c.w_size - c.insert : n;
    }
    c.block_start = c.strstart;
  }
  if (c.high_water < c.strstart) {
    c.high_water = c.strstart;
  }
  if (m) {
    return vk;
  } else if (a !== Od && a !== ek && c.strm.avail_in === 0 && c.strstart === c.block_start) {
    return tk;
  } else {
    l = c.window_size - c.strstart;
    if (c.strm.avail_in > l && c.block_start >= c.w_size) {
      c.block_start -= c.w_size;
      c.strstart -= c.w_size;
      c.window.set(c.window.subarray(c.w_size, c.w_size + c.strstart), 0);
      if (c.matches < 2) {
        c.matches++;
      }
      l += c.w_size;
      if (c.insert > c.strstart) {
        c.insert = c.strstart;
      }
    }
    if (l > c.strm.avail_in) {
      l = c.strm.avail_in;
    }
    if (l) {
      Hk(c.strm, c.window, c.strstart, l);
      c.strstart += l;
      c.insert += l > c.w_size - c.insert ? c.w_size - c.insert : l;
    }
    if (c.high_water < c.strstart) {
      c.high_water = c.strstart;
    }
    l = c.bi_valid + 42 >> 3;
    l = c.pending_buf_size - l > 65535 ? 65535 : c.pending_buf_size - l;
    b = l > c.w_size ? c.w_size : l;
    k = c.strstart - c.block_start;
    if (k >= b || (k || a === ek) && a !== Od && c.strm.avail_in === 0 && k <= l) {
      j = k > l ? l : k;
      m = a === ek && c.strm.avail_in === 0 && j === k ? 1 : 0;
      bk(c, c.block_start, j, m);
      c.block_start += j;
      Dk(c.strm);
    }
    if (m) {
      return uk;
    } else {
      return sk;
    }
  }
};
const Kk = (c, a) => {
  let b;
  let f;
  while (true) {
    if (c.lookahead < Qd) {
      Ik(c);
      if (c.lookahead < Qd && a === Od) {
        return sk;
      }
      if (c.lookahead === 0) {
        break;
      }
    }
    b = 0;
    if (c.lookahead >= Yd) {
      c.ins_h = Ck(c, c.ins_h, c.window[c.strstart + Yd - 1]);
      b = c.prev[c.strstart & c.w_mask] = c.head[c.ins_h];
      c.head[c.ins_h] = c.strstart;
    }
    if (b !== 0 && c.strstart - b <= c.w_size - Qd) {
      c.match_length = Te(c, b);
    }
    if (c.match_length >= Yd) {
      f = Ld(c, c.strstart - c.match_start, c.match_length - Yd);
      c.lookahead -= c.match_length;
      if (c.match_length <= c.max_lazy_match && c.lookahead >= Yd) {
        c.match_length--;
        do {
          c.strstart++;
          c.ins_h = Ck(c, c.ins_h, c.window[c.strstart + Yd - 1]);
          b = c.prev[c.strstart & c.w_mask] = c.head[c.ins_h];
          c.head[c.ins_h] = c.strstart;
        } while (--c.match_length !== 0);
        c.strstart++;
      } else {
        c.strstart += c.match_length;
        c.match_length = 0;
        c.ins_h = c.window[c.strstart];
        c.ins_h = Ck(c, c.ins_h, c.window[c.strstart + 1]);
      }
    } else {
      f = Ld(c, 0, c.window[c.strstart]);
      c.lookahead--;
      c.strstart++;
    }
    if (f && (Ek(c, false), c.strm.avail_out === 0)) {
      return sk;
    }
  }
  c.insert = c.strstart < Yd - 1 ? c.strstart : Yd - 1;
  if (a === ek) {
    Ek(c, true);
    if (c.strm.avail_out === 0) {
      return uk;
    } else {
      return vk;
    }
  } else if (c.sym_next && (Ek(c, false), c.strm.avail_out === 0)) {
    return sk;
  } else {
    return tk;
  }
};
const Lk = (c, a) => {
  let b;
  let g;
  let h;
  while (true) {
    if (c.lookahead < Qd) {
      Ik(c);
      if (c.lookahead < Qd && a === Od) {
        return sk;
      }
      if (c.lookahead === 0) {
        break;
      }
    }
    b = 0;
    if (c.lookahead >= Yd) {
      c.ins_h = Ck(c, c.ins_h, c.window[c.strstart + Yd - 1]);
      b = c.prev[c.strstart & c.w_mask] = c.head[c.ins_h];
      c.head[c.ins_h] = c.strstart;
    }
    c.prev_length = c.match_length;
    c.prev_match = c.match_start;
    c.match_length = Yd - 1;
    if (b !== 0 && c.prev_length < c.max_lazy_match && c.strstart - b <= c.w_size - Qd) {
      c.match_length = Te(c, b);
      if (c.match_length <= 5 && (c.strategy === Nd || c.match_length === Yd && c.strstart - c.match_start > 4096)) {
        c.match_length = Yd - 1;
      }
    }
    if (c.prev_length >= Yd && c.match_length <= c.prev_length) {
      h = c.strstart + c.lookahead - Yd;
      g = Ld(c, c.strstart - 1 - c.prev_match, c.prev_length - Yd);
      c.lookahead -= c.prev_length - 1;
      c.prev_length -= 2;
      do {
        if (++c.strstart <= h) {
          c.ins_h = Ck(c, c.ins_h, c.window[c.strstart + Yd - 1]);
          b = c.prev[c.strstart & c.w_mask] = c.head[c.ins_h];
          c.head[c.ins_h] = c.strstart;
        }
      } while (--c.prev_length !== 0);
      c.match_available = 0;
      c.match_length = Yd - 1;
      c.strstart++;
      if (g && (Ek(c, false), c.strm.avail_out === 0)) {
        return sk;
      }
    } else if (c.match_available) {
      g = Ld(c, 0, c.window[c.strstart - 1]);
      if (g) {
        Ek(c, false);
      }
      c.strstart++;
      c.lookahead--;
      if (c.strm.avail_out === 0) {
        return sk;
      }
    } else {
      c.match_available = 1;
      c.strstart++;
      c.lookahead--;
    }
  }
  if (c.match_available) {
    g = Ld(c, 0, c.window[c.strstart - 1]);
    c.match_available = 0;
  }
  c.insert = c.strstart < Yd - 1 ? c.strstart : Yd - 1;
  if (a === ek) {
    Ek(c, true);
    if (c.strm.avail_out === 0) {
      return uk;
    } else {
      return vk;
    }
  } else if (c.sym_next && (Ek(c, false), c.strm.avail_out === 0)) {
    return sk;
  } else {
    return tk;
  }
};
const Mk = (c, a) => {
  let b;
  let i;
  let j;
  let k;
  const l = c.window;
  while (true) {
    if (c.lookahead <= Jd) {
      Ik(c);
      if (c.lookahead <= Jd && a === Od) {
        return sk;
      }
      if (c.lookahead === 0) {
        break;
      }
    }
    c.match_length = 0;
    if (c.lookahead >= Yd && c.strstart > 0 && (j = c.strstart - 1, i = l[j], i === l[++j] && i === l[++j] && i === l[++j])) {
      k = c.strstart + Jd;
      do ; while (i === l[++j] && i === l[++j] && i === l[++j] && i === l[++j] && i === l[++j] && i === l[++j] && i === l[++j] && i === l[++j] && j < k);
      c.match_length = Jd - (k - j);
      if (c.match_length > c.lookahead) {
        c.match_length = c.lookahead;
      }
    }
    if (c.match_length >= Yd) {
      b = Ld(c, 1, c.match_length - Yd);
      c.lookahead -= c.match_length;
      c.strstart += c.match_length;
      c.match_length = 0;
    } else {
      b = Ld(c, 0, c.window[c.strstart]);
      c.lookahead--;
      c.strstart++;
    }
    if (b && (Ek(c, false), c.strm.avail_out === 0)) {
      return sk;
    }
  }
  c.insert = 0;
  if (a === ek) {
    Ek(c, true);
    if (c.strm.avail_out === 0) {
      return uk;
    } else {
      return vk;
    }
  } else if (c.sym_next && (Ek(c, false), c.strm.avail_out === 0)) {
    return sk;
  } else {
    return tk;
  }
};
const Ca = (c, a) => {
  let b;
  while (true) {
    if (c.lookahead === 0 && (Ik(c), c.lookahead === 0)) {
      if (a === Od) {
        return sk;
      }
      break;
    }
    c.match_length = 0;
    b = Ld(c, 0, c.window[c.strstart]);
    c.lookahead--;
    c.strstart++;
    if (b && (Ek(c, false), c.strm.avail_out === 0)) {
      return sk;
    }
  }
  c.insert = 0;
  if (a === ek) {
    Ek(c, true);
    if (c.strm.avail_out === 0) {
      return uk;
    } else {
      return vk;
    }
  } else if (c.sym_next && (Ek(c, false), c.strm.avail_out === 0)) {
    return sk;
  } else {
    return tk;
  }
};
function Nk(f, a, b, c, d) {
  this.good_length = f;
  this.max_lazy = a;
  this.nice_length = b;
  this.max_chain = c;
  this.func = d;
}
const Ok = [new Nk(0, 0, 0, 0, Jk), new Nk(4, 4, 8, 4, Kk), new Nk(4, 5, 16, 8, Kk), new Nk(4, 6, 32, 32, Kk), new Nk(4, 4, 16, 16, Lk), new Nk(8, 16, 32, 32, Lk), new Nk(8, 16, 128, 128, Lk), new Nk(8, 32, 128, 256, Lk), new Nk(32, 128, 258, 1024, Lk), new Nk(32, 258, 258, 4096, Lk)];
const Pk = b => {
  b.window_size = b.w_size * 2;
  zk(b.head);
  b.max_lazy_match = Ok[b.level].max_lazy;
  b.good_match = Ok[b.level].good_length;
  b.nice_match = Ok[b.level].nice_length;
  b.max_chain_length = Ok[b.level].max_chain;
  b.strstart = 0;
  b.block_start = 0;
  b.lookahead = 0;
  b.insert = 0;
  b.match_length = b.prev_length = Yd - 1;
  b.match_available = 0;
  b.ins_h = 0;
};
function Qk() {
  this.strm = null;
  this.status = 0;
  this.pending_buf = null;
  this.pending_buf_size = 0;
  this.pending_out = 0;
  this.pending = 0;
  this.wrap = 0;
  this.gzhead = null;
  this.gzindex = 0;
  this.method = Hd;
  this.last_flush = -1;
  this.w_size = 0;
  this.w_bits = 0;
  this.w_mask = 0;
  this.window = null;
  this.window_size = 0;
  this.prev = null;
  this.head = null;
  this.ins_h = 0;
  this.hash_size = 0;
  this.hash_bits = 0;
  this.hash_mask = 0;
  this.hash_shift = 0;
  this.block_start = 0;
  this.match_length = 0;
  this.prev_match = 0;
  this.match_available = 0;
  this.strstart = 0;
  this.match_start = 0;
  this.lookahead = 0;
  this.prev_length = 0;
  this.max_chain_length = 0;
  this.max_lazy_match = 0;
  this.level = 0;
  this.strategy = 0;
  this.good_match = 0;
  this.nice_match = 0;
  this.dyn_ltree = new Uint16Array(jk * 2);
  this.dyn_dtree = new Uint16Array((Kd * 2 + 1) * 2);
  this.bl_tree = new Uint16Array((Gd * 2 + 1) * 2);
  zk(this.dyn_ltree);
  zk(this.dyn_dtree);
  zk(this.bl_tree);
  this.l_desc = null;
  this.d_desc = null;
  this.bl_desc = null;
  this.bl_count = new Uint16Array(Xd + 1);
  this.heap = new Uint16Array(qd * 2 + 1);
  zk(this.heap);
  this.heap_len = 0;
  this.heap_max = 0;
  this.depth = new Uint16Array(qd * 2 + 1);
  zk(this.depth);
  this.sym_buf = 0;
  this.lit_bufsize = 0;
  this.sym_next = 0;
  this.sym_end = 0;
  this.opt_len = 0;
  this.static_len = 0;
  this.matches = 0;
  this.insert = 0;
  this.bi_buf = 0;
  this.bi_valid = 0;
}
const Rk = b => {
  if (!b) {
    return 1;
  }
  const a = b.state;
  if (!a || a.strm !== b || a.status !== kk && a.status !== lk && a.status !== mk && a.status !== nk && a.status !== ok && a.status !== pk && a.status !== qk && a.status !== rk) {
    return 1;
  } else {
    return 0;
  }
};
const Sk = b => {
  if (Rk(b)) {
    return xk(b, gk);
  }
  b.total_in = b.total_out = 0;
  b.data_type = Ud;
  const a = b.state;
  a.pending = 0;
  a.pending_out = 0;
  if (a.wrap < 0) {
    a.wrap = -a.wrap;
  }
  a.status = a.wrap === 2 ? lk : a.wrap ? kk : qk;
  b.adler = a.wrap === 2 ? 0 : 1;
  a.last_flush = -2;
  He(a);
  return Rd;
};
const Tk = c => {
  const a = Sk(c);
  if (a === Rd) {
    Pk(c.state);
  }
  return a;
};
const ii = (c, a) => Rk(c) || c.state.wrap !== 2 ? gk : (c.state.gzhead = a, Rd);
const Uk = (g, a, j, c, k, e) => {
  if (!g) {
    return gk;
  }
  let f = 1;
  if (a === ik) {
    a = 6;
  }
  if (c < 0) {
    f = 0;
    c = -c;
  } else if (c > 15) {
    f = 2;
    c -= 16;
  }
  if (k < 1 || k > jd || j !== Hd || c < 8 || c > 15 || a < 0 || a > 9 || e < 0 || e > Md || c === 8 && f !== 1) {
    return xk(g, gk);
  }
  if (c === 8) {
    c = 9;
  }
  const l = new Qk();
  g.state = l;
  l.strm = g;
  l.status = kk;
  l.wrap = f;
  l.gzhead = null;
  l.w_bits = c;
  l.w_size = 1 << l.w_bits;
  l.w_mask = l.w_size - 1;
  l.hash_bits = k + 7;
  l.hash_size = 1 << l.hash_bits;
  l.hash_mask = l.hash_size - 1;
  l.hash_shift = ~~((l.hash_bits + Yd - 1) / Yd);
  l.window = new Uint8Array(l.w_size * 2);
  l.head = new Uint16Array(l.hash_size);
  l.prev = new Uint16Array(l.w_size);
  l.lit_bufsize = 1 << k + 6;
  l.pending_buf_size = l.lit_bufsize * 4;
  l.pending_buf = new Uint8Array(l.pending_buf_size);
  l.sym_buf = l.lit_bufsize;
  l.sym_end = (l.lit_bufsize - 1) * 3;
  l.level = a;
  l.strategy = e;
  l.method = j;
  return Tk(g);
};
const Vk = (c, a) => Uk(c, a, Hd, Zd, ua, di);
const Wk = (c, a) => {
  if (Rk(c) || a > Fd || a < 0) {
    if (c) {
      return xk(c, gk);
    } else {
      return gk;
    }
  }
  const g = c.state;
  if (!c.output || c.avail_in !== 0 && !c.input || g.status === rk && a !== ek) {
    return xk(c, c.avail_out === 0 ? hk : gk);
  }
  const b = g.last_flush;
  g.last_flush = a;
  if (g.pending !== 0) {
    Dk(c);
    if (c.avail_out === 0) {
      g.last_flush = -1;
      return Rd;
    }
  } else if (c.avail_in === 0 && yk(a) <= yk(b) && a !== ek) {
    return xk(c, hk);
  }
  if (g.status === rk && c.avail_in !== 0) {
    return xk(c, hk);
  }
  if (g.status === kk && g.wrap === 0) {
    g.status = qk;
  }
  if (g.status === kk) {
    let a = Hd + (g.w_bits - 8 << 4) << 8;
    let b = -1;
    if (g.strategy >= ba || g.level < 2) {
      b = 0;
    } else if (g.level < 6) {
      b = 1;
    } else if (g.level === 6) {
      b = 2;
    } else {
      b = 3;
    }
    a |= b << 6;
    if (g.strstart !== 0) {
      a |= be;
    }
    a += 31 - a % 31;
    Gk(g, a);
    if (g.strstart !== 0) {
      Gk(g, c.adler >>> 16);
      Gk(g, c.adler & 65535);
    }
    c.adler = 1;
    g.status = qk;
    Dk(c);
    if (g.pending !== 0) {
      g.last_flush = -1;
      return Rd;
    }
  }
  if (g.status === lk) {
    c.adler = 0;
    Fk(g, 31);
    Fk(g, 139);
    Fk(g, 8);
    if (g.gzhead) {
      Fk(g, (g.gzhead.text ? 1 : 0) + (g.gzhead.hcrc ? 2 : 0) + (g.gzhead.extra ? 4 : 0) + (g.gzhead.name ? 8 : 0) + (g.gzhead.comment ? 16 : 0));
      Fk(g, g.gzhead.time & 255);
      Fk(g, g.gzhead.time >> 8 & 255);
      Fk(g, g.gzhead.time >> 16 & 255);
      Fk(g, g.gzhead.time >> 24 & 255);
      Fk(g, g.level === 9 ? 2 : g.strategy >= ba || g.level < 2 ? 4 : 0);
      Fk(g, g.gzhead.os & 255);
      if (g.gzhead.extra && g.gzhead.extra.length) {
        Fk(g, g.gzhead.extra.length & 255);
        Fk(g, g.gzhead.extra.length >> 8 & 255);
      }
      if (g.gzhead.hcrc) {
        c.adler = Bd(c.adler, g.pending_buf, g.pending, 0);
      }
      g.gzindex = 0;
      g.status = mk;
    } else {
      Fk(g, 0);
      Fk(g, 0);
      Fk(g, 0);
      Fk(g, 0);
      Fk(g, 0);
      Fk(g, g.level === 9 ? 2 : g.strategy >= ba || g.level < 2 ? 4 : 0);
      Fk(g, wk);
      g.status = qk;
      Dk(c);
      if (g.pending !== 0) {
        g.last_flush = -1;
        return Rd;
      }
    }
  }
  if (g.status === mk) {
    if (g.gzhead.extra) {
      let a = g.pending;
      let b = (g.gzhead.extra.length & 65535) - g.gzindex;
      while (g.pending + b > g.pending_buf_size) {
        let d = g.pending_buf_size - g.pending;
        g.pending_buf.set(g.gzhead.extra.subarray(g.gzindex, g.gzindex + d), g.pending);
        g.pending = g.pending_buf_size;
        if (g.gzhead.hcrc && g.pending > a) {
          c.adler = Bd(c.adler, g.pending_buf, g.pending - a, a);
        }
        g.gzindex += d;
        Dk(c);
        if (g.pending !== 0) {
          g.last_flush = -1;
          return Rd;
        }
        a = 0;
        b -= d;
      }
      let d = new Uint8Array(g.gzhead.extra);
      g.pending_buf.set(d.subarray(g.gzindex, g.gzindex + b), g.pending);
      g.pending += b;
      if (g.gzhead.hcrc && g.pending > a) {
        c.adler = Bd(c.adler, g.pending_buf, g.pending - a, a);
      }
      g.gzindex = 0;
    }
    g.status = nk;
  }
  if (g.status === nk) {
    if (g.gzhead.name) {
      let a = g.pending;
      let b;
      do {
        if (g.pending === g.pending_buf_size) {
          if (g.gzhead.hcrc && g.pending > a) {
            c.adler = Bd(c.adler, g.pending_buf, g.pending - a, a);
          }
          Dk(c);
          if (g.pending !== 0) {
            g.last_flush = -1;
            return Rd;
          }
          a = 0;
        }
        if (g.gzindex < g.gzhead.name.length) {
          b = g.gzhead.name.charCodeAt(g.gzindex++) & 255;
        } else {
          b = 0;
        }
        Fk(g, b);
      } while (b !== 0);
      if (g.gzhead.hcrc && g.pending > a) {
        c.adler = Bd(c.adler, g.pending_buf, g.pending - a, a);
      }
      g.gzindex = 0;
    }
    g.status = ok;
  }
  if (g.status === ok) {
    if (g.gzhead.comment) {
      let a = g.pending;
      let b;
      do {
        if (g.pending === g.pending_buf_size) {
          if (g.gzhead.hcrc && g.pending > a) {
            c.adler = Bd(c.adler, g.pending_buf, g.pending - a, a);
          }
          Dk(c);
          if (g.pending !== 0) {
            g.last_flush = -1;
            return Rd;
          }
          a = 0;
        }
        if (g.gzindex < g.gzhead.comment.length) {
          b = g.gzhead.comment.charCodeAt(g.gzindex++) & 255;
        } else {
          b = 0;
        }
        Fk(g, b);
      } while (b !== 0);
      if (g.gzhead.hcrc && g.pending > a) {
        c.adler = Bd(c.adler, g.pending_buf, g.pending - a, a);
      }
    }
    g.status = pk;
  }
  if (g.status === pk) {
    if (g.gzhead.hcrc) {
      if (g.pending + 2 > g.pending_buf_size && (Dk(c), g.pending !== 0)) {
        g.last_flush = -1;
        return Rd;
      }
      Fk(g, c.adler & 255);
      Fk(g, c.adler >> 8 & 255);
      c.adler = 0;
    }
    g.status = qk;
    Dk(c);
    if (g.pending !== 0) {
      g.last_flush = -1;
      return Rd;
    }
  }
  if (c.avail_in !== 0 || g.lookahead !== 0 || a !== Od && g.status !== rk) {
    let b = g.level === 0 ? Jk(g, a) : g.strategy === ba ? Ca(g, a) : g.strategy === Pd ? Mk(g, a) : Ok[g.level].func(g, a);
    if (b === uk || b === vk) {
      g.status = rk;
    }
    if (b === sk || b === uk) {
      if (c.avail_out === 0) {
        g.last_flush = -1;
      }
      return Rd;
    }
    if (b === tk && (a === dk ? Qa(g) : a !== Fd && (bk(g, 0, 0, false), a === zd && (zk(g.head), g.lookahead === 0 && (g.strstart = 0, g.block_start = 0, g.insert = 0))), Dk(c), c.avail_out === 0)) {
      g.last_flush = -1;
      return Rd;
    }
  }
  if (a !== ek) {
    return Rd;
  } else if (g.wrap <= 0) {
    return fk;
  } else {
    if (g.wrap === 2) {
      Fk(g, c.adler & 255);
      Fk(g, c.adler >> 8 & 255);
      Fk(g, c.adler >> 16 & 255);
      Fk(g, c.adler >> 24 & 255);
      Fk(g, c.total_in & 255);
      Fk(g, c.total_in >> 8 & 255);
      Fk(g, c.total_in >> 16 & 255);
      Fk(g, c.total_in >> 24 & 255);
    } else {
      Gk(g, c.adler >>> 16);
      Gk(g, c.adler & 65535);
    }
    Dk(c);
    if (g.wrap > 0) {
      g.wrap = -g.wrap;
    }
    if (g.pending !== 0) {
      return Rd;
    } else {
      return fk;
    }
  }
};
const Xk = b => {
  if (Rk(b)) {
    return gk;
  }
  const a = b.state.status;
  b.state = null;
  if (a === qk) {
    return xk(b, Ze);
  } else {
    return Rd;
  }
};
const Yk = (c, j) => {
  let k = j.length;
  if (Rk(c)) {
    return gk;
  }
  const l = c.state;
  const e = l.wrap;
  if (e === 2 || e === 1 && l.status !== kk || l.lookahead) {
    return gk;
  }
  if (e === 1) {
    c.adler = Ad(c.adler, j, k, 0);
  }
  l.wrap = 0;
  if (k >= l.w_size) {
    if (e === 0) {
      zk(l.head);
      l.strstart = 0;
      l.block_start = 0;
      l.insert = 0;
    }
    let b = new Uint8Array(l.w_size);
    b.set(j.subarray(k - l.w_size, k), 0);
    j = b;
    k = l.w_size;
  }
  const a = c.avail_in;
  const f = c.next_in;
  const g = c.input;
  c.avail_in = k;
  c.next_in = 0;
  c.input = j;
  Ik(l);
  while (l.lookahead >= Yd) {
    let c = l.strstart;
    let a = l.lookahead - (Yd - 1);
    do {
      l.ins_h = Ck(l, l.ins_h, l.window[c + Yd - 1]);
      l.prev[c & l.w_mask] = l.head[l.ins_h];
      l.head[l.ins_h] = c;
      c++;
    } while (--a);
    l.strstart = c;
    l.lookahead = Yd - 1;
    Ik(l);
  }
  l.strstart += l.lookahead;
  l.block_start = l.strstart;
  l.insert = l.lookahead;
  l.lookahead = 0;
  l.match_length = l.prev_length = Yd - 1;
  l.match_available = 0;
  c.next_in = f;
  c.input = g;
  c.avail_in = a;
  l.wrap = e;
  return Rd;
};
var Zk = Vk;
var $k = Uk;
var _k = Tk;
var bl = Sk;
var cl = ii;
var dl = Wk;
var fl = Xk;
var gl = Yk;
var hl = "pako deflate (from Nodeca project)";
var jl = {
  deflateInit: Zk,
  deflateInit2: $k,
  deflateReset: _k,
  deflateResetKeep: bl,
  deflateSetHeader: cl,
  deflate: dl,
  deflateEnd: fl,
  deflateSetDictionary: gl,
  deflateInfo: hl
};
const kl = (c, a) => Object.prototype.hasOwnProperty.call(c, a);
function ll(e) {
  const a = Array.prototype.slice.call(arguments, 1);
  while (a.length) {
    const c = a.shift();
    if (c) {
      if (typeof c != "object") {
        throw new TypeError(c + "must be non-object");
      }
      for (const a in c) {
        if (kl(c, a)) {
          e[a] = c[a];
        }
      }
    }
  }
  return e;
}
var ml = b => {
  let a = 0;
  for (let c = 0, d = b.length; c < d; c++) {
    a += b[c].length;
  }
  const g = new Uint8Array(a);
  for (let a = 0, c = 0, d = b.length; a < d; a++) {
    let d = b[a];
    g.set(d, c);
    c += d.length;
  }
  return g;
};
var ol = {
  assign: ll,
  flattenChunks: ml
};
let pl = true;
try {
  String.fromCharCode.apply(null, new Uint8Array(1));
} catch {
  pl = false;
}
const ql = new Uint8Array(256);
for (let a = 0; a < 256; a++) {
  ql[a] = a >= 252 ? 6 : a >= 248 ? 5 : a >= 240 ? 4 : a >= 224 ? 3 : a >= 192 ? 2 : 1;
}
ql[254] = ql[254] = 1;
var da = b => {
  if (typeof TextEncoder == "function" && TextEncoder.prototype.encode) {
    return new TextEncoder().encode(b);
  }
  let a;
  let j;
  let k;
  let l;
  let m;
  let n = b.length;
  let h = 0;
  for (l = 0; l < n; l++) {
    j = b.charCodeAt(l);
    if ((j & 64512) === 55296 && l + 1 < n) {
      k = b.charCodeAt(l + 1);
      if ((k & 64512) === 56320) {
        j = 65536 + (j - 55296 << 10) + (k - 56320);
        l++;
      }
    }
    h += j < 128 ? 1 : j < 2048 ? 2 : j < 65536 ? 3 : 4;
  }
  a = new Uint8Array(h);
  m = 0;
  l = 0;
  for (; m < h; l++) {
    j = b.charCodeAt(l);
    if ((j & 64512) === 55296 && l + 1 < n) {
      k = b.charCodeAt(l + 1);
      if ((k & 64512) === 56320) {
        j = 65536 + (j - 55296 << 10) + (k - 56320);
        l++;
      }
    }
    if (j < 128) {
      a[m++] = j;
    } else if (j < 2048) {
      a[m++] = j >>> 6 | 192;
      a[m++] = j & 63 | 128;
    } else if (j < 65536) {
      a[m++] = j >>> 12 | 224;
      a[m++] = j >>> 6 & 63 | 128;
      a[m++] = j & 63 | 128;
    } else {
      a[m++] = j >>> 18 | 240;
      a[m++] = j >>> 12 & 63 | 128;
      a[m++] = j >>> 6 & 63 | 128;
      a[m++] = j & 63 | 128;
    }
  }
  return a;
};
const sl = (c, a) => {
  if (a < 65534 && c.subarray && pl) {
    return String.fromCharCode.apply(null, c.length === a ? c : c.subarray(0, a));
  }
  let b = "";
  for (let d = 0; d < a; d++) {
    b += String.fromCharCode(c[d]);
  }
  return b;
};
var ul = (h, a) => {
  const i = a || h.length;
  if (typeof TextDecoder == "function" && TextDecoder.prototype.decode) {
    return new TextDecoder().decode(h.subarray(0, a));
  }
  let d;
  let j;
  const k = new Array(i * 2);
  j = 0;
  d = 0;
  while (d < i) {
    let a = h[d++];
    if (a < 128) {
      k[j++] = a;
      continue;
    }
    let b = ql[a];
    if (b > 4) {
      k[j++] = 65533;
      d += b - 1;
      continue;
    }
    for (a &= b === 2 ? 31 : b === 3 ? 15 : 7; b > 1 && d < i;) {
      a = a << 6 | h[d++] & 63;
      b--;
    }
    if (b > 1) {
      k[j++] = 65533;
      continue;
    }
    if (a < 65536) {
      k[j++] = a;
    } else {
      a -= 65536;
      k[j++] = a >> 10 & 1023 | 55296;
      k[j++] = a & 1023 | 56320;
    }
  }
  return sl(k, j);
};
var vl = (c, a) => {
  a = a || c.length;
  if (a > c.length) {
    a = c.length;
  }
  let e = a - 1;
  while (e >= 0 && (c[e] & 192) === 128) {
    e--;
  }
  if (e < 0 || e === 0) {
    return a;
  } else if (e + ql[c[e]] > a) {
    return e;
  } else {
    return a;
  }
};
var wl = {
  string2buf: da,
  buf2string: ul,
  utf8border: vl
};
function xl() {
  this.input = null;
  this.next_in = 0;
  this.avail_in = 0;
  this.total_in = 0;
  this.output = null;
  this.next_out = 0;
  this.avail_out = 0;
  this.total_out = 0;
  this.msg = "";
  this.state = null;
  this.data_type = 2;
  this.adler = 0;
}
var yl = xl;
const zl = Object.prototype.toString;
const {
  Z_NO_FLUSH: Al,
  Z_SYNC_FLUSH: Bl,
  Z_FULL_FLUSH: ec,
  Z_FINISH: Cl,
  Z_OK: Dl,
  Z_STREAM_END: El,
  Z_DEFAULT_COMPRESSION: Fl,
  Z_DEFAULT_STRATEGY: ji,
  Z_DEFLATED: Gl
} = Dd;
function Hl(b) {
  this.options = ol.assign({
    level: Fl,
    method: Gl,
    chunkSize: 16384,
    windowBits: 15,
    memLevel: 8,
    strategy: ji
  }, b || {});
  let e = this.options;
  if (e.raw && e.windowBits > 0) {
    e.windowBits = -e.windowBits;
  } else if (e.gzip && e.windowBits > 0 && e.windowBits < 16) {
    e.windowBits += 16;
  }
  this.err = 0;
  this.msg = "";
  this.ended = false;
  this.chunks = [];
  this.strm = new yl();
  this.strm.avail_out = 0;
  let c = jl.deflateInit2(this.strm, e.level, e.method, e.windowBits, e.memLevel, e.strategy);
  if (c !== Dl) {
    throw new Error(Id[c]);
  }
  if (e.header) {
    jl.deflateSetHeader(this.strm, e.header);
  }
  if (e.dictionary) {
    let b;
    if (typeof e.dictionary == "string") {
      b = wl.string2buf(e.dictionary);
    } else if (zl.call(e.dictionary) === "[object ArrayBuffer]") {
      b = new Uint8Array(e.dictionary);
    } else {
      b = e.dictionary;
    }
    c = jl.deflateSetDictionary(this.strm, b);
    if (c !== Dl) {
      throw new Error(Id[c]);
    }
    this._dict_set = true;
  }
}
Hl.prototype.push = function (c, a) {
  const b = this.strm;
  const d = this.options.chunkSize;
  let e;
  let h;
  if (this.ended) {
    return false;
  }
  if (a === ~~a) {
    h = a;
  } else {
    h = a === true ? Cl : Al;
  }
  if (typeof c == "string") {
    b.input = wl.string2buf(c);
  } else if (zl.call(c) === "[object ArrayBuffer]") {
    b.input = new Uint8Array(c);
  } else {
    b.input = c;
  }
  b.next_in = 0;
  b.avail_in = b.input.length;
  while (true) {
    if (b.avail_out === 0) {
      b.output = new Uint8Array(d);
      b.next_out = 0;
      b.avail_out = d;
    }
    if ((h === Bl || h === ec) && b.avail_out <= 6) {
      this.onData(b.output.subarray(0, b.next_out));
      b.avail_out = 0;
      continue;
    }
    e = jl.deflate(b, h);
    if (e === El) {
      if (b.next_out > 0) {
        this.onData(b.output.subarray(0, b.next_out));
      }
      e = jl.deflateEnd(this.strm);
      this.onEnd(e);
      this.ended = true;
      return e === Dl;
    }
    if (b.avail_out === 0) {
      this.onData(b.output);
      continue;
    }
    if (h > 0 && b.next_out > 0) {
      this.onData(b.output.subarray(0, b.next_out));
      b.avail_out = 0;
      continue;
    }
    if (b.avail_in === 0) {
      break;
    }
  }
  return true;
};
Hl.prototype.onData = function (b) {
  this.chunks.push(b);
};
Hl.prototype.onEnd = function (b) {
  if (b === Dl) {
    this.result = ol.flattenChunks(this.chunks);
  }
  this.chunks = [];
  this.err = b;
  this.msg = this.strm.msg;
};
function Il(c, a) {
  const b = new Hl(a);
  b.push(c, true);
  if (b.err) {
    throw b.msg || Id[b.err];
  }
  return b.result;
}
function Jl(c, a) {
  a = a || {};
  a.raw = true;
  return Il(c, a);
}
function ai(c, a) {
  a = a || {};
  a.gzip = true;
  return Il(c, a);
}
var Kl = Hl;
var Ll = Il;
var Ml = Jl;
var Nl = ai;
var Ol = Dd;
var Pl = {
  Deflate: Kl,
  deflate: Ll,
  deflateRaw: Ml,
  gzip: Nl,
  constants: Ol
};
const Ql = 16209;
const Rl = 16191;
function Sl(c, a) {
  let b;
  let C;
  let D;
  let E;
  let F;
  let G;
  let H;
  let I;
  let J;
  let K;
  let L;
  let M;
  let N;
  let O;
  let P;
  let Q;
  let R;
  let S;
  let T;
  let U;
  let V;
  let W;
  let X;
  let Y;
  const Z = c.state;
  b = c.next_in;
  X = c.input;
  C = b + (c.avail_in - 5);
  D = c.next_out;
  Y = c.output;
  E = D - (a - c.avail_out);
  F = D + (c.avail_out - 257);
  G = Z.dmax;
  H = Z.wsize;
  I = Z.whave;
  J = Z.wnext;
  K = Z.window;
  L = Z.hold;
  M = Z.bits;
  N = Z.lencode;
  O = Z.distcode;
  P = (1 << Z.lenbits) - 1;
  Q = (1 << Z.distbits) - 1;
  _0x2c53b4: do {
    if (M < 15) {
      L += X[b++] << M;
      M += 8;
      L += X[b++] << M;
      M += 8;
    }
    R = N[L & P];
    _0x52cad1: while (true) {
      S = R >>> 24;
      L >>>= S;
      M -= S;
      S = R >>> 16 & 255;
      if (S === 0) {
        Y[D++] = R & 65535;
      } else if (S & 16) {
        T = R & 65535;
        S &= 15;
        if (S) {
          if (M < S) {
            L += X[b++] << M;
            M += 8;
          }
          T += L & (1 << S) - 1;
          L >>>= S;
          M -= S;
        }
        if (M < 15) {
          L += X[b++] << M;
          M += 8;
          L += X[b++] << M;
          M += 8;
        }
        R = O[L & Q];
        _0x431baf: while (true) {
          S = R >>> 24;
          L >>>= S;
          M -= S;
          S = R >>> 16 & 255;
          if (S & 16) {
            U = R & 65535;
            S &= 15;
            if (M < S) {
              L += X[b++] << M;
              M += 8;
              if (M < S) {
                L += X[b++] << M;
                M += 8;
              }
            }
            U += L & (1 << S) - 1;
            if (U > G) {
              c.msg = "invalid distance too far back";
              Z.mode = Ql;
              break _0x2c53b4;
            }
            L >>>= S;
            M -= S;
            S = D - E;
            if (U > S) {
              S = U - S;
              if (S > I && Z.sane) {
                c.msg = "invalid distance too far back";
                Z.mode = Ql;
                break _0x2c53b4;
              }
              V = 0;
              W = K;
              if (J === 0) {
                V += H - S;
                if (S < T) {
                  T -= S;
                  do {
                    Y[D++] = K[V++];
                  } while (--S);
                  V = D - U;
                  W = Y;
                }
              } else if (J < S) {
                V += H + J - S;
                S -= J;
                if (S < T) {
                  T -= S;
                  do {
                    Y[D++] = K[V++];
                  } while (--S);
                  V = 0;
                  if (J < T) {
                    S = J;
                    T -= S;
                    do {
                      Y[D++] = K[V++];
                    } while (--S);
                    V = D - U;
                    W = Y;
                  }
                }
              } else {
                V += J - S;
                if (S < T) {
                  T -= S;
                  do {
                    Y[D++] = K[V++];
                  } while (--S);
                  V = D - U;
                  W = Y;
                }
              }
              while (T > 2) {
                Y[D++] = W[V++];
                Y[D++] = W[V++];
                Y[D++] = W[V++];
                T -= 3;
              }
              if (T) {
                Y[D++] = W[V++];
                if (T > 1) {
                  Y[D++] = W[V++];
                }
              }
            } else {
              V = D - U;
              do {
                Y[D++] = Y[V++];
                Y[D++] = Y[V++];
                Y[D++] = Y[V++];
                T -= 3;
              } while (T > 2);
              if (T) {
                Y[D++] = Y[V++];
                if (T > 1) {
                  Y[D++] = Y[V++];
                }
              }
            }
          } else if (S & 64) {
            c.msg = "invalid distance code";
            Z.mode = Ql;
            break _0x2c53b4;
          } else {
            R = O[(R & 65535) + (L & (1 << S) - 1)];
            continue _0x431baf;
          }
          break;
        }
      } else if (S & 64) {
        if (S & 32) {
          Z.mode = Rl;
          break _0x2c53b4;
        } else {
          c.msg = "invalid literal/length code";
          Z.mode = Ql;
          break _0x2c53b4;
        }
      } else {
        R = N[(R & 65535) + (L & (1 << S) - 1)];
        continue _0x52cad1;
      }
      break;
    }
  } while (b < C && D < F);
  T = M >> 3;
  b -= T;
  M -= T << 3;
  L &= (1 << M) - 1;
  c.next_in = b;
  c.next_out = D;
  c.avail_in = b < C ? 5 + (C - b) : 5 - (b - C);
  c.avail_out = D < F ? 257 + (F - D) : 257 - (D - F);
  Z.hold = L;
  Z.bits = M;
}
const fi = 15;
const Tl = 852;
const Ul = 592;
const Vl = 0;
const Wl = 1;
const Xl = 2;
const Yl = new Uint16Array([3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0]);
const ka = new Uint8Array([16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 16, 72, 78]);
const Zl = new Uint16Array([1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577, 0, 0]);
const $l = new Uint8Array([16, 16, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 27, 27, 28, 28, 29, 29, 64, 64]);
const _l = (i, a, b, c, d, e, H, g) => {
  const h = g.bits;
  let j = 0;
  let I = 0;
  let J = 0;
  let K = 0;
  let L = 0;
  let M = 0;
  let N = 0;
  let O = 0;
  let P = 0;
  let Q = 0;
  let R;
  let S;
  let T;
  let U;
  let V;
  let W = null;
  let X;
  const Y = new Uint16Array(fi + 1);
  const B = new Uint16Array(fi + 1);
  let C = null;
  let Z;
  let $;
  let _;
  for (j = 0; j <= fi; j++) {
    Y[j] = 0;
  }
  for (I = 0; I < c; I++) {
    Y[a[b + I]]++;
  }
  L = h;
  K = fi;
  for (; K >= 1 && Y[K] === 0; K--);
  if (L > K) {
    L = K;
  }
  if (K === 0) {
    d[e++] = 1 << 24 | 64 << 16 | 0;
    d[e++] = 1 << 24 | 64 << 16 | 0;
    g.bits = 1;
    return 0;
  }
  for (J = 1; J < K && Y[J] === 0; J++);
  if (L < J) {
    L = J;
  }
  O = 1;
  j = 1;
  for (; j <= fi; j++) {
    O <<= 1;
    O -= Y[j];
    if (O < 0) {
      return -1;
    }
  }
  if (O > 0 && (i === Vl || K !== 1)) {
    return -1;
  }
  B[1] = 0;
  j = 1;
  for (; j < fi; j++) {
    B[j + 1] = B[j] + Y[j];
  }
  for (I = 0; I < c; I++) {
    if (a[b + I] !== 0) {
      H[B[a[b + I]]++] = I;
    }
  }
  if (i === Vl) {
    W = C = H;
    X = 20;
  } else if (i === Wl) {
    W = Yl;
    C = ka;
    X = 257;
  } else {
    W = Zl;
    C = $l;
    X = 0;
  }
  Q = 0;
  I = 0;
  j = J;
  V = e;
  M = L;
  N = 0;
  T = -1;
  P = 1 << L;
  U = P - 1;
  if (i === Wl && P > Tl || i === Xl && P > Ul) {
    return 1;
  }
  while (true) {
    Z = j - N;
    if (H[I] + 1 < X) {
      $ = 0;
      _ = H[I];
    } else if (H[I] >= X) {
      $ = C[H[I] - X];
      _ = W[H[I] - X];
    } else {
      $ = 96;
      _ = 0;
    }
    R = 1 << j - N;
    S = 1 << M;
    J = S;
    do {
      S -= R;
      d[V + (Q >> N) + S] = Z << 24 | $ << 16 | _ | 0;
    } while (S !== 0);
    for (R = 1 << j - 1; Q & R;) {
      R >>= 1;
    }
    if (R !== 0) {
      Q &= R - 1;
      Q += R;
    } else {
      Q = 0;
    }
    I++;
    if (--Y[j] === 0) {
      if (j === K) {
        break;
      }
      j = a[b + H[I]];
    }
    if (j > L && (Q & U) !== T) {
      if (N === 0) {
        N = L;
      }
      V += J;
      M = j - N;
      O = 1 << M;
      while (M + N < K && (O -= Y[M + N], O > 0)) {
        M++;
        O <<= 1;
      }
      P += 1 << M;
      if (i === Wl && P > Tl || i === Xl && P > Ul) {
        return 1;
      }
      T = Q & U;
      d[T] = L << 24 | M << 16 | V - e | 0;
    }
  }
  if (Q !== 0) {
    d[V + Q] = j - N << 24 | 64 << 16 | 0;
  }
  g.bits = L;
  return 0;
};
var am = _l;
const bm = 0;
const cm = 1;
const dm = 2;
const {
  Z_FINISH: em,
  Z_BLOCK: tc,
  Z_TREES: nc,
  Z_OK: fm,
  Z_STREAM_END: ef,
  Z_NEED_DICT: hi,
  Z_STREAM_ERROR: gm,
  Z_DATA_ERROR: tf,
  Z_MEM_ERROR: nf,
  Z_BUF_ERROR: hm,
  Z_DEFLATED: rc
} = Dd;
const ic = 16180;
const rf = 16181;
const im = 16182;
const fa = 16183;
const jm = 16184;
const km = 16185;
const lm = 16186;
const mm = 16187;
const nm = 16188;
const om = 16189;
const pm = 16190;
const qm = 16191;
const rm = 16192;
const Zi = 16193;
const sm = 16194;
const Ea = 16195;
const tm = 16196;
const Sa = 16197;
const um = 16198;
const vm = 16199;
const wm = 16200;
const xm = 16201;
const vi = 16202;
const _i = 16203;
const ym = 16204;
const zm = 16205;
const Am = 16206;
const Bm = 16207;
const Cm = 16208;
const Aa = 16209;
const Dm = 16210;
const Em = 16211;
const Le = 852;
const ac = 592;
const sc = 15;
const af = sc;
const sf = b => (b >>> 24 & 255) + (b >>> 8 & 65280) + ((b & 65280) << 8) + ((b & 255) << 24);
function of() {
  this.strm = null;
  this.mode = 0;
  this.last = false;
  this.wrap = 0;
  this.havedict = false;
  this.flags = 0;
  this.dmax = 0;
  this.check = 0;
  this.total = 0;
  this.head = null;
  this.wbits = 0;
  this.wsize = 0;
  this.whave = 0;
  this.wnext = 0;
  this.window = null;
  this.hold = 0;
  this.bits = 0;
  this.length = 0;
  this.offset = 0;
  this.extra = 0;
  this.lencode = null;
  this.distcode = null;
  this.lenbits = 0;
  this.distbits = 0;
  this.ncode = 0;
  this.nlen = 0;
  this.ndist = 0;
  this.have = 0;
  this.next = null;
  this.lens = new Uint16Array(320);
  this.work = new Uint16Array(288);
  this.lendyn = null;
  this.distdyn = null;
  this.sane = 0;
  this.back = 0;
  this.was = 0;
}
const lf = b => {
  if (!b) {
    return 1;
  }
  const a = b.state;
  if (!a || a.strm !== b || a.mode < ic || a.mode > Em) {
    return 1;
  } else {
    return 0;
  }
};
const Fm = b => {
  if (lf(b)) {
    return gm;
  }
  const a = b.state;
  b.total_in = b.total_out = a.total = 0;
  b.msg = "";
  if (a.wrap) {
    b.adler = a.wrap & 1;
  }
  a.mode = ic;
  a.last = 0;
  a.havedict = 0;
  a.flags = -1;
  a.dmax = 32768;
  a.head = null;
  a.hold = 0;
  a.bits = 0;
  a.lencode = a.lendyn = new Int32Array(Le);
  a.distcode = a.distdyn = new Int32Array(ac);
  a.sane = 1;
  a.back = -1;
  return fm;
};
const cf = b => {
  if (lf(b)) {
    return gm;
  }
  const a = b.state;
  a.wsize = 0;
  a.whave = 0;
  a.wnext = 0;
  return Fm(b);
};
const Gm = (c, a) => {
  let f;
  if (lf(c)) {
    return gm;
  }
  const g = c.state;
  if (a < 0) {
    f = 0;
    a = -a;
  } else {
    f = (a >> 4) + 5;
    if (a < 48) {
      a &= 15;
    }
  }
  if (a && (a < 8 || a > 15)) {
    return gm;
  } else {
    if (g.window !== null && g.wbits !== a) {
      g.window = null;
    }
    g.wrap = f;
    g.wbits = a;
    return cf(c);
  }
};
const oc = (c, a) => {
  if (!c) {
    return gm;
  }
  const b = new of();
  c.state = b;
  b.strm = c;
  b.window = null;
  b.mode = ic;
  const d = Gm(c, a);
  if (d !== fm) {
    c.state = null;
  }
  return d;
};
const lc = b => oc(b, af);
let cc = true;
let uc;
let uf;
const Hm = b => {
  if (cc) {
    uc = new Int32Array(512);
    uf = new Int32Array(32);
    let a = 0;
    while (a < 144) {
      b.lens[a++] = 8;
    }
    while (a < 256) {
      b.lens[a++] = 9;
    }
    while (a < 280) {
      b.lens[a++] = 7;
    }
    while (a < 288) {
      b.lens[a++] = 8;
    }
    am(cm, b.lens, 0, 288, uc, 0, b.work, {
      bits: 9
    });
    a = 0;
    while (a < 32) {
      b.lens[a++] = 5;
    }
    am(dm, b.lens, 0, 32, uf, 0, b.work, {
      bits: 5
    });
    cc = false;
  }
  b.lencode = uc;
  b.lenbits = 9;
  b.distcode = uf;
  b.distbits = 5;
};
const $a = (e, a, b, c) => {
  let h;
  const i = e.state;
  if (i.window === null) {
    i.wsize = 1 << i.wbits;
    i.wnext = 0;
    i.whave = 0;
    i.window = new Uint8Array(i.wsize);
  }
  if (c >= i.wsize) {
    i.window.set(a.subarray(b - i.wsize, b), 0);
    i.wnext = 0;
    i.whave = i.wsize;
  } else {
    h = i.wsize - i.wnext;
    if (h > c) {
      h = c;
    }
    i.window.set(a.subarray(b - c, b - c + h), i.wnext);
    c -= h;
    if (c) {
      i.window.set(a.subarray(b - c, b), 0);
      i.wnext = c;
      i.whave = i.wsize;
    } else {
      i.wnext += h;
      if (i.wnext === i.wsize) {
        i.wnext = 0;
      }
      if (i.whave < i.wsize) {
        i.whave += h;
      }
    }
  }
  return 0;
};
const Ta = (c, a) => {
  let b;
  let E;
  let F;
  let G;
  let H;
  let I;
  let J;
  let K;
  let L;
  let M;
  let N;
  let O;
  let P;
  let Q;
  let R = 0;
  let S;
  let T;
  let U;
  let V;
  let W;
  let X;
  let Y;
  let Z;
  const $ = new Uint8Array(4);
  let A;
  let _;
  const aa = new Uint8Array([16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15]);
  if (lf(c) || !c.output || !c.input && c.avail_in !== 0) {
    return gm;
  }
  b = c.state;
  if (b.mode === qm) {
    b.mode = rm;
  }
  H = c.next_out;
  F = c.output;
  J = c.avail_out;
  G = c.next_in;
  E = c.input;
  I = c.avail_in;
  K = b.hold;
  L = b.bits;
  M = I;
  N = J;
  Z = fm;
  _0x40120c: while (true) {
    switch (b.mode) {
      case ic:
        if (b.wrap === 0) {
          b.mode = rm;
          break;
        }
        while (L < 16) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        if (b.wrap & 2 && K === 35615) {
          if (b.wbits === 0) {
            b.wbits = 15;
          }
          b.check = 0;
          $[0] = K & 255;
          $[1] = K >>> 8 & 255;
          b.check = Bd(b.check, $, 2, 0);
          K = 0;
          L = 0;
          b.mode = rf;
          break;
        }
        if (b.head) {
          b.head.done = false;
        }
        if (!(b.wrap & 1) || (((K & 255) << 8) + (K >> 8)) % 31) {
          c.msg = "incorrect header check";
          b.mode = Aa;
          break;
        }
        if ((K & 15) !== rc) {
          c.msg = "unknown compression method";
          b.mode = Aa;
          break;
        }
        K >>>= 4;
        L -= 4;
        Y = (K & 15) + 8;
        if (b.wbits === 0) {
          b.wbits = Y;
        }
        if (Y > 15 || Y > b.wbits) {
          c.msg = "invalid window size";
          b.mode = Aa;
          break;
        }
        b.dmax = 1 << b.wbits;
        b.flags = 0;
        c.adler = b.check = 1;
        b.mode = K & 512 ? om : qm;
        K = 0;
        L = 0;
        break;
      case rf:
        while (L < 16) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        b.flags = K;
        if ((b.flags & 255) !== rc) {
          c.msg = "unknown compression method";
          b.mode = Aa;
          break;
        }
        if (b.flags & 57344) {
          c.msg = "unknown header flags set";
          b.mode = Aa;
          break;
        }
        if (b.head) {
          b.head.text = K >> 8 & 1;
        }
        if (b.flags & 512 && b.wrap & 4) {
          $[0] = K & 255;
          $[1] = K >>> 8 & 255;
          b.check = Bd(b.check, $, 2, 0);
        }
        K = 0;
        L = 0;
        b.mode = im;
      case im:
        while (L < 32) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        if (b.head) {
          b.head.time = K;
        }
        if (b.flags & 512 && b.wrap & 4) {
          $[0] = K & 255;
          $[1] = K >>> 8 & 255;
          $[2] = K >>> 16 & 255;
          $[3] = K >>> 24 & 255;
          b.check = Bd(b.check, $, 4, 0);
        }
        K = 0;
        L = 0;
        b.mode = fa;
      case fa:
        while (L < 16) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        if (b.head) {
          b.head.xflags = K & 255;
          b.head.os = K >> 8;
        }
        if (b.flags & 512 && b.wrap & 4) {
          $[0] = K & 255;
          $[1] = K >>> 8 & 255;
          b.check = Bd(b.check, $, 2, 0);
        }
        K = 0;
        L = 0;
        b.mode = jm;
      case jm:
        if (b.flags & 1024) {
          while (L < 16) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          b.length = K;
          if (b.head) {
            b.head.extra_len = K;
          }
          if (b.flags & 512 && b.wrap & 4) {
            $[0] = K & 255;
            $[1] = K >>> 8 & 255;
            b.check = Bd(b.check, $, 2, 0);
          }
          K = 0;
          L = 0;
        } else if (b.head) {
          b.head.extra = null;
        }
        b.mode = km;
      case km:
        if (b.flags & 1024 && (O = b.length, O > I && (O = I), O && (b.head && (Y = b.head.extra_len - b.length, b.head.extra ||= new Uint8Array(b.head.extra_len), b.head.extra.set(E.subarray(G, G + O), Y)), b.flags & 512 && b.wrap & 4 && (b.check = Bd(b.check, E, O, G)), I -= O, G += O, b.length -= O), b.length)) {
          break _0x40120c;
        }
        b.length = 0;
        b.mode = lm;
      case lm:
        if (b.flags & 2048) {
          if (I === 0) {
            break _0x40120c;
          }
          O = 0;
          do {
            Y = E[G + O++];
            if (b.head && Y && b.length < 65536) {
              b.head.name += String.fromCharCode(Y);
            }
          } while (Y && O < I);
          if (b.flags & 512 && b.wrap & 4) {
            b.check = Bd(b.check, E, O, G);
          }
          I -= O;
          G += O;
          if (Y) {
            break _0x40120c;
          }
        } else if (b.head) {
          b.head.name = null;
        }
        b.length = 0;
        b.mode = mm;
      case mm:
        if (b.flags & 4096) {
          if (I === 0) {
            break _0x40120c;
          }
          O = 0;
          do {
            Y = E[G + O++];
            if (b.head && Y && b.length < 65536) {
              b.head.comment += String.fromCharCode(Y);
            }
          } while (Y && O < I);
          if (b.flags & 512 && b.wrap & 4) {
            b.check = Bd(b.check, E, O, G);
          }
          I -= O;
          G += O;
          if (Y) {
            break _0x40120c;
          }
        } else if (b.head) {
          b.head.comment = null;
        }
        b.mode = nm;
      case nm:
        if (b.flags & 512) {
          while (L < 16) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          if (b.wrap & 4 && K !== (b.check & 65535)) {
            c.msg = "header crc mismatch";
            b.mode = Aa;
            break;
          }
          K = 0;
          L = 0;
        }
        if (b.head) {
          b.head.hcrc = b.flags >> 9 & 1;
          b.head.done = true;
        }
        c.adler = b.check = 0;
        b.mode = qm;
        break;
      case om:
        while (L < 32) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        c.adler = b.check = sf(K);
        K = 0;
        L = 0;
        b.mode = pm;
      case pm:
        if (b.havedict === 0) {
          c.next_out = H;
          c.avail_out = J;
          c.next_in = G;
          c.avail_in = I;
          b.hold = K;
          b.bits = L;
          return hi;
        }
        c.adler = b.check = 1;
        b.mode = qm;
      case qm:
        if (a === tc || a === nc) {
          break _0x40120c;
        }
      case rm:
        if (b.last) {
          K >>>= L & 7;
          L -= L & 7;
          b.mode = Am;
          break;
        }
        while (L < 3) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        b.last = K & 1;
        K >>>= 1;
        L -= 1;
        switch (K & 3) {
          case 0:
            b.mode = Zi;
            break;
          case 1:
            Hm(b);
            b.mode = vm;
            if (a === nc) {
              K >>>= 2;
              L -= 2;
              break _0x40120c;
            }
            break;
          case 2:
            b.mode = tm;
            break;
          case 3:
            c.msg = "invalid block type";
            b.mode = Aa;
        }
        K >>>= 2;
        L -= 2;
        break;
      case Zi:
        K >>>= L & 7;
        L -= L & 7;
        while (L < 32) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        if ((K & 65535) !== (K >>> 16 ^ 65535)) {
          c.msg = "invalid stored block lengths";
          b.mode = Aa;
          break;
        }
        b.length = K & 65535;
        K = 0;
        L = 0;
        b.mode = sm;
        if (a === nc) {
          break _0x40120c;
        }
      case sm:
        b.mode = Ea;
      case Ea:
        O = b.length;
        if (O) {
          if (O > I) {
            O = I;
          }
          if (O > J) {
            O = J;
          }
          if (O === 0) {
            break _0x40120c;
          }
          F.set(E.subarray(G, G + O), H);
          I -= O;
          G += O;
          J -= O;
          H += O;
          b.length -= O;
          break;
        }
        b.mode = qm;
        break;
      case tm:
        while (L < 14) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        b.nlen = (K & 31) + 257;
        K >>>= 5;
        L -= 5;
        b.ndist = (K & 31) + 1;
        K >>>= 5;
        L -= 5;
        b.ncode = (K & 15) + 4;
        K >>>= 4;
        L -= 4;
        if (b.nlen > 286 || b.ndist > 30) {
          c.msg = "too many length or distance symbols";
          b.mode = Aa;
          break;
        }
        b.have = 0;
        b.mode = Sa;
      case Sa:
        while (b.have < b.ncode) {
          while (L < 3) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          b.lens[aa[b.have++]] = K & 7;
          K >>>= 3;
          L -= 3;
        }
        while (b.have < 19) {
          b.lens[aa[b.have++]] = 0;
        }
        b.lencode = b.lendyn;
        b.lenbits = 7;
        A = {
          bits: b.lenbits
        };
        Z = am(bm, b.lens, 0, 19, b.lencode, 0, b.work, A);
        b.lenbits = A.bits;
        if (Z) {
          c.msg = "invalid code lengths set";
          b.mode = Aa;
          break;
        }
        b.have = 0;
        b.mode = um;
      case um:
        while (b.have < b.nlen + b.ndist) {
          R = b.lencode[K & (1 << b.lenbits) - 1];
          S = R >>> 24;
          T = R >>> 16 & 255;
          U = R & 65535;
          while (S > L) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          if (U < 16) {
            K >>>= S;
            L -= S;
            b.lens[b.have++] = U;
          } else {
            if (U === 16) {
              for (_ = S + 2; L < _;) {
                if (I === 0) {
                  break _0x40120c;
                }
                I--;
                K += E[G++] << L;
                L += 8;
              }
              K >>>= S;
              L -= S;
              if (b.have === 0) {
                c.msg = "invalid bit length repeat";
                b.mode = Aa;
                break;
              }
              Y = b.lens[b.have - 1];
              O = 3 + (K & 3);
              K >>>= 2;
              L -= 2;
            } else if (U === 17) {
              for (_ = S + 3; L < _;) {
                if (I === 0) {
                  break _0x40120c;
                }
                I--;
                K += E[G++] << L;
                L += 8;
              }
              K >>>= S;
              L -= S;
              Y = 0;
              O = 3 + (K & 7);
              K >>>= 3;
              L -= 3;
            } else {
              for (_ = S + 7; L < _;) {
                if (I === 0) {
                  break _0x40120c;
                }
                I--;
                K += E[G++] << L;
                L += 8;
              }
              K >>>= S;
              L -= S;
              Y = 0;
              O = 11 + (K & 127);
              K >>>= 7;
              L -= 7;
            }
            if (b.have + O > b.nlen + b.ndist) {
              c.msg = "invalid bit length repeat";
              b.mode = Aa;
              break;
            }
            while (O--) {
              b.lens[b.have++] = Y;
            }
          }
        }
        if (b.mode === Aa) {
          break;
        }
        if (b.lens[256] === 0) {
          c.msg = "invalid code -- missing end-of-block";
          b.mode = Aa;
          break;
        }
        b.lenbits = 9;
        A = {
          bits: b.lenbits
        };
        Z = am(cm, b.lens, 0, b.nlen, b.lencode, 0, b.work, A);
        b.lenbits = A.bits;
        if (Z) {
          c.msg = "invalid literal/lengths set";
          b.mode = Aa;
          break;
        }
        b.distbits = 6;
        b.distcode = b.distdyn;
        A = {
          bits: b.distbits
        };
        Z = am(dm, b.lens, b.nlen, b.ndist, b.distcode, 0, b.work, A);
        b.distbits = A.bits;
        if (Z) {
          c.msg = "invalid distances set";
          b.mode = Aa;
          break;
        }
        b.mode = vm;
        if (a === nc) {
          break _0x40120c;
        }
      case vm:
        b.mode = wm;
      case wm:
        if (I >= 6 && J >= 258) {
          c.next_out = H;
          c.avail_out = J;
          c.next_in = G;
          c.avail_in = I;
          b.hold = K;
          b.bits = L;
          Sl(c, N);
          H = c.next_out;
          F = c.output;
          J = c.avail_out;
          G = c.next_in;
          E = c.input;
          I = c.avail_in;
          K = b.hold;
          L = b.bits;
          if (b.mode === qm) {
            b.back = -1;
          }
          break;
        }
        for (b.back = 0; R = b.lencode[K & (1 << b.lenbits) - 1], S = R >>> 24, T = R >>> 16 & 255, U = R & 65535, S > L;) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        if (T && !(T & 240)) {
          V = S;
          W = T;
          X = U;
          R = b.lencode[X + ((K & (1 << V + W) - 1) >> V)];
          S = R >>> 24;
          T = R >>> 16 & 255;
          U = R & 65535;
          while (V + S > L) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          K >>>= V;
          L -= V;
          b.back += V;
        }
        K >>>= S;
        L -= S;
        b.back += S;
        b.length = U;
        if (T === 0) {
          b.mode = zm;
          break;
        }
        if (T & 32) {
          b.back = -1;
          b.mode = qm;
          break;
        }
        if (T & 64) {
          c.msg = "invalid literal/length code";
          b.mode = Aa;
          break;
        }
        b.extra = T & 15;
        b.mode = xm;
      case xm:
        if (b.extra) {
          for (_ = b.extra; L < _;) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          b.length += K & (1 << b.extra) - 1;
          K >>>= b.extra;
          L -= b.extra;
          b.back += b.extra;
        }
        b.was = b.length;
        b.mode = vi;
      case vi:
        R = b.distcode[K & (1 << b.distbits) - 1];
        S = R >>> 24;
        T = R >>> 16 & 255;
        U = R & 65535;
        while (S > L) {
          if (I === 0) {
            break _0x40120c;
          }
          I--;
          K += E[G++] << L;
          L += 8;
        }
        if (!(T & 240)) {
          V = S;
          W = T;
          X = U;
          R = b.distcode[X + ((K & (1 << V + W) - 1) >> V)];
          S = R >>> 24;
          T = R >>> 16 & 255;
          U = R & 65535;
          while (V + S > L) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          K >>>= V;
          L -= V;
          b.back += V;
        }
        K >>>= S;
        L -= S;
        b.back += S;
        if (T & 64) {
          c.msg = "invalid distance code";
          b.mode = Aa;
          break;
        }
        b.offset = U;
        b.extra = T & 15;
        b.mode = _i;
      case _i:
        if (b.extra) {
          for (_ = b.extra; L < _;) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          b.offset += K & (1 << b.extra) - 1;
          K >>>= b.extra;
          L -= b.extra;
          b.back += b.extra;
        }
        if (b.offset > b.dmax) {
          c.msg = "invalid distance too far back";
          b.mode = Aa;
          break;
        }
        b.mode = ym;
      case ym:
        if (J === 0) {
          break _0x40120c;
        }
        O = N - J;
        if (b.offset > O) {
          O = b.offset - O;
          if (O > b.whave && b.sane) {
            c.msg = "invalid distance too far back";
            b.mode = Aa;
            break;
          }
          if (O > b.wnext) {
            O -= b.wnext;
            P = b.wsize - O;
          } else {
            P = b.wnext - O;
          }
          if (O > b.length) {
            O = b.length;
          }
          Q = b.window;
        } else {
          Q = F;
          P = H - b.offset;
          O = b.length;
        }
        if (O > J) {
          O = J;
        }
        J -= O;
        b.length -= O;
        do {
          F[H++] = Q[P++];
        } while (--O);
        if (b.length === 0) {
          b.mode = wm;
        }
        break;
      case zm:
        if (J === 0) {
          break _0x40120c;
        }
        F[H++] = b.length;
        J--;
        b.mode = wm;
        break;
      case Am:
        if (b.wrap) {
          while (L < 32) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K |= E[G++] << L;
            L += 8;
          }
          N -= J;
          c.total_out += N;
          b.total += N;
          if (b.wrap & 4 && N) {
            c.adler = b.check = b.flags ? Bd(b.check, F, N, H - N) : Ad(b.check, F, N, H - N);
          }
          N = J;
          if (b.wrap & 4 && (b.flags ? K : sf(K)) !== b.check) {
            c.msg = "incorrect data check";
            b.mode = Aa;
            break;
          }
          K = 0;
          L = 0;
        }
        b.mode = Bm;
      case Bm:
        if (b.wrap && b.flags) {
          while (L < 32) {
            if (I === 0) {
              break _0x40120c;
            }
            I--;
            K += E[G++] << L;
            L += 8;
          }
          if (b.wrap & 4 && K !== (b.total & 4294967295)) {
            c.msg = "incorrect length check";
            b.mode = Aa;
            break;
          }
          K = 0;
          L = 0;
        }
        b.mode = Cm;
      case Cm:
        Z = ef;
        break _0x40120c;
      case Aa:
        Z = tf;
        break _0x40120c;
      case Dm:
        return nf;
      case Em:
      default:
        return gm;
    }
  }
  c.next_out = H;
  c.avail_out = J;
  c.next_in = G;
  c.avail_in = I;
  b.hold = K;
  b.bits = L;
  if (b.wsize || N !== c.avail_out && b.mode < Aa && (b.mode < Am || a !== em)) {
    $a(c, c.output, c.next_out, N - c.avail_out);
  }
  M -= c.avail_in;
  N -= c.avail_out;
  c.total_in += M;
  c.total_out += N;
  b.total += N;
  if (b.wrap & 4 && N) {
    c.adler = b.check = b.flags ? Bd(b.check, F, N, c.next_out - N) : Ad(b.check, F, N, c.next_out - N);
  }
  c.data_type = b.bits + (b.last ? 64 : 0) + (b.mode === qm ? 128 : 0) + (b.mode === vm || b.mode === sm ? 256 : 0);
  if ((M === 0 && N === 0 || a === em) && Z === fm) {
    Z = hm;
  }
  return Z;
};
const df = b => {
  if (lf(b)) {
    return gm;
  }
  let a = b.state;
  a.window &&= null;
  b.state = null;
  return fm;
};
const dc = (c, a) => {
  if (lf(c)) {
    return gm;
  }
  const b = c.state;
  if (b.wrap & 2) {
    b.head = a;
    a.done = false;
    return fm;
  } else {
    return gm;
  }
};
const ff = (c, a) => {
  const b = a.length;
  let d;
  let h;
  let i;
  if (lf(c) || (d = c.state, d.wrap !== 0 && d.mode !== pm)) {
    return gm;
  } else if (d.mode === pm && (h = 1, h = Ad(h, a, b, 0), h !== d.check)) {
    return tf;
  } else {
    i = $a(c, a, b, b);
    if (i) {
      d.mode = Dm;
      return nf;
    } else {
      d.havedict = 1;
      return fm;
    }
  }
};
var hf = cf;
var vf = Gm;
var _f = Fm;
var pf = lc;
var gf = oc;
var mf = Ta;
var yf = df;
var wf = dc;
var xf = ff;
var bf = "pako inflate (from Nodeca project)";
var Cf = {
  inflateReset: hf,
  inflateReset2: vf,
  inflateResetKeep: _f,
  inflateInit: pf,
  inflateInit2: gf,
  inflate: mf,
  inflateEnd: yf,
  inflateGetHeader: wf,
  inflateSetDictionary: xf,
  inflateInfo: bf
};
function kf() {
  this.text = 0;
  this.time = 0;
  this.xflags = 0;
  this.os = 0;
  this.extra = null;
  this.extra_len = 0;
  this.name = "";
  this.comment = "";
  this.hcrc = 0;
  this.done = false;
}
var Ef = kf;
const Im = Object.prototype.toString;
const {
  Z_NO_FLUSH: Sf,
  Z_FINISH: Af,
  Z_OK: fc,
  Z_STREAM_END: $f,
  Z_NEED_DICT: Tf,
  Z_STREAM_ERROR: Jm,
  Z_DATA_ERROR: Ba,
  Z_MEM_ERROR: Ia
} = Dd;
function Bf(b) {
  this.options = ol.assign({
    chunkSize: 65536,
    windowBits: 15,
    to: ""
  }, b || {});
  const a = this.options;
  if (a.raw && a.windowBits >= 0 && a.windowBits < 16) {
    a.windowBits = -a.windowBits;
    if (a.windowBits === 0) {
      a.windowBits = -15;
    }
  }
  if (a.windowBits >= 0 && a.windowBits < 16 && (!b || !b.windowBits)) {
    a.windowBits += 32;
  }
  if (a.windowBits > 15 && a.windowBits < 48) {
    if (!(a.windowBits & 15)) {
      a.windowBits |= 15;
    }
  }
  this.err = 0;
  this.msg = "";
  this.ended = false;
  this.chunks = [];
  this.strm = new yl();
  this.strm.avail_out = 0;
  let c = Cf.inflateInit2(this.strm, a.windowBits);
  if (c !== fc) {
    throw new Error(Id[c]);
  }
  this.header = new Ef();
  Cf.inflateGetHeader(this.strm, this.header);
  if (a.dictionary && (typeof a.dictionary == "string" ? a.dictionary = wl.string2buf(a.dictionary) : Im.call(a.dictionary) === "[object ArrayBuffer]" && (a.dictionary = new Uint8Array(a.dictionary)), a.raw && (c = Cf.inflateSetDictionary(this.strm, a.dictionary), c !== fc))) {
    throw new Error(Id[c]);
  }
}
Bf.prototype.push = function (c, a) {
  const j = this.strm;
  const d = this.options.chunkSize;
  const b = this.options.dictionary;
  let e;
  let f;
  let k;
  if (this.ended) {
    return false;
  }
  if (a === ~~a) {
    f = a;
  } else {
    f = a === true ? Af : Sf;
  }
  if (Im.call(c) === "[object ArrayBuffer]") {
    j.input = new Uint8Array(c);
  } else {
    j.input = c;
  }
  j.next_in = 0;
  j.avail_in = j.input.length;
  while (true) {
    if (j.avail_out === 0) {
      j.output = new Uint8Array(d);
      j.next_out = 0;
      j.avail_out = d;
    }
    e = Cf.inflate(j, f);
    if (e === Tf && b) {
      e = Cf.inflateSetDictionary(j, b);
      if (e === fc) {
        e = Cf.inflate(j, f);
      } else if (e === Ba) {
        e = Tf;
      }
    }
    while (j.avail_in > 0 && e === $f && j.state.wrap > 0 && c[j.next_in] !== 0) {
      Cf.inflateReset(j);
      e = Cf.inflate(j, f);
    }
    switch (e) {
      case Jm:
      case Ba:
      case Tf:
      case Ia:
        this.onEnd(e);
        this.ended = true;
        return false;
    }
    k = j.avail_out;
    if (j.next_out && (j.avail_out === 0 || e === $f)) {
      if (this.options.to === "string") {
        let c = wl.utf8border(j.output, j.next_out);
        let a = j.next_out - c;
        let b = wl.buf2string(j.output, c);
        j.next_out = a;
        j.avail_out = d - a;
        if (a) {
          j.output.set(j.output.subarray(c, c + a), 0);
        }
        this.onData(b);
      } else {
        this.onData(j.output.length === j.next_out ? j.output : j.output.subarray(0, j.next_out));
      }
    }
    if (e !== fc || k !== 0) {
      if (e === $f) {
        e = Cf.inflateEnd(this.strm);
        this.onEnd(e);
        this.ended = true;
        return true;
      }
      if (j.avail_in === 0) {
        break;
      }
    }
  }
  return true;
};
Bf.prototype.onData = function (b) {
  this.chunks.push(b);
};
Bf.prototype.onEnd = function (b) {
  if (b === fc) {
    if (this.options.to === "string") {
      this.result = this.chunks.join("");
    } else {
      this.result = ol.flattenChunks(this.chunks);
    }
  }
  this.chunks = [];
  this.err = b;
  this.msg = this.strm.msg;
};
function Km(c, a) {
  const b = new Bf(a);
  b.push(c);
  if (b.err) {
    throw b.msg || Id[b.err];
  }
  return b.result;
}
function If(c, a) {
  a = a || {};
  a.raw = true;
  return Km(c, a);
}
var si = Bf;
var Lm = Km;
var Df = If;
var Lf = Km;
var Of = Dd;
var zf = {
  Inflate: si,
  inflate: Lm,
  inflateRaw: Df,
  ungzip: Lf,
  constants: Of
};
const {
  Deflate: Ff,
  deflate: Rf,
  deflateRaw: Nf,
  gzip: Mm
} = Pl;
const {
  Inflate: Pf,
  inflate: Nm,
  inflateRaw: Om,
  ungzip: Pm
} = zf;
var Mf = Rf;
var Qm = Nm;
var Rm = {
  exports: {}
};
(function (e) {
  (function (a, b, c) {
    e.exports = c(a);
    e.exports.default = e.exports;
  })(Hb, "UUID", function () {
    function a(i, a, b, c, d, e) {
      function j(c, a) {
        var b = c.toString(16);
        if (b.length < 2) {
          b = "0" + b;
        }
        if (a) {
          b = b.toUpperCase();
        }
        return b;
      }
      for (var g = a; g <= b; g++) {
        d[e++] = j(i[g], c);
      }
      return d;
    }
    function c(g, a, b, c, d) {
      for (var h = a; h <= b; h += 2) {
        c[d++] = parseInt(g.substr(h, 2), 16);
      }
    }
    var b = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&<>()[]{}@%$#".split("");
    var d = [0, 68, 0, 84, 83, 82, 72, 0, 75, 76, 70, 65, 0, 63, 62, 69, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 64, 0, 73, 66, 74, 71, 81, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 77, 0, 78, 67, 0, 0, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 79, 0, 80, 0, 0];
    function e(a, d) {
      if (d % 4 !== 0) {
        throw new Error("z85_encode: invalid input length (multiple of 4 expected)");
      }
      var c = "";
      for (var e = 0, k = 0; e < d;) {
        k = k * 256 + a[e++];
        if (e % 4 === 0) {
          for (var l = 52200625; l >= 1;) {
            var m = Math.floor(k / l) % 85;
            c += b[m];
            l /= 85;
          }
          k = 0;
        }
      }
      return c;
    }
    function f(a, b) {
      var f = a.length;
      if (f % 5 !== 0) {
        throw new Error("z85_decode: invalid input length (multiple of 5 expected)");
      }
      if (typeof b === "undefined") {
        b = new Array(f * 4 / 5);
      }
      for (var e = 0, l = 0, m = 0; e < f;) {
        var n = a.charCodeAt(e++) - 32;
        if (n < 0 || n >= d.length) {
          break;
        }
        m = m * 85 + d[n];
        if (e % 5 === 0) {
          for (var o = 16777216; o >= 1;) {
            b[l++] = Math.trunc(m / o % 256);
            o /= 256;
          }
          m = 0;
        }
      }
      return b;
    }
    function g(a, b) {
      var c = {
        ibits: 8,
        obits: 8,
        obigendian: true
      };
      for (var d in b) {
        if (typeof c[d] !== "undefined") {
          c[d] = b[d];
        }
      }
      for (var e = [], g = 0, o, p, q = 0, r, s = 0, t = a.length; q === 0 && (p = a.charCodeAt(g++)), o = p >> c.ibits - (q + 8) & 255, q = (q + 8) % c.ibits, c.obigendian ? s === 0 ? r = o << c.obits - 8 : r |= o << c.obits - 8 - s : s === 0 ? r = o : r |= o << s, s = (s + 8) % c.obits, s !== 0 || !(e.push(r), g >= t););
      return e;
    }
    function h(a, b) {
      var c = {
        ibits: 32,
        ibigendian: true
      };
      for (var d in b) {
        if (typeof c[d] !== "undefined") {
          c[d] = b[d];
        }
      }
      var e = "";
      var m = 4294967295;
      if (c.ibits < 32) {
        m = (1 << c.ibits) - 1;
      }
      for (var n = a.length, i = 0; i < n; i++) {
        var o = a[i] & m;
        for (var p = 0; p < c.ibits; p += 8) {
          if (c.ibigendian) {
            e += String.fromCharCode(o >> c.ibits - 8 - p & 255);
          } else {
            e += String.fromCharCode(o >> p & 255);
          }
        }
      }
      return e;
    }
    var i = 8;
    var j = 8;
    var k = 256;
    function l(i, a, b, c, d, e, f, g) {
      return [g, f, e, d, c, b, a, i];
    }
    function m() {
      return l(0, 0, 0, 0, 0, 0, 0, 0);
    }
    function n(a) {
      return a.slice(0);
    }
    function o(a) {
      var c = m();
      for (var d = 0; d < i; d++) {
        c[d] = Math.floor(a % k);
        a /= k;
      }
      return c;
    }
    function p(d) {
      var a = 0;
      for (var e = i - 1; e >= 0; e--) {
        a *= k;
        a += d[e];
      }
      return Math.floor(a);
    }
    function q(a, b) {
      var c = 0;
      for (var d = 0; d < i; d++) {
        c += a[d] + b[d];
        a[d] = Math.floor(c % k);
        c = Math.floor(c / k);
      }
      return c;
    }
    function r(e, a) {
      var b = 0;
      for (var f = 0; f < i; f++) {
        b += e[f] * a;
        e[f] = Math.floor(b % k);
        b = Math.floor(b / k);
      }
      return b;
    }
    function s(a, b) {
      var c;
      var d;
      var j = new Array(i + i);
      for (c = 0; c < i + i; c++) {
        j[c] = 0;
      }
      var g;
      for (c = 0; c < i; c++) {
        g = 0;
        d = 0;
        for (; d < i; d++) {
          g += a[c] * b[d] + j[c + d];
          j[c + d] = g % k;
          g /= k;
        }
        for (; d < i + i - c; d++) {
          g += j[c + d];
          j[c + d] = g % k;
          g /= k;
        }
      }
      for (c = 0; c < i; c++) {
        a[c] = j[c];
      }
      return j.slice(i, i);
    }
    function t(d, a) {
      for (var b = 0; b < i; b++) {
        d[b] &= a[b];
      }
      return d;
    }
    function u(d, a) {
      for (var b = 0; b < i; b++) {
        d[b] |= a[b];
      }
      return d;
    }
    function v(a, b) {
      var c = m();
      if (b % j !== 0) {
        throw new Error("ui64_rorn: only bit rotations supported with a multiple of digit bits");
      }
      for (var d = Math.floor(b / j), e = 0; e < d; e++) {
        for (var f = i - 1 - 1; f >= 0; f--) {
          c[f + 1] = c[f];
        }
        c[0] = a[0];
        f = 0;
        for (; f < i - 1; f++) {
          a[f] = a[f + 1];
        }
        a[f] = 0;
      }
      return p(c);
    }
    function w(a, b) {
      if (b > i * j) {
        throw new Error("ui64_ror: invalid number of bits to shift");
      }
      var c = new Array(i + i);
      var d;
      for (d = 0; d < i; d++) {
        c[d + i] = a[d];
        c[d] = 0;
      }
      var e = Math.floor(b / j);
      var g = b % j;
      for (d = e; d < i + i - 1; d++) {
        c[d - e] = (c[d] >>> g | c[d + 1] << j - g) & (1 << j) - 1;
      }
      c[i + i - 1 - e] = c[i + i - 1] >>> g & (1 << j) - 1;
      d = i + i - 1 - e + 1;
      for (; d < i + i; d++) {
        c[d] = 0;
      }
      for (d = 0; d < i; d++) {
        a[d] = c[d + i];
      }
      return c.slice(0, i);
    }
    function x(a, b) {
      if (b > i * j) {
        throw new Error("ui64_rol: invalid number of bits to shift");
      }
      var c = new Array(i + i);
      var d;
      for (d = 0; d < i; d++) {
        c[d + i] = 0;
        c[d] = a[d];
      }
      var e = Math.floor(b / j);
      var g = b % j;
      for (d = i - 1 - e; d > 0; d--) {
        c[d + e] = (c[d] << g | c[d - 1] >>> j - g) & (1 << j) - 1;
      }
      c[0 + e] = c[0] << g & (1 << j) - 1;
      d = 0 + e - 1;
      for (; d >= 0; d--) {
        c[d] = 0;
      }
      for (d = 0; d < i; d++) {
        a[d] = c[d];
      }
      return c.slice(i, i);
    }
    function y(d, a) {
      for (var b = 0; b < i; b++) {
        d[b] ^= a[b];
      }
    }
    function z(e, a) {
      var b = (e & 65535) + (a & 65535);
      var c = (e >> 16) + (a >> 16) + (b >> 16);
      return c << 16 | b & 65535;
    }
    function A(c, a) {
      return c << a & 4294967295 | c >>> 32 - a & 4294967295;
    }
    function B(a, b) {
      function c(e, a, b, c) {
        if (e < 20) {
          return a & b | ~a & c;
        } else if (e < 40) {
          return a ^ b ^ c;
        } else if (e < 60) {
          return a & b | a & c | b & c;
        } else {
          return a ^ b ^ c;
        }
      }
      function d(b) {
        if (b < 20) {
          return 1518500249;
        } else if (b < 40) {
          return 1859775393;
        } else if (b < 60) {
          return -1894007588;
        } else {
          return -899497514;
        }
      }
      a[b >> 5] |= 128 << 24 - b % 32;
      a[(b + 64 >> 9 << 4) + 15] = b;
      var e = Array(80);
      var f = 1732584193;
      var g = -271733879;
      var u = -1732584194;
      var v = 271733878;
      var w = -1009589776;
      for (var x = 0; x < a.length; x += 16) {
        var y = f;
        var B = g;
        var C = u;
        var D = v;
        var E = w;
        for (var F = 0; F < 80; F++) {
          if (F < 16) {
            e[F] = a[x + F];
          } else {
            e[F] = A(e[F - 3] ^ e[F - 8] ^ e[F - 14] ^ e[F - 16], 1);
          }
          var G = z(z(A(f, 5), c(F, g, u, v)), z(z(w, e[F]), d(F)));
          w = v;
          v = u;
          u = A(g, 30);
          g = f;
          f = G;
        }
        f = z(f, y);
        g = z(g, B);
        u = z(u, C);
        v = z(v, D);
        w = z(w, E);
      }
      return [f, g, u, v, w];
    }
    function C(a) {
      return h(B(g(a, {
        ibits: 8,
        obits: 32,
        obigendian: true
      }), a.length * 8), {
        ibits: 32,
        ibigendian: true
      });
    }
    function D(q, a) {
      function r(g, a, b, c, d, e) {
        return z(A(z(z(a, g), z(c, e)), d), b);
      }
      function b(c, a, b, d, e, f, g) {
        return r(a & b | ~a & d, c, a, e, f, g);
      }
      function c(c, a, b, d, e, f, g) {
        return r(a & d | b & ~d, c, a, e, f, g);
      }
      function d(c, a, b, d, e, f, g) {
        return r(a ^ b ^ d, c, a, e, f, g);
      }
      function e(c, a, b, d, e, f, g) {
        return r(b ^ (a | ~d), c, a, e, f, g);
      }
      q[a >> 5] |= 128 << a % 32;
      q[(a + 64 >>> 9 << 4) + 14] = a;
      var f = 1732584193;
      var g = -271733879;
      var s = -1732584194;
      var t = 271733878;
      for (var u = 0; u < q.length; u += 16) {
        var v = f;
        var w = g;
        var x = s;
        var y = t;
        f = b(f, g, s, t, q[u + 0], 7, -680876936);
        t = b(t, f, g, s, q[u + 1], 12, -389564586);
        s = b(s, t, f, g, q[u + 2], 17, 606105819);
        g = b(g, s, t, f, q[u + 3], 22, -1044525330);
        f = b(f, g, s, t, q[u + 4], 7, -176418897);
        t = b(t, f, g, s, q[u + 5], 12, 1200080426);
        s = b(s, t, f, g, q[u + 6], 17, -1473231341);
        g = b(g, s, t, f, q[u + 7], 22, -45705983);
        f = b(f, g, s, t, q[u + 8], 7, 1770035416);
        t = b(t, f, g, s, q[u + 9], 12, -1958414417);
        s = b(s, t, f, g, q[u + 10], 17, -42063);
        g = b(g, s, t, f, q[u + 11], 22, -1990404162);
        f = b(f, g, s, t, q[u + 12], 7, 1804603682);
        t = b(t, f, g, s, q[u + 13], 12, -40341101);
        s = b(s, t, f, g, q[u + 14], 17, -1502002290);
        g = b(g, s, t, f, q[u + 15], 22, 1236535329);
        f = c(f, g, s, t, q[u + 1], 5, -165796510);
        t = c(t, f, g, s, q[u + 6], 9, -1069501632);
        s = c(s, t, f, g, q[u + 11], 14, 643717713);
        g = c(g, s, t, f, q[u + 0], 20, -373897302);
        f = c(f, g, s, t, q[u + 5], 5, -701558691);
        t = c(t, f, g, s, q[u + 10], 9, 38016083);
        s = c(s, t, f, g, q[u + 15], 14, -660478335);
        g = c(g, s, t, f, q[u + 4], 20, -405537848);
        f = c(f, g, s, t, q[u + 9], 5, 568446438);
        t = c(t, f, g, s, q[u + 14], 9, -1019803690);
        s = c(s, t, f, g, q[u + 3], 14, -187363961);
        g = c(g, s, t, f, q[u + 8], 20, 1163531501);
        f = c(f, g, s, t, q[u + 13], 5, -1444681467);
        t = c(t, f, g, s, q[u + 2], 9, -51403784);
        s = c(s, t, f, g, q[u + 7], 14, 1735328473);
        g = c(g, s, t, f, q[u + 12], 20, -1926607734);
        f = d(f, g, s, t, q[u + 5], 4, -378558);
        t = d(t, f, g, s, q[u + 8], 11, -2022574463);
        s = d(s, t, f, g, q[u + 11], 16, 1839030562);
        g = d(g, s, t, f, q[u + 14], 23, -35309556);
        f = d(f, g, s, t, q[u + 1], 4, -1530992060);
        t = d(t, f, g, s, q[u + 4], 11, 1272893353);
        s = d(s, t, f, g, q[u + 7], 16, -155497632);
        g = d(g, s, t, f, q[u + 10], 23, -1094730640);
        f = d(f, g, s, t, q[u + 13], 4, 681279174);
        t = d(t, f, g, s, q[u + 0], 11, -358537222);
        s = d(s, t, f, g, q[u + 3], 16, -722521979);
        g = d(g, s, t, f, q[u + 6], 23, 76029189);
        f = d(f, g, s, t, q[u + 9], 4, -640364487);
        t = d(t, f, g, s, q[u + 12], 11, -421815835);
        s = d(s, t, f, g, q[u + 15], 16, 530742520);
        g = d(g, s, t, f, q[u + 2], 23, -995338651);
        f = e(f, g, s, t, q[u + 0], 6, -198630844);
        t = e(t, f, g, s, q[u + 7], 10, 1126891415);
        s = e(s, t, f, g, q[u + 14], 15, -1416354905);
        g = e(g, s, t, f, q[u + 5], 21, -57434055);
        f = e(f, g, s, t, q[u + 12], 6, 1700485571);
        t = e(t, f, g, s, q[u + 3], 10, -1894986606);
        s = e(s, t, f, g, q[u + 10], 15, -1051523);
        g = e(g, s, t, f, q[u + 1], 21, -2054922799);
        f = e(f, g, s, t, q[u + 8], 6, 1873313359);
        t = e(t, f, g, s, q[u + 15], 10, -30611744);
        s = e(s, t, f, g, q[u + 6], 15, -1560198380);
        g = e(g, s, t, f, q[u + 13], 21, 1309151649);
        f = e(f, g, s, t, q[u + 4], 6, -145523070);
        t = e(t, f, g, s, q[u + 11], 10, -1120210379);
        s = e(s, t, f, g, q[u + 2], 15, 718787259);
        g = e(g, s, t, f, q[u + 9], 21, -343485551);
        f = z(f, v);
        g = z(g, w);
        s = z(s, x);
        t = z(t, y);
      }
      return [f, g, s, t];
    }
    function E(a) {
      return h(D(g(a, {
        ibits: 8,
        obits: 32,
        obigendian: false
      }), a.length * 8), {
        ibits: 32,
        ibigendian: false
      });
    }
    function F(a) {
      this.mul = l(88, 81, 244, 45, 76, 149, 127, 45);
      this.inc = l(20, 5, 123, 126, 247, 103, 129, 79);
      this.mask = l(0, 0, 0, 0, 255, 255, 255, 255);
      this.state = n(this.inc);
      this.next();
      t(this.state, this.mask);
      var c;
      if (a !== undefined) {
        a = o(a >>> 0);
      } else if (typeof window == "object" && typeof window.crypto == "object" && typeof window.crypto.getRandomValues == "function") {
        c = new Uint32Array(2);
        window.crypto.getRandomValues(c);
        a = u(o(c[0] >>> 0), w(o(c[1] >>> 0), 32));
      } else if (typeof globalThis == "object" && typeof globalThis.crypto == "object" && typeof globalThis.crypto.getRandomValues == "function") {
        c = new Uint32Array(2);
        globalThis.crypto.getRandomValues(c);
        a = u(o(c[0] >>> 0), w(o(c[1] >>> 0), 32));
      } else {
        a = o(Math.random() * 4294967295 >>> 0);
        u(a, w(o(new Date().getTime()), 32));
      }
      u(this.state, a);
      this.next();
    }
    F.prototype.next = function () {
      var a = n(this.state);
      s(this.state, this.mul);
      q(this.state, this.inc);
      var b = n(a);
      w(b, 18);
      y(b, a);
      w(b, 27);
      var c = n(a);
      w(c, 59);
      t(b, this.mask);
      var d = p(c);
      var e = n(b);
      x(e, 32 - d);
      w(b, d);
      y(b, e);
      return p(b);
    };
    F.prototype.reseed = function (a) {
      if (typeof a != "string") {
        throw new Error("UUID: PCG: seed: invalid argument (string expected)");
      }
      for (var b = B(g(a, {
          ibits: 8,
          obits: 32,
          obigendian: true
        }), a.length * 8), c = 0; c < b.length; c++) {
        y(G.state, o(b[c] >>> 0));
      }
    };
    var G = new F();
    F.reseed = function (b) {
      G.reseed(b);
    };
    function H(a, b) {
      var c = [];
      for (var d = 0; d < a; d++) {
        c[d] = G.next() % b;
      }
      return c;
    }
    var I = 0;
    var J = 0;
    function N() {
      if (arguments.length === 1 && typeof arguments[0] == "string") {
        this.parse.apply(this, arguments);
      } else if (arguments.length >= 1 && typeof arguments[0] == "number") {
        this.make.apply(this, arguments);
      } else {
        if (arguments.length >= 1) {
          throw new Error("UUID: constructor: invalid arguments");
        }
        for (var a = 0; a < 16; a++) {
          this[a] = 0;
        }
      }
    }
    if (typeof Uint8Array !== "undefined") {
      N.prototype = new Uint8Array(16);
    } else if (Jb.Buffer) {
      N.prototype = Jb.Buffer.alloc(16);
    } else {
      N.prototype = new Array(16);
    }
    N.prototype.constructor = N;
    N.prototype.make = function (a) {
      var b;
      var c = this;
      if (a === 1) {
        var e = new Date();
        var f = e.getTime();
        if (f !== I) {
          J = 0;
        } else {
          J++;
        }
        I = f;
        var g = o(f);
        r(g, 10000);
        q(g, l(1, 178, 29, 210, 19, 129, 64, 0));
        if (J > 0) {
          q(g, o(J));
        }
        var h;
        h = v(g, 8);
        c[3] = h & 255;
        h = v(g, 8);
        c[2] = h & 255;
        h = v(g, 8);
        c[1] = h & 255;
        h = v(g, 8);
        c[0] = h & 255;
        h = v(g, 8);
        c[5] = h & 255;
        h = v(g, 8);
        c[4] = h & 255;
        h = v(g, 8);
        c[7] = h & 255;
        h = v(g, 8);
        c[6] = h & 15;
        var n = H(2, 255);
        c[8] = n[0];
        c[9] = n[1];
        var j = H(6, 255);
        j[0] |= 1;
        j[0] |= 2;
        b = 0;
        for (; b < 6; b++) {
          c[10 + b] = j[b];
        }
      } else if (a === 4) {
        var k = H(16, 255);
        for (b = 0; b < 16; b++) {
          this[b] = k[b];
        }
      } else if (a === 3 || a === 5) {
        var s = "";
        var t = typeof arguments[1] == "object" && arguments[1] instanceof N ? arguments[1] : new N().parse(arguments[1]);
        for (b = 0; b < 16; b++) {
          s += String.fromCharCode(t[b]);
        }
        s += arguments[2];
        var u = a === 3 ? E(s) : C(s);
        for (b = 0; b < 16; b++) {
          c[b] = u.charCodeAt(b);
        }
      } else {
        throw new Error("UUID: make: invalid version");
      }
      c[6] &= 15;
      c[6] |= a << 4;
      c[8] &= 63;
      c[8] |= 128;
      return c;
    };
    N.prototype.format = function (c) {
      var b;
      var d;
      if (c === "z85") {
        b = e(this, 16);
      } else if (c === "b16") {
        d = Array(32);
        a(this, 0, 15, true, d, 0);
        b = d.join("");
      } else if (c === undefined || c === "std") {
        d = new Array(36);
        a(this, 0, 3, false, d, 0);
        d[8] = "-";
        a(this, 4, 5, false, d, 9);
        d[13] = "-";
        a(this, 6, 7, false, d, 14);
        d[18] = "-";
        a(this, 8, 9, false, d, 19);
        d[23] = "-";
        a(this, 10, 15, false, d, 24);
        b = d.join("");
      }
      return b;
    };
    N.prototype.toString = function (b) {
      return this.format(b);
    };
    N.prototype.toJSON = function () {
      return this.format("std");
    };
    N.prototype.parse = function (a, d) {
      if (typeof a != "string") {
        throw new Error("UUID: parse: invalid argument (type string expected)");
      }
      if (d === "z85") {
        f(a, this);
      } else if (d === "b16") {
        c(a, 0, 35, this, 0);
      } else if (d === undefined || d === "std") {
        var e = {
          nil: "00000000-0000-0000-0000-000000000000",
          "ns:DNS": "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
          "ns:URL": "6ba7b811-9dad-11d1-80b4-00c04fd430c8",
          "ns:OID": "6ba7b812-9dad-11d1-80b4-00c04fd430c8",
          "ns:X500": "6ba7b814-9dad-11d1-80b4-00c04fd430c8"
        };
        if (e[a] !== undefined) {
          a = e[a];
        } else if (!a.match(/^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/)) {
          throw new Error("UUID: parse: invalid string representation (expected \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx\")");
        }
        c(a, 0, 7, this, 0);
        c(a, 9, 12, this, 4);
        c(a, 14, 17, this, 6);
        c(a, 19, 22, this, 8);
        c(a, 24, 35, this, 10);
      }
      return this;
    };
    N.prototype.export = function () {
      var c = Array(16);
      for (var a = 0; a < 16; a++) {
        c[a] = this[a];
      }
      return c;
    };
    N.prototype.import = function (a) {
      if (typeof a != "object" || !(a instanceof Array)) {
        throw new Error("UUID: import: invalid argument (type Array expected)");
      }
      if (a.length !== 16) {
        throw new Error("UUID: import: invalid argument (Array of length 16 expected)");
      }
      for (var b = 0; b < 16; b++) {
        if (typeof a[b] != "number") {
          throw new Error("UUID: import: invalid array element #" + b + " (type Number expected)");
        }
        if (!isFinite(a[b]) || Math.floor(a[b]) !== a[b]) {
          throw new Error("UUID: import: invalid array element #" + b + " (Number with integer value expected)");
        }
        if (a[b] < 0 || a[b] > 255) {
          throw new Error("UUID: import: invalid array element #" + b + " (Number with integer value in range 0...255 expected)");
        }
        this[b] = a[b];
      }
      return this;
    };
    N.prototype.compare = function (a) {
      if (typeof a != "object") {
        throw new Error("UUID: compare: invalid argument (type UUID expected)");
      }
      if (!(a instanceof N)) {
        throw new Error("UUID: compare: invalid argument (type UUID expected)");
      }
      for (var b = 0; b < 16; b++) {
        if (this[b] < a[b]) {
          return -1;
        }
        if (this[b] > a[b]) {
          return 1;
        }
      }
      return 0;
    };
    N.prototype.equal = function (b) {
      return this.compare(b) === 0;
    };
    N.prototype.fold = function (a) {
      if (typeof a === "undefined") {
        throw new Error("UUID: fold: invalid argument (number of fold operations expected)");
      }
      if (a < 1 || a > 4) {
        throw new Error("UUID: fold: invalid argument (1-4 fold operations expected)");
      }
      for (var b = 16 / Math.pow(2, a), c = new Array(b), d = 0; d < b; d++) {
        var e = 0;
        for (var i = 0; d + i < 16; i += b) {
          e ^= this[d + i];
        }
        c[d] = e;
      }
      return c;
    };
    N.PCG = F;
    return N;
  });
})(Rm);
var Uf = Rm.exports;
const Hf = Ib(Uf);
var hc = Object.create;
var jf = Object.defineProperty;
var Zf = Object.getOwnPropertyDescriptor;
var Wf = Object.getOwnPropertyNames;
var Sm = Object.getPrototypeOf;
var Vf = Object.prototype.hasOwnProperty;
var vc = (c, a) => function () {
  if (!a) {
    (0, c[Wf(c)[0]])((a = {
      exports: {}
    }).exports, a);
  }
  return a.exports;
};
var qf = (d, a) => {
  for (var b in a) {
    jf(d, b, {
      get: a[b],
      enumerable: true
    });
  }
};
var Kf = (e, a, b, c) => {
  if (a && typeof a == "object" || typeof a == "function") {
    for (let d of Wf(a)) {
      if (!Vf.call(e, d) && d !== b) {
        jf(e, d, {
          get: () => a[d],
          enumerable: !(c = Zf(a, d)) || c.enumerable
        });
      }
    }
  }
  return e;
};
var Ce = (d, a, b) => {
  b = d != null ? hc(Sm(d)) : {};
  return Kf(a || !d || !d.__esModule ? jf(b, "default", {
    value: d,
    enumerable: true
  }) : b, d);
};
var Tm = (d, a, b) => {
  if (!a.has(d)) {
    throw TypeError("Cannot " + b);
  }
};
var Gf = (d, a, b) => {
  Tm(d, a, "read from private field");
  if (b) {
    return b.call(d);
  } else {
    return a.get(d);
  }
};
var Xf = (d, a, b) => {
  if (a.has(d)) {
    throw TypeError("Cannot add the same private member more than once");
  }
  if (a instanceof WeakSet) {
    a.add(d);
  } else {
    a.set(d, b);
  }
};
var Um = (e, a, b, c) => {
  Tm(e, a, "write to private field");
  if (c) {
    c.call(e, b);
  } else {
    a.set(e, b);
  }
  return b;
};
var J = (e, a, b, c) => ({
  set _(c) {
    Um(e, a, c, b);
  },
  get _() {
    return Gf(e, a, c);
  }
});
var de = (d, a, b) => {
  Tm(d, a, "access private method");
  return b;
};
var ke = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/core.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b();
      } else if (typeof define == "function" && define.amd) {
        define([], b);
      } else {
        a.CryptoJS = b();
      }
    })(e, function () {
      var b = b || function (p, c) {
        var b = Object.create || function () {
          function c() {}
          return function (a) {
            var b;
            c.prototype = a;
            b = new c();
            c.prototype = null;
            return b;
          };
        }();
        var a = {};
        var d = a.lib = {};
        var e = d.Base = function () {
          return {
            extend: function (d) {
              var a = b(this);
              if (d) {
                a.mixIn(d);
              }
              if (!a.hasOwnProperty("init") || this.init === a.init) {
                a.init = function () {
                  a.$super.init.apply(this, arguments);
                };
              }
              a.init.prototype = a;
              a.$super = this;
              return a;
            },
            create: function () {
              var a = this.extend();
              a.init.apply(a, arguments);
              return a;
            },
            init: function () {},
            mixIn: function (b) {
              for (var a in b) {
                if (b.hasOwnProperty(a)) {
                  this[a] = b[a];
                }
              }
              if (b.hasOwnProperty("toString")) {
                this.toString = b.toString;
              }
            },
            clone: function () {
              return this.init.prototype.extend(this);
            }
          };
        }();
        var q = d.WordArray = e.extend({
          init: function (b, e) {
            b = this.words = b || [];
            if (e != c) {
              this.sigBytes = e;
            } else {
              this.sigBytes = b.length * 4;
            }
          },
          toString: function (b) {
            return (b || g).stringify(this);
          },
          concat: function (b) {
            var a = this.words;
            var c = b.words;
            var d = this.sigBytes;
            var e = b.sigBytes;
            this.clamp();
            if (d % 4) {
              for (var f = 0; f < e; f++) {
                var g = c[f >>> 2] >>> 24 - f % 4 * 8 & 255;
                a[d + f >>> 2] |= g << 24 - (d + f) % 4 * 8;
              }
            } else {
              for (var f = 0; f < e; f += 4) {
                a[d + f >>> 2] = c[f >>> 2];
              }
            }
            this.sigBytes += e;
            return this;
          },
          clamp: function () {
            var a = this.words;
            var b = this.sigBytes;
            a[b >>> 2] &= 4294967295 << 32 - b % 4 * 8;
            a.length = p.ceil(b / 4);
          },
          clone: function () {
            var a = e.clone.call(this);
            a.words = this.words.slice(0);
            return a;
          },
          random: function (a) {
            var b = [];
            function c(a) {
              var a = a;
              var e = 987654321;
              var g = 4294967295;
              return function () {
                e = (e & 65535) * 36969 + (e >> 16) & g;
                a = (a & 65535) * 18000 + (a >> 16) & g;
                var b = (e << 16) + a & g;
                b /= 4294967296;
                b += 0.5;
                return b * (p.random() > 0.5 ? 1 : -1);
              };
            }
            for (var d = 0, e; d < a; d += 4) {
              var f = c((e || p.random()) * 4294967296);
              e = f() * 987654071;
              b.push(f() * 4294967296 | 0);
            }
            return new q.init(b, a);
          }
        });
        var f = a.enc = {};
        var g = f.Hex = {
          stringify: function (b) {
            var a = b.words;
            for (var c = b.sigBytes, d = [], e = 0; e < c; e++) {
              var f = a[e >>> 2] >>> 24 - e % 4 * 8 & 255;
              d.push((f >>> 4).toString(16));
              d.push((f & 15).toString(16));
            }
            return d.join("");
          },
          parse: function (b) {
            for (var a = b.length, c = [], d = 0; d < a; d += 2) {
              c[d >>> 3] |= parseInt(b.substr(d, 2), 16) << 24 - d % 8 * 4;
            }
            return new q.init(c, a / 2);
          }
        };
        var h = f.Latin1 = {
          stringify: function (b) {
            var a = b.words;
            for (var c = b.sigBytes, d = [], e = 0; e < c; e++) {
              var f = a[e >>> 2] >>> 24 - e % 4 * 8 & 255;
              d.push(String.fromCharCode(f));
            }
            return d.join("");
          },
          parse: function (b) {
            for (var a = b.length, c = [], d = 0; d < a; d++) {
              c[d >>> 2] |= (b.charCodeAt(d) & 255) << 24 - d % 4 * 8;
            }
            return new q.init(c, a);
          }
        };
        var i = f.Utf8 = {
          stringify: function (b) {
            try {
              return decodeURIComponent(escape(h.stringify(b)));
            } catch {
              throw new Error("Malformed UTF-8 data");
            }
          },
          parse: function (b) {
            return h.parse(unescape(encodeURIComponent(b)));
          }
        };
        var j = d.BufferedBlockAlgorithm = e.extend({
          reset: function () {
            this._data = new q.init();
            this._nDataBytes = 0;
          },
          _append: function (b) {
            if (typeof b == "string") {
              b = i.parse(b);
            }
            this._data.concat(b);
            this._nDataBytes += b.sigBytes;
          },
          _process: function (a) {
            var b = this._data;
            var c = b.words;
            var d = b.sigBytes;
            var e = this.blockSize;
            var f = e * 4;
            var g = d / f;
            if (a) {
              g = p.ceil(g);
            } else {
              g = p.max((g | 0) - this._minBufferSize, 0);
            }
            var h = g * e;
            var i = p.min(h * 4, d);
            if (h) {
              for (var j = 0; j < h; j += e) {
                this._doProcessBlock(c, j);
              }
              var l = c.splice(0, h);
              b.sigBytes -= i;
            }
            return new q.init(l, i);
          },
          clone: function () {
            var a = e.clone.call(this);
            a._data = this._data.clone();
            return a;
          },
          _minBufferSize: 0
        });
        d.Hasher = j.extend({
          cfg: e.extend(),
          init: function (b) {
            this.cfg = this.cfg.extend(b);
            this.reset();
          },
          reset: function () {
            j.reset.call(this);
            this._doReset();
          },
          update: function (b) {
            this._append(b);
            this._process();
            return this;
          },
          finalize: function (b) {
            if (b) {
              this._append(b);
            }
            var a = this._doFinalize();
            return a;
          },
          blockSize: 16,
          _createHelper: function (d) {
            return function (a, b) {
              return new d.init(b).finalize(a);
            };
          },
          _createHmacHelper: function (d) {
            return function (a, b) {
              return new k.HMAC.init(d, b).finalize(a);
            };
          }
        });
        var k = a.algo = {};
        return a;
      }(Math);
      return b;
    });
  }
});
var Vm = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/x64-core.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (c) {
      (function (i) {
        var a = c;
        var b = a.lib;
        var j = b.Base;
        var k = b.WordArray;
        var d = a.x64 = {};
        d.Word = j.extend({
          init: function (c, a) {
            this.high = c;
            this.low = a;
          }
        });
        d.WordArray = j.extend({
          init: function (b, c) {
            b = this.words = b || [];
            if (c != i) {
              this.sigBytes = c;
            } else {
              this.sigBytes = b.length * 8;
            }
          },
          toX32: function () {
            var a = this.words;
            for (var b = a.length, c = [], d = 0; d < b; d++) {
              var e = a[d];
              c.push(e.high);
              c.push(e.low);
            }
            return k.create(c, this.sigBytes);
          },
          clone: function () {
            var a = j.clone.call(this);
            var b = a.words = this.words.slice(0);
            for (var c = b.length, d = 0; d < c; d++) {
              b[d] = b[d].clone();
            }
            return a;
          }
        });
      })();
      return c;
    });
  }
});
var ve = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/lib-typedarrays.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (b) {
      (function () {
        if (typeof ArrayBuffer == "function") {
          var a = b;
          var c = a.lib;
          var d = c.WordArray;
          var h = d.init;
          var e = d.init = function (b) {
            if (b instanceof ArrayBuffer) {
              b = new Uint8Array(b);
            }
            if (b instanceof Int8Array || typeof Uint8ClampedArray !== "undefined" && b instanceof Uint8ClampedArray || b instanceof Int16Array || b instanceof Uint16Array || b instanceof Int32Array || b instanceof Uint32Array || b instanceof Float32Array || b instanceof Float64Array) {
              b = new Uint8Array(b.buffer, b.byteOffset, b.byteLength);
            }
            if (b instanceof Uint8Array) {
              for (var c = b.byteLength, d = [], e = 0; e < c; e++) {
                d[e >>> 2] |= b[e] << 24 - e % 4 * 8;
              }
              h.call(this, d, c);
            } else {
              h.apply(this, arguments);
            }
          };
          e.prototype = d;
        }
      })();
      return b.lib.WordArray;
    });
  }
});
var Ee = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/enc-utf16.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var i = c.WordArray;
        var d = a.enc;
        d.Utf16 = d.Utf16BE = {
          stringify: function (b) {
            var a = b.words;
            for (var c = b.sigBytes, d = [], e = 0; e < c; e += 2) {
              var f = a[e >>> 2] >>> 16 - e % 4 * 8 & 65535;
              d.push(String.fromCharCode(f));
            }
            return d.join("");
          },
          parse: function (b) {
            for (var a = b.length, c = [], d = 0; d < a; d++) {
              c[d >>> 1] |= b.charCodeAt(d) << 16 - d % 2 * 16;
            }
            return i.create(c, a * 2);
          }
        };
        d.Utf16LE = {
          stringify: function (b) {
            var a = b.words;
            for (var c = b.sigBytes, d = [], f = 0; f < c; f += 2) {
              var g = e(a[f >>> 2] >>> 16 - f % 4 * 8 & 65535);
              d.push(String.fromCharCode(g));
            }
            return d.join("");
          },
          parse: function (b) {
            for (var a = b.length, c = [], d = 0; d < a; d++) {
              c[d >>> 1] |= e(b.charCodeAt(d) << 16 - d % 2 * 16);
            }
            return i.create(c, a * 2);
          }
        };
        function e(b) {
          return b << 8 & 4278255360 | b >>> 8 & 16711935;
        }
      })();
      return b.enc.Utf16;
    });
  }
});
var ha = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/enc-base64.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var l = c.WordArray;
        var d = a.enc;
        d.Base64 = {
          stringify: function (b) {
            var a = b.words;
            var c = b.sigBytes;
            var d = this._map;
            b.clamp();
            var e = [];
            for (var f = 0; f < c; f += 3) {
              var g = a[f >>> 2] >>> 24 - f % 4 * 8 & 255;
              var o = a[f + 1 >>> 2] >>> 24 - (f + 1) % 4 * 8 & 255;
              var p = a[f + 2 >>> 2] >>> 24 - (f + 2) % 4 * 8 & 255;
              var q = g << 16 | o << 8 | p;
              for (var r = 0; r < 4 && f + r * 0.75 < c; r++) {
                e.push(d.charAt(q >>> (3 - r) * 6 & 63));
              }
            }
            var s = d.charAt(64);
            if (s) {
              while (e.length % 4) {
                e.push(s);
              }
            }
            return e.join("");
          },
          parse: function (b) {
            var a = b.length;
            var c = this._map;
            var e = this._reverseMap;
            if (!e) {
              e = this._reverseMap = [];
              for (var g = 0; g < c.length; g++) {
                e[c.charCodeAt(g)] = g;
              }
            }
            var l = c.charAt(64);
            if (l) {
              var i = b.indexOf(l);
              if (i !== -1) {
                a = i;
              }
            }
            return k(b, a, e);
          },
          _map: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
        };
        function k(b, a, c) {
          var d = [];
          var e = 0;
          for (var f = 0; f < a; f++) {
            if (f % 4) {
              var g = c[b.charCodeAt(f - 1)] << f % 4 * 2;
              var m = c[b.charCodeAt(f)] >>> 6 - f % 4 * 2;
              d[e >>> 2] |= (g | m) << 24 - e % 4 * 8;
              e++;
            }
          }
          return l.create(d, e);
        }
      })();
      return b.enc.Base64;
    });
  }
});
var Yf = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/md5.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (c) {
      (function (a) {
        var b = c;
        var d = b.lib;
        var e = d.WordArray;
        var f = d.Hasher;
        var g = b.algo;
        var H = [];
        (function () {
          for (var b = 0; b < 64; b++) {
            H[b] = a.abs(a.sin(b + 1)) * 4294967296 | 0;
          }
        })();
        var h = g.MD5 = f.extend({
          _doReset: function () {
            this._hash = new e.init([1732584193, 4023233417, 2562383102, 271733878]);
          },
          _doProcessBlock: function (c, a) {
            for (var b = 0; b < 16; b++) {
              var d = a + b;
              var n = c[d];
              c[d] = (n << 8 | n >>> 24) & 16711935 | (n << 24 | n >>> 8) & 4278255360;
            }
            var I = this._hash.words;
            var h = c[a + 0];
            var j = c[a + 1];
            var o = c[a + 2];
            var p = c[a + 3];
            var q = c[a + 4];
            var r = c[a + 5];
            var s = c[a + 6];
            var t = c[a + 7];
            var u = c[a + 8];
            var v = c[a + 9];
            var w = c[a + 10];
            var x = c[a + 11];
            var y = c[a + 12];
            var z = c[a + 13];
            var A = c[a + 14];
            var B = c[a + 15];
            var C = I[0];
            var J = I[1];
            var K = I[2];
            var L = I[3];
            C = i(C, J, K, L, h, 7, H[0]);
            L = i(L, C, J, K, j, 12, H[1]);
            K = i(K, L, C, J, o, 17, H[2]);
            J = i(J, K, L, C, p, 22, H[3]);
            C = i(C, J, K, L, q, 7, H[4]);
            L = i(L, C, J, K, r, 12, H[5]);
            K = i(K, L, C, J, s, 17, H[6]);
            J = i(J, K, L, C, t, 22, H[7]);
            C = i(C, J, K, L, u, 7, H[8]);
            L = i(L, C, J, K, v, 12, H[9]);
            K = i(K, L, C, J, w, 17, H[10]);
            J = i(J, K, L, C, x, 22, H[11]);
            C = i(C, J, K, L, y, 7, H[12]);
            L = i(L, C, J, K, z, 12, H[13]);
            K = i(K, L, C, J, A, 17, H[14]);
            J = i(J, K, L, C, B, 22, H[15]);
            C = k(C, J, K, L, j, 5, H[16]);
            L = k(L, C, J, K, s, 9, H[17]);
            K = k(K, L, C, J, x, 14, H[18]);
            J = k(J, K, L, C, h, 20, H[19]);
            C = k(C, J, K, L, r, 5, H[20]);
            L = k(L, C, J, K, w, 9, H[21]);
            K = k(K, L, C, J, B, 14, H[22]);
            J = k(J, K, L, C, q, 20, H[23]);
            C = k(C, J, K, L, v, 5, H[24]);
            L = k(L, C, J, K, A, 9, H[25]);
            K = k(K, L, C, J, p, 14, H[26]);
            J = k(J, K, L, C, u, 20, H[27]);
            C = k(C, J, K, L, z, 5, H[28]);
            L = k(L, C, J, K, o, 9, H[29]);
            K = k(K, L, C, J, t, 14, H[30]);
            J = k(J, K, L, C, y, 20, H[31]);
            C = l(C, J, K, L, r, 4, H[32]);
            L = l(L, C, J, K, u, 11, H[33]);
            K = l(K, L, C, J, x, 16, H[34]);
            J = l(J, K, L, C, A, 23, H[35]);
            C = l(C, J, K, L, j, 4, H[36]);
            L = l(L, C, J, K, q, 11, H[37]);
            K = l(K, L, C, J, t, 16, H[38]);
            J = l(J, K, L, C, w, 23, H[39]);
            C = l(C, J, K, L, z, 4, H[40]);
            L = l(L, C, J, K, h, 11, H[41]);
            K = l(K, L, C, J, p, 16, H[42]);
            J = l(J, K, L, C, s, 23, H[43]);
            C = l(C, J, K, L, v, 4, H[44]);
            L = l(L, C, J, K, y, 11, H[45]);
            K = l(K, L, C, J, B, 16, H[46]);
            J = l(J, K, L, C, o, 23, H[47]);
            C = m(C, J, K, L, h, 6, H[48]);
            L = m(L, C, J, K, t, 10, H[49]);
            K = m(K, L, C, J, A, 15, H[50]);
            J = m(J, K, L, C, r, 21, H[51]);
            C = m(C, J, K, L, y, 6, H[52]);
            L = m(L, C, J, K, p, 10, H[53]);
            K = m(K, L, C, J, w, 15, H[54]);
            J = m(J, K, L, C, j, 21, H[55]);
            C = m(C, J, K, L, u, 6, H[56]);
            L = m(L, C, J, K, B, 10, H[57]);
            K = m(K, L, C, J, s, 15, H[58]);
            J = m(J, K, L, C, z, 21, H[59]);
            C = m(C, J, K, L, q, 6, H[60]);
            L = m(L, C, J, K, x, 10, H[61]);
            K = m(K, L, C, J, o, 15, H[62]);
            J = m(J, K, L, C, v, 21, H[63]);
            I[0] = I[0] + C | 0;
            I[1] = I[1] + J | 0;
            I[2] = I[2] + K | 0;
            I[3] = I[3] + L | 0;
          },
          _doFinalize: function () {
            var b = this._data;
            var c = b.words;
            var d = this._nDataBytes * 8;
            var e = b.sigBytes * 8;
            c[e >>> 5] |= 128 << 24 - e % 32;
            var f = a.floor(d / 4294967296);
            var g = d;
            c[(e + 64 >>> 9 << 4) + 15] = (f << 8 | f >>> 24) & 16711935 | (f << 24 | f >>> 8) & 4278255360;
            c[(e + 64 >>> 9 << 4) + 14] = (g << 8 | g >>> 24) & 16711935 | (g << 24 | g >>> 8) & 4278255360;
            b.sigBytes = (c.length + 1) * 4;
            this._process();
            var h = this._hash;
            var i = h.words;
            for (var j = 0; j < 4; j++) {
              var k = i[j];
              i[j] = (k << 8 | k >>> 24) & 16711935 | (k << 24 | k >>> 8) & 4278255360;
            }
            return h;
          },
          clone: function () {
            var a = f.clone.call(this);
            a._hash = this._hash.clone();
            return a;
          }
        });
        function i(i, a, b, c, d, e, f) {
          var g = i + (a & b | ~a & c) + d + f;
          return (g << e | g >>> 32 - e) + a;
        }
        function k(i, a, b, c, d, e, f) {
          var g = i + (a & c | b & ~c) + d + f;
          return (g << e | g >>> 32 - e) + a;
        }
        function l(i, a, b, c, d, e, f) {
          var g = i + (a ^ b ^ c) + d + f;
          return (g << e | g >>> 32 - e) + a;
        }
        function m(i, a, b, c, d, e, f) {
          var g = i + (b ^ (a | ~c)) + d + f;
          return (g << e | g >>> 32 - e) + a;
        }
        b.MD5 = f._createHelper(h);
        b.HmacMD5 = f._createHmacHelper(h);
      })(Math);
      return c.MD5;
    });
  }
});
var Jf = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha1.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.WordArray;
        var e = c.Hasher;
        var f = a.algo;
        var o = [];
        var g = f.SHA1 = e.extend({
          _doReset: function () {
            this._hash = new d.init([1732584193, 4023233417, 2562383102, 271733878, 3285377520]);
          },
          _doProcessBlock: function (b, a) {
            var c = this._hash.words;
            var d = c[0];
            var e = c[1];
            var h = c[2];
            var p = c[3];
            var q = c[4];
            for (var r = 0; r < 80; r++) {
              if (r < 16) {
                o[r] = b[a + r] | 0;
              } else {
                var s = o[r - 3] ^ o[r - 8] ^ o[r - 14] ^ o[r - 16];
                o[r] = s << 1 | s >>> 31;
              }
              var t = (d << 5 | d >>> 27) + q + o[r];
              if (r < 20) {
                t += (e & h | ~e & p) + 1518500249;
              } else if (r < 40) {
                t += (e ^ h ^ p) + 1859775393;
              } else if (r < 60) {
                t += (e & h | e & p | h & p) - 1894007588;
              } else {
                t += (e ^ h ^ p) - 899497514;
              }
              q = p;
              p = h;
              h = e << 30 | e >>> 2;
              e = d;
              d = t;
            }
            c[0] = c[0] + d | 0;
            c[1] = c[1] + e | 0;
            c[2] = c[2] + h | 0;
            c[3] = c[3] + p | 0;
            c[4] = c[4] + q | 0;
          },
          _doFinalize: function () {
            var a = this._data;
            var b = a.words;
            var c = this._nDataBytes * 8;
            var d = a.sigBytes * 8;
            b[d >>> 5] |= 128 << 24 - d % 32;
            b[(d + 64 >>> 9 << 4) + 14] = Math.floor(c / 4294967296);
            b[(d + 64 >>> 9 << 4) + 15] = c;
            a.sigBytes = b.length * 4;
            this._process();
            return this._hash;
          },
          clone: function () {
            var a = e.clone.call(this);
            a._hash = this._hash.clone();
            return a;
          }
        });
        a.SHA1 = e._createHelper(g);
        a.HmacSHA1 = e._createHmacHelper(g);
      })();
      return b.SHA1;
    });
  }
});
var Wm = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha256.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (c) {
      (function (m) {
        var a = c;
        var b = a.lib;
        var d = b.WordArray;
        var e = b.Hasher;
        var f = a.algo;
        var h = [];
        var A = [];
        (function () {
          function a(b) {
            for (var a = m.sqrt(b), c = 2; c <= a; c++) {
              if (!(b % c)) {
                return false;
              }
            }
            return true;
          }
          function b(b) {
            return (b - (b | 0)) * 4294967296 | 0;
          }
          var c = 2;
          for (var d = 0; d < 64;) {
            if (a(c)) {
              if (d < 8) {
                h[d] = b(m.pow(c, 1 / 2));
              }
              A[d] = b(m.pow(c, 1 / 3));
              d++;
            }
            c++;
          }
        })();
        var j = [];
        var g = f.SHA256 = e.extend({
          _doReset: function () {
            this._hash = new d.init(h.slice(0));
          },
          _doProcessBlock: function (c, a) {
            var b = this._hash.words;
            var d = b[0];
            var e = b[1];
            var k = b[2];
            var B = b[3];
            var C = b[4];
            var D = b[5];
            var E = b[6];
            var F = b[7];
            for (var G = 0; G < 64; G++) {
              if (G < 16) {
                j[G] = c[a + G] | 0;
              } else {
                var H = j[G - 15];
                var I = (H << 25 | H >>> 7) ^ (H << 14 | H >>> 18) ^ H >>> 3;
                var J = j[G - 2];
                var K = (J << 15 | J >>> 17) ^ (J << 13 | J >>> 19) ^ J >>> 10;
                j[G] = I + j[G - 7] + K + j[G - 16];
              }
              var L = C & D ^ ~C & E;
              var M = d & e ^ d & k ^ e & k;
              var N = (d << 30 | d >>> 2) ^ (d << 19 | d >>> 13) ^ (d << 10 | d >>> 22);
              var O = (C << 26 | C >>> 6) ^ (C << 21 | C >>> 11) ^ (C << 7 | C >>> 25);
              var P = F + O + L + A[G] + j[G];
              var Q = N + M;
              F = E;
              E = D;
              D = C;
              C = B + P | 0;
              B = k;
              k = e;
              e = d;
              d = P + Q | 0;
            }
            b[0] = b[0] + d | 0;
            b[1] = b[1] + e | 0;
            b[2] = b[2] + k | 0;
            b[3] = b[3] + B | 0;
            b[4] = b[4] + C | 0;
            b[5] = b[5] + D | 0;
            b[6] = b[6] + E | 0;
            b[7] = b[7] + F | 0;
          },
          _doFinalize: function () {
            var a = this._data;
            var b = a.words;
            var c = this._nDataBytes * 8;
            var d = a.sigBytes * 8;
            b[d >>> 5] |= 128 << 24 - d % 32;
            b[(d + 64 >>> 9 << 4) + 14] = m.floor(c / 4294967296);
            b[(d + 64 >>> 9 << 4) + 15] = c;
            a.sigBytes = b.length * 4;
            this._process();
            return this._hash;
          },
          clone: function () {
            var a = e.clone.call(this);
            a._hash = this._hash.clone();
            return a;
          }
        });
        a.SHA256 = e._createHelper(g);
        a.HmacSHA256 = e._createHmacHelper(g);
      })(Math);
      return c.SHA256;
    });
  }
});
var Xm = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha224.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Wm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./sha256"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.WordArray;
        var e = a.algo;
        var f = e.SHA256;
        var g = e.SHA224 = f.extend({
          _doReset: function () {
            this._hash = new d.init([3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428]);
          },
          _doFinalize: function () {
            var a = f._doFinalize.call(this);
            a.sigBytes -= 4;
            return a;
          }
        });
        a.SHA224 = f._createHelper(g);
        a.HmacSHA224 = f._createHmacHelper(g);
      })();
      return b.SHA224;
    });
  }
});
var Ym = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha512.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Vm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./x64-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.Hasher;
        var e = a.x64;
        var f = e.Word;
        var g = e.WordArray;
        var h = a.algo;
        function i() {
          return f.create.apply(f, arguments);
        }
        var j = [i(1116352408, 3609767458), i(1899447441, 602891725), i(3049323471, 3964484399), i(3921009573, 2173295548), i(961987163, 4081628472), i(1508970993, 3053834265), i(2453635748, 2937671579), i(2870763221, 3664609560), i(3624381080, 2734883394), i(310598401, 1164996542), i(607225278, 1323610764), i(1426881987, 3590304994), i(1925078388, 4068182383), i(2162078206, 991336113), i(2614888103, 633803317), i(3248222580, 3479774868), i(3835390401, 2666613458), i(4022224774, 944711139), i(264347078, 2341262773), i(604807628, 2007800933), i(770255983, 1495990901), i(1249150122, 1856431235), i(1555081692, 3175218132), i(1996064986, 2198950837), i(2554220882, 3999719339), i(2821834349, 766784016), i(2952996808, 2566594879), i(3210313671, 3203337956), i(3336571891, 1034457026), i(3584528711, 2466948901), i(113926993, 3758326383), i(338241895, 168717936), i(666307205, 1188179964), i(773529912, 1546045734), i(1294757372, 1522805485), i(1396182291, 2643833823), i(1695183700, 2343527390), i(1986661051, 1014477480), i(2177026350, 1206759142), i(2456956037, 344077627), i(2730485921, 1290863460), i(2820302411, 3158454273), i(3259730800, 3505952657), i(3345764771, 106217008), i(3516065817, 3606008344), i(3600352804, 1432725776), i(4094571909, 1467031594), i(275423344, 851169720), i(430227734, 3100823752), i(506948616, 1363258195), i(659060556, 3750685593), i(883997877, 3785050280), i(958139571, 3318307427), i(1322822218, 3812723403), i(1537002063, 2003034995), i(1747873779, 3602036899), i(1955562222, 1575990012), i(2024104815, 1125592928), i(2227730452, 2716904306), i(2361852424, 442776044), i(2428436474, 593698344), i(2756734187, 3733110249), i(3204031479, 2999351573), i(3329325298, 3815920427), i(3391569614, 3928383900), i(3515267271, 566280711), i(3940187606, 3454069534), i(4118630271, 4000239992), i(116418474, 1914138554), i(174292421, 2731055270), i(289380356, 3203993006), i(460393269, 320620315), i(685471733, 587496836), i(852142971, 1086792851), i(1017036298, 365543100), i(1126000580, 2618297676), i(1288033470, 3409855158), i(1501505948, 4234509866), i(1607167915, 987167468), i(1816402316, 1246189591)];
        var k = [];
        (function () {
          for (var b = 0; b < 80; b++) {
            k[b] = i();
          }
        })();
        var l = h.SHA512 = d.extend({
          _doReset: function () {
            this._hash = new g.init([new f.init(1779033703, 4089235720), new f.init(3144134277, 2227873595), new f.init(1013904242, 4271175723), new f.init(2773480762, 1595750129), new f.init(1359893119, 2917565137), new f.init(2600822924, 725511199), new f.init(528734635, 4215389547), new f.init(1541459225, 327033209)]);
          },
          _doProcessBlock: function (b, a) {
            var c = this._hash.words;
            var d = c[0];
            var e = c[1];
            var f = c[2];
            var g = c[3];
            var h = c[4];
            var i = c[5];
            var l = c[6];
            var m = c[7];
            var n = d.high;
            var o = d.low;
            var p = e.high;
            var r = e.low;
            var Ca = f.high;
            var t = f.low;
            var Da = g.high;
            var v = g.low;
            var Ea = h.high;
            var x = h.low;
            var Fa = i.high;
            var z = i.low;
            var Ga = l.high;
            var B = l.low;
            var Ha = m.high;
            var D = m.low;
            var Ia = n;
            var Ja = o;
            var Ka = p;
            var La = r;
            var Ma = Ca;
            var Na = t;
            var Oa = Da;
            var Pa = v;
            var Qa = Ea;
            var Ra = x;
            var Sa = Fa;
            var Ta = z;
            var Ua = Ga;
            var Va = B;
            var Wa = Ha;
            var Xa = D;
            for (var Ya = 0; Ya < 80; Ya++) {
              var Za = k[Ya];
              if (Ya < 16) {
                var $a = Za.high = b[a + Ya * 2] | 0;
                var _a = Za.low = b[a + Ya * 2 + 1] | 0;
              } else {
                var ab = k[Ya - 15];
                var bb = ab.high;
                var cb = ab.low;
                var db = (bb >>> 1 | cb << 31) ^ (bb >>> 8 | cb << 24) ^ bb >>> 7;
                var eb = (cb >>> 1 | bb << 31) ^ (cb >>> 8 | bb << 24) ^ (cb >>> 7 | bb << 25);
                var fb = k[Ya - 2];
                var gb = fb.high;
                var hb = fb.low;
                var ib = (gb >>> 19 | hb << 13) ^ (gb << 3 | hb >>> 29) ^ gb >>> 6;
                var jb = (hb >>> 19 | gb << 13) ^ (hb << 3 | gb >>> 29) ^ (hb >>> 6 | gb << 26);
                var kb = k[Ya - 7];
                var lb = kb.high;
                var mb = kb.low;
                var nb = k[Ya - 16];
                var ob = nb.high;
                var pb = nb.low;
                var _a = eb + mb;
                var $a = db + lb + (_a >>> 0 < eb >>> 0 ? 1 : 0);
                var _a = _a + jb;
                var $a = $a + ib + (_a >>> 0 < jb >>> 0 ? 1 : 0);
                var _a = _a + pb;
                var $a = $a + ob + (_a >>> 0 < pb >>> 0 ? 1 : 0);
                Za.high = $a;
                Za.low = _a;
              }
              var qb = Qa & Sa ^ ~Qa & Ua;
              var rb = Ra & Ta ^ ~Ra & Va;
              var sb = Ia & Ka ^ Ia & Ma ^ Ka & Ma;
              var tb = Ja & La ^ Ja & Na ^ La & Na;
              var ub = (Ia >>> 28 | Ja << 4) ^ (Ia << 30 | Ja >>> 2) ^ (Ia << 25 | Ja >>> 7);
              var vb = (Ja >>> 28 | Ia << 4) ^ (Ja << 30 | Ia >>> 2) ^ (Ja << 25 | Ia >>> 7);
              var wb = (Qa >>> 14 | Ra << 18) ^ (Qa >>> 18 | Ra << 14) ^ (Qa << 23 | Ra >>> 9);
              var xb = (Ra >>> 14 | Qa << 18) ^ (Ra >>> 18 | Qa << 14) ^ (Ra << 23 | Qa >>> 9);
              var yb = j[Ya];
              var zb = yb.high;
              var Ab = yb.low;
              var Bb = Xa + xb;
              var Cb = Wa + wb + (Bb >>> 0 < Xa >>> 0 ? 1 : 0);
              var Bb = Bb + rb;
              var Cb = Cb + qb + (Bb >>> 0 < rb >>> 0 ? 1 : 0);
              var Bb = Bb + Ab;
              var Cb = Cb + zb + (Bb >>> 0 < Ab >>> 0 ? 1 : 0);
              var Bb = Bb + _a;
              var Cb = Cb + $a + (Bb >>> 0 < _a >>> 0 ? 1 : 0);
              var Db = vb + tb;
              var Eb = ub + sb + (Db >>> 0 < vb >>> 0 ? 1 : 0);
              Wa = Ua;
              Xa = Va;
              Ua = Sa;
              Va = Ta;
              Sa = Qa;
              Ta = Ra;
              Ra = Pa + Bb | 0;
              Qa = Oa + Cb + (Ra >>> 0 < Pa >>> 0 ? 1 : 0) | 0;
              Oa = Ma;
              Pa = Na;
              Ma = Ka;
              Na = La;
              Ka = Ia;
              La = Ja;
              Ja = Bb + Db | 0;
              Ia = Cb + Eb + (Ja >>> 0 < Bb >>> 0 ? 1 : 0) | 0;
            }
            o = d.low = o + Ja;
            d.high = n + Ia + (o >>> 0 < Ja >>> 0 ? 1 : 0);
            r = e.low = r + La;
            e.high = p + Ka + (r >>> 0 < La >>> 0 ? 1 : 0);
            t = f.low = t + Na;
            f.high = Ca + Ma + (t >>> 0 < Na >>> 0 ? 1 : 0);
            v = g.low = v + Pa;
            g.high = Da + Oa + (v >>> 0 < Pa >>> 0 ? 1 : 0);
            x = h.low = x + Ra;
            h.high = Ea + Qa + (x >>> 0 < Ra >>> 0 ? 1 : 0);
            z = i.low = z + Ta;
            i.high = Fa + Sa + (z >>> 0 < Ta >>> 0 ? 1 : 0);
            B = l.low = B + Va;
            l.high = Ga + Ua + (B >>> 0 < Va >>> 0 ? 1 : 0);
            D = m.low = D + Xa;
            m.high = Ha + Wa + (D >>> 0 < Xa >>> 0 ? 1 : 0);
          },
          _doFinalize: function () {
            var a = this._data;
            var b = a.words;
            var c = this._nDataBytes * 8;
            var d = a.sigBytes * 8;
            b[d >>> 5] |= 128 << 24 - d % 32;
            b[(d + 128 >>> 10 << 5) + 30] = Math.floor(c / 4294967296);
            b[(d + 128 >>> 10 << 5) + 31] = c;
            a.sigBytes = b.length * 4;
            this._process();
            var e = this._hash.toX32();
            return e;
          },
          clone: function () {
            var a = d.clone.call(this);
            a._hash = this._hash.clone();
            return a;
          },
          blockSize: 32
        });
        a.SHA512 = d._createHelper(l);
        a.HmacSHA512 = d._createHmacHelper(l);
      })();
      return b.SHA512;
    });
  }
});
var _c = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha384.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Vm(), Ym());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./x64-core", "./sha512"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.x64;
        var d = c.Word;
        var e = c.WordArray;
        var f = a.algo;
        var g = f.SHA512;
        var h = f.SHA384 = g.extend({
          _doReset: function () {
            this._hash = new e.init([new d.init(3418070365, 3238371032), new d.init(1654270250, 914150663), new d.init(2438529370, 812702999), new d.init(355462360, 4144912697), new d.init(1731405415, 4290775857), new d.init(2394180231, 1750603025), new d.init(3675008525, 1694076839), new d.init(1203062813, 3204075428)]);
          },
          _doFinalize: function () {
            var a = g._doFinalize.call(this);
            a.sigBytes -= 16;
            return a;
          }
        });
        a.SHA384 = g._createHelper(h);
        a.HmacSHA384 = g._createHmacHelper(h);
      })();
      return b.SHA384;
    });
  }
});
var Qf = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha3.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Vm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./x64-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (c) {
      (function (a) {
        var b = c;
        var d = b.lib;
        var q = d.WordArray;
        var f = d.Hasher;
        var e = b.x64;
        var p = e.Word;
        var g = b.algo;
        var h = [];
        var i = [];
        var k = [];
        (function () {
          var l = 1;
          var m = 0;
          for (var q = 0; q < 24; q++) {
            h[l + m * 5] = (q + 1) * (q + 2) / 2 % 64;
            var r = m % 5;
            var s = (l * 2 + m * 3) % 5;
            l = r;
            m = s;
          }
          for (var l = 0; l < 5; l++) {
            for (var m = 0; m < 5; m++) {
              i[l + m * 5] = m + (l * 2 + m * 3) % 5 * 5;
            }
          }
          var t = 1;
          for (var u = 0; u < 24; u++) {
            var v = 0;
            var w = 0;
            for (var x = 0; x < 7; x++) {
              if (t & 1) {
                var y = (1 << x) - 1;
                if (y < 32) {
                  w ^= 1 << y;
                } else {
                  v ^= 1 << y - 32;
                }
              }
              if (t & 128) {
                t = t << 1 ^ 113;
              } else {
                t <<= 1;
              }
            }
            k[u] = p.create(v, w);
          }
        })();
        var l = [];
        (function () {
          for (var b = 0; b < 25; b++) {
            l[b] = p.create();
          }
        })();
        var j = g.SHA3 = f.extend({
          cfg: f.cfg.extend({
            outputLength: 512
          }),
          _doReset: function () {
            var a = this._state = [];
            for (var b = 0; b < 25; b++) {
              a[b] = new p.init();
            }
            this.blockSize = (1600 - this.cfg.outputLength * 2) / 32;
          },
          _doProcessBlock: function (c, a) {
            var b = this._state;
            for (var d = this.blockSize / 2, e = 0; e < d; e++) {
              var f = c[a + e * 2];
              var m = c[a + e * 2 + 1];
              f = (f << 8 | f >>> 24) & 16711935 | (f << 24 | f >>> 8) & 4278255360;
              m = (m << 8 | m >>> 24) & 16711935 | (m << 24 | m >>> 8) & 4278255360;
              var n = b[e];
              n.high ^= m;
              n.low ^= f;
            }
            for (var J = 0; J < 24; J++) {
              for (var K = 0; K < 5; K++) {
                var L = 0;
                var M = 0;
                for (var N = 0; N < 5; N++) {
                  var n = b[K + N * 5];
                  L ^= n.high;
                  M ^= n.low;
                }
                var O = l[K];
                O.high = L;
                O.low = M;
              }
              for (var K = 0; K < 5; K++) {
                var P = l[(K + 4) % 5];
                var Q = l[(K + 1) % 5];
                var R = Q.high;
                var S = Q.low;
                var L = P.high ^ (R << 1 | S >>> 31);
                var M = P.low ^ (S << 1 | R >>> 31);
                for (var N = 0; N < 5; N++) {
                  var n = b[K + N * 5];
                  n.high ^= L;
                  n.low ^= M;
                }
              }
              for (var T = 1; T < 25; T++) {
                var n = b[T];
                var U = n.high;
                var V = n.low;
                var W = h[T];
                if (W < 32) {
                  var L = U << W | V >>> 32 - W;
                  var M = V << W | U >>> 32 - W;
                } else {
                  var L = V << W - 32 | U >>> 64 - W;
                  var M = U << W - 32 | V >>> 64 - W;
                }
                var X = l[i[T]];
                X.high = L;
                X.low = M;
              }
              var Y = l[0];
              var Z = b[0];
              Y.high = Z.high;
              Y.low = Z.low;
              for (var K = 0; K < 5; K++) {
                for (var N = 0; N < 5; N++) {
                  var T = K + N * 5;
                  var n = b[T];
                  var $ = l[T];
                  var _ = l[(K + 1) % 5 + N * 5];
                  var aa = l[(K + 2) % 5 + N * 5];
                  n.high = $.high ^ ~_.high & aa.high;
                  n.low = $.low ^ ~_.low & aa.low;
                }
              }
              var n = b[0];
              var ba = k[J];
              n.high ^= ba.high;
              n.low ^= ba.low;
            }
          },
          _doFinalize: function () {
            var b = this._data;
            var c = b.words;
            this._nDataBytes * 8;
            var d = b.sigBytes * 8;
            var e = this.blockSize * 32;
            c[d >>> 5] |= 1 << 24 - d % 32;
            c[(a.ceil((d + 1) / e) * e >>> 5) - 1] |= 128;
            b.sigBytes = c.length * 4;
            this._process();
            var f = this._state;
            var g = this.cfg.outputLength / 8;
            for (var h = g / 8, i = [], j = 0; j < h; j++) {
              var k = f[j];
              var l = k.high;
              var r = k.low;
              l = (l << 8 | l >>> 24) & 16711935 | (l << 24 | l >>> 8) & 4278255360;
              r = (r << 8 | r >>> 24) & 16711935 | (r << 24 | r >>> 8) & 4278255360;
              i.push(r);
              i.push(l);
            }
            return new q.init(i, g);
          },
          clone: function () {
            var a = f.clone.call(this);
            var b = a._state = this._state.slice(0);
            for (var c = 0; c < 25; c++) {
              b[c] = b[c].clone();
            }
            return a;
          }
        });
        b.SHA3 = f._createHelper(j);
        b.HmacSHA3 = f._createHmacHelper(j);
      })(Math);
      return c.SHA3;
    });
  }
});
var pc = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/ripemd160.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (c) {
      (function (a) {
        var b = c;
        var d = b.lib;
        var e = d.WordArray;
        var f = d.Hasher;
        var g = b.algo;
        var L = e.create([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 7, 4, 13, 1, 10, 6, 15, 3, 12, 0, 9, 5, 2, 14, 11, 8, 3, 10, 14, 4, 9, 15, 8, 1, 2, 7, 0, 6, 13, 11, 5, 12, 1, 9, 11, 10, 0, 8, 12, 4, 13, 3, 7, 15, 14, 5, 6, 2, 4, 0, 5, 9, 7, 12, 2, 10, 14, 1, 3, 8, 11, 6, 15, 13]);
        var i = e.create([5, 14, 7, 0, 9, 2, 11, 4, 13, 6, 15, 8, 1, 10, 3, 12, 6, 11, 3, 7, 0, 13, 5, 10, 14, 15, 8, 12, 4, 9, 1, 2, 15, 5, 1, 3, 7, 14, 6, 9, 11, 8, 12, 2, 10, 0, 4, 13, 8, 6, 4, 1, 3, 11, 15, 0, 5, 12, 2, 13, 9, 7, 10, 14, 12, 15, 10, 4, 1, 5, 8, 7, 6, 2, 13, 14, 0, 3, 9, 11]);
        var j = e.create([11, 14, 15, 12, 5, 8, 7, 9, 11, 13, 14, 15, 6, 7, 9, 8, 7, 6, 8, 13, 11, 9, 7, 15, 7, 12, 15, 9, 11, 7, 13, 12, 11, 13, 6, 7, 14, 9, 13, 15, 14, 8, 13, 6, 5, 12, 7, 5, 11, 12, 14, 15, 14, 15, 9, 8, 9, 14, 5, 6, 8, 6, 5, 12, 9, 15, 5, 11, 6, 8, 13, 12, 5, 12, 13, 14, 11, 8, 5, 6]);
        var k = e.create([8, 9, 9, 11, 13, 15, 15, 5, 7, 7, 8, 11, 14, 14, 12, 6, 9, 13, 15, 7, 12, 8, 9, 11, 7, 7, 12, 7, 6, 15, 13, 11, 9, 7, 15, 11, 8, 6, 6, 14, 12, 13, 5, 14, 13, 13, 7, 5, 15, 5, 8, 11, 14, 14, 6, 14, 6, 9, 12, 9, 12, 5, 15, 8, 8, 5, 12, 9, 12, 5, 14, 6, 8, 13, 6, 5, 15, 13, 11, 11]);
        var l = e.create([0, 1518500249, 1859775393, 2400959708, 2840853838]);
        var m = e.create([1352829926, 1548603684, 1836072691, 2053994217, 0]);
        var h = g.RIPEMD160 = f.extend({
          _doReset: function () {
            this._hash = e.create([1732584193, 4023233417, 2562383102, 271733878, 3285377520]);
          },
          _doProcessBlock: function (c, a) {
            for (var b = 0; b < 16; b++) {
              var d = a + b;
              var u = c[d];
              c[d] = (u << 8 | u >>> 24) & 16711935 | (u << 24 | u >>> 8) & 4278255360;
            }
            var M = this._hash.words;
            var h = l.words;
            var o = m.words;
            var v = L.words;
            var w = i.words;
            var x = j.words;
            var y = k.words;
            var z;
            var N;
            var O;
            var P;
            var Q;
            var R;
            var S;
            var T;
            var U;
            var V;
            R = z = M[0];
            S = N = M[1];
            T = O = M[2];
            U = P = M[3];
            V = Q = M[4];
            var W;
            for (var b = 0; b < 80; b += 1) {
              W = z + c[a + v[b]] | 0;
              if (b < 16) {
                W += n(N, O, P) + h[0];
              } else if (b < 32) {
                W += p(N, O, P) + h[1];
              } else if (b < 48) {
                W += q(N, O, P) + h[2];
              } else if (b < 64) {
                W += r(N, O, P) + h[3];
              } else {
                W += s(N, O, P) + h[4];
              }
              W = W | 0;
              W = t(W, x[b]);
              W = W + Q | 0;
              z = Q;
              Q = P;
              P = t(O, 10);
              O = N;
              N = W;
              W = R + c[a + w[b]] | 0;
              if (b < 16) {
                W += s(S, T, U) + o[0];
              } else if (b < 32) {
                W += r(S, T, U) + o[1];
              } else if (b < 48) {
                W += q(S, T, U) + o[2];
              } else if (b < 64) {
                W += p(S, T, U) + o[3];
              } else {
                W += n(S, T, U) + o[4];
              }
              W = W | 0;
              W = t(W, y[b]);
              W = W + V | 0;
              R = V;
              V = U;
              U = t(T, 10);
              T = S;
              S = W;
            }
            W = M[1] + O + U | 0;
            M[1] = M[2] + P + V | 0;
            M[2] = M[3] + Q + R | 0;
            M[3] = M[4] + z + S | 0;
            M[4] = M[0] + N + T | 0;
            M[0] = W;
          },
          _doFinalize: function () {
            var a = this._data;
            var b = a.words;
            var c = this._nDataBytes * 8;
            var d = a.sigBytes * 8;
            b[d >>> 5] |= 128 << 24 - d % 32;
            b[(d + 64 >>> 9 << 4) + 14] = (c << 8 | c >>> 24) & 16711935 | (c << 24 | c >>> 8) & 4278255360;
            a.sigBytes = (b.length + 1) * 4;
            this._process();
            var e = this._hash;
            var f = e.words;
            for (var g = 0; g < 5; g++) {
              var h = f[g];
              f[g] = (h << 8 | h >>> 24) & 16711935 | (h << 24 | h >>> 8) & 4278255360;
            }
            return e;
          },
          clone: function () {
            var a = f.clone.call(this);
            a._hash = this._hash.clone();
            return a;
          }
        });
        function n(d, a, b) {
          return d ^ a ^ b;
        }
        function p(d, a, b) {
          return d & a | ~d & b;
        }
        function q(d, a, b) {
          return (d | ~a) ^ b;
        }
        function r(d, a, b) {
          return d & b | a & ~b;
        }
        function s(d, a, b) {
          return d ^ (a | ~b);
        }
        function t(c, a) {
          return c << a | c >>> 32 - a;
        }
        b.RIPEMD160 = f._createHelper(h);
        b.HmacRIPEMD160 = f._createHmacHelper(h);
      })();
      return c.RIPEMD160;
    });
  }
});
var eh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/hmac.js"(e, c) {
    (function (a, b) {
      if (typeof e == "object") {
        c.exports = e = b(ke());
      } else if (typeof define == "function" && define.amd) {
        define(["./core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(e, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.Base;
        var e = a.enc;
        var f = e.Utf8;
        var g = a.algo;
        g.HMAC = d.extend({
          init: function (b, d) {
            b = this._hasher = new b.init();
            if (typeof d == "string") {
              d = f.parse(d);
            }
            var g = b.blockSize;
            var e = g * 4;
            if (d.sigBytes > e) {
              d = b.finalize(d);
            }
            d.clamp();
            var m = this._oKey = d.clone();
            var h = this._iKey = d.clone();
            var i = m.words;
            var j = h.words;
            for (var k = 0; k < g; k++) {
              i[k] ^= 1549556828;
              j[k] ^= 909522486;
            }
            m.sigBytes = h.sigBytes = e;
            this.reset();
          },
          reset: function () {
            var a = this._hasher;
            a.reset();
            a.update(this._iKey);
          },
          update: function (b) {
            this._hasher.update(b);
            return this;
          },
          finalize: function (b) {
            var a = this._hasher;
            var c = a.finalize(b);
            a.reset();
            var d = a.finalize(this._oKey.clone().concat(c));
            return d;
          }
        });
      })();
    });
  }
});
var th = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pbkdf2.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Jf(), eh());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./sha1", "./hmac"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.Base;
        var v = c.WordArray;
        var e = a.algo;
        var f = e.SHA1;
        var w = e.HMAC;
        var g = e.PBKDF2 = d.extend({
          cfg: d.extend({
            keySize: 4,
            hasher: f,
            iterations: 1
          }),
          init: function (b) {
            this.cfg = this.cfg.extend(b);
          },
          compute: function (b, a) {
            var c = this.cfg;
            var d = w.create(c.hasher, b);
            var e = v.create();
            var f = v.create([1]);
            for (var g = e.words, h = f.words, i = c.keySize, j = c.iterations; g.length < i;) {
              var k = d.update(a).finalize(f);
              d.reset();
              var l = k.words;
              var m = l.length;
              var n = k;
              for (var x = 1; x < j; x++) {
                n = d.finalize(n);
                d.reset();
                var y = n.words;
                for (var z = 0; z < m; z++) {
                  l[z] ^= y[z];
                }
              }
              e.concat(k);
              h[0]++;
            }
            e.sigBytes = i * 4;
            return e;
          }
        });
        a.PBKDF2 = function (b, a, c) {
          return g.create(c).compute(b, a);
        };
      })();
      return b.PBKDF2;
    });
  }
});
var nh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/evpkdf.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Jf(), eh());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./sha1", "./hmac"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.Base;
        var n = c.WordArray;
        var e = a.algo;
        var f = e.MD5;
        var g = e.EvpKDF = d.extend({
          cfg: d.extend({
            keySize: 4,
            hasher: f,
            iterations: 1
          }),
          init: function (b) {
            this.cfg = this.cfg.extend(b);
          },
          compute: function (b, a) {
            var c = this.cfg;
            var d = c.hasher.create();
            var e = n.create();
            for (var f = e.words, g = c.keySize, h = c.iterations; f.length < g;) {
              if (i) {
                d.update(i);
              }
              var i = d.update(b).finalize(a);
              d.reset();
              for (var j = 1; j < h; j++) {
                i = d.finalize(i);
                d.reset();
              }
              e.concat(i);
            }
            e.sigBytes = g * 4;
            return e;
          }
        });
        a.EvpKDF = function (b, a, c) {
          return g.create(c).compute(b, a);
        };
      })();
      return b.EvpKDF;
    });
  }
});
var Zm = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/cipher-core.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), nh());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./evpkdf"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      if (!b.lib.Cipher) {
        (function (a) {
          var c = b;
          var d = c.lib;
          var e = d.Base;
          var A = d.WordArray;
          var f = d.BufferedBlockAlgorithm;
          var g = c.enc;
          g.Utf8;
          var h = g.Base64;
          var i = c.algo;
          var j = i.EvpKDF;
          var k = d.Cipher = f.extend({
            cfg: e.extend(),
            createEncryptor: function (c, a) {
              return this.create(this._ENC_XFORM_MODE, c, a);
            },
            createDecryptor: function (c, a) {
              return this.create(this._DEC_XFORM_MODE, c, a);
            },
            init: function (d, a, b) {
              this.cfg = this.cfg.extend(b);
              this._xformMode = d;
              this._key = a;
              this.reset();
            },
            reset: function () {
              f.reset.call(this);
              this._doReset();
            },
            process: function (b) {
              this._append(b);
              return this._process();
            },
            finalize: function (b) {
              if (b) {
                this._append(b);
              }
              var a = this._doFinalize();
              return a;
            },
            keySize: 4,
            ivSize: 4,
            _ENC_XFORM_MODE: 1,
            _DEC_XFORM_MODE: 2,
            _createHelper: function () {
              function f(b) {
                if (typeof b == "string") {
                  return w;
                } else {
                  return t;
                }
              }
              return function (a) {
                return {
                  encrypt: function (b, c, d) {
                    return f(c).encrypt(a, b, c, d);
                  },
                  decrypt: function (b, c, d) {
                    return f(c).decrypt(a, b, c, d);
                  }
                };
              };
            }()
          });
          d.StreamCipher = k.extend({
            _doFinalize: function () {
              var a = this._process(true);
              return a;
            },
            blockSize: 1
          });
          var l = c.mode = {};
          var m = d.BlockCipherMode = e.extend({
            createEncryptor: function (c, a) {
              return this.Encryptor.create(c, a);
            },
            createDecryptor: function (c, a) {
              return this.Decryptor.create(c, a);
            },
            init: function (c, a) {
              this._cipher = c;
              this._iv = a;
            }
          });
          var n = l.CBC = function () {
            var c = m.extend();
            c.Encryptor = c.extend({
              processBlock: function (a, b) {
                var c = this._cipher;
                var e = c.blockSize;
                d.call(this, a, b, e);
                c.encryptBlock(a, b);
                this._prevBlock = a.slice(b, b + e);
              }
            });
            c.Decryptor = c.extend({
              processBlock: function (a, b) {
                var c = this._cipher;
                var e = c.blockSize;
                var f = a.slice(b, b + e);
                c.decryptBlock(a, b);
                d.call(this, a, b, e);
                this._prevBlock = f;
              }
            });
            function d(c, b, d) {
              var e = this._iv;
              if (e) {
                var f = e;
                this._iv = a;
              } else {
                var f = this._prevBlock;
              }
              for (var g = 0; g < d; g++) {
                c[b + g] ^= f[g];
              }
            }
            return c;
          }();
          var o = c.pad = {};
          var p = o.Pkcs7 = {
            pad: function (c, a) {
              var b = a * 4;
              for (var d = b - c.sigBytes % b, e = d << 24 | d << 16 | d << 8 | d, f = [], g = 0; g < d; g += 4) {
                f.push(e);
              }
              var h = A.create(f, d);
              c.concat(h);
            },
            unpad: function (b) {
              var a = b.words[b.sigBytes - 1 >>> 2] & 255;
              b.sigBytes -= a;
            }
          };
          d.BlockCipher = k.extend({
            cfg: k.cfg.extend({
              mode: n,
              padding: p
            }),
            reset: function () {
              k.reset.call(this);
              var a = this.cfg;
              var b = a.iv;
              var c = a.mode;
              if (this._xformMode == this._ENC_XFORM_MODE) {
                var d = c.createEncryptor;
              } else {
                var d = c.createDecryptor;
                this._minBufferSize = 1;
              }
              if (this._mode && this._mode.__creator == d) {
                this._mode.init(this, b && b.words);
              } else {
                this._mode = d.call(c, this, b && b.words);
                this._mode.__creator = d;
              }
            },
            _doProcessBlock: function (c, a) {
              this._mode.processBlock(c, a);
            },
            _doFinalize: function () {
              var a = this.cfg.padding;
              if (this._xformMode == this._ENC_XFORM_MODE) {
                a.pad(this._data, this.blockSize);
                var b = this._process(true);
              } else {
                var b = this._process(true);
                a.unpad(b);
              }
              return b;
            },
            blockSize: 4
          });
          var q = d.CipherParams = e.extend({
            init: function (b) {
              this.mixIn(b);
            },
            toString: function (b) {
              return (b || this.formatter).stringify(this);
            }
          });
          var r = c.format = {};
          var s = r.OpenSSL = {
            stringify: function (b) {
              var a = b.ciphertext;
              var c = b.salt;
              if (c) {
                var d = A.create([1398893684, 1701076831]).concat(c).concat(a);
              } else {
                var d = a;
              }
              return d.toString(h);
            },
            parse: function (b) {
              var a = h.parse(b);
              var c = a.words;
              if (c[0] == 1398893684 && c[1] == 1701076831) {
                var d = A.create(c.slice(2, 4));
                c.splice(0, 4);
                a.sigBytes -= 16;
              }
              return q.create({
                ciphertext: a,
                salt: d
              });
            }
          };
          var t = d.SerializableCipher = e.extend({
            cfg: e.extend({
              format: s
            }),
            encrypt: function (d, a, b, c) {
              c = this.cfg.extend(c);
              var f = d.createEncryptor(b, c);
              var g = f.finalize(a);
              var h = f.cfg;
              return q.create({
                ciphertext: g,
                key: b,
                iv: h.iv,
                algorithm: d,
                mode: h.mode,
                padding: h.padding,
                blockSize: d.blockSize,
                formatter: c.format
              });
            },
            decrypt: function (d, a, f, c) {
              c = this.cfg.extend(c);
              a = this._parse(a, c.format);
              var h = d.createDecryptor(f, c).finalize(a.ciphertext);
              return h;
            },
            _parse: function (c, a) {
              if (typeof c == "string") {
                return a.parse(c, this);
              } else {
                return c;
              }
            }
          });
          var u = c.kdf = {};
          var v = u.OpenSSL = {
            execute: function (d, a, b, c) {
              c ||= A.random(8);
              var f = j.create({
                keySize: a + b
              }).compute(d, c);
              var g = A.create(f.words.slice(a), b * 4);
              f.sigBytes = a * 4;
              return q.create({
                key: f,
                iv: g,
                salt: c
              });
            }
          };
          var w = d.PasswordBasedCipher = t.extend({
            cfg: t.cfg.extend({
              kdf: v
            }),
            encrypt: function (d, a, b, c) {
              c = this.cfg.extend(c);
              var f = c.kdf.execute(b, d.keySize, d.ivSize);
              c.iv = f.iv;
              var g = t.encrypt.call(this, d, a, f.key, c);
              g.mixIn(f);
              return g;
            },
            decrypt: function (d, a, f, c) {
              c = this.cfg.extend(c);
              a = this._parse(a, c.format);
              var i = c.kdf.execute(f, d.keySize, d.ivSize, a.salt);
              c.iv = i.iv;
              var g = t.decrypt.call(this, d, a, i.key, c);
              return g;
            }
          });
        })();
      }
    });
  }
});
var rh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-cfb.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.mode.CFB = function () {
        var a = b.lib.BlockCipherMode.extend();
        a.Encryptor = a.extend({
          processBlock: function (d, a) {
            var b = this._cipher;
            var e = b.blockSize;
            c.call(this, d, a, e, b);
            this._prevBlock = d.slice(a, a + e);
          }
        });
        a.Decryptor = a.extend({
          processBlock: function (d, a) {
            var b = this._cipher;
            var e = b.blockSize;
            var f = d.slice(a, a + e);
            c.call(this, d, a, e, b);
            this._prevBlock = f;
          }
        });
        function c(c, a, b, d) {
          var e = this._iv;
          if (e) {
            var f = e.slice(0);
            this._iv = undefined;
          } else {
            var f = this._prevBlock;
          }
          d.encryptBlock(f, 0);
          for (var g = 0; g < b; g++) {
            c[a + g] ^= f[g];
          }
        }
        return a;
      }();
      return b.mode.CFB;
    });
  }
});
var $m = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ctr.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.mode.CTR = function () {
        var a = b.lib.BlockCipherMode.extend();
        var c = a.Encryptor = a.extend({
          processBlock: function (c, a) {
            var b = this._cipher;
            var d = b.blockSize;
            var e = this._iv;
            var f = this._counter;
            if (e) {
              f = this._counter = e.slice(0);
              this._iv = undefined;
            }
            var g = f.slice(0);
            b.encryptBlock(g, 0);
            f[d - 1] = f[d - 1] + 1 | 0;
            for (var i = 0; i < d; i++) {
              c[a + i] ^= g[i];
            }
          }
        });
        a.Decryptor = c;
        return a;
      }();
      return b.mode.CTR;
    });
  }
});
var We = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ctr-gladman.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.mode.CTRGladman = function () {
        var a = b.lib.BlockCipherMode.extend();
        function c(e) {
          if ((e >> 24 & 255) === 255) {
            var f = e >> 16 & 255;
            var g = e >> 8 & 255;
            var h = e & 255;
            if (f === 255) {
              f = 0;
              if (g === 255) {
                g = 0;
                if (h === 255) {
                  h = 0;
                } else {
                  ++h;
                }
              } else {
                ++g;
              }
            } else {
              ++f;
            }
            e = 0;
            e += f << 16;
            e += g << 8;
            e += h;
          } else {
            e += 1 << 24;
          }
          return e;
        }
        function d(b) {
          if ((b[0] = c(b[0])) === 0) {
            b[1] = c(b[1]);
          }
          return b;
        }
        var e = a.Encryptor = a.extend({
          processBlock: function (c, a) {
            var b = this._cipher;
            var e = b.blockSize;
            var f = this._iv;
            var g = this._counter;
            if (f) {
              g = this._counter = f.slice(0);
              this._iv = undefined;
            }
            d(g);
            var h = g.slice(0);
            b.encryptBlock(h, 0);
            for (var j = 0; j < e; j++) {
              c[a + j] ^= h[j];
            }
          }
        });
        a.Decryptor = e;
        return a;
      }();
      return b.mode.CTRGladman;
    });
  }
});
var ih = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ofb.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.mode.OFB = function () {
        var a = b.lib.BlockCipherMode.extend();
        var c = a.Encryptor = a.extend({
          processBlock: function (c, a) {
            var b = this._cipher;
            var d = b.blockSize;
            var e = this._iv;
            var f = this._keystream;
            if (e) {
              f = this._keystream = e.slice(0);
              this._iv = undefined;
            }
            b.encryptBlock(f, 0);
            for (var g = 0; g < d; g++) {
              c[a + g] ^= f[g];
            }
          }
        });
        a.Decryptor = c;
        return a;
      }();
      return b.mode.OFB;
    });
  }
});
var ah = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ecb.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.mode.ECB = function () {
        var a = b.lib.BlockCipherMode.extend();
        a.Encryptor = a.extend({
          processBlock: function (c, a) {
            this._cipher.encryptBlock(c, a);
          }
        });
        a.Decryptor = a.extend({
          processBlock: function (c, a) {
            this._cipher.decryptBlock(c, a);
          }
        });
        return a;
      }();
      return b.mode.ECB;
    });
  }
});
var sh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-ansix923.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.pad.AnsiX923 = {
        pad: function (b, a) {
          var c = b.sigBytes;
          var d = a * 4;
          var e = d - c % d;
          var f = c + e - 1;
          b.clamp();
          b.words[f >>> 2] |= e << 24 - f % 4 * 8;
          b.sigBytes += e;
        },
        unpad: function (b) {
          var a = b.words[b.sigBytes - 1 >>> 2] & 255;
          b.sigBytes -= a;
        }
      };
      return b.pad.Ansix923;
    });
  }
});
var oh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-iso10126.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.pad.Iso10126 = {
        pad: function (a, c) {
          var d = c * 4;
          var e = d - a.sigBytes % d;
          a.concat(b.lib.WordArray.random(e - 1)).concat(b.lib.WordArray.create([e << 24], 1));
        },
        unpad: function (b) {
          var a = b.words[b.sigBytes - 1 >>> 2] & 255;
          b.sigBytes -= a;
        }
      };
      return b.pad.Iso10126;
    });
  }
});
var lh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-iso97971.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.pad.Iso97971 = {
        pad: function (a, c) {
          a.concat(b.lib.WordArray.create([2147483648], 1));
          b.pad.ZeroPadding.pad(a, c);
        },
        unpad: function (a) {
          b.pad.ZeroPadding.unpad(a);
          a.sigBytes--;
        }
      };
      return b.pad.Iso97971;
    });
  }
});
var ch = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-zeropadding.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.pad.ZeroPadding = {
        pad: function (b, a) {
          var c = a * 4;
          b.clamp();
          b.sigBytes += c - (b.sigBytes % c || c);
        },
        unpad: function (b) {
          for (var a = b.words, c = b.sigBytes - 1; !(a[c >>> 2] >>> 24 - c % 4 * 8 & 255);) {
            c--;
          }
          b.sigBytes = c + 1;
        }
      };
      return b.pad.ZeroPadding;
    });
  }
});
var uh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-nopadding.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      b.pad.NoPadding = {
        pad: function () {},
        unpad: function () {}
      };
      return b.pad.NoPadding;
    });
  }
});
var dh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/format-hex.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (c) {
      (function (a) {
        var b = c;
        var d = b.lib;
        var e = d.CipherParams;
        var f = b.enc;
        var g = f.Hex;
        var h = b.format;
        h.Hex = {
          stringify: function (b) {
            return b.ciphertext.toString(g);
          },
          parse: function (b) {
            var a = g.parse(b);
            return e.create({
              ciphertext: a
            });
          }
        };
      })();
      return c.format.Hex;
    });
  }
});
var fh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/aes.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), ha(), Yf(), nh(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.BlockCipher;
        var e = a.algo;
        var t = [];
        var g = [];
        var h = [];
        var i = [];
        var j = [];
        var k = [];
        var u = [];
        var m = [];
        var n = [];
        var o = [];
        (function () {
          var l = [];
          for (var a = 0; a < 256; a++) {
            if (a < 128) {
              l[a] = a << 1;
            } else {
              l[a] = a << 1 ^ 283;
            }
          }
          var p = 0;
          var v = 0;
          for (var a = 0; a < 256; a++) {
            var w = v ^ v << 1 ^ v << 2 ^ v << 3 ^ v << 4;
            w = w >>> 8 ^ w & 255 ^ 99;
            t[p] = w;
            g[w] = p;
            var x = l[p];
            var y = l[x];
            var z = l[y];
            var A = l[w] * 257 ^ w * 16843008;
            h[p] = A << 24 | A >>> 8;
            i[p] = A << 16 | A >>> 16;
            j[p] = A << 8 | A >>> 24;
            k[p] = A;
            var A = z * 16843009 ^ y * 65537 ^ x * 257 ^ p * 16843008;
            u[w] = A << 24 | A >>> 8;
            m[w] = A << 16 | A >>> 16;
            n[w] = A << 8 | A >>> 24;
            o[w] = A;
            if (p) {
              p = x ^ l[l[l[z ^ x]]];
              v ^= l[l[v]];
            } else {
              p = v = 1;
            }
          }
        })();
        var f = [0, 1, 2, 4, 8, 16, 32, 64, 128, 27, 54];
        var l = e.AES = d.extend({
          _doReset: function () {
            if (!this._nRounds || this._keyPriorReset !== this._key) {
              var a = this._keyPriorReset = this._key;
              var b = a.words;
              var c = a.sigBytes / 4;
              var d = this._nRounds = c + 6;
              for (var e = (d + 1) * 4, g = this._keySchedule = [], h = 0; h < e; h++) {
                if (h < c) {
                  g[h] = b[h];
                } else {
                  var i = g[h - 1];
                  if (h % c) {
                    if (c > 6 && h % c == 4) {
                      i = t[i >>> 24] << 24 | t[i >>> 16 & 255] << 16 | t[i >>> 8 & 255] << 8 | t[i & 255];
                    }
                  } else {
                    i = i << 8 | i >>> 24;
                    i = t[i >>> 24] << 24 | t[i >>> 16 & 255] << 16 | t[i >>> 8 & 255] << 8 | t[i & 255];
                    i ^= f[h / c | 0] << 24;
                  }
                  g[h] = g[h - c] ^ i;
                }
              }
              var p = this._invKeySchedule = [];
              for (var l = 0; l < e; l++) {
                var h = e - l;
                if (l % 4) {
                  var i = g[h];
                } else {
                  var i = g[h - 4];
                }
                if (l < 4 || h <= 4) {
                  p[l] = i;
                } else {
                  p[l] = u[t[i >>> 24]] ^ m[t[i >>> 16 & 255]] ^ n[t[i >>> 8 & 255]] ^ o[t[i & 255]];
                }
              }
            }
          },
          encryptBlock: function (b, a) {
            this._doCryptBlock(b, a, this._keySchedule, h, i, j, k, t);
          },
          decryptBlock: function (d, a) {
            var b = d[a + 1];
            d[a + 1] = d[a + 3];
            d[a + 3] = b;
            this._doCryptBlock(d, a, this._invKeySchedule, u, m, n, o, g);
            var b = d[a + 1];
            d[a + 1] = d[a + 3];
            d[a + 3] = b;
          },
          _doCryptBlock: function (t, a, b, c, d, e, f, g) {
            for (var h = this._nRounds, i = t[a] ^ b[0], u = t[a + 1] ^ b[1], v = t[a + 2] ^ b[2], w = t[a + 3] ^ b[3], x = 4, y = 1; y < h; y++) {
              var z = c[i >>> 24] ^ d[u >>> 16 & 255] ^ e[v >>> 8 & 255] ^ f[w & 255] ^ b[x++];
              var A = c[u >>> 24] ^ d[v >>> 16 & 255] ^ e[w >>> 8 & 255] ^ f[i & 255] ^ b[x++];
              var B = c[v >>> 24] ^ d[w >>> 16 & 255] ^ e[i >>> 8 & 255] ^ f[u & 255] ^ b[x++];
              var C = c[w >>> 24] ^ d[i >>> 16 & 255] ^ e[u >>> 8 & 255] ^ f[v & 255] ^ b[x++];
              i = z;
              u = A;
              v = B;
              w = C;
            }
            var z = (g[i >>> 24] << 24 | g[u >>> 16 & 255] << 16 | g[v >>> 8 & 255] << 8 | g[w & 255]) ^ b[x++];
            var A = (g[u >>> 24] << 24 | g[v >>> 16 & 255] << 16 | g[w >>> 8 & 255] << 8 | g[i & 255]) ^ b[x++];
            var B = (g[v >>> 24] << 24 | g[w >>> 16 & 255] << 16 | g[i >>> 8 & 255] << 8 | g[u & 255]) ^ b[x++];
            var C = (g[w >>> 24] << 24 | g[i >>> 16 & 255] << 16 | g[u >>> 8 & 255] << 8 | g[v & 255]) ^ b[x++];
            t[a] = z;
            t[a + 1] = A;
            t[a + 2] = B;
            t[a + 3] = C;
          },
          keySize: 8
        });
        a.AES = d._createHelper(l);
      })();
      return b.AES;
    });
  }
});
var hh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/tripledes.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), ha(), Yf(), nh(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var q = c.WordArray;
        var d = c.BlockCipher;
        var e = a.algo;
        var r = [57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26, 18, 10, 2, 59, 51, 43, 35, 27, 19, 11, 3, 60, 52, 44, 36, 63, 55, 47, 39, 31, 23, 15, 7, 62, 54, 46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 28, 20, 12, 4];
        var g = [14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4, 26, 8, 16, 7, 27, 20, 13, 2, 41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32];
        var h = [1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28];
        var f = [{
          0: 8421888,
          268435456: 32768,
          536870912: 8421378,
          805306368: 2,
          1073741824: 512,
          1342177280: 8421890,
          1610612736: 8389122,
          1879048192: 8388608,
          2147483648: 514,
          2415919104: 8389120,
          2684354560: 33280,
          2952790016: 8421376,
          3221225472: 32770,
          3489660928: 8388610,
          3758096384: 0,
          4026531840: 33282,
          134217728: 0,
          402653184: 8421890,
          671088640: 33282,
          939524096: 32768,
          1207959552: 8421888,
          1476395008: 512,
          1744830464: 8421378,
          2013265920: 2,
          2281701376: 8389120,
          2550136832: 33280,
          2818572288: 8421376,
          3087007744: 8389122,
          3355443200: 8388610,
          3623878656: 32770,
          3892314112: 514,
          4160749568: 8388608,
          1: 32768,
          268435457: 2,
          536870913: 8421888,
          805306369: 8388608,
          1073741825: 8421378,
          1342177281: 33280,
          1610612737: 512,
          1879048193: 8389122,
          2147483649: 8421890,
          2415919105: 8421376,
          2684354561: 8388610,
          2952790017: 33282,
          3221225473: 514,
          3489660929: 8389120,
          3758096385: 32770,
          4026531841: 0,
          134217729: 8421890,
          402653185: 8421376,
          671088641: 8388608,
          939524097: 512,
          1207959553: 32768,
          1476395009: 8388610,
          1744830465: 2,
          2013265921: 33282,
          2281701377: 32770,
          2550136833: 8389122,
          2818572289: 514,
          3087007745: 8421888,
          3355443201: 8389120,
          3623878657: 0,
          3892314113: 33280,
          4160749569: 8421378
        }, {
          0: 1074282512,
          16777216: 16384,
          33554432: 524288,
          50331648: 1074266128,
          67108864: 1073741840,
          83886080: 1074282496,
          100663296: 1073758208,
          117440512: 16,
          134217728: 540672,
          150994944: 1073758224,
          167772160: 1073741824,
          184549376: 540688,
          201326592: 524304,
          218103808: 0,
          234881024: 16400,
          251658240: 1074266112,
          8388608: 1073758208,
          25165824: 540688,
          41943040: 16,
          58720256: 1073758224,
          75497472: 1074282512,
          92274688: 1073741824,
          109051904: 524288,
          125829120: 1074266128,
          142606336: 524304,
          159383552: 0,
          176160768: 16384,
          192937984: 1074266112,
          209715200: 1073741840,
          226492416: 540672,
          243269632: 1074282496,
          260046848: 16400,
          268435456: 0,
          285212672: 1074266128,
          301989888: 1073758224,
          318767104: 1074282496,
          335544320: 1074266112,
          352321536: 16,
          369098752: 540688,
          385875968: 16384,
          402653184: 16400,
          419430400: 524288,
          436207616: 524304,
          452984832: 1073741840,
          469762048: 540672,
          486539264: 1073758208,
          503316480: 1073741824,
          520093696: 1074282512,
          276824064: 540688,
          293601280: 524288,
          310378496: 1074266112,
          327155712: 16384,
          343932928: 1073758208,
          360710144: 1074282512,
          377487360: 16,
          394264576: 1073741824,
          411041792: 1074282496,
          427819008: 1073741840,
          444596224: 1073758224,
          461373440: 524304,
          478150656: 0,
          494927872: 16400,
          511705088: 1074266128,
          528482304: 540672
        }, {
          0: 260,
          1048576: 0,
          2097152: 67109120,
          3145728: 65796,
          4194304: 65540,
          5242880: 67108868,
          6291456: 67174660,
          7340032: 67174400,
          8388608: 67108864,
          9437184: 67174656,
          10485760: 65792,
          11534336: 67174404,
          12582912: 67109124,
          13631488: 65536,
          14680064: 4,
          15728640: 256,
          524288: 67174656,
          1572864: 67174404,
          2621440: 0,
          3670016: 67109120,
          4718592: 67108868,
          5767168: 65536,
          6815744: 65540,
          7864320: 260,
          8912896: 4,
          9961472: 256,
          11010048: 67174400,
          12058624: 65796,
          13107200: 65792,
          14155776: 67109124,
          15204352: 67174660,
          16252928: 67108864,
          16777216: 67174656,
          17825792: 65540,
          18874368: 65536,
          19922944: 67109120,
          20971520: 256,
          22020096: 67174660,
          23068672: 67108868,
          24117248: 0,
          25165824: 67109124,
          26214400: 67108864,
          27262976: 4,
          28311552: 65792,
          29360128: 67174400,
          30408704: 260,
          31457280: 65796,
          32505856: 67174404,
          17301504: 67108864,
          18350080: 260,
          19398656: 67174656,
          20447232: 0,
          21495808: 65540,
          22544384: 67109120,
          23592960: 256,
          24641536: 67174404,
          25690112: 65536,
          26738688: 67174660,
          27787264: 65796,
          28835840: 67108868,
          29884416: 67109124,
          30932992: 67174400,
          31981568: 4,
          33030144: 65792
        }, {
          0: 2151682048,
          65536: 2147487808,
          131072: 4198464,
          196608: 2151677952,
          262144: 0,
          327680: 4198400,
          393216: 2147483712,
          458752: 4194368,
          524288: 2147483648,
          589824: 4194304,
          655360: 64,
          720896: 2147487744,
          786432: 2151678016,
          851968: 4160,
          917504: 4096,
          983040: 2151682112,
          32768: 2147487808,
          98304: 64,
          163840: 2151678016,
          229376: 2147487744,
          294912: 4198400,
          360448: 2151682112,
          425984: 0,
          491520: 2151677952,
          557056: 4096,
          622592: 2151682048,
          688128: 4194304,
          753664: 4160,
          819200: 2147483648,
          884736: 4194368,
          950272: 4198464,
          1015808: 2147483712,
          1048576: 4194368,
          1114112: 4198400,
          1179648: 2147483712,
          1245184: 0,
          1310720: 4160,
          1376256: 2151678016,
          1441792: 2151682048,
          1507328: 2147487808,
          1572864: 2151682112,
          1638400: 2147483648,
          1703936: 2151677952,
          1769472: 4198464,
          1835008: 2147487744,
          1900544: 4194304,
          1966080: 64,
          2031616: 4096,
          1081344: 2151677952,
          1146880: 2151682112,
          1212416: 0,
          1277952: 4198400,
          1343488: 4194368,
          1409024: 2147483648,
          1474560: 2147487808,
          1540096: 64,
          1605632: 2147483712,
          1671168: 4096,
          1736704: 2147487744,
          1802240: 2151678016,
          1867776: 4160,
          1933312: 2151682048,
          1998848: 4194304,
          2064384: 4198464
        }, {
          0: 128,
          4096: 17039360,
          8192: 262144,
          12288: 536870912,
          16384: 537133184,
          20480: 16777344,
          24576: 553648256,
          28672: 262272,
          32768: 16777216,
          36864: 537133056,
          40960: 536871040,
          45056: 553910400,
          49152: 553910272,
          53248: 0,
          57344: 17039488,
          61440: 553648128,
          2048: 17039488,
          6144: 553648256,
          10240: 128,
          14336: 17039360,
          18432: 262144,
          22528: 537133184,
          26624: 553910272,
          30720: 536870912,
          34816: 537133056,
          38912: 0,
          43008: 553910400,
          47104: 16777344,
          51200: 536871040,
          55296: 553648128,
          59392: 16777216,
          63488: 262272,
          65536: 262144,
          69632: 128,
          73728: 536870912,
          77824: 553648256,
          81920: 16777344,
          86016: 553910272,
          90112: 537133184,
          94208: 16777216,
          98304: 553910400,
          102400: 553648128,
          106496: 17039360,
          110592: 537133056,
          114688: 262272,
          118784: 536871040,
          122880: 0,
          126976: 17039488,
          67584: 553648256,
          71680: 16777216,
          75776: 17039360,
          79872: 537133184,
          83968: 536870912,
          88064: 17039488,
          92160: 128,
          96256: 553910272,
          100352: 262272,
          104448: 553910400,
          108544: 0,
          112640: 553648128,
          116736: 16777344,
          120832: 262144,
          124928: 537133056,
          129024: 536871040
        }, {
          0: 268435464,
          256: 8192,
          512: 270532608,
          768: 270540808,
          1024: 268443648,
          1280: 2097152,
          1536: 2097160,
          1792: 268435456,
          2048: 0,
          2304: 268443656,
          2560: 2105344,
          2816: 8,
          3072: 270532616,
          3328: 2105352,
          3584: 8200,
          3840: 270540800,
          128: 270532608,
          384: 270540808,
          640: 8,
          896: 2097152,
          1152: 2105352,
          1408: 268435464,
          1664: 268443648,
          1920: 8200,
          2176: 2097160,
          2432: 8192,
          2688: 268443656,
          2944: 270532616,
          3200: 0,
          3456: 270540800,
          3712: 2105344,
          3968: 268435456,
          4096: 268443648,
          4352: 270532616,
          4608: 270540808,
          4864: 8200,
          5120: 2097152,
          5376: 268435456,
          5632: 268435464,
          5888: 2105344,
          6144: 2105352,
          6400: 0,
          6656: 8,
          6912: 270532608,
          7168: 8192,
          7424: 268443656,
          7680: 270540800,
          7936: 2097160,
          4224: 8,
          4480: 2105344,
          4736: 2097152,
          4992: 268435464,
          5248: 268443648,
          5504: 8200,
          5760: 270540808,
          6016: 270532608,
          6272: 270540800,
          6528: 270532616,
          6784: 8192,
          7040: 2105352,
          7296: 2097160,
          7552: 0,
          7808: 268435456,
          8064: 268443656
        }, {
          0: 1048576,
          16: 33555457,
          32: 1024,
          48: 1049601,
          64: 34604033,
          80: 0,
          96: 1,
          112: 34603009,
          128: 33555456,
          144: 1048577,
          160: 33554433,
          176: 34604032,
          192: 34603008,
          208: 1025,
          224: 1049600,
          240: 33554432,
          8: 34603009,
          24: 0,
          40: 33555457,
          56: 34604032,
          72: 1048576,
          88: 33554433,
          104: 33554432,
          120: 1025,
          136: 1049601,
          152: 33555456,
          168: 34603008,
          184: 1048577,
          200: 1024,
          216: 34604033,
          232: 1,
          248: 1049600,
          256: 33554432,
          272: 1048576,
          288: 33555457,
          304: 34603009,
          320: 1048577,
          336: 33555456,
          352: 34604032,
          368: 1049601,
          384: 1025,
          400: 34604033,
          416: 1049600,
          432: 1,
          448: 0,
          464: 34603008,
          480: 33554433,
          496: 1024,
          264: 1049600,
          280: 33555457,
          296: 34603009,
          312: 1,
          328: 33554432,
          344: 1048576,
          360: 1025,
          376: 34604032,
          392: 33554433,
          408: 34603008,
          424: 0,
          440: 34604033,
          456: 1049601,
          472: 1024,
          488: 33555456,
          504: 1048577
        }, {
          0: 134219808,
          1: 131072,
          2: 134217728,
          3: 32,
          4: 131104,
          5: 134350880,
          6: 134350848,
          7: 2048,
          8: 134348800,
          9: 134219776,
          10: 133120,
          11: 134348832,
          12: 2080,
          13: 0,
          14: 134217760,
          15: 133152,
          2147483648: 2048,
          2147483649: 134350880,
          2147483650: 134219808,
          2147483651: 134217728,
          2147483652: 134348800,
          2147483653: 133120,
          2147483654: 133152,
          2147483655: 32,
          2147483656: 134217760,
          2147483657: 2080,
          2147483658: 131104,
          2147483659: 134350848,
          2147483660: 0,
          2147483661: 134348832,
          2147483662: 134219776,
          2147483663: 131072,
          16: 133152,
          17: 134350848,
          18: 32,
          19: 2048,
          20: 134219776,
          21: 134217760,
          22: 134348832,
          23: 131072,
          24: 0,
          25: 131104,
          26: 134348800,
          27: 134219808,
          28: 134350880,
          29: 133120,
          30: 2080,
          31: 134217728,
          2147483664: 131072,
          2147483665: 2048,
          2147483666: 134348832,
          2147483667: 133152,
          2147483668: 32,
          2147483669: 134348800,
          2147483670: 134217728,
          2147483671: 134219808,
          2147483672: 134350880,
          2147483673: 134217760,
          2147483674: 134219776,
          2147483675: 0,
          2147483676: 133120,
          2147483677: 2080,
          2147483678: 131104,
          2147483679: 134350848
        }];
        var j = [4160749569, 528482304, 33030144, 2064384, 129024, 8064, 504, 2147483679];
        var i = e.DES = d.extend({
          _doReset: function () {
            var a = this._key;
            var b = a.words;
            var c = [];
            for (var d = 0; d < 56; d++) {
              var e = r[d] - 1;
              c[d] = b[e >>> 5] >>> 31 - e % 32 & 1;
            }
            var i = this._subKeys = [];
            for (var j = 0; j < 16; j++) {
              var k = i[j] = [];
              var p = h[j];
              for (var d = 0; d < 24; d++) {
                k[d / 6 | 0] |= c[(g[d] - 1 + p) % 28] << 31 - d % 6;
                k[4 + (d / 6 | 0)] |= c[28 + (g[d + 24] - 1 + p) % 28] << 31 - d % 6;
              }
              k[0] = k[0] << 1 | k[0] >>> 31;
              for (var d = 1; d < 7; d++) {
                k[d] = k[d] >>> (d - 1) * 4 + 3;
              }
              k[7] = k[7] << 5 | k[7] >>> 27;
            }
            var q = this._invSubKeys = [];
            for (var d = 0; d < 16; d++) {
              q[d] = i[15 - d];
            }
          },
          encryptBlock: function (b, a) {
            this._doCryptBlock(b, a, this._subKeys);
          },
          decryptBlock: function (b, a) {
            this._doCryptBlock(b, a, this._invSubKeys);
          },
          _doCryptBlock: function (b, a, c) {
            this._lBlock = b[a];
            this._rBlock = b[a + 1];
            k.call(this, 4, 252645135);
            k.call(this, 16, 65535);
            l.call(this, 2, 858993459);
            l.call(this, 8, 16711935);
            k.call(this, 1, 1431655765);
            for (var d = 0; d < 16; d++) {
              var e = c[d];
              var n = this._lBlock;
              var o = this._rBlock;
              var q = 0;
              for (var r = 0; r < 8; r++) {
                q |= f[r][((o ^ e[r]) & j[r]) >>> 0];
              }
              this._lBlock = o;
              this._rBlock = n ^ q;
            }
            var s = this._lBlock;
            this._lBlock = this._rBlock;
            this._rBlock = s;
            k.call(this, 1, 1431655765);
            l.call(this, 8, 16711935);
            l.call(this, 2, 858993459);
            k.call(this, 16, 65535);
            k.call(this, 4, 252645135);
            b[a] = this._lBlock;
            b[a + 1] = this._rBlock;
          },
          keySize: 2,
          ivSize: 2,
          blockSize: 2
        });
        function k(b, a) {
          var c = (this._lBlock >>> b ^ this._rBlock) & a;
          this._rBlock ^= c;
          this._lBlock ^= c << b;
        }
        function l(b, a) {
          var c = (this._rBlock >>> b ^ this._lBlock) & a;
          this._lBlock ^= c;
          this._rBlock ^= c << b;
        }
        a.DES = d._createHelper(i);
        var m = e.TripleDES = d.extend({
          _doReset: function () {
            var a = this._key;
            var b = a.words;
            this._des1 = i.createEncryptor(q.create(b.slice(0, 2)));
            this._des2 = i.createEncryptor(q.create(b.slice(2, 4)));
            this._des3 = i.createEncryptor(q.create(b.slice(4, 6)));
          },
          encryptBlock: function (b, a) {
            this._des1.encryptBlock(b, a);
            this._des2.decryptBlock(b, a);
            this._des3.encryptBlock(b, a);
          },
          decryptBlock: function (b, a) {
            this._des3.decryptBlock(b, a);
            this._des2.encryptBlock(b, a);
            this._des1.decryptBlock(b, a);
          },
          keySize: 6,
          ivSize: 2,
          blockSize: 2
        });
        a.TripleDES = d._createHelper(m);
      })();
      return b.TripleDES;
    });
  }
});
var vh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/rc4.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), ha(), Yf(), nh(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.StreamCipher;
        var e = a.algo;
        var f = e.RC4 = d.extend({
          _doReset: function () {
            var a = this._key;
            var b = a.words;
            var c = a.sigBytes;
            var d = this._S = [];
            for (var e = 0; e < 256; e++) {
              d[e] = e;
            }
            for (var e = 0, f = 0; e < 256; e++) {
              var l = e % c;
              var m = b[l >>> 2] >>> 24 - l % 4 * 8 & 255;
              f = (f + d[e] + m) % 256;
              var n = d[e];
              d[e] = d[f];
              d[f] = n;
            }
            this._i = this._j = 0;
          },
          _doProcessBlock: function (b, a) {
            b[a] ^= g.call(this);
          },
          keySize: 8,
          ivSize: 0
        });
        function g() {
          var g = this._S;
          var a = this._i;
          var h = this._j;
          var i = 0;
          for (var j = 0; j < 4; j++) {
            a = (a + 1) % 256;
            h = (h + g[a]) % 256;
            var k = g[a];
            g[a] = g[h];
            g[h] = k;
            i |= g[(g[a] + g[h]) % 256] << 24 - j * 8;
          }
          this._i = a;
          this._j = h;
          return i;
        }
        a.RC4 = d._createHelper(f);
        var h = e.RC4Drop = f.extend({
          cfg: f.cfg.extend({
            drop: 192
          }),
          _doReset: function () {
            f._doReset.call(this);
            for (var a = this.cfg.drop; a > 0; a--) {
              g.call(this);
            }
          }
        });
        a.RC4Drop = d._createHelper(h);
      })();
      return b.RC4;
    });
  }
});
var _h = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/rabbit.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), ha(), Yf(), nh(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.StreamCipher;
        var e = a.algo;
        var l = [];
        var m = [];
        var h = [];
        var f = e.Rabbit = d.extend({
          _doReset: function () {
            var a = this._key.words;
            var b = this.cfg.iv;
            for (var c = 0; c < 4; c++) {
              a[c] = (a[c] << 8 | a[c] >>> 24) & 16711935 | (a[c] << 24 | a[c] >>> 8) & 4278255360;
            }
            var d = this._X = [a[0], a[3] << 16 | a[2] >>> 16, a[1], a[0] << 16 | a[3] >>> 16, a[2], a[1] << 16 | a[0] >>> 16, a[3], a[2] << 16 | a[1] >>> 16];
            var f = this._C = [a[2] << 16 | a[2] >>> 16, a[0] & 4294901760 | a[1] & 65535, a[3] << 16 | a[3] >>> 16, a[1] & 4294901760 | a[2] & 65535, a[0] << 16 | a[0] >>> 16, a[2] & 4294901760 | a[3] & 65535, a[1] << 16 | a[1] >>> 16, a[3] & 4294901760 | a[0] & 65535];
            this._b = 0;
            for (var c = 0; c < 4; c++) {
              g.call(this);
            }
            for (var c = 0; c < 8; c++) {
              f[c] ^= d[c + 4 & 7];
            }
            if (b) {
              var k = b.words;
              var h = k[0];
              var i = k[1];
              var j = (h << 8 | h >>> 24) & 16711935 | (h << 24 | h >>> 8) & 4278255360;
              var l = (i << 8 | i >>> 24) & 16711935 | (i << 24 | i >>> 8) & 4278255360;
              var m = j >>> 16 | l & 4294901760;
              var n = l << 16 | j & 65535;
              f[0] ^= j;
              f[1] ^= m;
              f[2] ^= l;
              f[3] ^= n;
              f[4] ^= j;
              f[5] ^= m;
              f[6] ^= l;
              f[7] ^= n;
              for (var c = 0; c < 4; c++) {
                g.call(this);
              }
            }
          },
          _doProcessBlock: function (b, a) {
            var c = this._X;
            g.call(this);
            l[0] = c[0] ^ c[5] >>> 16 ^ c[3] << 16;
            l[1] = c[2] ^ c[7] >>> 16 ^ c[5] << 16;
            l[2] = c[4] ^ c[1] >>> 16 ^ c[7] << 16;
            l[3] = c[6] ^ c[3] >>> 16 ^ c[1] << 16;
            for (var d = 0; d < 4; d++) {
              l[d] = (l[d] << 8 | l[d] >>> 24) & 16711935 | (l[d] << 24 | l[d] >>> 8) & 4278255360;
              b[a + d] ^= l[d];
            }
          },
          blockSize: 4,
          ivSize: 2
        });
        function g() {
          var i = this._X;
          var a = this._C;
          for (var b = 0; b < 8; b++) {
            m[b] = a[b];
          }
          a[0] = a[0] + 1295307597 + this._b | 0;
          a[1] = a[1] + 3545052371 + (a[0] >>> 0 < m[0] >>> 0 ? 1 : 0) | 0;
          a[2] = a[2] + 886263092 + (a[1] >>> 0 < m[1] >>> 0 ? 1 : 0) | 0;
          a[3] = a[3] + 1295307597 + (a[2] >>> 0 < m[2] >>> 0 ? 1 : 0) | 0;
          a[4] = a[4] + 3545052371 + (a[3] >>> 0 < m[3] >>> 0 ? 1 : 0) | 0;
          a[5] = a[5] + 886263092 + (a[4] >>> 0 < m[4] >>> 0 ? 1 : 0) | 0;
          a[6] = a[6] + 1295307597 + (a[5] >>> 0 < m[5] >>> 0 ? 1 : 0) | 0;
          a[7] = a[7] + 3545052371 + (a[6] >>> 0 < m[6] >>> 0 ? 1 : 0) | 0;
          this._b = a[7] >>> 0 < m[7] >>> 0 ? 1 : 0;
          for (var b = 0; b < 8; b++) {
            var k = i[b] + a[b];
            var l = k & 65535;
            var n = k >>> 16;
            var o = ((l * l >>> 17) + l * n >>> 15) + n * n;
            var p = ((k & 4294901760) * k | 0) + ((k & 65535) * k | 0);
            h[b] = o ^ p;
          }
          i[0] = h[0] + (h[7] << 16 | h[7] >>> 16) + (h[6] << 16 | h[6] >>> 16) | 0;
          i[1] = h[1] + (h[0] << 8 | h[0] >>> 24) + h[7] | 0;
          i[2] = h[2] + (h[1] << 16 | h[1] >>> 16) + (h[0] << 16 | h[0] >>> 16) | 0;
          i[3] = h[3] + (h[2] << 8 | h[2] >>> 24) + h[1] | 0;
          i[4] = h[4] + (h[3] << 16 | h[3] >>> 16) + (h[2] << 16 | h[2] >>> 16) | 0;
          i[5] = h[5] + (h[4] << 8 | h[4] >>> 24) + h[3] | 0;
          i[6] = h[6] + (h[5] << 16 | h[5] >>> 16) + (h[4] << 16 | h[4] >>> 16) | 0;
          i[7] = h[7] + (h[6] << 8 | h[6] >>> 24) + h[5] | 0;
        }
        a.Rabbit = d._createHelper(f);
      })();
      return b.Rabbit;
    });
  }
});
var ph = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/rabbit-legacy.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), ha(), Yf(), nh(), Zm());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], b);
      } else {
        b(a.CryptoJS);
      }
    })(f, function (b) {
      (function () {
        var a = b;
        var c = a.lib;
        var d = c.StreamCipher;
        var e = a.algo;
        var f = [];
        var l = [];
        var h = [];
        var g = e.RabbitLegacy = d.extend({
          _doReset: function () {
            var a = this._key.words;
            var b = this.cfg.iv;
            var c = this._X = [a[0], a[3] << 16 | a[2] >>> 16, a[1], a[0] << 16 | a[3] >>> 16, a[2], a[1] << 16 | a[0] >>> 16, a[3], a[2] << 16 | a[1] >>> 16];
            var d = this._C = [a[2] << 16 | a[2] >>> 16, a[0] & 4294901760 | a[1] & 65535, a[3] << 16 | a[3] >>> 16, a[1] & 4294901760 | a[2] & 65535, a[0] << 16 | a[0] >>> 16, a[2] & 4294901760 | a[3] & 65535, a[1] << 16 | a[1] >>> 16, a[3] & 4294901760 | a[0] & 65535];
            this._b = 0;
            for (var e = 0; e < 4; e++) {
              i.call(this);
            }
            for (var e = 0; e < 8; e++) {
              d[e] ^= c[e + 4 & 7];
            }
            if (b) {
              var f = b.words;
              var h = f[0];
              var k = f[1];
              var j = (h << 8 | h >>> 24) & 16711935 | (h << 24 | h >>> 8) & 4278255360;
              var l = (k << 8 | k >>> 24) & 16711935 | (k << 24 | k >>> 8) & 4278255360;
              var m = j >>> 16 | l & 4294901760;
              var n = l << 16 | j & 65535;
              d[0] ^= j;
              d[1] ^= m;
              d[2] ^= l;
              d[3] ^= n;
              d[4] ^= j;
              d[5] ^= m;
              d[6] ^= l;
              d[7] ^= n;
              for (var e = 0; e < 4; e++) {
                i.call(this);
              }
            }
          },
          _doProcessBlock: function (e, a) {
            var b = this._X;
            i.call(this);
            f[0] = b[0] ^ b[5] >>> 16 ^ b[3] << 16;
            f[1] = b[2] ^ b[7] >>> 16 ^ b[5] << 16;
            f[2] = b[4] ^ b[1] >>> 16 ^ b[7] << 16;
            f[3] = b[6] ^ b[3] >>> 16 ^ b[1] << 16;
            for (var c = 0; c < 4; c++) {
              f[c] = (f[c] << 8 | f[c] >>> 24) & 16711935 | (f[c] << 24 | f[c] >>> 8) & 4278255360;
              e[a + c] ^= f[c];
            }
          },
          blockSize: 4,
          ivSize: 2
        });
        function i() {
          var i = this._X;
          var a = this._C;
          for (var b = 0; b < 8; b++) {
            l[b] = a[b];
          }
          a[0] = a[0] + 1295307597 + this._b | 0;
          a[1] = a[1] + 3545052371 + (a[0] >>> 0 < l[0] >>> 0 ? 1 : 0) | 0;
          a[2] = a[2] + 886263092 + (a[1] >>> 0 < l[1] >>> 0 ? 1 : 0) | 0;
          a[3] = a[3] + 1295307597 + (a[2] >>> 0 < l[2] >>> 0 ? 1 : 0) | 0;
          a[4] = a[4] + 3545052371 + (a[3] >>> 0 < l[3] >>> 0 ? 1 : 0) | 0;
          a[5] = a[5] + 886263092 + (a[4] >>> 0 < l[4] >>> 0 ? 1 : 0) | 0;
          a[6] = a[6] + 1295307597 + (a[5] >>> 0 < l[5] >>> 0 ? 1 : 0) | 0;
          a[7] = a[7] + 3545052371 + (a[6] >>> 0 < l[6] >>> 0 ? 1 : 0) | 0;
          this._b = a[7] >>> 0 < l[7] >>> 0 ? 1 : 0;
          for (var b = 0; b < 8; b++) {
            var k = i[b] + a[b];
            var m = k & 65535;
            var n = k >>> 16;
            var o = ((m * m >>> 17) + m * n >>> 15) + n * n;
            var p = ((k & 4294901760) * k | 0) + ((k & 65535) * k | 0);
            h[b] = o ^ p;
          }
          i[0] = h[0] + (h[7] << 16 | h[7] >>> 16) + (h[6] << 16 | h[6] >>> 16) | 0;
          i[1] = h[1] + (h[0] << 8 | h[0] >>> 24) + h[7] | 0;
          i[2] = h[2] + (h[1] << 16 | h[1] >>> 16) + (h[0] << 16 | h[0] >>> 16) | 0;
          i[3] = h[3] + (h[2] << 8 | h[2] >>> 24) + h[1] | 0;
          i[4] = h[4] + (h[3] << 16 | h[3] >>> 16) + (h[2] << 16 | h[2] >>> 16) | 0;
          i[5] = h[5] + (h[4] << 8 | h[4] >>> 24) + h[3] | 0;
          i[6] = h[6] + (h[5] << 16 | h[5] >>> 16) + (h[4] << 16 | h[4] >>> 16) | 0;
          i[7] = h[7] + (h[6] << 8 | h[6] >>> 24) + h[5] | 0;
        }
        a.RabbitLegacy = d._createHelper(g);
      })();
      return b.RabbitLegacy;
    });
  }
});
var gh = vc({
  "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/index.js"(f, c) {
    (function (a, b, d) {
      if (typeof f == "object") {
        c.exports = f = b(ke(), Vm(), ve(), Ee(), ha(), Yf(), Jf(), Wm(), Xm(), Ym(), _c(), Qf(), pc(), eh(), th(), nh(), Zm(), rh(), $m(), We(), ih(), ah(), sh(), oh(), lh(), ch(), uh(), dh(), fh(), hh(), vh(), _h(), ph());
      } else if (typeof define == "function" && define.amd) {
        define(["./core", "./x64-core", "./lib-typedarrays", "./enc-utf16", "./enc-base64", "./md5", "./sha1", "./sha256", "./sha224", "./sha512", "./sha384", "./sha3", "./ripemd160", "./hmac", "./pbkdf2", "./evpkdf", "./cipher-core", "./mode-cfb", "./mode-ctr", "./mode-ctr-gladman", "./mode-ofb", "./mode-ecb", "./pad-ansix923", "./pad-iso10126", "./pad-iso97971", "./pad-zeropadding", "./pad-nopadding", "./format-hex", "./aes", "./tripledes", "./rc4", "./rabbit", "./rabbit-legacy"], b);
      } else {
        a.CryptoJS = b(a.CryptoJS);
      }
    })(f, function (b) {
      return b;
    });
  }
});
var mh;
var yh;
var wh;
var Wi;
var Vi;
var qi = class {
  constructor(c, a) {
    Xf(this, Wi);
    Xf(this, mh, undefined);
    Xf(this, yh, undefined);
    Xf(this, wh, undefined);
    Um(this, mh, c);
    Um(this, yh, a);
    Um(this, wh, typeof GetParentResourceName != "function");
  }
  async get(d, a, b = undefined) {
    if (b === undefined) b = {};
    return de(this, Wi, Vi).call(this, d, "GET", undefined, a, b);
  }
  async post(e, a = undefined, f, c = undefined) {
    if (a === undefined) a = {};
    if (c === undefined) c = {};
    return de(this, Wi, Vi).call(this, e, "POST", a, f, c);
  }
  async delete(e, a = undefined, f, c = undefined) {
    if (a === undefined) a = {};
    if (c === undefined) c = {};
    return de(this, Wi, Vi).call(this, e, "DELETE", a, f, c);
  }
  async patch(e, a = undefined, f, c = undefined) {
    if (a === undefined) a = {};
    if (c === undefined) c = {};
    return de(this, Wi, Vi).call(this, e, "PUT", a, f, c);
  }
  async put(e, a = undefined, f, c = undefined) {
    if (a === undefined) a = {};
    if (c === undefined) c = {};
    return de(this, Wi, Vi).call(this, e, "PUT", a, f, c);
  }
};
mh = new WeakMap();
yh = new WeakMap();
wh = new WeakMap();
Wi = new WeakSet();
Vi = async function (f, a, b, c, d = undefined) {
  if (d === undefined) d = {};
  if (Gf(this, wh)) {
    if (d.delay) {
      await new Promise(b => setTimeout(b, d.delay));
    }
    return [true, {
      status: 200,
      data: d.mockupData ?? null
    }];
  }
  try {
    const d = await fetch("" + Gf(this, mh) + f, {
      ...c,
      method: a,
      body: b ? JSON.stringify(b) : undefined,
      headers: {
        ...Gf(this, yh),
        ...(c?.headers || {})
      }
    });
    const e = await d.json();
    return [true, {
      status: d.status,
      data: e
    }];
  } catch (b) {
    return [false, {
      code: b.code,
      message: b.message
    }];
  }
};
var _m;
var bn = Ce(gh());
var xh = {
  warning: 1,
  log: 2,
  error: 3,
  debug: 4
};
var bh = typeof GetConvar == "function" ? GetConvar(GetCurrentResourceName() + "_logLevel", "") : "";
var cn = typeof GetConvar == "function" ? GetConvar("sv_loglevel", "warning") : "warning";
cn = bh?.length > 0 ? bh : cn;
(() => {
  if (!xh[cn]) {
    throw new Error("Invalid log level: " + cn);
  }
})();
var dn = () => xh[cn] >= xh.warning;
var Da = () => xh[cn] >= xh.log;
var an = () => xh[cn] >= xh.error;
var Ch = () => cn === "debug";
var kh = {
  warning: (c, ...a) => {
    if (dn()) {
      console.log("^3[WARNING] ^7" + c, ...a, "^0");
    }
  },
  log: (c, ...a) => {
    if (Da()) {
      console.log("^5[KarmaDevelopments] ^7" + c, ...a, "^0");
    }
  },
  debug: (c, ...a) => {
    if (Ch()) {
      console.log("^2[D] " + c, ...a, "^0");
    }
  },
  error: (c, ...a) => {
    if (an()) {
      console.log("^1[ERROR] " + c, ...a, "^0");
    }
  }
};
var Eh = (b = 128) => bn.lib.WordArray.random(b / 8).toString();
var Sh = (c, a) => typeof c != "string" || typeof a != "string" ? "" : bn.AES.encrypt(c, a).toString();
var Ge = (c, a) => typeof c != "string" || typeof a != "string" ? "" : bn.AES.decrypt(c, a).toString(bn.enc.Utf8);
var en = b => typeof b != "string" ? "" : bn.enc.Base64.stringify(bn.enc.Utf8.parse(b));
var Ah = b => typeof b != "string" ? "" : bn.enc.Utf8.stringify(bn.enc.Base64.parse(b));
var $h = (c, a) => en((0, bn.HmacMD5)(c, a).toString());
var Th = {};
var Bh = (c, a = undefined) => {
  if (a === undefined) a = Eh();
  if (Th[c] === undefined) {
    Th[c] = $h(c, a);
  }
  return Th[c];
};
var Ih = (c, a = undefined) => {
  if (a === undefined) a = Eh();
  try {
    return Sh(JSON.stringify(c), a);
  } catch {
    kh.error("Failed to encode payload");
  }
};
var La = (c, a = undefined) => {
  if (a === undefined) a = Eh();
  try {
    return JSON.parse(Ge(c, a));
  } catch {
    kh.error("Failed to decode payload");
  }
};
var gc = {};
qf(gc, {
  MathUtils: () => zh
});
var mc;
var Dh;
var yc = class e {
  constructor(d, a, b) {
    Xf(this, mc);
    const c = de(this, mc, Dh).call(this, d, a, b);
    this.x = c.x;
    this.y = c.y;
    this.z = c.z;
  }
  equals(d, a, b) {
    const c = de(this, mc, Dh).call(this, d, a, b);
    return this.x === c.x && this.y === c.y && this.z === c.z;
  }
  add(e, a, b, c) {
    let d = de(this, mc, Dh).call(this, e, a, b);
    this.x += c ? d.x * c : d.x;
    this.y += c ? d.y * c : d.y;
    this.z += c ? d.z * c : d.z;
    return this;
  }
  addScalar(b) {
    if (typeof b != "number") {
      throw new Error("Invalid scalar");
    }
    this.x += b;
    this.y += b;
    this.z += b;
    return this;
  }
  sub(f, a, b, c) {
    const d = de(this, mc, Dh).call(this, f, a, b);
    this.x -= c ? d.x * c : d.x;
    this.y -= c ? d.y * c : d.y;
    this.z -= c ? d.z * c : d.z;
    return this;
  }
  subScalar(b) {
    if (typeof b != "number") {
      throw new Error("Invalid scalar");
    }
    this.x -= b;
    this.y -= b;
    this.z -= b;
    return this;
  }
  multiply(d, a, b) {
    const c = de(this, mc, Dh).call(this, d, a, b);
    this.x *= c.x;
    this.y *= c.y;
    this.z *= c.z;
    return this;
  }
  multiplyScalar(b) {
    if (typeof b != "number") {
      throw new Error("Invalid scalar");
    }
    this.x *= b;
    this.y *= b;
    this.z *= b;
    return this;
  }
  divide(d, a, b) {
    const c = de(this, mc, Dh).call(this, d, a, b);
    this.x /= c.x;
    this.y /= c.y;
    this.z /= c.z;
    return this;
  }
  divideScalar(b) {
    if (typeof b != "number") {
      throw new Error("Invalid scalar");
    }
    this.x /= b;
    this.y /= b;
    this.z /= b;
    return this;
  }
  round() {
    this.x = Math.round(this.x);
    this.y = Math.round(this.y);
    this.z = Math.round(this.z);
    return this;
  }
  floor() {
    this.x = Math.floor(this.x);
    this.y = Math.floor(this.y);
    this.z = Math.floor(this.z);
    return this;
  }
  ceil() {
    this.x = Math.ceil(this.x);
    this.y = Math.ceil(this.y);
    this.z = Math.ceil(this.z);
    return this;
  }
  getCenter(b, a, c) {
    const d = de(this, mc, Dh).call(this, b, a, c);
    return new e((this.x + d.x) / 2, (this.y + d.y) / 2, (this.z + d.z) / 2);
  }
  getDistance(d, a, b) {
    const [c, e, f] = d instanceof Array ? d : typeof d == "object" ? [d.x, d.y, d.z] : [d, a, b];
    if (typeof c != "number" || typeof e != "number" || typeof f != "number") {
      throw new Error("Invalid vector coordinates");
    }
    const [g, h, i] = [this.x - c, this.y - e, this.z - f];
    return Math.sqrt(g * g + h * h + i * i);
  }
  toArray(b) {
    if (typeof b == "number") {
      return [parseFloat(this.x.toFixed(b)), parseFloat(this.y.toFixed(b)), parseFloat(this.z.toFixed(b))];
    } else {
      return [this.x, this.y, this.z];
    }
  }
  toJSON(b) {
    if (typeof b == "number") {
      return {
        x: parseFloat(this.x.toFixed(b)),
        y: parseFloat(this.y.toFixed(b)),
        z: parseFloat(this.z.toFixed(b))
      };
    } else {
      return {
        x: this.x,
        y: this.y,
        z: this.z
      };
    }
  }
  toString(b) {
    return JSON.stringify(this.toJSON(b));
  }
};
mc = new WeakSet();
Dh = function (d, a, b) {
  let c = {
    x: 0,
    y: 0,
    z: 0
  };
  if (d instanceof yc) {
    c = d;
  } else if (d instanceof Array) {
    c = {
      x: d[0],
      y: d[1],
      z: d[2]
    };
  } else if (typeof d == "object") {
    c = d;
  } else {
    c = {
      x: d,
      y: a,
      z: b
    };
  }
  if (typeof c.x != "number" || typeof c.y != "number" || typeof c.z != "number") {
    throw new Error("Invalid vector coordinates");
  }
  return c;
};
var fn = yc;
var jn = (d, a, b) => Math.min(Math.max(d, a), b);
var wc = (d, a, b) => a[0] + (b - d[0]) * (a[1] - a[0]) / (d[1] - d[0]);
var kn = ([g, a, b], [c, d, e]) => {
  const [f, h, i] = [g - c, a - d, b - e];
  return Math.sqrt(f * f + h * h + i * i);
};
var Lh = (c, a) => Math.floor(a ? Math.random() * (a - c + 1) + c : Math.random() * c);
var Oh = (d, a, b) => {
  if (d instanceof fn) {
    return d;
  }
  if (d instanceof Array) {
    return new fn(d);
  }
  if (typeof d == "object") {
    return new fn(d);
  }
  if (typeof d != "number" || typeof a != "number" || typeof b != "number") {
    throw new Error("Invalid vector coordinates");
  }
  return new fn(d, a, b);
};
var zh = {
  clamp: jn,
  getMapRange: wc,
  getDistance: kn,
  getRandomNumber: Lh,
  parseVector3: Oh
};
function Fh(e, a) {
  const b = "_";
  const c = Rh((a, b, ...c) => e(a, ...c), a);
  return {
    get: function (...d) {
      return c.get(b, ...d);
    },
    reset: function () {
      c.reset(b);
    }
  };
}
function Rh(g, a) {
  const c = a.timeToLive || 60000;
  const j = {};
  async function d(a, ...b) {
    let e = j[a];
    if (!e) {
      e = {
        value: null,
        lastUpdated: 0
      };
      j[a] = e;
    }
    const f = Date.now();
    if (e.lastUpdated === 0 || f - e.lastUpdated > c) {
      const [h, c] = await g(e, a, ...b);
      if (h) {
        e.lastUpdated = f;
        e.value = c;
      }
      return c;
    }
    return await new Promise(b => setTimeout(() => b(e.value), 0));
  }
  return {
    get: async function (c, ...a) {
      return await d(c, ...a);
    },
    reset: function (b) {
      const a = j[b];
      if (a) {
        a.lastUpdated = 0;
      }
    }
  };
}
function Nh() {
  if (typeof Pc.crypto == "object") {
    return nj();
  } else {
    return new Hf(4).toString();
  }
}
function Ph(b) {
  return ga(b, ga.URL);
}
function bc(d, a) {
  return new Promise((b, c) => {
    const e = Date.now();
    const f = setInterval(() => {
      const c = Date.now() - e > a;
      if (d() || c) {
        clearInterval(f);
        return b(c);
      }
    }, 1);
  });
}
function Mh(c) {
  return new Promise(a => setTimeout(() => a(), c));
}
function Uh() {
  return Mh(0);
}
({
  ...gc
});
var Hh;
var Cc;
var jh = class {
  constructor(b) {
    Xf(this, Hh, undefined);
    Xf(this, Cc, undefined);
    Um(this, Cc, b ?? 5);
    Um(this, Hh, new Map());
  }
  setTTL(b) {
    Um(this, Cc, b);
  }
  set(d, a, b) {
    Gf(this, Hh).set(d, {
      value: a,
      expiration: Date.now() + (b ?? Gf(this, Cc)) * 1000
    });
    return this;
  }
  get(c, a = false) {
    const b = Gf(this, Hh).get(c);
    const d = b ? a ? true : b.expiration > Date.now() : false;
    if (!b || !d) {
      if (b) {
        Gf(this, Hh).delete(c);
      }
      return;
    }
    return b.value;
  }
  has(c, a = false) {
    const b = Gf(this, Hh).get(c);
    const d = b ? a ? true : b.expiration > Date.now() : false;
    if (b && !d) {
      Gf(this, Hh).delete(c);
    }
    return d;
  }
  delete(b) {
    return Gf(this, Hh).delete(b);
  }
  clear() {
    Gf(this, Hh).clear();
  }
  values(b = false) {
    const a = [];
    const c = Date.now();
    for (const d of Gf(this, Hh).values()) {
      if (b || d.expiration > c) {
        a.push(d.value);
      }
    }
    return a;
  }
  keys(b = false) {
    const a = [];
    const c = Date.now();
    for (const [d, e] of Gf(this, Hh).entries()) {
      if (b || e.expiration > c) {
        a.push(d);
      }
    }
    return a;
  }
  entries(b = false) {
    const a = [];
    const c = Date.now();
    for (const [d, e] of Gf(this, Hh).entries()) {
      if (b || e.expiration > c) {
        a.push([d, e.value]);
      }
    }
    return a;
  }
};
Hh = new WeakMap();
Cc = new WeakMap();
var nn;
var on;
var Zh;
var qn;
var rn;
var oi;
var Ki;
var tn;
var un;
var bi;
var pn;
var vn;
var hn;
var Gi;
var wn;
var xn;
var Xi;
var Yi;
var yn;
var An;
var Bn = class {
  constructor() {
    Xf(this, pn);
    Xf(this, hn);
    Xf(this, wn);
    Xf(this, Xi);
    Xf(this, yn);
    Xf(this, nn, undefined);
    Xf(this, on, undefined);
    Xf(this, Zh, undefined);
    Xf(this, qn, undefined);
    Xf(this, rn, undefined);
    Xf(this, oi, undefined);
    Xf(this, Ki, undefined);
    Xf(this, tn, undefined);
    Xf(this, un, undefined);
    Xf(this, bi, undefined);
    Um(this, on, typeof GetParentResourceName != "function");
    Um(this, nn, Gf(this, on) ? window.crypto.randomUUID() : GetParentResourceName());
    Um(this, oi, false);
    Um(this, Ki, 0);
    Um(this, tn, []);
    Um(this, un, new Map());
    Um(this, bi, new Map());
    de(this, wn, xn).call(this, "__npx_sdk:init");
    de(this, pn, vn).call(this, "__npx_sdk:ready", de(this, yn, An).bind(this));
    window.addEventListener("message", async ({
      data: a
    }) => {
      const {
        event: b,
        args: c
      } = a;
      if (!b) {
        return;
      }
      const d = Gf(this, un).get(b);
      if (d) {
        d(...c);
      }
    });
  }
  async register(c, a) {
    de(this, hn, Gi).call(this, "__nui_req:" + c, async (b, d) => {
      let e;
      let f;
      const j = La(b, Gf(this, qn));
      if (!j?.id || !j?.resource) {
        return kh.error("[NUI] " + c + " - Invalid metadata received");
      }
      try {
        e = await a(...d);
        f = true;
      } catch (b) {
        e = b.message;
        f = false;
      }
      de(this, Xi, Yi).call(this, "__nui_res:" + j.resource, j.id, [f, e]);
    });
  }
  async execute(c, ...a) {
    const h = {
      id: ++J(this, Ki)._,
      resource: Gf(this, nn)
    };
    const b = a[a.length - 1];
    const d = typeof b == "object" && b?.mockupData;
    if (!Gf(this, on) && d) {
      a.splice(a.length - 1, 1);
    } else if (Gf(this, on) && d) {
      const c = b.delay ?? 0;
      if (c > 0) {
        await new Promise(a => setTimeout(a, c));
      }
      return b.mockupData ?? null;
    }
    const e = new Promise((a, b) => {
      let d;
      if (Gf(this, oi)) {
        d = +setTimeout(() => b(new Error("RPC timed out | " + c)), 60000);
      } else {
        d = 0;
      }
      Gf(this, bi).set(h.id, {
        resolve: a,
        reject: b,
        timeout: d
      });
    });
    e.finally(() => Gf(this, bi).delete(h.id));
    if (Gf(this, oi)) {
      de(this, Xi, Yi).call(this, "__nui_req:" + c, Ih(h, Gf(this, rn)), a);
    } else {
      Gf(this, tn).push({
        type: "execute",
        event: "__nui_req:" + c,
        metadata: h,
        args: a
      });
    }
    return e;
  }
};
nn = new WeakMap();
on = new WeakMap();
Zh = new WeakMap();
qn = new WeakMap();
rn = new WeakMap();
oi = new WeakMap();
Ki = new WeakMap();
tn = new WeakMap();
un = new WeakMap();
bi = new WeakMap();
pn = new WeakSet();
vn = function (c, a) {
  Gf(this, un).set(c, a);
};
hn = new WeakSet();
Gi = function (c, a) {
  if (Gf(this, oi)) {
    const b = Bh(c, Gf(this, Zh));
    return de(this, pn, vn).call(this, b, a);
  }
  Gf(this, tn).push({
    type: "on",
    event: c,
    callback: a
  });
};
wn = new WeakSet();
xn = function (c, ...a) {
  fetch("https://" + Gf(this, nn) + "/" + c, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8"
    },
    body: JSON.stringify({
      args: a
    })
  });
};
Xi = new WeakSet();
Yi = function (d, ...a) {
  if (Gf(this, oi)) {
    const b = Bh(d, Gf(this, Zh));
    return de(this, wn, xn).call(this, b, ...a);
  }
  Gf(this, tn).push({
    type: "emit",
    event: d,
    args: a
  });
};
yn = new WeakSet();
An = async function (b) {
  if (Gf(this, oi)) {
    return kh.error("[NUI] SDK already initialized");
  }
  const a = Ah(b);
  const c = a?.split(":").filter(b => b.length > 0);
  if (!c || c.length === 0) {
    return kh.error("SDK NUI handlers failed to initialize");
  }
  Um(this, Zh, c[0]);
  Um(this, qn, c[2]);
  Um(this, rn, c[1]);
  Um(this, oi, true);
  de(this, hn, Gi).call(this, "__nui_res:" + Gf(this, nn), (b, [a, c]) => {
    const d = Gf(this, bi).get(b);
    if (!d) {
      return kh.error("[NUI] Invalid response received");
    }
    clearTimeout(d.timeout);
    if (a) {
      d.resolve(c);
    } else {
      d.reject(c);
    }
  });
  kh.debug("[NUI] SDK initialized");
  for (const d of Gf(this, tn)) {
    if (d.type === "on") {
      de(this, hn, Gi).call(this, d.event, d.callback);
    } else if (d.type === "emit") {
      de(this, Xi, Yi).call(this, d.event, ...d.args);
    } else if (d.type === "execute") {
      const b = Gf(this, bi).get(d.metadata.id);
      if (!b) {
        kh.error("[RPC] " + d.event + " - Failed to execute queued RPC call");
        continue;
      }
      b.timeout = +setTimeout(() => b.reject(new Error("RPC timed out | " + d.event)), 60000);
      de(this, Xi, Yi).call(this, d.event, Ih(d.metadata, Gf(this, rn)), d.args);
    }
  }
};
var Cn = new Bn();
var kc;
var Dn;
var ye;
var Ue;
var ln = class {
  constructor() {
    Xf(this, ye);
    Xf(this, kc, undefined);
    Xf(this, Dn, undefined);
    Um(this, kc, {});
    Um(this, Dn, 10);
  }
  on(c, a) {
    Gf(this, kc)[c] ||= [];
    Gf(this, kc)[c].push(a);
    const b = Gf(this, kc)[c].length;
    if (b > Gf(this, Dn)) {
      de(this, ye, Ue).call(this, c, b);
    }
  }
  off(c, a) {
    const b = Gf(this, kc)[c];
    if (!b) {
      return;
    }
    const d = b.indexOf(a);
    if (d !== -1) {
      b.splice(d, 1);
    }
  }
  once(e, a) {
    const b = (...c) => {
      a(...c);
      this.off(e, b);
    };
    this.on(e, b);
  }
  emit(c, ...e) {
    const b = Gf(this, kc)[c];
    if (b) {
      for (const c of b) {
        try {
          c(...e);
        } catch (b) {
          console.error(b);
        }
      }
    }
  }
  addListener(c, a) {
    this.on(c, a);
  }
  prependListener(c, a) {
    Gf(this, kc)[c] ||= [];
    Gf(this, kc)[c].unshift(a);
    const b = Gf(this, kc)[c].length;
    if (b > Gf(this, Dn)) {
      de(this, ye, Ue).call(this, c, b);
    }
  }
  prependOnceListener(e, a) {
    const b = (...d) => {
      a(...d);
      this.off(e, b);
    };
    this.prependListener(e, b);
  }
  removeListener(c, a) {
    this.off(c, a);
  }
  removeAllListeners(b) {
    if (b) {
      delete Gf(this, kc)[b];
    } else {
      Um(this, kc, {});
    }
  }
  listenerCount(b) {
    const a = Gf(this, kc)[b];
    if (a) {
      return a.length;
    } else {
      return 0;
    }
  }
  getMaxListeners() {
    return Gf(this, Dn);
  }
  setMaxListeners(b) {
    Um(this, Dn, b);
  }
  rawListeners(b) {
    return Gf(this, kc)[b] || [];
  }
  eventNames() {
    return Object.keys(Gf(this, kc));
  }
};
kc = new WeakMap();
Dn = new WeakMap();
ye = new WeakSet();
Ue = function (c, a) {
  console.log("Possible EventEmitter memory leak detected. " + a + " listeners added. Use emitter.setMaxListeners() to increase limit");
  kh.debug("EventEmitter", "Event name: " + c + " | Listeners count: " + a);
};
var Ci = ["ACK", "HEARTBEAT"];
var En;
var Vh;
var pi;
var Fn;
var Gn;
var In;
var Jn;
var Kn;
var Ln;
var Nn;
var On;
var Mn;
var Pn;
var Ji;
var Qn;
var Ec;
var Rn;
var Sc;
var Sn;
var Ac;
var Tn;
var $c;
var Vn;
var Tc;
var Wn;
var Bc;
var Xn;
var Ic;
var Un;
var Yn = class {
  constructor() {
    Xf(this, Nn);
    Xf(this, Mn);
    Xf(this, Ji);
    Xf(this, Ec);
    Xf(this, Sc);
    Xf(this, Ac);
    Xf(this, $c);
    Xf(this, Tc);
    Xf(this, Bc);
    Xf(this, Ic);
    Xf(this, En, undefined);
    Xf(this, Vh, undefined);
    Xf(this, pi, undefined);
    Xf(this, Fn, undefined);
    Xf(this, Gn, undefined);
    Xf(this, In, undefined);
    Xf(this, Jn, undefined);
    Xf(this, Kn, undefined);
    Xf(this, Ln, undefined);
    Um(this, Gn, 0);
    Um(this, Fn, false);
    Um(this, In, new Map());
    Um(this, Jn, new ln());
  }
  async connect() {
    if (typeof GetParentResourceName != "function") {
      return de(this, Nn, On).call(this, "ws://localhost:5000", "dev");
    }
    const a = await Cn.execute("__npx_sdk:sockets:init");
    if (!a?.API_URL || !a?.API_KEY) {
      return false;
    } else {
      return de(this, Nn, On).call(this, a.API_URL, a.API_KEY);
    }
  }
  on(c, a) {
    if (!Ci.includes(c)) {
      Gf(this, Jn).on(c, a);
    }
  }
  once(c, a) {
    if (!Ci.includes(c)) {
      Gf(this, Jn).once(c, a);
    }
  }
  off(c, a) {
    if (!Ci.includes(c)) {
      Gf(this, Jn).off(c, a);
    }
  }
  emit(c, a) {
    var b;
    if (Ci.includes(c)) {
      return;
    }
    const f = de(this, Bc, Xn).call(this, {
      id: ++J(this, Gn)._,
      event: c,
      data: a
    });
    if ((b = Gf(this, pi)) != null) {
      b.send(f);
    }
  }
  execute(c, a) {
    var b;
    const h = {
      id: ++J(this, Gn)._,
      data: a
    };
    const e = new Promise(a => {
      const b = +setTimeout(() => a([false, "Request timed out | " + c]), 60000);
      Gf(this, In).set(h.id, {
        resolve: a,
        timeout: b
      });
    });
    e.finally(() => Gf(this, In).delete(h.id));
    const f = de(this, Bc, Xn).call(this, {
      event: c,
      data: h
    });
    if ((b = Gf(this, pi)) != null) {
      b.send(f);
    }
    return e;
  }
  register(c, d) {
    Gf(this, Jn).on(c, async b => {
      var a;
      let c;
      try {
        c = {
          success: true,
          data: await d(b.data)
        };
      } catch (b) {
        c = {
          success: false,
          data: b.message
        };
      }
      const g = de(this, Bc, Xn).call(this, {
        id: b.id,
        event: "ACK",
        data: c
      });
      if ((a = Gf(this, pi)) != null) {
        a.send(g);
      }
    });
  }
  onReconnect(b) {
    Um(this, Kn, b);
  }
  get isOnline() {
    var a;
    return ((a = Gf(this, pi)) == null ? undefined : a.readyState) === WebSocket.OPEN;
  }
};
En = new WeakMap();
Vh = new WeakMap();
pi = new WeakMap();
Fn = new WeakMap();
Gn = new WeakMap();
In = new WeakMap();
Jn = new WeakMap();
Kn = new WeakMap();
Ln = new WeakMap();
Nn = new WeakSet();
On = async function (c, a) {
  Um(this, Fn, false);
  Um(this, En, c);
  Um(this, Vh, a);
  Um(this, pi, new WebSocket(c + "?authorization=bearer%20" + a));
  Gf(this, pi).onopen = de(this, Ji, Qn).bind(this);
  Gf(this, pi).onerror = de(this, Ec, Rn).bind(this);
  Gf(this, pi).onclose = de(this, Sc, Sn).bind(this);
  Gf(this, pi).onmessage = de(this, Ac, Tn).bind(this);
  kh.debug("[NUI] SDK Sockets initialized");
  return new Promise(c => {
    let a = 0;
    clearInterval(Gf(this, Ln));
    Um(this, Ln, +setInterval(() => {
      if (++a > 100) {
        clearInterval(Gf(this, Ln));
        c(false);
        kh.error("[NUI] SDK Sockets failed to connect");
        return;
      }
      if (Gf(this, Fn)) {
        clearInterval(Gf(this, Ln));
        c(true);
      }
    }, 100));
  });
};
Mn = new WeakSet();
Pn = async function () {
  if (typeof Gf(this, En) != "string" || typeof Gf(this, Vh) != "string") {
    return;
  }
  kh.debug("[NUI] SDK Sockets reconnecting");
  if ((await de(this, Nn, On).call(this, Gf(this, En), Gf(this, Vh))) && Gf(this, Kn)) {
    Gf(this, Kn).call(this);
  }
};
Ji = new WeakSet();
Qn = function () {
  kh.debug("[NUI] SDK Sockets connected");
  Um(this, Fn, true);
};
Ec = new WeakSet();
Rn = function (b) {
  kh.error("[NUI] SDK Sockets error", b);
};
Sc = new WeakSet();
Sn = function (b) {
  kh.debug("[NUI] SDK Sockets closed");
  setTimeout(de(this, Mn, Pn).bind(this), 1500);
};
Ac = new WeakSet();
Tn = function (b) {
  const {
    event: a,
    data: e
  } = de(this, Ic, Un).call(this, b.data);
  if (a) {
    if (a === "HEARTBEAT") {
      de(this, $c, Vn).call(this);
    } else if (a === "ACK") {
      const {
        id: b,
        data: a
      } = e;
      de(this, Tc, Wn).call(this, b, a);
    } else {
      Gf(this, Jn).emit(a, e);
    }
  }
};
$c = new WeakSet();
Vn = function () {
  var a;
  const d = de(this, Bc, Xn).call(this, {
    event: "HEARTBEAT",
    data: "PONG"
  });
  if ((a = Gf(this, pi)) != null) {
    a.send(d);
  }
};
Tc = new WeakSet();
Wn = function (c, a) {
  const b = Gf(this, In).get(c);
  if (b) {
    clearTimeout(b.timeout);
    b.resolve([a.success, a.data]);
  }
};
Bc = new WeakSet();
Xn = function (b) {
  return JSON.stringify(b);
};
Ic = new WeakSet();
Un = function (b) {
  return JSON.parse(b);
};
Cn.register("__npx_sdk:sockets:register", async b => {
  Zn.register(b, a => Cn.execute("__npx_sdk:sockets:pipe:" + b, a));
});
Cn.register("__npx_sdk:sockets:execute", async (c, a) => Zn.execute(c, a));
var Zn = new Yn();
var Dc = {};
qf(Dc, {
  CreateInstance: () => qh,
  Game: () => _m
});
function qh(c, a) {
  return new qi(c, a);
}
var Lc = {};
qf(Lc, {
  Cache: () => jh,
  Vector3: () => fn
}); /*! Bundled license information:
    crypto-js/ripemd160.js:
    (** @preserve
    (c) 2012 by Cédric Mesnil. All rights reserved.
    Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
    - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    *)
    crypto-js/mode-ctr-gladman.js:
    (** @preserve
    * Counter block mode compatible with  Dr Brian Gladman fileenc.c
    * derived from CryptoJS.mode.CTR
    * Jan Hruby jhruby.web@gmail.com
    *)
    */
const Kh = "_App_qvehz_1";
const Gh = "_clothingMenu_qvehz_13";
const Xh = "_container_qvehz_17";
const Yh = {
  App: Kh,
  clothingMenu: Gh,
  container: Xh
};
const Jh = "_header_1vquv_1";
const Qh = "_title_1vquv_13";
const Oa = "_description_1vquv_23";
const $n = "_divider_1vquv_32";
const _n = "_line_1vquv_43";
const ao = {
  header: Jh,
  title: Qh,
  description: Oa,
  divider: $n,
  line: _n
};
const bo = mb("<div><div class=\"w-full flex flex-row justify-start items-center gap-[3vh]\"><svg width=\"4.9vh\" height=\"5.64vh\" viewBox=\"0 0 53 61\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M24.75 1.58771C25.8329 0.962498 27.1671 0.962499 28.25 1.58771L50.6638 14.5283C51.7467 15.1535 52.4138 16.309 52.4138 17.5594V43.4406C52.4138 44.691 51.7467 45.8465 50.6638 46.4717L28.25 59.4123C27.1671 60.0375 25.8329 60.0375 24.75 59.4123L2.33623 46.4717C1.25332 45.8465 0.586226 44.691 0.586226 43.4406V17.5594C0.586226 16.309 1.25332 15.1535 2.33623 14.5283L24.75 1.58771Z\" fill=\"url(#paint0_radial_0_1)\" fill-opacity=\"0.25\" stroke=\"url(#paint1_radial_0_1)\"></path><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M32.2405 18.0799C32.133 18.1316 31.9437 18.2809 31.8198 18.4117C31.0609 19.2127 30.7111 20.3265 30.623 22.2221C30.5864 23.0097 30.6267 23.2209 30.8593 23.4598C31.0674 23.6735 31.2892 23.7629 31.6115 23.7629C32.0529 23.7629 32.3572 23.5349 32.4826 23.1104L32.5367 22.927L33.317 23.7094L34.0972 24.4918L30.7747 24.4781C27.8255 24.4659 27.3775 24.4742 26.7887 24.551C24.8395 24.8053 23.4864 25.3993 22.4194 26.4689C21.2468 27.6446 20.6106 29.4309 20.4606 31.9689C20.4234 32.5984 20.4627 32.7966 20.6748 33.0486C21.0375 33.4796 21.7491 33.4796 22.1118 33.0486C22.2932 32.8331 22.3337 32.6664 22.3917 31.8966C22.4198 31.5228 22.4495 31.2103 22.4577 31.2022C22.4659 31.194 23.2279 31.943 24.1512 32.8666L25.8298 34.5459L25.4927 34.5836C25.3073 34.6043 23.3746 34.624 21.1978 34.6273C17.7207 34.6325 17.1875 34.6431 16.8071 34.7149C16.1865 34.832 15.6846 34.9771 15.3927 35.1237C14.7783 35.4322 14.1543 35.9915 14.0408 36.3355C13.9135 36.7213 14.0944 37.2154 14.4417 37.4301C14.8349 37.6732 15.2555 37.6104 15.6841 37.2446C15.8388 37.1125 16.085 36.9459 16.2311 36.8744L16.4968 36.7443L18.3465 38.5937C19.3638 39.6108 20.1962 40.4672 20.1962 40.4966C20.1962 40.6065 19.8995 41.1359 19.7099 41.3643C19.389 41.7509 19.338 42.1839 19.5692 42.558C19.7835 42.9048 20.2779 43.0864 20.6624 42.9595C21.015 42.8431 21.5263 42.242 21.8049 41.6164C22.1628 40.8127 22.3804 39.6615 22.4053 38.4401C22.4168 37.8756 22.3416 37.6605 22.052 37.4299C21.7469 37.1869 21.1781 37.1607 20.8872 37.3761C20.7107 37.5068 20.5382 37.7707 20.5382 37.9098C20.5382 37.973 20.5215 38.0247 20.501 38.0247C20.4805 38.0247 20.1232 37.6831 19.707 37.2657L18.9502 36.5066L22.2239 36.5205C24.6593 36.5308 25.629 36.5183 26.0107 36.4717C28.0816 36.2191 29.4791 35.6296 30.5543 34.5551C31.7186 33.3917 32.341 31.5772 32.5174 28.8322L32.5759 27.9224L32.4462 27.6594C32.1896 27.1394 31.6647 26.9655 31.1411 27.2272C30.7455 27.4249 30.6713 27.6275 30.631 28.618C30.6136 29.048 30.5868 29.4853 30.5716 29.5897L30.544 29.7795L28.8877 28.1237L27.2313 26.4679L27.3906 26.4262C27.4782 26.4033 29.1329 26.3879 31.0678 26.3922C35.3813 26.4016 36.1082 26.3548 37.1753 25.9989C37.9802 25.7304 38.7673 25.1532 38.938 24.7064C39.2099 23.9943 38.5427 23.259 37.8049 23.4577C37.6965 23.4868 37.477 23.6153 37.317 23.7433C37.157 23.8712 36.9101 24.0296 36.7684 24.0953L36.5107 24.2148L34.6503 22.3542L32.7898 20.4936L32.8741 20.2728C32.9205 20.1514 33.0776 19.9025 33.2231 19.7198C33.6199 19.2218 33.6785 18.8245 33.4143 18.4233C33.1673 18.0482 32.6318 17.8916 32.2405 18.0799ZM27.5418 29.4652L30.0253 31.9493L29.9524 32.1239C29.6636 32.8153 28.9961 33.4979 28.2302 33.8853L27.9822 34.0107L25.4827 31.5098L22.9831 29.009L23.1299 28.719C23.4729 28.041 24.0194 27.4962 24.7181 27.1358C24.8781 27.0532 25.0201 26.9847 25.0337 26.9834C25.0472 26.9821 26.1758 28.0989 27.5418 29.4652Z\" fill=\"#00F8B9\"></path><defs><radialGradient id=\"paint0_radial_0_1\" cx=\"0\" cy=\"0\" r=\"1\" gradientUnits=\"userSpaceOnUse\" gradientTransform=\"translate(26.5 30.5) rotate(48.6215) scale(37.9374)\"><stop stop-color=\"#00F8B9\"></stop><stop offset=\"1\" stop-color=\"#00664C\"></stop></radialGradient><radialGradient id=\"paint1_radial_0_1\" cx=\"0\" cy=\"0\" r=\"1\" gradientUnits=\"userSpaceOnUse\" gradientTransform=\"translate(26.5 30.5) rotate(73.393) scale(45.3543)\"><stop stop-color=\"#00F8B9\"></stop><stop offset=\"1\" stop-color=\"#00F8B9\" stop-opacity=\"0.39\"></stop></radialGradient></defs></svg><div class=\"flex flex-col justify-start items-start gap-[0.3vh]\"><div>CHARACTER CREATION</div><div>BUILD YOUR CHARACTER WITH ALL YOUR WISHES</div></div></div><div><div>");
function co() {
  return (() => {
    const a = bo();
    const b = a.firstChild;
    const c = b.firstChild;
    const d = c.nextSibling;
    const e = d.firstChild;
    const f = e.nextSibling;
    const g = b.nextSibling;
    const h = g.firstChild;
    p(b => {
      const c = ao.header;
      const d = ao.title;
      const i = ao.description;
      const j = ao.divider;
      const k = ao.line;
      if (c !== b._v$) {
        qb(a, b._v$ = c);
      }
      if (d !== b._v$2) {
        qb(e, b._v$2 = d);
      }
      if (i !== b._v$3) {
        qb(f, b._v$3 = i);
      }
      if (j !== b._v$4) {
        qb(g, b._v$4 = j);
      }
      if (k !== b._v$5) {
        qb(h, b._v$5 = k);
      }
      return b;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined
    });
    return a;
  })();
}
const eo = "_nav_wg1fn_1";
const fo = "_navItem_wg1fn_12";
const go = "_active_wg1fn_41";
const ho = {
  nav: eo,
  navItem: fo,
  active: go
};
const io = Symbol("store-raw");
const jo = Symbol("store-node");
function za(c) {
  let a = c[Ie];
  if (!a && (Object.defineProperty(c, Ie, {
    value: a = new Proxy(c, zc)
  }), !Array.isArray(c))) {
    const b = Object.keys(c);
    const d = Object.getOwnPropertyDescriptors(c);
    for (let e = 0, f = b.length; e < f; e++) {
      const f = b[e];
      if (d[f].get) {
        Object.defineProperty(c, f, {
          enumerable: d[f].enumerable,
          get: d[f].get.bind(a)
        });
      }
    }
  }
  return a;
}
function ko(a) {
  let b;
  return a != null && typeof a == "object" && (a[Ie] || !(b = Object.getPrototypeOf(a)) || b === Object.prototype || Array.isArray(a));
}
function lo(c, h = undefined) {
  if (h === undefined) h = new Set();
  let i;
  let j;
  let k;
  let l;
  if (i = c != null && c[io]) {
    return i;
  }
  if (!ko(c) || h.has(c)) {
    return c;
  }
  if (Array.isArray(c)) {
    if (Object.isFrozen(c)) {
      c = c.slice(0);
    } else {
      h.add(c);
    }
    for (let a = 0, b = c.length; a < b; a++) {
      k = c[a];
      if ((j = lo(k, h)) !== k) {
        c[a] = j;
      }
    }
  } else {
    if (Object.isFrozen(c)) {
      c = Object.assign({}, c);
    } else {
      h.add(c);
    }
    const a = Object.keys(c);
    const b = Object.getOwnPropertyDescriptors(c);
    for (let d = 0, e = a.length; d < e; d++) {
      l = a[d];
      if (!b[l].get) {
        k = c[l];
        if ((j = lo(k, h)) !== k) {
          c[l] = j;
        }
      }
    }
  }
  return c;
}
function Oc(b) {
  let a = b[jo];
  if (!a) {
    Object.defineProperty(b, jo, {
      value: a = Object.create(null)
    });
  }
  return a;
}
function Qi(d, a, b) {
  return d[a] ||= po(b);
}
function mo(a, b) {
  const c = Reflect.getOwnPropertyDescriptor(a, b);
  if (!!c && !c.get && !!c.configurable && b !== Ie && b !== jo) {
    delete c.value;
    delete c.writable;
    c.get = () => a[Ie][b];
  }
  return c;
}
function no(c) {
  if (u()) {
    const a = Oc(c);
    (a._ ||= po())();
  }
}
function oo(b) {
  no(b);
  return Reflect.ownKeys(b);
}
function po(d) {
  const [a, b] = Cr(d, {
    equals: false,
    internal: true
  });
  a.$ = b;
  return a;
}
const zc = {
  get(b, c, a) {
    if (c === io) {
      return b;
    }
    if (c === Ie) {
      return a;
    }
    if (c === Wh) {
      no(b);
      return a;
    }
    const d = Oc(b);
    const e = d[c];
    let f = e ? e() : b[c];
    if (c === jo || c === "__proto__") {
      return f;
    }
    if (!e) {
      const e = Object.getOwnPropertyDescriptor(b, c);
      if (u() && (typeof f != "function" || b.hasOwnProperty(c)) && (!e || !e.get)) {
        f = Qi(d, c, f)();
      }
    }
    if (ko(f)) {
      return za(f);
    } else {
      return f;
    }
  },
  has(a, b) {
    if (b === io || b === Ie || b === Wh || b === jo || b === "__proto__") {
      return true;
    } else {
      this.get(a, b, a);
      return b in a;
    }
  },
  set() {
    return true;
  },
  deleteProperty() {
    return true;
  },
  ownKeys: oo,
  getOwnPropertyDescriptor: mo
};
function ro(e, a, b, c = false) {
  if (!c && e[a] === b) {
    return;
  }
  const d = e[a];
  const f = e.length;
  if (b === undefined) {
    delete e[a];
  } else {
    e[a] = b;
  }
  let g = Oc(e);
  let h;
  if (h = Qi(g, a, d)) {
    h.$(() => b);
  }
  if (Array.isArray(e) && e.length !== f) {
    for (let a = e.length; a < f; a++) {
      if (h = g[a]) {
        h.$();
      }
    }
    if (h = Qi(g, "length", f)) {
      h.$(e.length);
    }
  }
  if (h = g._) {
    h.$();
  }
}
function Fc(f, a) {
  const b = Object.keys(a);
  for (let d = 0; d < b.length; d += 1) {
    const e = b[d];
    ro(f, e, a[e]);
  }
}
function so(f, a) {
  if (typeof a == "function") {
    a = a(f);
  }
  a = lo(a);
  if (Array.isArray(a)) {
    if (f === a) {
      return;
    }
    let b = 0;
    let c = a.length;
    for (; b < c; b++) {
      const d = a[b];
      if (f[b] !== d) {
        ro(f, b, d);
      }
    }
    ro(f, "length", c);
  } else {
    Fc(f, a);
  }
}
function ea(d, a, b = undefined) {
  if (b === undefined) b = [];
  let i;
  let j = d;
  if (a.length > 1) {
    i = a.shift();
    const c = typeof i;
    const e = Array.isArray(d);
    if (Array.isArray(i)) {
      for (let c = 0; c < i.length; c++) {
        ea(d, [i[c]].concat(a), b);
      }
      return;
    } else if (e && c === "function") {
      for (let c = 0; c < d.length; c++) {
        if (i(d[c], c)) {
          ea(d, [c].concat(a), b);
        }
      }
      return;
    } else if (e && c === "object") {
      const {
        from: c = 0,
        to: f = d.length - 1,
        by: g = 1
      } = i;
      for (let h = c; h <= f; h += g) {
        ea(d, [h].concat(a), b);
      }
      return;
    } else if (a.length > 1) {
      ea(d[i], a, [i].concat(b));
      return;
    }
    j = d[i];
    b = [i].concat(b);
  }
  let h = a[0];
  if ((typeof h != "function" || !(h = h(j, b), h === j)) && (i !== undefined || h != null)) {
    h = lo(h);
    if (i === undefined || ko(j) && ko(h) && !Array.isArray(h)) {
      Fc(j, h);
    } else {
      ro(d, i, h);
    }
  }
}
function Rc(...[c, a]) {
  const b = lo(c || {});
  const d = Array.isArray(b);
  const e = za(b);
  function f(...c) {
    m(() => {
      if (d && c.length === 1) {
        so(b, c[0]);
      } else {
        ea(b, c);
      }
    });
  }
  return [e, f];
}
function to(c, a) {
  const e = x(a);
  return [a => X(e.Provider, {
    value: c(a),
    get children() {
      return a.children;
    }
  }), () => y(e)];
}
const [uo, gn] = to(() => {
  const [a, b] = Cr(false);
  const [c, d] = Cr("peds");
  const [e, f] = Rc({});
  const [g, h] = Rc({});
  const [i, j] = Cr(0);
  const [k, l] = Cr("");
  const [m, n] = Cr(false);
  const [o, p] = Rc({
    show: false,
    payment: "cash",
    discard: false,
    action: () => {}
  });
  const [q, r] = Cr("");
  return {
    visible: a,
    setVisible: b,
    page: c,
    setPage: d,
    clothingData: e,
    setClothingData: f,
    barberData: g,
    setBarberData: h,
    cost: i,
    setCost: j,
    type: k,
    setType: l,
    isFree: m,
    setIsFree: n,
    modalData: o,
    setModalData: p,
    clothingPage: q,
    setClothingPage: r
  };
});
const vo = () => gn();
const wo = mb("<div>");
const xo = mb("<div><img><span>");
function Ve() {
  const {
    page: k,
    setPage: b,
    clothingData: a,
    type: c
  } = vo();
  const d = s(() => a.modelName.includes("freemode_01"));
  const e = s(() => [{
    id: "peds",
    label: "Peds",
    icon: "peds.svg",
    category: "barber"
  }, {
    id: "face",
    label: "Face",
    icon: "face.svg",
    condition: d(),
    category: "barber"
  }, {
    id: "facefeat",
    label: "Face Feat.",
    icon: "facefeat.svg",
    condition: d(),
    category: "barber"
  }, {
    id: "skin",
    label: "Skin",
    icon: "skin.svg",
    condition: d(),
    category: "barber"
  }, {
    id: "hair",
    label: "Hair",
    icon: "hair.svg",
    category: "barber"
  }, {
    id: "makeup",
    label: "Makeup",
    icon: "makeup.svg",
    condition: d(),
    category: "barber"
  }, {
    id: "clothing",
    label: "Clothing",
    icon: "clothing.svg",
    category: "spawn"
  }, {
    id: "accessories",
    label: "Accessories",
    icon: "accessories.svg",
    category: "spawn"
  }, {
    id: "ZONE_HEAD",
    label: "Head",
    icon: "face.svg",
    category: "tattoo"
  }, {
    id: "ZONE_TORSO",
    label: "Torso",
    icon: "skin.svg",
    category: "tattoo"
  }, {
    id: "ZONE_LEFT_ARM",
    label: "Left Arm",
    icon: "skin.svg",
    category: "tattoo"
  }, {
    id: "ZONE_RIGHT_ARM",
    label: "Right Arm",
    icon: "skin.svg",
    category: "tattoo"
  }, {
    id: "ZONE_LEFT_LEG",
    label: "Left Leg",
    icon: "skin.svg",
    category: "tattoo"
  }, {
    id: "ZONE_RIGHT_LEG",
    label: "Right Leg",
    icon: "skin.svg",
    category: "tattoo"
  }]);
  return (() => {
    const a = wo();
    oa(a, X(sa, {
      get each() {
        return e().filter(a => c() === "spawn" && !a.id.includes("ZONE_") ? true : a.category === c());
      },
      children: d => {
        if (d.condition !== false) {
          return (() => {
            const a = xo();
            const e = a.firstChild;
            const c = e.nextSibling;
            a.$$click = () => {
              b(d.id);
            };
            ob(e, "draggable", false);
            oa(c, () => d.label);
            p(b => {
              const c = ho.navItem;
              const f = {
                [ho.active]: k() === d.id
              };
              const g = "./nav/" + d.icon;
              if (c !== b._v$) {
                qb(a, b._v$ = c);
              }
              b._v$2 = sb(a, f, b._v$2);
              if (g !== b._v$3) {
                ob(e, "src", b._v$3 = g);
              }
              return b;
            }, {
              _v$: undefined,
              _v$2: undefined,
              _v$3: undefined
            });
            return a;
          })();
        }
      }
    }));
    p(() => qb(a, ho.nav));
    return a;
  })();
}
nb(["click"]);
const yo = "_toggles_17w7d_1";
const zo = "_toggleItem_17w7d_9";
const Ao = "_active_17w7d_20";
const Bo = {
  toggles: yo,
  toggleItem: zo,
  active: Ao
};
const Co = mb("<svg width=\"2.5vh\" height=\"1.48vh\" viewBox=\"0 0 27 16\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M16.5332 0.0286024C15.5756 0.122012 14.6683 0.438778 13.2081 1.1896L12.2811 1.66629L11.7205 1.66507C11.4122 1.66438 10.8541 1.61678 10.4802 1.55922C8.37824 1.23556 7.39671 1.41963 6.53236 2.29961C6.09516 2.74468 5.88391 3.07691 5.61933 3.73554C5.13377 4.94398 4.87645 6.69012 4.84743 8.97383C4.83357 10.0616 4.83807 10.1221 4.9484 10.3309C5.40426 11.1939 6.97395 11.7725 9.8789 12.1482C13.5472 12.6226 18.3655 12.249 20.5721 11.319C21.2703 11.0247 21.8359 10.5175 21.9417 10.0908C21.985 9.91592 21.9201 7.75421 21.8516 7.09399C21.5629 4.30934 20.9837 2.56607 19.9289 1.3079C19.3606 0.629992 18.4391 0.13202 17.6036 0.0512135C17.4245 0.0338448 17.2073 0.0122401 17.121 0.00313212C17.0347 -0.00597583 16.7702 0.00546181 16.5332 0.0286024ZM3.38645 9.16219C2.59751 9.3965 1.6028 9.80668 1.14636 10.086C-0.251761 10.9414 -0.382695 12.1012 0.817877 12.9956C2.88301 14.5341 8.58593 15.4573 14.88 15.2721C21.0851 15.0895 25.4821 14.003 26.5389 12.391C26.8784 11.8732 26.8385 11.2967 26.4253 10.7481C26.0004 10.184 24.8303 9.58433 23.2711 9.13174C22.972 9.04489 22.7071 8.97383 22.6824 8.97383C22.6578 8.97383 22.6376 9.2332 22.6376 9.55023C22.6376 9.93615 22.6097 10.2141 22.5531 10.3914C22.244 11.361 20.9735 12.1034 18.8989 12.5269C16.0557 13.1073 12.5764 13.2135 9.53902 12.8127C6.55474 12.4189 4.81124 11.68 4.27956 10.5836C4.17101 10.3597 4.15119 10.2316 4.13514 9.64898C4.12233 9.18374 4.09785 8.97494 4.05644 8.97748C4.02334 8.97944 3.72189 9.06258 3.38645 9.16219Z\" fill=\"white\">");
const Do = mb("<svg width=\"1.85vh\" height=\"2.03vh\" viewBox=\"0 0 20 22\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M0.837595 0.0521017C0.668809 0.10088 0.363816 0.360155 0.232846 0.566226C-0.0170239 0.959372 -0.00997136 0.800317 0.00729236 5.64356C0.0245128 10.473 0.0169843 10.3091 0.28243 11.6314C0.724494 13.8338 1.66911 15.8749 3.01711 17.5407C3.42651 18.0466 4.31994 18.9419 4.76252 19.2898C5.48002 19.8539 7.88094 21.545 8.15949 21.6826C8.67044 21.935 8.90633 21.9864 9.55772 21.9874C10.5546 21.9889 10.7471 21.9002 12.5503 20.6079C14.2302 19.4041 14.4873 19.2051 15.0486 18.675C17.043 16.7914 18.4295 14.0924 18.9206 11.1372C19.106 10.0218 19.1189 9.64434 19.1194 5.31101C19.1199 0.82924 19.1259 0.948929 18.8833 0.567386C18.7586 0.371071 18.4991 0.142653 18.3131 0.0654673C18.0012 -0.0639769 17.8132 -0.020485 16.9999 0.36918C14.0203 1.79663 11.0106 2.32997 7.79055 2.00116C5.79588 1.79745 3.87835 1.23584 1.94797 0.289975C1.34292 -0.00647479 1.16928 -0.0436922 0.837595 0.0521017ZM5.87423 5.788C6.342 5.89751 6.68667 6.09468 7.07408 6.47429C7.49763 6.88931 7.70596 7.27201 7.81102 7.82804C7.90279 8.31367 7.87133 8.63182 7.71864 8.76277C7.55959 8.89914 7.46808 8.88534 7.09528 8.66861C6.56894 8.36262 6.04189 8.20718 5.4448 8.18191C4.67235 8.1492 4.05449 8.30306 3.4137 8.68756C3.10719 8.87155 3.04419 8.8862 2.87969 8.81177C2.73384 8.74575 2.67806 8.60024 2.67893 8.28801C2.68222 7.1219 3.4818 6.09623 4.62523 5.79131C4.93611 5.70841 5.5277 5.70687 5.87423 5.788ZM14.7715 5.88732C15.7796 6.28184 16.4373 7.24352 16.4373 8.3233C16.4373 8.5809 16.4251 8.62026 16.3108 8.73385C16.2412 8.80295 16.1402 8.85947 16.0862 8.85947C16.0323 8.85947 15.8599 8.78254 15.7033 8.68851C14.5538 7.99866 13.2128 7.99273 12.0197 8.67222C11.8389 8.77519 11.6501 8.85947 11.6003 8.85947C11.5504 8.85947 11.455 8.81275 11.3882 8.75564C11.2709 8.65529 11.2669 8.63836 11.2694 8.25067C11.2741 7.52622 11.5384 6.93439 12.0888 6.41589C12.6254 5.91036 13.161 5.7152 13.9494 5.73807C14.3618 5.75001 14.4715 5.76991 14.7715 5.88732ZM6.60558 13.5174C8.46236 14.4435 10.6932 14.446 12.5446 13.524C12.9919 13.3012 13.11 13.2864 13.259 13.4345C13.3893 13.5639 13.3999 13.8258 13.2967 14.3664C13.0738 15.5341 12.3349 16.5055 11.2649 17.0374C9.54063 17.8947 7.42706 17.3062 6.37925 15.677C6.04064 15.1506 5.82538 14.4504 5.81894 13.8547C5.81535 13.5212 5.82253 13.4908 5.92326 13.4137C6.08174 13.2924 6.18628 13.3083 6.60558 13.5174Z\" fill=\"white\">");
const Fa = mb("<svg width=\"2.31vh\" height=\"0.83vh\" viewBox=\"0 0 25 9\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M2.396 0.0295653C2.05291 0.048655 1.6717 0.0916432 1.54889 0.125014C0.986228 0.278023 0.45261 0.64578 0.151592 1.0881L0.000633756 1.30999V2.16946C0.000633756 3.18705 -0.0494694 3.08378 0.741301 3.69601L1.27976 4.11288L1.41989 5.19254C1.58347 6.45256 1.63797 6.68232 1.8793 7.12935C2.21305 7.74755 2.78734 8.21445 3.52741 8.46927L3.91806 8.60377H5.93915C7.75119 8.60377 7.99896 8.59435 8.33452 8.51245C9.54238 8.21775 10.4985 7.46334 11.0296 6.38601C11.1827 6.07543 11.2743 5.77791 11.413 5.14032C11.6265 4.15883 11.5407 4.23538 12.4266 4.23718C13.3103 4.23902 13.2371 4.1818 13.3995 4.99639C13.6501 6.25403 13.9793 6.89468 14.7262 7.57856C15.0281 7.855 15.2492 8.00529 15.6193 8.18564C16.4415 8.58629 16.5783 8.60377 18.8891 8.60377C20.6855 8.60377 20.9152 8.59484 21.1847 8.5144C22.1126 8.23747 22.8513 7.56452 23.1572 6.71729C23.2325 6.50886 23.5551 4.45936 23.5551 4.18962C23.5551 4.1581 23.8256 3.91858 24.1562 3.65739C24.4868 3.39621 24.7787 3.12759 24.8049 3.06051C24.8851 2.85524 24.8647 1.41564 24.7788 1.21541C24.6707 0.963651 24.1271 0.464403 23.788 0.305565C23.1672 0.0147011 23.1253 0.0119812 19.2135 0.00892103C15.2533 0.00581227 15.4601 -0.00929439 14.7321 0.336167C14.3943 0.496511 13.7972 0.996779 13.6307 1.25894L13.5318 1.41476L12.4312 1.41122L11.3307 1.40767L11.1885 1.21692C10.9919 0.953208 10.531 0.552128 10.245 0.395816C10.1137 0.324072 9.83786 0.207056 9.63201 0.135749L9.25773 0.00610378L6.13876 0.00046928C4.42333 -0.00268806 2.73909 0.010427 2.396 0.0295653Z\" fill=\"white\">");
const Eo = mb("<svg width=\"1.57vh\" height=\"1.57vh\" viewBox=\"0 0 17 17\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M3.1409 0.98704C1.36866 1.57904 0.163353 1.99988 0.115301 2.04345C0.0713856 2.08329 0.0206112 2.15456 0.00250078 2.20185C-0.0344459 2.29826 0.349284 5.86566 0.408479 5.97601C0.427206 6.01096 0.485675 6.07339 0.538409 6.11475C0.631102 6.18754 0.674146 6.19 1.84472 6.19H3.05517L3.06472 11.4766L3.07426 16.7632L3.19291 16.8816L3.31155 17H8.50013H13.6887L13.8073 16.8816L13.926 16.7632L13.9355 11.4766L13.9451 6.19H15.1555C16.3261 6.19 16.3691 6.18754 16.4618 6.11475C16.5146 6.07339 16.573 6.01096 16.5918 5.97601C16.6513 5.86501 17.0347 2.29815 16.9975 2.20185C16.9792 2.15456 16.9257 2.08126 16.8787 2.03896C16.7467 1.92018 10.8701 -0.022328 10.7408 0.0100477C10.6862 0.0237006 10.5254 0.149039 10.3833 0.288573C10.0797 0.586726 9.75519 0.787571 9.35302 0.926127C9.08931 1.01695 9.01437 1.0263 8.53642 1.02778C7.98389 1.02952 7.83051 1.00341 7.43136 0.839503C7.12272 0.712788 6.863 0.537619 6.62249 0.293932C6.38934 0.0577059 6.29439 -0.00400344 6.17067 0.000197427C6.12443 0.00175465 4.76104 0.445852 3.1409 0.98704Z\" fill=\"white\">");
const Fo = mb("<svg width=\"1.38vh\" height=\"1.85vh\" viewBox=\"0 0 15 20\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M6.80274 0.0514903C6.01193 0.234715 5.3054 0.680989 4.82316 1.30197C4.53188 1.67702 4.36171 1.99667 4.22132 2.43243C4.061 2.93003 4.02824 3.29281 4.02824 4.57041V5.69404L2.54411 5.7051L1.06002 5.71616L0.907024 5.82108C0.814599 5.88445 0.722136 5.99418 0.673564 6.09813C0.597631 6.2606 0.576157 6.58557 0.289408 11.9156C0.122333 15.0206 -0.00771964 17.737 0.000356737 17.952C0.0180946 18.4251 0.104255 18.6983 0.356585 19.0817C0.550494 19.3762 0.830601 19.6267 1.14403 19.7856C1.60129 20.0176 1.25959 20.0065 7.59788 19.9952L13.4066 19.9848L13.6708 19.8761C14.4608 19.5511 14.9589 18.8372 14.9995 17.9715C15.0203 17.5265 14.4258 6.40653 14.3703 6.20211C14.3214 6.02245 14.0925 5.78582 13.9193 5.73598C13.8408 5.71339 13.1966 5.69697 12.3828 5.69685L10.9817 5.69662L10.962 4.37726C10.9446 3.20391 10.9335 3.02159 10.8623 2.7298C10.5521 1.45861 9.62381 0.468915 8.39952 0.104186C8.02295 -0.00800781 7.17961 -0.0358413 6.80274 0.0514903ZM7.98744 1.49578C8.68106 1.66513 9.24803 2.23529 9.48259 2.99926C9.53776 3.17901 9.55154 3.41778 9.56656 4.45544L9.58448 5.69662H7.50138H5.41828L5.43327 4.4359C5.44712 3.27068 5.45444 3.15571 5.53022 2.91827C5.86837 1.85864 6.93785 1.2395 7.98744 1.49578Z\" fill=\"white\">");
const Ho = mb("<svg width=\"1.94vh\" height=\"1.94vh\" viewBox=\"0 0 21 21\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M6.5625 10.8773C6.5625 11.226 6.42305 11.5582 6.17695 11.8043L5.07773 12.9035C4.57324 13.408 3.74473 13.3711 3.05156 13.1988C2.86289 13.1496 2.66602 13.125 2.46094 13.125C1.10332 13.125 0 14.2283 0 15.5859C0 16.9436 1.10332 18.0469 2.46094 18.0469C2.71934 18.0469 2.95312 18.2807 2.95312 18.5391C2.95312 19.8967 4.05645 21 5.41406 21C6.77168 21 7.875 19.8967 7.875 18.5391C7.875 18.334 7.85039 18.1371 7.80117 17.9443C7.62891 17.2512 7.58789 16.4227 8.09648 15.9182L9.1957 14.8189C9.4418 14.5729 9.77402 14.4334 10.1227 14.4334H13.7812C14.0396 14.4334 14.2898 14.4211 14.54 14.3924C15.0281 14.3432 15.2127 13.7566 14.983 13.326C14.6344 12.6779 14.4375 11.9396 14.4375 11.1521C14.4375 8.61328 16.4924 6.5584 19.0312 6.5584C19.3594 6.5584 19.6752 6.59121 19.9828 6.65684C20.4627 6.75938 20.9713 6.41484 20.8852 5.93496C20.2822 2.56348 17.3291 0 13.7812 0C9.79453 0 6.5625 3.23203 6.5625 7.21875V10.8773Z\" fill=\"white\">");
const Io = mb("<svg width=\"1.75vh\" height=\"1.75vh\" viewBox=\"0 0 19 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M4.61757 0.0667864C4.2199 0.20585 3.93429 0.469476 3.7524 0.865317L3.663 1.05989L3.64275 4.96754C3.62462 8.46239 3.61551 8.89252 3.5568 9.03919C3.35421 9.54525 3.29297 9.61942 1.98015 10.9499C1.2696 11.67 0.629278 12.3466 0.557245 12.4535C0.379366 12.7176 0.174414 13.1727 0.0956423 13.4786C-0.267495 14.8889 0.430945 16.4366 1.72427 17.0876C2.23576 17.3451 2.62798 17.4399 3.18171 17.4399C3.87846 17.4399 4.47607 17.2499 5.02238 16.8545C5.32516 16.6355 9.27719 12.6543 9.45499 12.3893C9.64683 12.1033 9.8091 11.7319 9.90003 11.3709C9.97932 11.0559 9.98073 10.9492 9.97046 6.05464L9.95995 1.05989L9.85426 0.833492C9.70562 0.515078 9.49345 0.296613 9.18446 0.143811L8.91895 0.0124821L6.87256 0.00317626C4.98673 -0.00540446 4.80977 -0.000409088 4.61757 0.0667864ZM8.86625 1.11089L8.99736 1.24251L9.01047 1.78567L9.02363 2.32887H6.81456H4.60554V1.86431C4.60554 1.32686 4.65491 1.1629 4.85381 1.04011C4.98304 0.960349 5.03662 0.958456 6.86085 0.968769L8.73517 0.979323L8.86625 1.11089ZM13.6428 1.62143C13.2898 1.73233 12.9359 2.05042 12.774 2.40235C12.6875 2.59016 12.6872 2.60201 12.6654 6.47823C12.6481 9.53909 12.6322 10.4 12.5906 10.5269C12.4298 11.0171 12.3408 11.1266 11.0027 12.4807C9.51335 13.9879 9.37514 14.1678 9.12992 14.918C9.0124 15.2775 8.98545 16.078 9.07681 16.4941C9.21037 17.1023 9.50184 17.6403 9.93143 18.0718C10.2211 18.3628 10.4527 18.5256 10.8325 18.7056C11.2414 18.8992 11.5395 18.9715 12.0293 18.9957C12.7527 19.0315 13.419 18.8429 13.9784 18.4441C14.1405 18.3286 15.1095 17.384 16.3621 16.1204L18.4728 13.9914L18.6581 13.6087C19.0098 12.8823 18.9815 13.3685 18.9947 7.81284C19.0077 2.37367 19.0174 2.60523 18.7581 2.1994C18.6049 1.9595 18.3841 1.7814 18.0889 1.65946L17.8612 1.56535L15.8358 1.56712C14.2856 1.56845 13.771 1.58118 13.6428 1.62143ZM17.8846 2.68201L18.0016 2.81358V3.35679V3.89999H15.8157H13.6298V3.39441C13.6298 3.02198 13.6458 2.85786 13.6905 2.77104C13.8154 2.52836 13.7867 2.53139 15.8692 2.54134L17.7676 2.55044L17.8846 2.68201Z\" fill=\"white\">");
const Lo = mb("<div>");
function Mo() {
  const [d, b] = Rc([{
    id: "hat",
    icon: Co(),
    label: "Hat",
    male: {
      drawables: {}
    },
    female: {
      drawables: {}
    },
    props: {
      Hat: [-1, 0]
    },
    active: false
  }, {
    id: "mask",
    icon: Do(),
    label: "Mask",
    male: {
      drawables: {
        Mask: [-1, 0]
      }
    },
    female: {
      drawables: {
        Mask: [-1, 0]
      }
    },
    props: {},
    active: false
  }, {
    id: "glasses",
    icon: Fa(),
    label: "Glasses",
    male: {
      drawables: {}
    },
    female: {
      drawables: {}
    },
    props: {
      Glasses: [-1, 0]
    },
    active: false
  }, {
    id: "torso",
    icon: Eo(),
    label: "Torso",
    male: {
      drawables: {
        Undershirt: [15, 0],
        Torso: [15, 0],
        Kevlar: [0, 0],
        Jacket: [15, 0]
      }
    },
    female: {
      drawables: {
        Undershirt: [14, 0],
        Torso: [15, 0],
        Kevlar: [-1, 0],
        Jacket: [18, 0]
      }
    },
    props: {},
    active: false
  }, {
    id: "bag",
    icon: Fo(),
    label: "Bag",
    male: {
      drawables: {
        Parachute: [-1, 0]
      }
    },
    female: {
      drawables: {
        Parachute: [-1, 0]
      }
    },
    props: {},
    active: false
  }, {
    id: "legs",
    icon: Ho(),
    label: "Legs",
    male: {
      drawables: {
        Leg: [14, 0]
      }
    },
    female: {
      drawables: {
        Leg: [17, 0]
      }
    },
    props: {},
    active: false
  }, {
    id: "shoes",
    icon: Io(),
    label: "Shoes",
    male: {
      drawables: {
        Shoes: [34, 0]
      }
    },
    female: {
      drawables: {
        Shoes: [35, 0]
      }
    },
    props: {},
    active: false
  }]);
  return (() => {
    const a = Lo();
    oa(a, X(sa, {
      each: d,
      children: h => (() => {
        const a = Lo();
        a.$$click = async () => {
          const a = d.map((a, b) => a.id === h.id ? {
            ...a,
            active: !a.active
          } : a);
          b(a);
          await fetch("https://karma-clothing/karma-clothing:setToggles", {
            method: "POST",
            headers: {
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              toggles: a.map(b => ({
                id: b.id,
                male: b.male,
                female: b.female,
                props: b.props,
                active: b.active
              }))
            })
          }).then(b => b.json());
        };
        oa(a, () => h.icon);
        p(c => {
          const b = Bo.toggleItem;
          const d = {
            [Bo.active]: h.active
          };
          if (b !== c._v$) {
            qb(a, c._v$ = b);
          }
          c._v$2 = sb(a, d, c._v$2);
          return c;
        }, {
          _v$: undefined,
          _v$2: undefined
        });
        return a;
      })()
    }));
    p(() => qb(a, Bo.toggles));
    return a;
  })();
}
nb(["click"]);
const No = "_pageWrapper_h288d_1";
const Oo = {
  pageWrapper: No
};
const Po = mb("<div>");
let Ro;
function So(b) {
  return (() => {
    const a = Po();
    const c = Ro;
    if (typeof c == "function") {
      vb(c, a);
    } else {
      Ro = a;
    }
    oa(a, () => b.children);
    p(c => {
      const d = Oo.pageWrapper;
      const e = {
        ...b.style
      };
      if (d !== c._v$) {
        qb(a, c._v$ = d);
      }
      c._v$2 = tb(a, e, c._v$2);
      return c;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return a;
  })();
}
const To = "_grid_c1zuu_1";
const ta = "_collapsed_c1zuu_13";
const Uo = "_gridItem_c1zuu_16";
const Vo = "_image_c1zuu_33";
const Wo = "_text_c1zuu_40";
const Zo = "_active_c1zuu_57";
const $o = "_peds_c1zuu_68";
const _o = "_collapse_c1zuu_13";
const ap = "_collapseList_c1zuu_78";
const bp = {
  grid: To,
  collapsed: ta,
  gridItem: Uo,
  image: Vo,
  text: Wo,
  active: Zo,
  peds: $o,
  collapse: _o,
  collapseList: ap
};
const cp = "_title_fh3pv_1";
const dp = "_collapse_fh3pv_21";
const ep = "_arrowBox_fh3pv_24";
const fp = "_expand_fh3pv_34";
const gp = {
  title: cp,
  collapse: dp,
  arrowBox: ep,
  expand: fp
};
const hp = mb("<div class=\"flex flex-row justify-end items-center gap-[0.5vh]\"><div>Expand</div><div><svg width=\"0.74vh\" height=\"0.46vh\" viewBox=\"0 0 8 5\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M1 1L4 4L7 1\" stroke=\"#00F8B9\">");
const ip = mb("<div><div class=\"w-full flex flex-row justify-between items-center\">");
function gi(k) {
  return (() => {
    const a = ip();
    const b = a.firstChild;
    a.$$click = () => {
      if (k.onClick) {
        k.onClick();
      }
    };
    oa(b, () => k.text, null);
    oa(b, X(Ma, {
      get when() {
        return k.collapsed !== undefined;
      },
      get children() {
        const a = hp();
        const c = a.firstChild;
        const d = c.nextSibling;
        const b = d.firstChild;
        b.style.setProperty("transition", "transform 0.2s ease-in-out");
        p(a => {
          const e = gp.expand;
          const f = gp.arrowBox;
          const g = k.collapsed ? "rotate(180deg)" : "rotate(0deg)";
          if (e !== a._v$) {
            qb(c, a._v$ = e);
          }
          if (f !== a._v$2) {
            qb(d, a._v$2 = f);
          }
          if (g !== a._v$3) {
            if ((a._v$3 = g) != null) {
              b.style.setProperty("transform", g);
            } else {
              b.style.removeProperty("transform");
            }
          }
          return a;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined
        });
        return a;
      }
    }), null);
    p(b => {
      const c = gp.title;
      const d = {
        [gp.collapse]: k.collapsed !== undefined
      };
      if (c !== b._v$4) {
        qb(a, b._v$4 = c);
      }
      b._v$5 = sb(a, d, b._v$5);
      return b;
    }, {
      _v$4: undefined,
      _v$5: undefined
    });
    return a;
  })();
}
nb(["click"]);
const jp = (c, a) => {
  const b = [];
  for (let d = 0; d < a; d += 1) {
    b.push(c + d);
  }
  return b;
};
const kp = b => Number.isFinite(b) ? b : 0;
const li = b => b.matches(":focus-within");
const na = b => b.querySelector(":focus");
const ki = b => {
  const a = na(b);
  if (a) {
    a.click();
    return true;
  } else {
    return false;
  }
};
const lp = (c, a) => {
  let i = a;
  let h = 0;
  let j = 0;
  while (i && c !== i) {
    const {
      offsetTop: a,
      offsetLeft: b,
      offsetParent: d
    } = i;
    if (c.contains(d)) {
      h += a;
      j += b;
    } else {
      h += a - c.offsetTop;
      j += b - c.offsetLeft;
      break;
    }
    i = d;
  }
  return {
    offsetTop: h,
    offsetLeft: j
  };
};
const mp = x();
const np = b => {
  let a = 0;
  let g = 0;
  if (b.borderBoxSize) {
    const {
      borderBoxSize: c
    } = b;
    const d = Array.isArray(c) ? c[0] : c;
    a = d.inlineSize;
    g = d.blockSize;
  } else {
    const c = b.target.getBoundingClientRect();
    a = c.width;
    g = c.height;
  }
  return {
    width: a,
    height: g
  };
};
const op = (f, a, b) => {
  const [c, d] = b ? [f, a] : [a, f];
  return {
    main: c,
    cross: d
  };
};
const pp = {
  main: 0,
  cross: 0
};
const qp = (c, a) => c.cross === a.cross;
const Ra = b => {
  const a = y(mp);
  const [p, c] = Cr(undefined);
  const d = () => b.scrollTarget || a?.scrollTarget;
  const q = s(() => (b.direction || "vertical") === "horizontal");
  const [g, h] = Rc({
    isMeasured: false,
    mainAxisScrollValue: 0,
    target: {
      ...pp
    },
    container: {
      ...pp,
      offsetMain: 0,
      offsetCross: 0
    },
    itemSize: {
      ...pp
    }
  });
  const e = b => {
    const a = b.target;
    const c = d();
    const e = p();
    const f = q();
    const i = np(b);
    const j = op(i.width, i.height, f);
    if (a === c) {
      h("target", j);
    } else if (a === e && (!qp(g.container, j) || !g.isMeasured)) {
      const d = lp(c, e);
      const a = op(d.offsetLeft, d.offsetTop, f);
      h("container", {
        ...j,
        offsetMain: a.main,
        offsetCross: a.cross
      });
    }
  };
  const f = () => {
    const a = d();
    if (a) {
      const c = q() ? a.scrollLeft : a.scrollTop;
      return Math.floor(c);
    }
    return 0;
  };
  const i = new ResizeObserver(b => {
    m(() => {
      b.forEach(b => e(b));
      h({
        isMeasured: true,
        mainAxisScrollValue: f()
      });
    });
  });
  Dr(() => {
    if (!g.isMeasured) {
      return;
    }
    const a = q();
    const c = b.itemSize;
    let d;
    if (typeof c == "function") {
      d = c(g.container.cross, a);
    } else {
      d = c;
    }
    const e = op(d.width || 0, d.height || 0, a);
    h("itemSize", e);
  });
  const j = () => {
    h("mainAxisScrollValue", f());
  };
  o(() => {
    const a = d();
    const b = p();
    if (!!a && !!b) {
      a.addEventListener("scroll", j);
      i.observe(a);
      i.observe(b);
      t(() => {
        h("isMeasured", false);
        a.removeEventListener("scroll", j);
        i.unobserve(a);
        i.unobserve(b);
      });
    }
  });
  return {
    containerEl: p,
    setContainerRefEl: c,
    isDirectionHorizontal: q,
    measurements: g
  };
};
const Na = 1;
const rp = b => {
  const {
    total: p,
    focusPosition: c,
    positionCount: d,
    startPosition: e,
    prevPositions: f,
    prevStartPosition: a
  } = b;
  const g = f.length;
  if (p <= d) {
    if (g === d && a === e) {
      return f;
    } else {
      return jp(0, d);
    }
  }
  const h = e + d;
  const i = b => b < e || b >= h;
  const j = () => {
    if (i(c)) {
      return c;
    }
    let b;
    if (h < p) {
      b = h;
    } else {
      b = e - 1;
    }
    return b;
  };
  const k = d + Na;
  if (g !== k) {
    const b = jp(e, d);
    b.push(j());
    return b;
  }
  const l = [];
  for (let g = 0; g < d; g += 1) {
    const b = e + g;
    if (!f.includes(b)) {
      l.push(b);
    }
  }
  const m = j();
  if (!f.includes(m)) {
    l.push(m);
  }
  return f.map(b => i(b) && b !== m ? l.pop() : b);
};
const sp = b => Number.isInteger(b) ? b : 0;
const tp = (i, a, l) => {
  const [b, d] = Rc({
    overscan: 0,
    positionCount: 0,
    maxScrollPosition: 0,
    currentPosition: 0
  });
  Dr(() => {
    if (!i.isMeasured) {
      return;
    }
    const c = a.totalItemCount;
    const e = i.itemSize.main;
    const f = i.target.main;
    q(() => {
      const a = l() ?? Math.max(Math.ceil(180 / e), 2);
      const b = kp(a);
      d("overscan", b);
      const g = Math.ceil(f / e);
      const h = sp(Math.min(g + b * 2, c));
      d("positionCount", h);
      d("maxScrollPosition", c - h);
    });
  });
  Dr(() => {
    if (!i.isMeasured) {
      return;
    }
    const a = i.mainAxisScrollValue - i.container.offsetMain;
    const c = Math.floor(a / i.itemSize.main) - b.overscan;
    const e = Math.min(Math.max(0, c), b.maxScrollPosition);
    d("currentPosition", e);
  });
  let e = 0;
  return s((d = undefined) => {
    if (d === undefined) d = [];
    if (!i.isMeasured) {
      return d;
    }
    const f = b.currentPosition;
    const g = rp({
      total: a.totalItemCount,
      focusPosition: a.focusPosition,
      positionCount: b.positionCount,
      startPosition: f,
      prevStartPosition: e,
      prevPositions: d
    });
    e = f;
    return g;
  });
};
const up = mb("<div>");
const vp = Math.random().toString(36).slice(2, Infinity);
const wp = "virtual-container-" + vp;
let xp;
const yp = () => {
  if (!xp) {
    xp = document.createElement("style");
    xp.type = "text/css";
    xp.textContent = "\n      ." + wp + " {\n        position: relative !important;\n        flex-shrink: 0 !important;\n      }\n      ." + wp + " > * {\n        will-change: transform !important;\n        box-sizing: border-box !important;\n        contain: strict !important;\n        position: absolute !important;\n        top: 0 !important;\n        left: 0 !important;\n      }\n    ";
    document.head.appendChild(xp);
  }
};
function Ap(t) {
  yp();
  const [b, v] = Rc({
    focusPosition: 0,
    mainAxis: {
      totalItemCount: 0,
      focusPosition: 0,
      scrollValue: 0
    },
    crossAxis: {
      totalItemCount: 0
    }
  });
  const {
    containerEl: a,
    setContainerRefEl: c,
    isDirectionHorizontal: A,
    measurements: B
  } = Ra(t);
  const d = () => t.items && t.items.length || 0;
  Dr(() => {
    if (!B.isMeasured) {
      return;
    }
    const a = kp(t.crossAxisCount?.(B, d()) || 0);
    v("crossAxis", {
      totalItemCount: Math.max(1, a)
    });
  });
  Dr(() => {
    if (!B.isMeasured) {
      return;
    }
    const a = d();
    const c = b.crossAxis.totalItemCount;
    const e = Math.ceil(a / c);
    v("mainAxis", {
      totalItemCount: kp(e)
    });
    v("crossAxis", {
      totalItemCount: c,
      positions: jp(0, b.crossAxis.totalItemCount)
    });
  });
  Dr(() => {
    const a = Math.floor(b.focusPosition / b.crossAxis.totalItemCount);
    v("mainAxis", "focusPosition", kp(a));
  });
  const i = tp(B, b.mainAxis, () => t.overscan);
  const e = () => {
    const a = b.mainAxis.totalItemCount * B.itemSize.main;
    const c = A() ? "width" : "height";
    const d = A() ? "height" : "width";
    return {
      [c]: a + "px",
      [d]: "100%"
    };
  };
  const f = (b, a = 0) => {
    const c = B.itemSize;
    const d = c.main * b;
    const e = c.cross * a;
    let f = e;
    let g = d;
    let h = c.cross;
    let i = c.main;
    if (A()) {
      f = d;
      g = e;
      h = c.main;
      i = c.cross;
    }
    return {
      transform: "translate(" + f + "px, " + g + "px)",
      width: h ? h + "px" : "",
      height: i ? i + "px" : ""
    };
  };
  const j = s(() => jp(0, b.crossAxis.totalItemCount));
  const g = s(() => t.items || []);
  const m = (c, a) => c * b.crossAxis.totalItemCount + a;
  const h = a => X(va, {
    get each() {
      return i();
    },
    children: h => {
      const c = s(() => {
        const b = h();
        const c = a.crossPos;
        if (c === undefined) {
          return b;
        } else {
          return m(b, c);
        }
      });
      return X(Ma, {
        get when() {
          return c() < g().length;
        },
        get children() {
          return X(Gb, {
            get component() {
              return t.children;
            },
            get items() {
              return g();
            },
            get item() {
              return g()[c()];
            },
            get index() {
              return c();
            },
            get tabIndex() {
              if (c() === b.focusPosition) {
                return 0;
              } else {
                return -1;
              }
            },
            get style() {
              return f(h(), a.crossPos);
            }
          });
        }
      });
    }
  });
  const o = z(() => X(Ma, {
    get when() {
      return b.crossAxis.totalItemCount > 1;
    },
    get fallback() {
      return X(h, {});
    },
    get children() {
      return X(va, {
        get each() {
          return j();
        },
        children: b => X(h, {
          get crossPos() {
            return b();
          }
        })
      });
    }
  }));
  const k = () => {
    const a = j();
    const d = i();
    const e = o().findIndex(a => a?.matches(":focus-within, :focus"));
    if (e === -1) {
      return -1;
    }
    if (b.crossAxis.totalItemCount > 1) {
      const f = Math.floor(e / d.length);
      const b = e % d.length;
      const c = a[f];
      const g = d[b];
      return m(g, c);
    }
    return d[e];
  };
  const n = (c, a) => {
    const e = b.focusPosition;
    let f = e % b.crossAxis.totalItemCount;
    let g = Math.floor(e / b.crossAxis.totalItemCount);
    if (a) {
      g += c;
    } else {
      f += c;
    }
    const q = m(g, f);
    if (q < 0 || q >= d()) {
      return;
    }
    const l = j().indexOf(f);
    if (l === -1) {
      return;
    }
    v("focusPosition", q);
    const n = o();
    const p = i();
    const r = p.indexOf(g);
    if (r === -1) {
      return;
    }
    const s = l * p.length + r;
    const t = n[s];
    if (t) {
      queueMicrotask(() => {
        t.focus();
        t.scrollIntoView({
          block: "nearest"
        });
      });
    }
  };
  const l = b => {
    const {
      code: c
    } = b;
    const d = c === "ArrowUp";
    const e = c === "ArrowDown";
    const f = c === "ArrowLeft";
    const g = c === "ArrowRight";
    const h = d || e;
    const i = f || g;
    if (h || i) {
      n(e || g ? 1 : -1, A() ? i : h);
    } else if (c === "Enter") {
      if (!ki(a())) {
        return;
      }
    } else {
      return;
    }
    b.preventDefault();
  };
  const q = () => {
    const a = k();
    v("focusPosition", a === -1 ? 0 : a);
  };
  const r = async () => {
    queueMicrotask(() => {
      if (!li(a())) {
        v("focusPosition", 0);
      }
    });
  };
  return (() => {
    const a = up();
    a.$$focusout = r;
    a.$$focusin = q;
    a.$$keydown = l;
    vb(c, a);
    oa(a, o);
    p(c => {
      const b = wp + " " + (t.className || "");
      const d = e();
      const f = t.role || "list";
      if (b !== c._v$) {
        a.className = c._v$ = b;
      }
      c._v$2 = tb(a, d, c._v$2);
      if (f !== c._v$3) {
        ob(a, "role", c._v$3 = f);
      }
      return c;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return a;
  })();
}
nb(["keydown", "focusin", "focusout"]);
const Bp = "" + new URL("whitelisted_clothing.png", import.meta.url).href;
const Cp = mb("<div>");
const Dp = mb("<div><img>");
const Ep = mb("<div><div>");
const Fp = window.location.href.includes("localhost");
const Gp = b => (() => {
  const a = Dp();
  const c = a.firstChild;
  a.$$click = () => b.onClick(b.item, b.index);
  c.addEventListener("error", b => {
    b.currentTarget.src = Bp;
  });
  ob(c, "draggable", false);
  oa(a, X(Ma, {
    get when() {
      return b.item.text;
    },
    get children() {
      const a = Cp();
      oa(a, () => b.item.text);
      p(() => qb(a, bp.text));
      return a;
    }
  }), null);
  p(d => {
    const e = bp.gridItem;
    const f = {
      [bp.peds]: b.item.icon.includes("peds"),
      [bp.active]: b.item.active
    };
    const g = {
      ...b.style,
      width: "9.72vh",
      height: "10.55vh"
    };
    const h = bp.image;
    const i = Fp ? "http://localhost/" + b.item.icon + "?" + ur : "https://assets.nopixel.net/dev/images/" + b.item.icon + "?" + ur;
    if (e !== d._v$) {
      qb(a, d._v$ = e);
    }
    d._v$2 = sb(a, f, d._v$2);
    d._v$3 = tb(a, g, d._v$3);
    if (h !== d._v$4) {
      qb(c, d._v$4 = h);
    }
    if (i !== d._v$5) {
      ob(c, "src", d._v$5 = i);
    }
    return d;
  }, {
    _v$: undefined,
    _v$2: undefined,
    _v$3: undefined,
    _v$4: undefined,
    _v$5: undefined
  });
  return a;
})();
function Hp(b) {
  let a;
  const g = b => b * 0.01 * window.innerHeight;
  const [k, d] = Cr(false);
  return [X(Ma, {
    get when() {
      return b.title;
    },
    get children() {
      return X(gi, {
        get text() {
          return b.title;
        },
        get collapsed() {
          return k();
        },
        onClick: () => {
          d(!k());
        }
      });
    }
  }), X(Ma, {
    get when() {
      return (b.items?.length ?? 0) > 0;
    },
    get children() {
      const e = Ep();
      const f = e.firstChild;
      const c = a;
      if (typeof c == "function") {
        vb(c, f);
      } else {
        a = f;
      }
      oa(f, X(Ap, {
        get items() {
          return b.items ?? [];
        },
        scrollTarget: a,
        get itemSize() {
          return {
            height: g(11.2),
            width: g(10.5)
          };
        },
        crossAxisCount: b => Math.floor(3),
        children: a => X(Gp, aa(a, {
          get onClick() {
            return b.onClick;
          }
        }))
      }));
      p(b => {
        const a = bp.collapseList;
        const c = {
          [bp.collapsed]: true
        };
        const d = bp.grid;
        const g = {
          [bp.collapsed]: k()
        };
        if (a !== b._v$6) {
          qb(e, b._v$6 = a);
        }
        b._v$7 = sb(e, c, b._v$7);
        if (d !== b._v$8) {
          qb(f, b._v$8 = d);
        }
        b._v$9 = sb(f, g, b._v$9);
        return b;
      }, {
        _v$6: undefined,
        _v$7: undefined,
        _v$8: undefined,
        _v$9: undefined
      });
      return e;
    }
  })];
}
nb(["click"]);
const Ip = "_inputArrow_qpo2z_1";
const Jp = "_button_qpo2z_32";
const Ke = "_right_qpo2z_47";
const Kp = {
  inputArrow: Ip,
  button: Jp,
  right: Ke
};
const Lp = mb("<div><div><svg width=\"0.46vh\" height=\"0.74vh\" viewBox=\"0 0 5 8\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M4 1.00098L1 4.00098L4 7.00098\" stroke=\"white\"></path></svg></div><input type=\"number\"><div><svg width=\"0.46vh\" height=\"0.74vh\" viewBox=\"0 0 5 8\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M4 1.00098L1 4.00098L4 7.00098\" stroke=\"white\">");
const Mp = mb("<div class=\"w-full flex flex-row justify-between items-center gap-[1.5vh]\">");
function mi(o) {
  const a = (c, a) => {
    const b = c.target.value;
    const d = Number(b);
    if (isNaN(d)) {
      c.currentTarget.value = "0";
      return;
    }
    if (d < (a.min ?? 0)) {
      c.currentTarget.value = (a.min ?? 0).toString();
      return;
    }
    if (d > a.max) {
      c.currentTarget.value = a.max.toString();
      return;
    }
    a.onChange(a.id, d);
  };
  let b;
  return (() => {
    const c = Lp();
    const d = c.firstChild;
    const e = d.nextSibling;
    const f = e.nextSibling;
    c.addEventListener("mouseleave", c => {
      if (b) {
        b.blur();
      }
    });
    c.addEventListener("mouseenter", c => {
      if (b) {
        b.focus();
        b.select();
      }
    });
    d.$$click = () => {
      const c = b;
      if (c) {
        c.value = +c.value - 1;
        a({
          target: c,
          currentTarget: c
        }, o);
      }
    };
    e.$$input = b => {
      a(b, o);
    };
    const g = b;
    if (typeof g == "function") {
      vb(g, e);
    } else {
      b = e;
    }
    f.$$click = () => {
      const c = b;
      if (c) {
        c.value = +c.value + 1;
        a({
          target: c,
          currentTarget: c
        }, o);
      }
    };
    p(a => {
      const b = Kp.inputArrow;
      const g = Kp.button;
      const h = o.min ?? 0;
      const i = o.max;
      const j = Kp.button;
      const k = {
        [Kp.right]: true
      };
      if (b !== a._v$) {
        qb(c, a._v$ = b);
      }
      if (g !== a._v$2) {
        qb(d, a._v$2 = g);
      }
      if (h !== a._v$3) {
        ob(e, "min", a._v$3 = h);
      }
      if (i !== a._v$4) {
        ob(e, "max", a._v$4 = i);
      }
      if (j !== a._v$5) {
        qb(f, a._v$5 = j);
      }
      a._v$6 = sb(f, k, a._v$6);
      return a;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined
    });
    p(() => e.value = o.value);
    return c;
  })();
}
function Np(b) {
  return X(Ma, {
    get when() {
      return b.firstInput && b.firstInput.max !== 0 || b.secondInput && b.secondInput.max !== 0;
    },
    get children() {
      return [X(Ma, {
        get when() {
          return b.title;
        },
        get children() {
          return X(gi, {
            get text() {
              return b.title;
            }
          });
        }
      }), (() => {
        const a = Mp();
        a.style.setProperty("direction", "ltr");
        oa(a, X(Ma, {
          get when() {
            return b.firstInput;
          },
          get children() {
            return X(mi, aa(() => b.firstInput));
          }
        }), null);
        oa(a, X(Ma, {
          get when() {
            return b.secondInput;
          },
          get children() {
            return X(mi, aa(() => b.secondInput));
          }
        }), null);
        return a;
      })()];
    }
  });
}
nb(["click", "input"]);
const Op = "_inputArrow_qpo2z_1";
const qo = "_button_qpo2z_32";
const ei = "_right_qpo2z_47";
const Pp = {
  inputArrow: Op,
  button: qo,
  right: ei
};
const Qp = mb("<div><input type=\"text\">");
function Rp(c) {
  let a;
  return (() => {
    const b = Qp();
    const d = b.firstChild;
    d.$$keyup = b => {
      if (b.key === "Enter") {
        console.log(b.key);
        c.onChange(c.id, a.value);
      }
    };
    const e = a;
    if (typeof e == "function") {
      vb(e, d);
    } else {
      a = d;
    }
    p(() => qb(b, Pp.inputArrow));
    p(() => d.value = c.value);
    return b;
  })();
}
function Sp(b) {
  return X(Ma, {
    get when() {
      return b.input;
    },
    get children() {
      return [X(Ma, {
        get when() {
          return b.title;
        },
        get children() {
          return X(gi, {
            get text() {
              return b.title;
            }
          });
        }
      }), X(Rp, aa(() => b.input))];
    }
  });
}
nb(["keyup"]);
function Tp() {
  const {
    clothingData: i,
    setClothingData: j,
    setCost: c
  } = vo();
  const a = s(() => i?.pedEntries.male?.map(a => ({
    id: a,
    icon: "clothing/peds/" + a + ".webp",
    active: i?.modelName === a,
    category: "male"
  })));
  const b = s(() => i?.pedEntries.female?.map(a => ({
    id: a,
    icon: "clothing/peds/" + a + ".webp",
    active: i?.modelName === a,
    category: "female"
  })));
  const d = async (a, b) => {
    j("modelName", a.id);
    const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "ped",
        data: {
          type: a.category,
          value: b
        }
      })
    }).then(b => b.json());
    c(d.cost);
    if (d.data.overwriteData) {
      j(d.data.overwriteData);
    }
  };
  const e = async (a, b) => {
    if (a === "Face") {
      const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          type: "drawable",
          name: "Face",
          component: b,
          texture: 0
        })
      }).then(b => b.json());
      c(d.cost);
      j("currentDrawables", "Face", d.data.currentDrawables.Face);
    } else {
      const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          type: "drawable",
          name: "Face",
          component: i.currentDrawables.Face[0],
          texture: b
        })
      }).then(b => b.json());
      c(d.cost);
      j("currentDrawables", "Face", d.data.currentDrawables.Face);
    }
  };
  return X(So, {
    get children() {
      return [X(Hp, {
        get items() {
          return a();
        },
        onClick: d,
        title: "Male Peds"
      }), X(Hp, {
        get items() {
          return b();
        },
        onClick: d,
        title: "Female Peds"
      }), X(Ma, {
        get when() {
          return i.drawables.Face.length > 1 || i.drawables.Face[i.currentDrawables.Face[0]] && !i.modelName.includes("freemode");
        },
        get children() {
          return X(Np, {
            title: "Face Skin",
            get firstInput() {
              return {
                id: "Face",
                value: i.currentDrawables.Face[0],
                max: i.drawables.Face.length - 1,
                onChange: e
              };
            },
            get secondInput() {
              return {
                id: "FaceTexture",
                value: i.currentDrawables.Face[1],
                max: i.drawables.Face[i.currentDrawables.Face[0]] - 1,
                onChange: e
              };
            }
          });
        }
      }), X(Sp, {
        title: "Custom Ped - Press Enter",
        get input() {
          return {
            id: "CustomPed",
            value: i.modelName,
            onChange: async (a, b) => {
              j("modelName", b);
              const c = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
                method: "POST",
                headers: {
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({
                  type: "ped",
                  data: {
                    type: "custom",
                    model: b
                  }
                })
              }).then(b => b.json());
              if (c.data.overwriteData) {
                j(c.data.overwriteData);
              }
            }
          };
        }
      })];
    }
  });
}
const Up = "_slider_pz2in_1";
const Vp = {
  slider: Up
};
const Wp = mb("<div><input step=\"0.01\" type=\"range\">");
const Xp = mb("<div class=\"w-full flex flex-row justify-between items-center gap-[1.5vh]\"><div><input step=\"0.01\" type=\"range\">");
function Ko(k) {
  return [X(Ma, {
    get when() {
      return k.title;
    },
    get children() {
      return X(gi, {
        get text() {
          return k.title;
        }
      });
    }
  }), (() => {
    const a = Xp();
    const b = a.firstChild;
    const d = b.firstChild;
    a.style.setProperty("direction", "rtl");
    oa(b, X(Ma, {
      get when() {
        return k.firstInput?.title;
      },
      get children() {
        return k.firstInput.title;
      }
    }), d);
    d.$$input = a => {
      const b = a.target;
      k.firstInput.onChange(k.firstInput.id, +b.value);
    };
    oa(a, X(Ma, {
      get when() {
        return k.secondInput;
      },
      get children() {
        const a = Wp();
        const c = a.firstChild;
        oa(a, X(Ma, {
          get when() {
            return k.secondInput?.title;
          },
          get children() {
            return k.secondInput.title;
          }
        }), c);
        c.$$input = a => {
          const b = a.target;
          k.secondInput.onChange(k.secondInput.id, +b.value);
        };
        p(d => {
          const b = Vp.slider;
          const e = k.secondInput.min ?? 0;
          const f = k.secondInput.max;
          const g = (k.secondInput.value - (k.secondInput.min ?? 0)) / (k.secondInput.max - (k.secondInput.min ?? 0)) * 100 + "% 100%";
          if (b !== d._v$) {
            qb(a, d._v$ = b);
          }
          if (e !== d._v$2) {
            ob(c, "min", d._v$2 = e);
          }
          if (f !== d._v$3) {
            ob(c, "max", d._v$3 = f);
          }
          if (g !== d._v$4) {
            if ((d._v$4 = g) != null) {
              c.style.setProperty("background-size", g);
            } else {
              c.style.removeProperty("background-size");
            }
          }
          return d;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined,
          _v$4: undefined
        });
        p(() => c.value = k.secondInput.value);
        return a;
      }
    }), null);
    p(a => {
      const c = Vp.slider;
      const e = k.firstInput.min ?? 0;
      const f = k.firstInput.max;
      const g = (k.firstInput.value - (k.firstInput.min ?? 0)) / (k.firstInput.max - (k.firstInput.min ?? 0)) * 100 + "% 100%";
      if (c !== a._v$5) {
        qb(b, a._v$5 = c);
      }
      if (e !== a._v$6) {
        ob(d, "min", a._v$6 = e);
      }
      if (f !== a._v$7) {
        ob(d, "max", a._v$7 = f);
      }
      if (g !== a._v$8) {
        if ((a._v$8 = g) != null) {
          d.style.setProperty("background-size", g);
        } else {
          d.style.removeProperty("background-size");
        }
      }
      return a;
    }, {
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined
    });
    p(() => d.value = k.firstInput.value);
    return a;
  })()];
}
nb(["input"]);
const Yp = "_container_m53fc_1";
const Zp = {
  container: Yp
};
const mn = mb("<div>");
function $p(b) {
  return (() => {
    const a = mn();
    oa(a, () => b.children);
    p(() => qb(a, Zp.container));
    return a;
  })();
}
const _p = "_randomize_epext_1";
const aq = {
  randomize: _p
};
const Pa = mb("<div>Randomize Face");
function bq() {
  const {
    clothingData: c,
    setBarberData: a
  } = vo();
  return (() => {
    const b = Pa();
    b.$$click = async () => {
      const b = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          type: "randomizeHeadblend",
          data: {}
        })
      }).then(a => a.json());
      if (b.data.currentHeadBlend) {
        a("currentHeadBlend", b.data.currentHeadBlend);
      }
    };
    p(() => qb(b, aq.randomize));
    return b;
  })();
}
nb(["click"]);
function cq() {
  const {
    clothingData: a,
    barberData: n,
    setBarberData: c,
    setCost: d
  } = vo();
  const b = s(() => Array.from(Array(n?.barberData.heads).keys()));
  const e = s(() => b().map((b, c) => {
    const d = c.toString().padStart(3, "0");
    return {
      id: "ShapeFirst",
      icon: "clothing/heads/" + a.modelName + "/SKEL_ROOT." + d + ".webp",
      active: n.currentHeadBlend.ShapeFirst === b
    };
  }));
  const f = s(() => b().map((b, c) => {
    const d = c.toString().padStart(3, "0");
    return {
      id: "SkinFirst",
      icon: "clothing/heads/" + a.modelName + "/SKEL_ROOT." + d + ".webp",
      active: n.currentHeadBlend.SkinFirst === b
    };
  }));
  const g = s(() => b().map((b, c) => {
    const d = c.toString().padStart(3, "0");
    return {
      id: "ShapeSecond",
      icon: "clothing/heads/" + a.modelName + "/SKEL_ROOT." + d + ".webp",
      active: n.currentHeadBlend.ShapeSecond === b
    };
  }));
  const h = s(() => b().map((b, c) => {
    const d = c.toString().padStart(3, "0");
    return {
      id: "SkinSecond",
      icon: "clothing/heads/" + a.modelName + "/SKEL_ROOT." + d + ".webp",
      active: n.currentHeadBlend.SkinSecond === b
    };
  }));
  const i = s(() => b().map((b, c) => {
    const d = c.toString().padStart(3, "0");
    return {
      id: "ShapeThird",
      icon: "clothing/heads/" + a.modelName + "/SKEL_ROOT." + d + ".webp",
      active: n.currentHeadBlend.ShapeThird === b
    };
  }));
  const j = s(() => b().map((b, c) => {
    const d = c.toString().padStart(3, "0");
    return {
      id: "SkinThird",
      icon: "clothing/heads/" + a.modelName + "/SKEL_ROOT." + d + ".webp",
      active: n.currentHeadBlend.SkinThird === b
    };
  }));
  const k = async (a, b) => {
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "headBlend",
        data: {
          ...n.currentHeadBlend,
          [a]: b
        }
      })
    }).then(b => b.json());
    d(e.cost);
    c("currentHeadBlend", {
      ...n.currentHeadBlend,
      [a]: b
    });
  };
  return X(Ma, {
    get when() {
      return n?.barberData;
    },
    get children() {
      return X(So, {
        style: {
          width: "34.5vh"
        },
        get children() {
          return [X(bq, {}), X($p, {
            get children() {
              return [X(Hp, {
                get items() {
                  return e();
                },
                onClick: (c, a) => k(c.id, a),
                title: "Face One"
              }), X(Hp, {
                get items() {
                  return f();
                },
                onClick: (c, a) => k(c.id, a),
                title: "Skin One"
              })];
            }
          }), X($p, {
            get children() {
              return [X(Hp, {
                get items() {
                  return g();
                },
                onClick: (c, a) => k(c.id, a),
                title: "Face Two"
              }), X(Hp, {
                get items() {
                  return h();
                },
                onClick: (c, a) => k(c.id, a),
                title: "Skin Two"
              })];
            }
          }), X($p, {
            get children() {
              return [X(Hp, {
                get items() {
                  return i();
                },
                onClick: (c, a) => k(c.id, a),
                title: "Face Three"
              }), X(Hp, {
                get items() {
                  return j();
                },
                onClick: (c, a) => k(c.id, a),
                title: "Skin Three"
              })];
            }
          }), X(Ko, {
            title: "Face Mix",
            get firstInput() {
              return {
                id: "ShapeMix",
                value: n.currentHeadBlend.ShapeMix,
                min: 0,
                max: 1,
                onChange: k
              };
            }
          }), X(Ko, {
            title: "Skin Mix",
            get firstInput() {
              return {
                id: "SkinMix",
                value: n.currentHeadBlend.SkinMix,
                min: 0,
                max: 1,
                onChange: k
              };
            }
          }), X(Ko, {
            title: "Third Mix",
            get firstInput() {
              return {
                id: "ThirdMix",
                value: n.currentHeadBlend.ThirdMix,
                min: 0,
                max: 1,
                onChange: k
              };
            }
          })];
        }
      });
    }
  });
}
function dq() {
  const {
    barberData: i,
    setBarberData: j,
    setCost: c
  } = vo();
  const a = async (b, a) => {
    const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "face",
        data: {
          ...i.currentFace,
          [b]: a
        }
      })
    }).then(b => b.json());
    c(d.cost);
    j("currentFace", {
      ...i.currentFace,
      [b]: a
    });
  };
  const b = [{
    title: "Nose",
    inputs: [[{
      id: "nose_width",
      title: "Width"
    }, {
      id: "nose_bone_curveness",
      title: "Bone Height"
    }], [{
      id: "nose_peak",
      title: "Peak Height"
    }, {
      id: "nose_length",
      title: "Peak Length"
    }], [{
      id: "nose_tip",
      title: "Peak Lowering"
    }, {
      id: "nose_bone_twist",
      title: "Bone Twist"
    }]]
  }, {
    title: "Eyebrows",
    inputs: [[{
      id: "eyebrow_up_down",
      title: "Eyebrow Height"
    }, {
      id: "eyebrow_in_out",
      title: "Eyebrow Depth"
    }]]
  }, {
    title: "Cheeks",
    inputs: [[{
      id: "cheek_bones",
      title: "Bone Height"
    }, {
      id: "cheek_sideways_bone_size",
      title: "Bone Width"
    }], [{
      id: "cheek_bones_width",
      title: "Cheek Width"
    }]]
  }, {
    title: "Jaw Bone",
    inputs: [[{
      id: "jaw_bone_width",
      title: "Bone Width"
    }, {
      id: "jaw_bone_shape",
      title: "Bone Length"
    }]]
  }, {
    title: "Chin",
    inputs: [[{
      id: "chin_bone",
      title: "Bone Height"
    }, {
      id: "chin_bone_length",
      title: "Bone Length"
    }], [{
      id: "chin_bone_shape",
      title: "Bone Width"
    }, {
      id: "chin_hole",
      title: "Chin Cleft"
    }]]
  }, {
    title: "Miscellaneous Features",
    inputs: [[{
      id: "eye_opening",
      title: "Eyes Squint"
    }, {
      id: "lip_thickness",
      title: "Lips Thickness"
    }], [{
      id: "neck_thickness",
      title: "Neck Thickness"
    }]]
  }];
  const d = s(() => {
    const a = i?.availableEyeColors.length ?? 0;
    return Array.from(Array(a - 1).keys()).map((b, a) => ({
      id: a,
      icon: "clothing/eyes/" + a + ".webp",
      active: i.currentEyeColor === a
    }));
  });
  const e = async (a, b) => {
    const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "eyeColor",
        data: b
      })
    }).then(b => b.json());
    c(d.cost);
    j("currentEyeColor", b);
  };
  return X(So, {
    get children() {
      return [X(sa, {
        each: b,
        children: b => X(sa, {
          get each() {
            return b.inputs;
          },
          children: (e, c) => X(Ko, {
            get title() {
              if (c() === 0) {
                return b.title;
              } else {
                return undefined;
              }
            },
            get firstInput() {
              return {
                title: e[0].title,
                id: e[0].id,
                value: i.currentFace[e[0].id],
                min: -1,
                max: 1,
                onChange: a
              };
            },
            get secondInput() {
              if (e.length > 1) {
                return {
                  title: e[1].title,
                  id: e[1].id,
                  value: i.currentFace[e[1].id],
                  min: -1,
                  max: 1,
                  onChange: a
                };
              } else {
                return undefined;
              }
            }
          })
        })
      }), X(Hp, {
        get items() {
          return d();
        },
        onClick: e,
        title: "Eye Color"
      })];
    }
  });
}
function eq() {
  const {
    barberData: i,
    setBarberData: a,
    setCost: b
  } = vo();
  const c = [{
    id: "Blemishes",
    title: "Blemishes",
    path: "clothing/blemishes/"
  }, {
    id: "Ageing",
    title: "Ageing",
    path: "clothing/ageing/"
  }, {
    id: "Complexion",
    title: "Complexion",
    path: "clothing/complexion/"
  }, {
    id: "SunDamage",
    title: "Sun Damage & Scars",
    path: "clothing/sundamage/"
  }, {
    id: "MolesFreckles",
    title: "Moles & Freckles",
    path: "clothing/molesfreckles/"
  }, {
    id: "ChestHair",
    title: "Chest Hair",
    path: "clothing/chesthair/"
  }, {
    id: "BodyBlemishes",
    title: "Body Blemishes",
    path: "clothing/bodyblemishes/"
  }, {
    id: "AddBodyBlemishes",
    title: "Add Body Blemishes",
    path: "clothing/addbodyblemishes/"
  }];
  const j = async (c, d) => {
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "overlays",
        data: {
          ...i.currentOverlays,
          [c.id]: {
            ...i.currentOverlays[c.id],
            value: d - 1
          }
        }
      })
    }).then(b => b.json());
    b(e.cost);
    a("currentOverlays", e.data.currentOverlays);
  };
  const d = async (c, d) => {
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "overlays",
        data: {
          ...i.currentOverlays,
          [c]: {
            ...i.currentOverlays[c],
            opacity: d
          }
        }
      })
    }).then(b => b.json());
    b(e.cost);
    a("currentOverlays", c, "opacity", d);
  };
  return X(So, {
    get children() {
      return X(sa, {
        each: c,
        children: c => {
          const a = i.barberData.headOverlays.find(a => a.name === c.id)?.total ?? 0;
          const b = Array.from(Array(a + 1).keys());
          const e = s(() => b.map((a, b) => ({
            id: c.id,
            icon: "" + c.path + (b - 1) + ".webp",
            active: i.currentOverlays[c.id].value === b - 1,
            text: b || "None"
          })));
          return [X(Hp, {
            get items() {
              return e();
            },
            onClick: j,
            get title() {
              return c.title;
            }
          }), X(Ko, {
            get firstInput() {
              return {
                title: "Opacity",
                id: c.id,
                value: i.currentOverlays[c.id].opacity,
                min: 0,
                max: 1,
                onChange: (c, a) => d(c, a)
              };
            }
          })];
        }
      });
    }
  });
}
const fq = "_colors_ypt65_1";
const gq = "_collapse_ypt65_23";
const hq = "_arrowBox_ypt65_27";
const iq = "_grid_ypt65_37";
const jq = "_colorBox_ypt65_44";
const kq = "_active_ypt65_52";
const lq = {
  colors: fq,
  collapse: gq,
  arrowBox: hq,
  grid: iq,
  colorBox: jq,
  active: kq
};
const mq = {
  padding: 0,
  border: 0,
  margin: 0
};
const nq = {
  display: "none",
  ...mq
};
const zn = {
  "will-change": "height"
};
const Ei = {
  overflow: "hidden",
  height: 0
};
const Go = typeof window !== "undefined" ? requestAnimationFrame : () => {};
const Xo = b => {
  let h;
  const i = aa({
    class: "",
    as: "div",
    value: true,
    onCollapsed: () => {},
    onExpanded: () => {}
  }, b);
  const [a, d] = Cr(i.value ? mq : nq);
  o(b => {
    const a = i.value;
    const c = typeof b !== "undefined" && b !== a;
    q(() => {
      if (c) {
        requestAnimationFrame(() => {
          if (a) {
            d({
              ...mq,
              ...zn,
              ...Ei
            });
            Go(() => {
              d(a => ({
                ...a,
                ...Yo(h.scrollHeight)
              }));
            });
          } else {
            d(a => ({
              ...a,
              ...zn,
              ...Yo(h.scrollHeight)
            }));
            Go(() => {
              d(b => ({
                ...b,
                ...Ei
              }));
            });
          }
        });
      }
    });
    return a;
  });
  function e(b) {
    if (b.target === h && b.propertyName === "height") {
      if (i.value) {
        if (h?.scrollHeight === parseFloat(b.target.style.height)) {
          d(mq);
          i.onExpanded();
        }
      } else if (h?.style.height === "0px") {
        d(nq);
        i.onCollapsed();
      }
    }
  }
  return X(Gb, {
    get style() {
      return a();
    },
    get id() {
      return i.id;
    },
    ref: b => h = b,
    get "aria-labelledby"() {
      return i["aria-labelledby"];
    },
    get role() {
      return i.role;
    },
    get component() {
      return i.as;
    },
    get class() {
      return i.class;
    },
    onTransitionEnd: e,
    get children() {
      return i.children;
    }
  });
};
function Yo(b = 0) {
  return {
    "--sc-auto-duration": Jo(b) + "ms",
    height: b + "px"
  };
}
function Jo(c = 0) {
  if (c === 0) {
    return 0;
  }
  const a = c / 36;
  return Math.round((4 + a ** 0.25 * 15 + a / 5) * 10);
}
const oq = mb("<div>");
const Qo = mb("<div><div class=\"w-full flex flex-row justify-between items-center\"><div><svg width=\"0.74vh\" height=\"0.46vh\" viewBox=\"0 0 8 5\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M1 1L4 4L7 1\" stroke=\"#00F8B9\">");
function pq(g) {
  const [f, a] = Cr(false);
  const [b, c] = Cr(false);
  return [X(Ma, {
    get when() {
      return g.title;
    },
    get children() {
      return X(gi, {
        get text() {
          return g.title;
        }
      });
    }
  }), (() => {
    const e = Qo();
    const d = e.firstChild;
    const h = d.firstChild;
    const i = h.firstChild;
    e.$$click = () => !b() && a(!f());
    oa(d, X(Ma, {
      get when() {
        return g.data?.title;
      },
      get children() {
        return g.data.title;
      }
    }), h);
    i.style.setProperty("transition", "transform 0.2s ease-in-out");
    oa(e, X(Xo, {
      get value() {
        return f();
      },
      get class() {
        return lq.collapse;
      },
      get children() {
        const a = oq();
        oa(a, X(sa, {
          get each() {
            return g.data.colors;
          },
          children: (a, b) => (() => {
            const d = oq();
            d.addEventListener("mouseleave", () => c(false));
            d.addEventListener("mouseenter", () => c(true));
            d.$$click = () => g.data.onChange(g.data.id, b());
            p(c => {
              const e = lq.colorBox;
              const f = "rgba(" + a.r + ", " + a.g + ", " + a.b + ", 1)";
              const h = {
                [lq.active]: b() === g.data.value
              };
              if (e !== c._v$4) {
                qb(d, c._v$4 = e);
              }
              if (f !== c._v$5) {
                if ((c._v$5 = f) != null) {
                  d.style.setProperty("background-color", f);
                } else {
                  d.style.removeProperty("background-color");
                }
              }
              c._v$6 = sb(d, h, c._v$6);
              return c;
            }, {
              _v$4: undefined,
              _v$5: undefined,
              _v$6: undefined
            });
            return d;
          })()
        }));
        p(() => qb(a, lq.grid));
        return a;
      }
    }), null);
    p(b => {
      const a = lq.colors;
      const c = lq.arrowBox;
      const d = f() ? "rotate(180deg)" : "rotate(0deg)";
      if (a !== b._v$) {
        qb(e, b._v$ = a);
      }
      if (c !== b._v$2) {
        qb(h, b._v$2 = c);
      }
      if (d !== b._v$3) {
        if ((b._v$3 = d) != null) {
          i.style.setProperty("transform", d);
        } else {
          i.style.removeProperty("transform");
        }
      }
      return b;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return e;
  })()];
}
nb(["click"]);
function el() {
  const {
    clothingData: l,
    barberData: m,
    setBarberData: a,
    setClothingData: b,
    setCost: n
  } = vo();
  const c = [{
    id: "Eyebrows",
    title: "Eyebrows",
    path: "clothing/eyebrows/"
  }, {
    id: "FacialHair",
    title: "Facial Hair",
    path: "clothing/facialhair/"
  }];
  const d = async (c, b) => {
    const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "overlays",
        data: {
          ...m.currentOverlays,
          [c.id]: {
            ...m.currentOverlays[c.id],
            value: b - 1
          }
        }
      })
    }).then(b => b.json());
    n(d.cost);
    a("currentOverlays", d.data.currentOverlays);
  };
  const e = async (c, b, d) => {
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "overlays",
        data: {
          ...m.currentOverlays,
          [c]: {
            ...m.currentOverlays[c],
            [d]: b
          }
        }
      })
    }).then(b => b.json());
    n(e.cost);
    a("currentOverlays", c, d, b);
  };
  const f = s(() => l.drawables.Hair.map((a, b) => ({
    id: a,
    icon: "clothing/hair/" + l.modelName + "/" + b + ".webp",
    active: l.currentDrawables.Hair[0] === b,
    text: b + 1
  })));
  const g = s(() => l.modelName.includes("freemode_01"));
  return X(So, {
    get children() {
      return [X(Ma, {
        get when() {
          return g();
        },
        get children() {
          return X(sa, {
            each: c,
            children: c => {
              const a = m.barberData.headOverlays.find(a => a.name === c.id)?.total ?? 0;
              const b = Array.from(Array(a + 1).keys());
              const f = s(() => b.map((a, b) => ({
                id: c.id,
                icon: "" + c.path + (b - 1) + ".webp",
                active: m.currentOverlays[c.id].value === b - 1,
                text: b || "None"
              })));
              return [X(Hp, {
                get items() {
                  return f();
                },
                onClick: d,
                get title() {
                  return c.title;
                }
              }), X(Ko, {
                get firstInput() {
                  return {
                    title: "Opacity",
                    id: c.id,
                    value: m.currentOverlays[c.id].opacity,
                    min: 0,
                    max: 1,
                    onChange: (b, a) => e(b, a, "opacity")
                  };
                }
              }), X(pq, {
                get data() {
                  return {
                    title: "Color",
                    id: c.id,
                    value: m.currentOverlays[c.id].firstColor,
                    colors: l.hairColors,
                    onChange: (c, a) => e(c, a, "firstColor")
                  };
                }
              }), X(pq, {
                get data() {
                  return {
                    title: "Highlight Color",
                    id: c.id,
                    value: m.currentOverlays[c.id].secondColor,
                    colors: l.hairColors,
                    onChange: (c, a) => e(c, a, "secondColor")
                  };
                }
              })];
            }
          });
        }
      }), X(Hp, {
        get items() {
          return f();
        },
        onClick: async (d, a) => {
          const c = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
            method: "POST",
            headers: {
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              type: "drawable",
              data: {
                name: "Hair",
                component: a,
                texture: l.currentDrawables.Hair[1]
              }
            })
          }).then(b => b.json());
          n(c.cost);
          b("currentDrawables", "Hair", c.data.currentDrawables.Hair);
        },
        title: "Hair"
      }), X(Np, {
        title: "Hair Texture",
        get firstInput() {
          return {
            id: "Face",
            value: l.currentDrawables.Hair[1],
            min: 0,
            max: l.drawables.Hair[l.currentDrawables.Hair[0]] - 1,
            onChange: async (a, c) => {
              const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
                method: "POST",
                headers: {
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({
                  type: "drawable",
                  data: {
                    name: "Hair",
                    component: l.currentDrawables.Hair[0],
                    texture: c
                  }
                })
              }).then(b => b.json());
              n(d.cost);
              b("currentDrawables", "Hair", d.data.currentDrawables.Hair);
            }
          };
        }
      }), X(Np, {
        title: "Hair Fade",
        get firstInput() {
          return {
            id: "fade",
            value: m.availableFades.findIndex(a => a.collection === m.currentFade.collection && a.overlay === m.currentFade.overlay) ?? -1,
            min: -1,
            max: m.availableFades.length,
            onChange: async (c, b) => {
              const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
                method: "POST",
                headers: {
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({
                  type: "fade",
                  data: {
                    ...m.availableFades[b]
                  }
                })
              }).then(b => b.json());
              n(d.cost);
              a("currentFade", d.data.currentFade);
            }
          };
        }
      }), X(pq, {
        get data() {
          return {
            title: "Hair Color",
            id: "HairColor",
            value: m.currentHair.color,
            colors: l.hairColors,
            onChange: async (c, b) => {
              const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
                method: "POST",
                headers: {
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({
                  type: "hairColors",
                  data: {
                    ...m.currentHair,
                    color: b
                  }
                })
              }).then(b => b.json());
              n(d.cost);
              a("currentHair", d.data.currentHair);
            }
          };
        }
      }), X(pq, {
        get data() {
          return {
            title: "Highlight Color",
            id: "highlightColor",
            value: m.currentHair.highlightColor,
            colors: l.hairColors,
            onChange: async (c, b) => {
              const d = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
                method: "POST",
                headers: {
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({
                  type: "hairColors",
                  data: {
                    ...m.currentHair,
                    highlightColor: b
                  }
                })
              }).then(b => b.json());
              n(d.cost);
              a("currentHair", d.data.currentHair);
            }
          };
        }
      })];
    }
  });
}
function qq() {
  const {
    barberData: j,
    setBarberData: a,
    setCost: b
  } = vo();
  const c = [{
    id: "Makeup",
    title: "Makeup",
    path: "clothing/makeup/"
  }, {
    id: "Blush",
    title: "Blush",
    path: "clothing/blush/"
  }, {
    id: "Lipstick",
    title: "Lipstick",
    path: "clothing/lipstick/"
  }];
  const i = async (c, d) => {
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "overlays",
        data: {
          ...j.currentOverlays,
          [c.id]: {
            ...j.currentOverlays[c.id],
            value: d - 1
          }
        }
      })
    }).then(b => b.json());
    b(e.cost);
    a("currentOverlays", e.data.currentOverlays);
  };
  const d = async (c, d, e) => {
    const f = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "overlays",
        data: {
          ...j.currentOverlays,
          [c]: {
            ...j.currentOverlays[c],
            [e]: d
          }
        }
      })
    }).then(b => b.json());
    b(f.cost);
    a("currentOverlays", c, e, d);
  };
  return X(So, {
    get children() {
      return X(sa, {
        each: c,
        children: c => {
          const a = j.barberData.headOverlays.find(a => a.name === c.id)?.total ?? 0;
          const b = Array.from(Array(a + 1).keys());
          const e = s(() => b.map((a, b) => ({
            id: c.id,
            icon: "" + c.path + (b - 1) + ".webp",
            active: j.currentOverlays[c.id].value === b - 1,
            text: b || "None"
          })));
          return [X(Hp, {
            get items() {
              return e();
            },
            onClick: i,
            get title() {
              return c.title;
            }
          }), X(Ko, {
            get firstInput() {
              return {
                title: "Opacity",
                id: c.id,
                value: j.currentOverlays[c.id].opacity,
                min: 0,
                max: 1,
                onChange: (c, a) => d(c, a, "opacity")
              };
            }
          }), X(pq, {
            get data() {
              return {
                title: "First Color",
                id: c.id,
                value: j.currentOverlays[c.id].firstColor,
                colors: j.makeupColors,
                onChange: (c, a) => d(c, a, "firstColor")
              };
            }
          }), X(pq, {
            get data() {
              return {
                title: "Second Color",
                id: c.id,
                value: j.currentOverlays[c.id].secondColor,
                colors: j.makeupColors,
                onChange: (c, a) => d(c, a, "secondColor")
              };
            }
          })];
        }
      });
    }
  });
}
function Hn() {
  const {
    clothingData: k,
    setClothingData: a,
    setCost: c,
    type: d,
    clothingPage: e
  } = vo();
  const b = [{
    id: "Jacket",
    title: "Jacket"
  }, {
    id: "Undershirt",
    title: "Undershirt"
  }, {
    id: "Torso",
    title: "Arms / Gloves"
  }, {
    id: "Leg",
    title: "Pants"
  }, {
    id: "Shoes",
    title: "Shoes"
  }, {
    id: "Badge",
    title: "Decals"
  }, {
    id: "Mask",
    title: "Masks"
  }, {
    id: "Accessory",
    title: "Scarfs & Necklaces"
  }, {
    id: "Kevlar",
    title: "Vest"
  }, {
    id: "Parachute",
    title: "Bags"
  }];
  const l = (a, c) => !!k.whitelistedClothing?.[k.gender]?.[a]?.find(a => a.componentId === c);
  const f = async (d, b) => {
    if (l(d, b)) {
      return;
    }
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "drawable",
        data: {
          name: d,
          component: b,
          texture: 0
        }
      })
    }).then(b => b.json());
    c(e.cost);
    a("currentDrawables", e.data.currentDrawables);
  };
  const g = async (b, d) => {
    if (l(b, k.currentDrawables[b][0])) {
      return;
    }
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "drawable",
        data: {
          name: b,
          component: k.currentDrawables[b][0],
          texture: d
        }
      })
    }).then(b => b.json());
    c(e.cost);
    a("currentDrawables", e.data.currentDrawables);
  };
  return X(So, {
    get children() {
      return X(sa, {
        get each() {
          return b.filter(a => d() !== "clothing" ? true : e() === a.id);
        },
        children: b => {
          const a = s(() => k.drawables[b.id]?.map((a, c) => l(b.id, c) ? {
            id: b.id,
            icon: "null",
            active: false,
            text: c
          } : {
            id: b.id,
            icon: "clothing/" + b.id + "/" + k.modelName + "/" + c + ".webp",
            active: k?.currentDrawables[b.id][0] === c,
            text: c
          }));
          return [X(Hp, {
            get items() {
              return a();
            },
            onClick: (c, a) => f(c.id, a),
            get title() {
              return b.title;
            }
          }), X(Np, {
            get firstInput() {
              return {
                id: b.id,
                value: k.currentDrawables[b.id][0],
                max: k.drawables[b.id].length - 1,
                onChange: (c, a) => f(c, a)
              };
            },
            get secondInput() {
              return {
                id: b.id,
                value: k.currentDrawables[b.id][1],
                max: k.drawables[b.id][k.currentDrawables[b.id][0]] - 1,
                onChange: (c, a) => g(c, a)
              };
            }
          })];
        }
      });
    }
  });
}
function rq() {
  const {
    clothingData: k,
    setClothingData: a,
    setCost: c,
    type: b,
    clothingPage: d
  } = vo();
  const e = [{
    id: "Hat",
    title: "Hat"
  }, {
    id: "Glasses",
    title: "Glasses"
  }, {
    id: "Ears",
    title: "Earrings"
  }, {
    id: "Watch",
    title: "Watches"
  }, {
    id: "Bracelet",
    title: "Bracelets"
  }];
  const l = (a, c) => !!k.whitelistedClothing?.[k.gender]?.[a]?.find(a => a.componentId === c);
  const f = async (d, b) => {
    if (l(d, b)) {
      return;
    }
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "prop",
        data: {
          name: d,
          component: b,
          texture: 0
        }
      })
    }).then(b => b.json());
    c(e.cost);
    a("currentProps", e.data.currentProps);
  };
  const g = async (b, d) => {
    if (l(b, k.currentProps[b][0])) {
      return;
    }
    const e = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "prop",
        data: {
          name: b,
          component: k.currentProps[b][0],
          texture: d
        }
      })
    }).then(b => b.json());
    c(e.cost);
    a("currentProps", e.data.currentProps);
  };
  return X(So, {
    get children() {
      return X(sa, {
        get each() {
          return e.filter(c => b() !== "clothing" ? true : d() === c.id);
        },
        children: b => {
          const a = s(() => {
            const a = k.props[b.id]?.map((a, c) => l(b.id, c) ? {
              id: b.id,
              index: c,
              icon: "null",
              active: false,
              text: c + 1
            } : {
              id: b.id,
              index: c,
              icon: "clothing/" + b.id + "/" + k.modelName + "/" + c + ".webp",
              active: k?.currentProps[b.id][0] === c,
              text: c + 1
            });
            a.unshift({
              id: b.id,
              index: -1,
              icon: "clothing/" + b.id + "/default.webp",
              active: k?.currentProps[b.id][0] === -1,
              text: "None"
            });
            return a;
          });
          return [X(Hp, {
            get items() {
              return a();
            },
            onClick: (c, a) => f(c.id, c.index),
            get title() {
              return b.title;
            }
          }), X(Np, {
            get firstInput() {
              return {
                id: b.id,
                value: k.currentProps[b.id][0],
                max: k.props[b.id].length - 1,
                onChange: (c, a) => f(c, a)
              };
            },
            get secondInput() {
              return {
                id: b.id,
                value: k.currentProps[b.id][1],
                max: k.props[b.id][k.currentProps[b.id][0]] - 1,
                onChange: (c, a) => g(c, a)
              };
            }
          })];
        }
      });
    }
  });
}
const sq = "_container_1hnhx_1";
const tq = "_payment_1hnhx_15";
const uq = "_button_1hnhx_23";
const vq = "_texts_1hnhx_47";
const wq = "_title_1hnhx_55";
const xq = "_description_1hnhx_70";
const yq = {
  container: sq,
  payment: tq,
  button: uq,
  texts: vq,
  title: wq,
  description: xq
};
const zq = mb("<div><div><div><span>Payment</span> <span>$</span></div><div>Total Price</div></div><div><div>Pay via Banking Card</div><div>Pay via Cash");
function Aq() {
  const {
    cost: n,
    setModalData: a,
    isFree: b,
    type: c
  } = vo();
  const d = d => {
    a({
      show: true,
      discard: false,
      action: () => {
        fetch("https://karma-clothing/karma-clothing:ui:close", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            action: d,
            type: c(),
            cost: b() ? undefined : n()
          })
        });
      }
    });
  };
  return (() => {
    const b = zq();
    const c = b.firstChild;
    const e = c.firstChild;
    const a = e.firstChild;
    const f = a.nextSibling;
    const g = f.nextSibling;
    g.firstChild;
    const h = e.nextSibling;
    const i = c.nextSibling;
    const j = i.firstChild;
    const k = j.nextSibling;
    oa(g, n, null);
    j.$$click = () => {
      d("bank");
    };
    k.$$click = () => {
      d("cash");
    };
    p(d => {
      const a = yq.container;
      const f = yq.texts;
      const g = yq.title;
      const l = yq.description;
      const m = yq.payment;
      const n = yq.button;
      const o = yq.button;
      if (a !== d._v$) {
        qb(b, d._v$ = a);
      }
      if (f !== d._v$2) {
        qb(c, d._v$2 = f);
      }
      if (g !== d._v$3) {
        qb(e, d._v$3 = g);
      }
      if (l !== d._v$4) {
        qb(h, d._v$4 = l);
      }
      if (m !== d._v$5) {
        qb(i, d._v$5 = m);
      }
      if (n !== d._v$6) {
        qb(j, d._v$6 = n);
      }
      if (o !== d._v$7) {
        qb(k, d._v$7 = o);
      }
      return d;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined
    });
    return b;
  })();
}
nb(["click"]);
const sn = "_confirm_e713z_1";
const Bq = {
  confirm: sn
};
const Cq = mb("<div>Finish");
function Dq() {
  const {
    setModalData: b
  } = vo();
  return (() => {
    const a = Cq();
    a.$$click = () => {
      b({
        show: true,
        discard: false,
        action: () => {
          fetch("https://karma-clothing/karma-clothing:ui:close", {
            method: "POST",
            headers: {
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              action: "cash",
              type: "spawn"
            })
          });
        }
      });
    };
    p(() => qb(a, Bq.confirm));
    return a;
  })();
}
nb(["click"]);
const Eq = "_modal_4ebh2_1";
const Fq = "_title_4ebh2_12";
const Gq = "_description_4ebh2_22";
const Hq = "_button_4ebh2_31";
const Iq = "_red_4ebh2_53";
const Jq = {
  modal: Eq,
  title: Fq,
  description: Gq,
  button: Hq,
  red: Iq
};
const Kq = mb("<div>Cash ($<!>)");
const Lq = mb("<div>Bank ($<!>)");
const Mq = mb("<div>Discard");
const Nq = mb("<div class=\"absolute flex h-full w-full items-center justify-center\"><div><div></div><div></div><div class=\"flex flex-row items-center justify-center gap-[1vh]\"><div>Cancel");
const Oq = mb("<div>Finalize Character");
function tl() {
  const {
    modalData: a,
    setModalData: b,
    type: c,
    cost: d,
    isFree: e
  } = vo();
  const f = () => c() === "spawn" ? "This will confirm the creation of your character." : "This will confirm the purchase of your clothing $" + d() + ".";
  const g = () => "Are you sure?";
  return (() => {
    const h = Nq();
    const i = h.firstChild;
    const j = i.firstChild;
    const k = j.nextSibling;
    const l = k.nextSibling;
    const m = l.firstChild;
    oa(j, g);
    oa(k, f);
    oa(l, X(Ma, {
      get when() {
        return c() !== "spawn";
      },
      get fallback() {
        return [(() => {
          const a = Oq();
          a.$$click = () => {
            fetch("https://karma-clothing/karma-clothing:ui:close", {
              method: "POST",
              headers: {
                "Content-Type": "application/json"
              },
              body: JSON.stringify({
                action: "cash",
                type: c(),
                cost: e() ? undefined : d()
              })
            });
          };
          p(() => qb(a, Jq.button));
          return a;
        })(), (() => {
          const c = Mq();
          c.$$click = () => {
            a.action();
            b({
              show: false,
              discard: false
            });
          };
          p(a => {
            const b = Jq.button;
            const d = {
              [Jq.red]: true
            };
            if (b !== a._v$8) {
              qb(c, a._v$8 = b);
            }
            a._v$9 = sb(c, d, a._v$9);
            return a;
          }, {
            _v$8: undefined,
            _v$9: undefined
          });
          return c;
        })()];
      },
      get children() {
        return [(() => {
          const a = Kq();
          const b = a.firstChild;
          const f = b.nextSibling;
          f.nextSibling;
          a.$$click = () => {
            fetch("https://karma-clothing/karma-clothing:ui:close", {
              method: "POST",
              headers: {
                "Content-Type": "application/json"
              },
              body: JSON.stringify({
                action: "cash",
                type: c(),
                cost: e() ? undefined : d()
              })
            });
          };
          oa(a, d, f);
          p(() => qb(a, Jq.button));
          return a;
        })(), (() => {
          const a = Lq();
          const b = a.firstChild;
          const f = b.nextSibling;
          f.nextSibling;
          a.$$click = () => {
            fetch("https://karma-clothing/karma-clothing:ui:close", {
              method: "POST",
              headers: {
                "Content-Type": "application/json"
              },
              body: JSON.stringify({
                action: "bank",
                type: c(),
                cost: e() ? undefined : d()
              })
            });
          };
          oa(a, d, f);
          p(() => qb(a, Jq.button));
          return a;
        })(), (() => {
          const c = Mq();
          c.$$click = () => {
            a.action();
            b({
              show: false,
              discard: false
            });
          };
          p(a => {
            const b = Jq.button;
            const d = {
              [Jq.red]: true
            };
            if (b !== a._v$) {
              qb(c, a._v$ = b);
            }
            a._v$2 = sb(c, d, a._v$2);
            return a;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return c;
        })()];
      }
    }), m);
    m.$$click = () => {
      b({
        show: false,
        discard: false
      });
    };
    p(b => {
      const a = Jq.modal;
      const c = Jq.title;
      const d = Jq.description;
      const e = Jq.button;
      const f = {
        [Jq.red]: true
      };
      if (a !== b._v$3) {
        qb(i, b._v$3 = a);
      }
      if (c !== b._v$4) {
        qb(j, b._v$4 = c);
      }
      if (d !== b._v$5) {
        qb(k, b._v$5 = d);
      }
      if (e !== b._v$6) {
        qb(m, b._v$6 = e);
      }
      b._v$7 = sb(m, f, b._v$7);
      return b;
    }, {
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined
    });
    return h;
  })();
}
nb(["click"]);
var Pq = () => {};
var Qq = (c, a) => a();
function Rq(p, a) {
  const b = q(p);
  const c = b ? [b] : [];
  const {
    onEnter: d = Qq,
    onExit: e = Qq
  } = a;
  const [f, g] = Cr(a.appear ? [] : c);
  const [h] = w();
  let i;
  let j = false;
  function r(c, a) {
    if (!c) {
      return a && a();
    }
    j = true;
    e(c, () => {
      m(() => {
        j = false;
        g(a => a.filter(a => a !== c));
        if (a) {
          a();
        }
      });
    });
  }
  function s(c) {
    const e = i;
    if (!e) {
      return c && c();
    }
    i = undefined;
    g(b => [e, ...b]);
    d(e, c ?? Pq);
  }
  const n = a.mode === "out-in" ? b => j || r(b, s) : a.mode === "in-out" ? b => s(() => r(b)) : b => {
    r(b);
    s();
  };
  Dr(a => {
    const b = p();
    if (q(h)) {
      h();
      return a;
    } else {
      if (b !== a) {
        i = b;
        m(() => q(() => n(a)));
      }
      return b;
    }
  }, a.appear ? undefined : b);
  return f;
}
var Sq = b => b instanceof Element;
function nl(d, e) {
  if (e(d)) {
    return d;
  }
  if (typeof d == "function" && !d.length) {
    return nl(d(), e);
  }
  if (Array.isArray(d)) {
    for (const b of d) {
      const c = nl(b, e);
      if (c) {
        return c;
      }
    }
  }
  return null;
}
function Tq(e, a = undefined, f = undefined) {
  if (a === undefined) a = Sq;
  if (f === undefined) f = Sq;
  const g = s(e);
  return s(() => nl(g(), a));
}
function rl(b) {
  return s(() => {
    const a = b.name || "s";
    return {
      enterActive: (b.enterActiveClass || a + "-enter-active").split(" "),
      enter: (b.enterClass || a + "-enter").split(" "),
      enterTo: (b.enterToClass || a + "-enter-to").split(" "),
      exitActive: (b.exitActiveClass || a + "-exit-active").split(" "),
      exit: (b.exitClass || a + "-exit").split(" "),
      exitTo: (b.exitToClass || a + "-exit-to").split(" "),
      move: (b.moveClass || a + "-move").split(" ")
    };
  });
}
function Uq(b) {
  requestAnimationFrame(() => requestAnimationFrame(b));
}
function Vq(e, a, j, b) {
  const {
    onBeforeEnter: c,
    onEnter: d,
    onAfterEnter: f
  } = a;
  c?.(j);
  j.classList.add(...e.enter);
  j.classList.add(...e.enterActive);
  queueMicrotask(() => {
    if (!j.parentNode) {
      return b?.();
    }
    d?.(j, () => g());
  });
  Uq(() => {
    j.classList.remove(...e.enter);
    j.classList.add(...e.enterTo);
    if (!d || d.length < 2) {
      j.addEventListener("transitionend", g);
      j.addEventListener("animationend", g);
    }
  });
  function g(a) {
    if (!a || a.target === j) {
      b?.();
      j.removeEventListener("transitionend", g);
      j.removeEventListener("animationend", g);
      j.classList.remove(...e.enterActive);
      j.classList.remove(...e.enterTo);
      f?.(j);
    }
  }
}
function Wq(e, a, j, b) {
  const {
    onBeforeExit: c,
    onExit: d,
    onAfterExit: f
  } = a;
  if (!j.parentNode) {
    return b?.();
  }
  c?.(j);
  j.classList.add(...e.exit);
  j.classList.add(...e.exitActive);
  d?.(j, () => g());
  Uq(() => {
    j.classList.remove(...e.exit);
    j.classList.add(...e.exitTo);
    if (!d || d.length < 2) {
      j.addEventListener("transitionend", g);
      j.addEventListener("animationend", g);
    }
  });
  function g(a) {
    if (!a || a.target === j) {
      b?.();
      j.removeEventListener("transitionend", g);
      j.removeEventListener("animationend", g);
      j.classList.remove(...e.exitActive);
      j.classList.remove(...e.exitTo);
      f?.(j);
    }
  }
}
var Nc = {
  inout: "in-out",
  outin: "out-in"
};
var Xq = e => {
  const a = rl(e);
  return Rq(Tq(() => e.children), {
    mode: Nc[e.mode],
    appear: e.appear,
    onEnter(c, b) {
      Vq(a(), e, c, b);
    },
    onExit(c, b) {
      Wq(a(), e, c, b);
    }
  });
};
const Yq = "_content_1ewqt_1";
const Zq = "_list_1ewqt_10";
const $q = "_row_1ewqt_22";
const _q = "_column_1ewqt_30";
const ar = "_item_1ewqt_39";
const br = "_big_1ewqt_56";
const cr = "_medium_1ewqt_60";
const dr = "_full_1ewqt_63";
const er = "_image_1ewqt_74";
const fr = "_box_1ewqt_86";
const gr = {
  content: Yq,
  list: Zq,
  row: $q,
  column: _q,
  item: ar,
  big: br,
  medium: cr,
  full: dr,
  image: er,
  box: fr
};
const hr = mb("<div><div></div><div>");
const ir = mb("<div><div><div><div></div><div>");
function jr(d) {
  const {
    setPage: a,
    setClothingPage: b
  } = vo();
  return (() => {
    const c = hr();
    const e = c.firstChild;
    const f = e.nextSibling;
    c.$$click = () => {
      a(d.type);
      b(d.id);
    };
    oa(f, () => d.label);
    p(a => {
      const b = gr.item;
      const g = {
        [gr.big]: d.big,
        [gr.medium]: d.medium,
        [gr.full]: d.full
      };
      const h = gr.image;
      const i = "url(./clothing/" + d.icon + ".png)";
      const j = gr.box;
      if (b !== a._v$) {
        qb(c, a._v$ = b);
      }
      a._v$2 = sb(c, g, a._v$2);
      if (h !== a._v$3) {
        qb(e, a._v$3 = h);
      }
      if (i !== a._v$4) {
        if ((a._v$4 = i) != null) {
          e.style.setProperty("background-image", i);
        } else {
          e.style.removeProperty("background-image");
        }
      }
      if (j !== a._v$5) {
        qb(f, a._v$5 = j);
      }
      return a;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined
    });
    return c;
  })();
}
function kr() {
  return (() => {
    const a = ir();
    const b = a.firstChild;
    const c = b.firstChild;
    const d = c.firstChild;
    const e = d.nextSibling;
    oa(d, X(jr, {
      id: "Jacket",
      label: "Jacket",
      icon: "jackets",
      big: true,
      type: "clothing"
    }), null);
    oa(d, X(jr, {
      id: "Leg",
      label: "Pants",
      icon: "pants",
      medium: true,
      type: "clothing"
    }), null);
    oa(d, X(jr, {
      id: "Ears",
      label: "Earrings",
      icon: "earrings",
      medium: true,
      type: "accessories"
    }), null);
    oa(d, X(jr, {
      id: "Badge",
      label: "Decals",
      icon: "badge",
      medium: true,
      type: "clothing"
    }), null);
    oa(d, X(jr, {
      id: "Watch",
      label: "Watches",
      icon: "watch",
      medium: true,
      type: "accessories"
    }), null);
    oa(d, X(jr, {
      id: "Accessory",
      label: "Scarfs & Necklaces",
      icon: "accessory",
      medium: true,
      type: "clothing"
    }), null);
    oa(d, X(jr, {
      id: "Shoes",
      label: "Shoes",
      icon: "shoes",
      medium: true,
      type: "clothing"
    }), null);
    oa(e, X(jr, {
      id: "Hat",
      label: "Hat",
      icon: "hats",
      type: "accessories"
    }), null);
    oa(e, X(jr, {
      id: "Mask",
      label: "Masks",
      icon: "masks",
      type: "clothing"
    }), null);
    oa(e, X(jr, {
      id: "Glasses",
      label: "Glasses",
      icon: "glasses",
      type: "accessories"
    }), null);
    oa(e, X(jr, {
      id: "Undershirt",
      label: "Undershirt",
      icon: "tshirts",
      type: "clothing"
    }), null);
    oa(e, X(jr, {
      id: "Parachute",
      label: "Bags",
      icon: "backpacks",
      type: "clothing"
    }), null);
    oa(e, X(jr, {
      id: "Torso",
      label: "Arms & Gloves",
      icon: "torso",
      type: "clothing"
    }), null);
    oa(e, X(jr, {
      id: "Bracelet",
      label: "Bracelets",
      icon: "bracelet",
      type: "accessories"
    }), null);
    oa(e, X(jr, {
      id: "Kevlar",
      label: "Vest",
      icon: "kevlar",
      type: "clothing"
    }), null);
    p(f => {
      const g = gr.content;
      const h = gr.list;
      const i = gr.row;
      const j = gr.column;
      const k = gr.column;
      if (g !== f._v$6) {
        qb(a, f._v$6 = g);
      }
      if (h !== f._v$7) {
        qb(b, f._v$7 = h);
      }
      if (i !== f._v$8) {
        qb(c, f._v$8 = i);
      }
      if (j !== f._v$9) {
        qb(d, f._v$9 = j);
      }
      if (k !== f._v$10) {
        qb(e, f._v$10 = k);
      }
      return f;
    }, {
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined,
      _v$10: undefined
    });
    return a;
  })();
}
nb(["click"]);
const lr = "_goBack_154md_1";
const Qe = "_arrowBox_154md_29";
const mr = {
  goBack: lr,
  arrowBox: Qe
};
const nr = mb("<div><div><svg width=\"0.74vh\" height=\"0.46vh\" viewBox=\"0 0 8 5\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M1 1L4 4L7 1\" stroke=\"#00F8B9\"></path></svg></div>Go Back");
function or() {
  const {
    setPage: b
  } = vo();
  return (() => {
    const g = nr();
    const c = g.firstChild;
    const a = c.firstChild;
    g.$$click = () => {
      b("");
    };
    a.style.setProperty("transform", "rotate(90deg)");
    a.style.setProperty("transition", "transform 0.2s ease-in-out");
    p(b => {
      const a = mr.goBack;
      const d = mr.arrowBox;
      if (a !== b._v$) {
        qb(g, b._v$ = a);
      }
      if (d !== b._v$2) {
        qb(c, b._v$2 = d);
      }
      return b;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return g;
  })();
}
nb(["click"]);
const il = "_scroll_1wewy_1";
const pr = {
  scroll: il
};
const qr = mb("<div>SCROLL HERE");
function rr() {
  return (() => {
    const a = qr();
    a.addEventListener("wheel", a => {
      Ro.scroll({
        top: Ro.scrollTop + a.deltaY
      });
    });
    p(() => qb(a, pr.scroll));
    return a;
  })();
}
function sr() {
  const {
    clothingData: j,
    setClothingData: a,
    setCost: b,
    page: g
  } = vo();
  const c = s(() => {
    const b = g();
    const c = j?.currentTattoos;
    return j?.tattoos[b]?.map(d => ({
      id: g(),
      data: d,
      icon: "clothing/tattoos/" + d.overlay + ".webp",
      active: c[b]?.find(a => a.overlay === d.overlay),
      text: d.label
    }));
  });
  const d = async (c, d) => {
    const e = c.id;
    const f = j.currentTattoos?.[e]?.find(b => b.overlay === c.data.overlay);
    const g = await fetch("https://karma-clothing/karma-clothing:ui:onChange", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        type: "tattoo",
        data: {
          ...(j.currentTattoos ?? {}),
          [c.id]: f ? j.currentTattoos?.[e]?.filter(b => b.overlay !== c.data.overlay) : [...(j.currentTattoos?.[e] ?? []), c.data]
        }
      })
    }).then(b => b.json());
    b(g.cost);
    a("currentTattoos", g.data.currentTattoos);
  };
  return X(So, {
    get children() {
      return X(Hp, {
        get items() {
          return c();
        },
        onClick: d,
        title: "Tattos"
      });
    }
  });
}
const tr = mb("<div><div><div class=\"w-full h-full flex flex-row justify-end items-start gap-[1.5vh]\"><div class=\"w-full h-full flex flex-col justify-start items-center gap-[1.2vh]\">");
const ur = Math.random();
function vr() {
  const {
    visible: q,
    page: a,
    setVisible: b,
    clothingData: c,
    setClothingData: d,
    setBarberData: e,
    setCost: f,
    type: u,
    setType: g,
    setIsFree: h,
    modalData: i,
    setModalData: j,
    setPage: k
  } = vo();
  const l = b => {
    if (b.key === "Escape" && q()) {
      j({
        show: true,
        discard: true,
        action: () => fetch("https://karma-clothing/karma-clothing:ui:close", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            action: "discard"
          })
        })
      });
    }
  };
  r(async () => {
    document.addEventListener("keydown", l);
  });
  t(() => {
    document.removeEventListener("keydown", l);
  });
  window.addEventListener("message", async (a, m) => {
    let c = a.data.action;
    let i = a.data.data;
    switch (c) {
      case "clothing:show":
        if (i.show) {
          d(i.data);
          e(i.barberData);
          f(0);
          g(i.type || "clothing");
          j({
            show: false,
            discard: false
          });
          h(i.isFree || false);
          if (i.type === "clothing") {
            k("");
          } else if (i.type === "tattoo") {
            k("ZONE_HEAD");
          } else {
            k("peds");
          }
          b(true);
        } else {
          b(false);
        }
    }
  });
  return X(Ma, {
    get when() {
      return q() && c?.modelName;
    },
    get children() {
      return [(() => {
        const i = tr();
        const b = i.firstChild;
        const c = b.firstChild;
        const d = c.firstChild;
        oa(b, X(co, {}), c);
        oa(c, X(rr, {}), d);
        oa(d, X(Mo, {}), null);
        oa(d, X(Ma, {
          get when() {
            return s(() => a() === "")() && u() === "clothing";
          },
          get children() {
            return X(kr, {});
          }
        }), null);
        oa(d, X(Ma, {
          get when() {
            return s(() => a() !== "")() && u() === "clothing";
          },
          get children() {
            return X(or, {});
          }
        }), null);
        oa(d, X(Ua, {
          get children() {
            return [X(_a, {
              get when() {
                return a() === "peds";
              },
              get children() {
                return X(Tp, {});
              }
            }), X(_a, {
              get when() {
                return a() === "face";
              },
              get children() {
                return X(cq, {});
              }
            }), X(_a, {
              get when() {
                return a() === "facefeat";
              },
              get children() {
                return X(dq, {});
              }
            }), X(_a, {
              get when() {
                return a() === "skin";
              },
              get children() {
                return X(eq, {});
              }
            }), X(_a, {
              get when() {
                return a() === "hair";
              },
              get children() {
                return X(el, {});
              }
            }), X(_a, {
              get when() {
                return a() === "makeup";
              },
              get children() {
                return X(qq, {});
              }
            }), X(_a, {
              get when() {
                return a() === "clothing";
              },
              get children() {
                return X(Hn, {});
              }
            }), X(_a, {
              get when() {
                return a() === "accessories";
              },
              get children() {
                return X(rq, {});
              }
            }), X(_a, {
              get when() {
                return a().includes("ZONE_");
              },
              get children() {
                return X(sr, {});
              }
            })];
          }
        }), null);
        oa(d, X(Ua, {
          get children() {
            return [X(_a, {
              get when() {
                return u() === "spawn";
              },
              get children() {
                return X(Dq, {});
              }
            }), X(_a, {
              get when() {
                return u() !== "spawn";
              },
              get children() {
                return X(Aq, {});
              }
            })];
          }
        }), null);
        oa(c, X(Ve, {}), null);
        p(a => {
          const c = Yh.App;
          const d = {
            [Yh.clothingMenu]: u() === "clothing"
          };
          const e = Yh.container;
          if (c !== a._v$) {
            qb(i, a._v$ = c);
          }
          a._v$2 = sb(i, d, a._v$2);
          if (e !== a._v$3) {
            qb(b, a._v$3 = e);
          }
          return a;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined
        });
        return i;
      })(), X(Xq, {
        name: "fade",
        get children() {
          return X(Ma, {
            get when() {
              return i.show;
            },
            get children() {
              return X(tl, {});
            }
          });
        }
      })];
    }
  });
}
lb(() => X(uo, {
  get children() {
    return X(vr, {});
  }
}), document.getElementById("root"));