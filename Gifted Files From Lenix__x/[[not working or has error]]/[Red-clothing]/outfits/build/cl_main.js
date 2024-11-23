(() => {
    'use strict';
  
    ;
    const a = typeof crypto !== "undefined" && crypto.randomUUID && crypto.randomUUID.bind(crypto);
    var b = {
      randomUUID: a
    };
    const c = b;
    ;
    let d;
    const e = new Uint8Array(16);
    function f() {
      if (!d) {
        d = typeof crypto !== "undefined" && crypto.getRandomValues && crypto.getRandomValues.bind(crypto);
        if (!d) {
          throw new Error("crypto.getRandomValues() not supported. See https://github.com/uuidjs/uuid#getrandomvalues-not-supported");
        }
      }
      return d(e);
    }
    ;
    const g = [];
    for (let a = 0; a < 256; ++a) {
      g.push((a + 256).toString(16).slice(1));
    }
    function h(a, b = 0) {
      return (g[a[b + 0]] + g[a[b + 1]] + g[a[b + 2]] + g[a[b + 3]] + "-" + g[a[b + 4]] + g[a[b + 5]] + "-" + g[a[b + 6]] + g[a[b + 7]] + "-" + g[a[b + 8]] + g[a[b + 9]] + "-" + g[a[b + 10]] + g[a[b + 11]] + g[a[b + 12]] + g[a[b + 13]] + g[a[b + 14]] + g[a[b + 15]]).toLowerCase();
    }
    function i(a, b = 0) {
      const c = h(a, b);
      if (!validate(c)) {
        throw TypeError("Stringified UUID is invalid");
      }
      return c;
    }
    const j = null && i;
    ;
    function k(a, b, d) {
      if (c.randomUUID && !b && !a) {
        return c.randomUUID();
      }
      a = a || {};
      const e = a.random || (a.rng || f)();
      e[6] = e[6] & 15 | 64;
      e[8] = e[8] & 63 | 128;
      if (b) {
        d = d || 0;
        for (let a = 0; a < 16; ++a) {
          b[d + a] = e[a];
        }
        return b;
      }
      return h(e);
    }
    const l = k;
    ;
    const m = /^(?:[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}|00000000-0000-0000-0000-000000000000)$/i;
    ;
    function n(a) {
      return typeof a === "string" && m.test(a);
    }
    const o = n;
    ;
    function p(a) {
      if (!o(a)) {
        throw TypeError("Invalid UUID");
      }
      let b;
      const c = new Uint8Array(16);
      c[0] = (b = parseInt(a.slice(0, 8), 16)) >>> 24;
      c[1] = b >>> 16 & 255;
      c[2] = b >>> 8 & 255;
      c[3] = b & 255;
      c[4] = (b = parseInt(a.slice(9, 13), 16)) >>> 8;
      c[5] = b & 255;
      c[6] = (b = parseInt(a.slice(14, 18), 16)) >>> 8;
      c[7] = b & 255;
      c[8] = (b = parseInt(a.slice(19, 23), 16)) >>> 8;
      c[9] = b & 255;
      c[10] = (b = parseInt(a.slice(24, 36), 16)) / 1099511627776 & 255;
      c[11] = b / 4294967296 & 255;
      c[12] = b >>> 24 & 255;
      c[13] = b >>> 16 & 255;
      c[14] = b >>> 8 & 255;
      c[15] = b & 255;
      return c;
    }
    const q = p;
    ;
    function r(a) {
      a = unescape(encodeURIComponent(a));
      const b = [];
      for (let c = 0; c < a.length; ++c) {
        b.push(a.charCodeAt(c));
      }
      return b;
    }
    const s = "6ba7b810-9dad-11d1-80b4-00c04fd430c8";
    const t = "6ba7b811-9dad-11d1-80b4-00c04fd430c8";
    function u(a, b, c) {
      function d(a, d, e, f) {
        if (typeof a === "string") {
          a = r(a);
        }
        if (typeof d === "string") {
          d = q(d);
        }
        if (d?.length !== 16) {
          throw TypeError("Namespace must be array-like (16 iterable integer values, 0-255)");
        }
        let g = new Uint8Array(16 + a.length);
        g.set(d);
        g.set(a, d.length);
        g = c(g);
        g[6] = g[6] & 15 | b;
        g[8] = g[8] & 63 | 128;
        if (e) {
          f = f || 0;
          for (let a = 0; a < 16; ++a) {
            e[f + a] = g[a];
          }
          return e;
        }
        return h(g);
      }
      try {
        d.name = a;
      } catch (a) {}
      d.DNS = s;
      d.URL = t;
      return d;
    }
    ;
    function v(a, b, c, d) {
      switch (a) {
        case 0:
          return b & c ^ ~b & d;
        case 1:
          return b ^ c ^ d;
        case 2:
          return b & c ^ b & d ^ c & d;
        case 3:
          return b ^ c ^ d;
      }
    }
    function w(a, b) {
      return a << b | a >>> 32 - b;
    }
    function x(a) {
      const b = [1518500249, 1859775393, 2400959708, 3395469782];
      const c = [1732584193, 4023233417, 2562383102, 271733878, 3285377520];
      if (typeof a === "string") {
        const b = unescape(encodeURIComponent(a));
        a = [];
        for (let c = 0; c < b.length; ++c) {
          a.push(b.charCodeAt(c));
        }
      } else if (!Array.isArray(a)) {
        a = Array.prototype.slice.call(a);
      }
      a.push(128);
      const d = a.length / 4 + 2;
      const e = Math.ceil(d / 16);
      const f = new Array(e);
      for (let b = 0; b < e; ++b) {
        const c = new Uint32Array(16);
        for (let d = 0; d < 16; ++d) {
          c[d] = a[b * 64 + d * 4] << 24 | a[b * 64 + d * 4 + 1] << 16 | a[b * 64 + d * 4 + 2] << 8 | a[b * 64 + d * 4 + 3];
        }
        f[b] = c;
      }
      f[e - 1][14] = (a.length - 1) * 8 / Math.pow(2, 32);
      f[e - 1][14] = Math.floor(f[e - 1][14]);
      f[e - 1][15] = (a.length - 1) * 8 & 4294967295;
      for (let d = 0; d < e; ++d) {
        const a = new Uint32Array(80);
        for (let b = 0; b < 16; ++b) {
          a[b] = f[d][b];
        }
        for (let b = 16; b < 80; ++b) {
          a[b] = w(a[b - 3] ^ a[b - 8] ^ a[b - 14] ^ a[b - 16], 1);
        }
        let e = c[0];
        let g = c[1];
        let h = c[2];
        let i = c[3];
        let j = c[4];
        for (let c = 0; c < 80; ++c) {
          const d = Math.floor(c / 20);
          const f = w(e, 5) + v(d, g, h, i) + j + b[d] + a[c] >>> 0;
          j = i;
          i = h;
          h = w(g, 30) >>> 0;
          g = e;
          e = f;
        }
        c[0] = c[0] + e >>> 0;
        c[1] = c[1] + g >>> 0;
        c[2] = c[2] + h >>> 0;
        c[3] = c[3] + i >>> 0;
        c[4] = c[4] + j >>> 0;
      }
      return [c[0] >> 24 & 255, c[0] >> 16 & 255, c[0] >> 8 & 255, c[0] & 255, c[1] >> 24 & 255, c[1] >> 16 & 255, c[1] >> 8 & 255, c[1] & 255, c[2] >> 24 & 255, c[2] >> 16 & 255, c[2] >> 8 & 255, c[2] & 255, c[3] >> 24 & 255, c[3] >> 16 & 255, c[3] >> 8 & 255, c[3] & 255, c[4] >> 24 & 255, c[4] >> 16 & 255, c[4] >> 8 & 255, c[4] & 255];
    }
    const y = x;
    ;
    const z = u("v5", 80, y);
    const A = z;
    ; /*! pako 2.1.0 https://github.com/nodeca/pako @license (MIT AND Zlib) */
    const B = 4;
    const C = 0;
    const D = 1;
    const E = 2;
    function F(a) {
      let b = a.length;
      while (--b >= 0) {
        a[b] = 0;
      }
    }
    const G = 0;
    const H = 1;
    const I = 2;
    const J = 3;
    const K = 258;
    const L = 29;
    const M = 256;
    const N = M + 1 + L;
    const O = 30;
    const P = 19;
    const Q = N * 2 + 1;
    const R = 15;
    const S = 16;
    const T = 7;
    const U = 256;
    const V = 16;
    const W = 17;
    const X = 18;
    const Y = new Uint8Array([0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0]);
    const Z = new Uint8Array([0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13]);
    const $ = new Uint8Array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 7]);
    const _ = new Uint8Array([16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15]);
    const aa = 512;
    const ba = new Array((N + 2) * 2);
    F(ba);
    const ca = new Array(O * 2);
    F(ca);
    const da = new Array(aa);
    F(da);
    const ea = new Array(K - J + 1);
    F(ea);
    const fa = new Array(L);
    F(fa);
    const ga = new Array(O);
    F(ga);
    function ha(a, b, c, d, e) {
      this.static_tree = a;
      this.extra_bits = b;
      this.extra_base = c;
      this.elems = d;
      this.max_length = e;
      this.has_stree = a && a.length;
    }
    let ia;
    let ja;
    let ka;
    function la(a, b) {
      this.dyn_tree = a;
      this.max_code = 0;
      this.stat_desc = b;
    }
    const ma = a => {
      if (a < 256) {
        return da[a];
      } else {
        return da[256 + (a >>> 7)];
      }
    };
    const na = (a, b) => {
      a.pending_buf[a.pending++] = b & 255;
      a.pending_buf[a.pending++] = b >>> 8 & 255;
    };
    const oa = (a, b, c) => {
      if (a.bi_valid > S - c) {
        a.bi_buf |= b << a.bi_valid & 65535;
        na(a, a.bi_buf);
        a.bi_buf = b >> S - a.bi_valid;
        a.bi_valid += c - S;
      } else {
        a.bi_buf |= b << a.bi_valid & 65535;
        a.bi_valid += c;
      }
    };
    const pa = (a, b, c) => {
      oa(a, c[b * 2], c[b * 2 + 1]);
    };
    const qa = (a, b) => {
      let c = 0;
      do {
        c |= a & 1;
        a >>>= 1;
        c <<= 1;
      } while (--b > 0);
      return c >>> 1;
    };
    const ra = a => {
      if (a.bi_valid === 16) {
        na(a, a.bi_buf);
        a.bi_buf = 0;
        a.bi_valid = 0;
      } else if (a.bi_valid >= 8) {
        a.pending_buf[a.pending++] = a.bi_buf & 255;
        a.bi_buf >>= 8;
        a.bi_valid -= 8;
      }
    };
    const sa = (a, b) => {
      const c = b.dyn_tree;
      const d = b.max_code;
      const e = b.stat_desc.static_tree;
      const f = b.stat_desc.has_stree;
      const g = b.stat_desc.extra_bits;
      const h = b.stat_desc.extra_base;
      const i = b.stat_desc.max_length;
      let j;
      let k;
      let l;
      let m;
      let n;
      let o;
      let p = 0;
      for (m = 0; m <= R; m++) {
        a.bl_count[m] = 0;
      }
      c[a.heap[a.heap_max] * 2 + 1] = 0;
      for (j = a.heap_max + 1; j < Q; j++) {
        k = a.heap[j];
        m = c[c[k * 2 + 1] * 2 + 1] + 1;
        if (m > i) {
          m = i;
          p++;
        }
        c[k * 2 + 1] = m;
        if (k > d) {
          continue;
        }
        a.bl_count[m]++;
        n = 0;
        if (k >= h) {
          n = g[k - h];
        }
        o = c[k * 2];
        a.opt_len += o * (m + n);
        if (f) {
          a.static_len += o * (e[k * 2 + 1] + n);
        }
      }
      if (p === 0) {
        return;
      }
      do {
        m = i - 1;
        while (a.bl_count[m] === 0) {
          m--;
        }
        a.bl_count[m]--;
        a.bl_count[m + 1] += 2;
        a.bl_count[i]--;
        p -= 2;
      } while (p > 0);
      for (m = i; m !== 0; m--) {
        k = a.bl_count[m];
        while (k !== 0) {
          l = a.heap[--j];
          if (l > d) {
            continue;
          }
          if (c[l * 2 + 1] !== m) {
            a.opt_len += (m - c[l * 2 + 1]) * c[l * 2];
            c[l * 2 + 1] = m;
          }
          k--;
        }
      }
    };
    const ta = (a, b, c) => {
      const d = new Array(R + 1);
      let e = 0;
      let f;
      let g;
      for (f = 1; f <= R; f++) {
        e = e + c[f - 1] << 1;
        d[f] = e;
      }
      for (g = 0; g <= b; g++) {
        let b = a[g * 2 + 1];
        if (b === 0) {
          continue;
        }
        a[g * 2] = qa(d[b]++, b);
      }
    };
    const ua = () => {
      let a;
      let b;
      let c;
      let d;
      let e;
      const f = new Array(R + 1);
      c = 0;
      for (d = 0; d < L - 1; d++) {
        fa[d] = c;
        for (a = 0; a < 1 << Y[d]; a++) {
          ea[c++] = d;
        }
      }
      ea[c - 1] = d;
      e = 0;
      for (d = 0; d < 16; d++) {
        ga[d] = e;
        for (a = 0; a < 1 << Z[d]; a++) {
          da[e++] = d;
        }
      }
      e >>= 7;
      for (; d < O; d++) {
        ga[d] = e << 7;
        for (a = 0; a < 1 << Z[d] - 7; a++) {
          da[256 + e++] = d;
        }
      }
      for (b = 0; b <= R; b++) {
        f[b] = 0;
      }
      a = 0;
      while (a <= 143) {
        ba[a * 2 + 1] = 8;
        a++;
        f[8]++;
      }
      while (a <= 255) {
        ba[a * 2 + 1] = 9;
        a++;
        f[9]++;
      }
      while (a <= 279) {
        ba[a * 2 + 1] = 7;
        a++;
        f[7]++;
      }
      while (a <= 287) {
        ba[a * 2 + 1] = 8;
        a++;
        f[8]++;
      }
      ta(ba, N + 1, f);
      for (a = 0; a < O; a++) {
        ca[a * 2 + 1] = 5;
        ca[a * 2] = qa(a, 5);
      }
      ia = new ha(ba, Y, M + 1, N, R);
      ja = new ha(ca, Z, 0, O, R);
      ka = new ha(new Array(0), $, 0, P, T);
    };
    const va = a => {
      let b;
      for (b = 0; b < N; b++) {
        a.dyn_ltree[b * 2] = 0;
      }
      for (b = 0; b < O; b++) {
        a.dyn_dtree[b * 2] = 0;
      }
      for (b = 0; b < P; b++) {
        a.bl_tree[b * 2] = 0;
      }
      a.dyn_ltree[U * 2] = 1;
      a.opt_len = a.static_len = 0;
      a.sym_next = a.matches = 0;
    };
    const wa = a => {
      if (a.bi_valid > 8) {
        na(a, a.bi_buf);
      } else if (a.bi_valid > 0) {
        a.pending_buf[a.pending++] = a.bi_buf;
      }
      a.bi_buf = 0;
      a.bi_valid = 0;
    };
    const xa = (a, b, c, d) => {
      const e = b * 2;
      const f = c * 2;
      return a[e] < a[f] || a[e] === a[f] && d[b] <= d[c];
    };
    const ya = (a, b, c) => {
      const d = a.heap[c];
      let e = c << 1;
      while (e <= a.heap_len) {
        if (e < a.heap_len && xa(b, a.heap[e + 1], a.heap[e], a.depth)) {
          e++;
        }
        if (xa(b, d, a.heap[e], a.depth)) {
          break;
        }
        a.heap[c] = a.heap[e];
        c = e;
        e <<= 1;
      }
      a.heap[c] = d;
    };
    const za = (a, b, c) => {
      let d;
      let e;
      let f = 0;
      let g;
      let h;
      if (a.sym_next !== 0) {
        do {
          d = a.pending_buf[a.sym_buf + f++] & 255;
          d += (a.pending_buf[a.sym_buf + f++] & 255) << 8;
          e = a.pending_buf[a.sym_buf + f++];
          if (d === 0) {
            pa(a, e, b);
          } else {
            g = ea[e];
            pa(a, g + M + 1, b);
            h = Y[g];
            if (h !== 0) {
              e -= fa[g];
              oa(a, e, h);
            }
            d--;
            g = ma(d);
            pa(a, g, c);
            h = Z[g];
            if (h !== 0) {
              d -= ga[g];
              oa(a, d, h);
            }
          }
        } while (f < a.sym_next);
      }
      pa(a, U, b);
    };
    const Aa = (a, b) => {
      const c = b.dyn_tree;
      const d = b.stat_desc.static_tree;
      const e = b.stat_desc.has_stree;
      const f = b.stat_desc.elems;
      let g;
      let h;
      let i = -1;
      let j;
      a.heap_len = 0;
      a.heap_max = Q;
      for (g = 0; g < f; g++) {
        if (c[g * 2] !== 0) {
          a.heap[++a.heap_len] = i = g;
          a.depth[g] = 0;
        } else {
          c[g * 2 + 1] = 0;
        }
      }
      while (a.heap_len < 2) {
        j = a.heap[++a.heap_len] = i < 2 ? ++i : 0;
        c[j * 2] = 1;
        a.depth[j] = 0;
        a.opt_len--;
        if (e) {
          a.static_len -= d[j * 2 + 1];
        }
      }
      b.max_code = i;
      for (g = a.heap_len >> 1; g >= 1; g--) {
        ya(a, c, g);
      }
      j = f;
      do {
        g = a.heap[1];
        a.heap[1] = a.heap[a.heap_len--];
        ya(a, c, 1);
        h = a.heap[1];
        a.heap[--a.heap_max] = g;
        a.heap[--a.heap_max] = h;
        c[j * 2] = c[g * 2] + c[h * 2];
        a.depth[j] = (a.depth[g] >= a.depth[h] ? a.depth[g] : a.depth[h]) + 1;
        c[g * 2 + 1] = c[h * 2 + 1] = j;
        a.heap[1] = j++;
        ya(a, c, 1);
      } while (a.heap_len >= 2);
      a.heap[--a.heap_max] = a.heap[1];
      sa(a, b);
      ta(c, i, a.bl_count);
    };
    const Ba = (a, b, c) => {
      let d;
      let e = -1;
      let f;
      let g = b[1];
      let h = 0;
      let i = 7;
      let j = 4;
      if (g === 0) {
        i = 138;
        j = 3;
      }
      b[(c + 1) * 2 + 1] = 65535;
      for (d = 0; d <= c; d++) {
        f = g;
        g = b[(d + 1) * 2 + 1];
        if (++h < i && f === g) {
          continue;
        } else if (h < j) {
          a.bl_tree[f * 2] += h;
        } else if (f !== 0) {
          if (f !== e) {
            a.bl_tree[f * 2]++;
          }
          a.bl_tree[V * 2]++;
        } else if (h <= 10) {
          a.bl_tree[W * 2]++;
        } else {
          a.bl_tree[X * 2]++;
        }
        h = 0;
        e = f;
        if (g === 0) {
          i = 138;
          j = 3;
        } else if (f === g) {
          i = 6;
          j = 3;
        } else {
          i = 7;
          j = 4;
        }
      }
    };
    const Ca = (a, b, c) => {
      let d;
      let e = -1;
      let f;
      let g = b[1];
      let h = 0;
      let i = 7;
      let j = 4;
      if (g === 0) {
        i = 138;
        j = 3;
      }
      for (d = 0; d <= c; d++) {
        f = g;
        g = b[(d + 1) * 2 + 1];
        if (++h < i && f === g) {
          continue;
        } else if (h < j) {
          do {
            pa(a, f, a.bl_tree);
          } while (--h !== 0);
        } else if (f !== 0) {
          if (f !== e) {
            pa(a, f, a.bl_tree);
            h--;
          }
          pa(a, V, a.bl_tree);
          oa(a, h - 3, 2);
        } else if (h <= 10) {
          pa(a, W, a.bl_tree);
          oa(a, h - 3, 3);
        } else {
          pa(a, X, a.bl_tree);
          oa(a, h - 11, 7);
        }
        h = 0;
        e = f;
        if (g === 0) {
          i = 138;
          j = 3;
        } else if (f === g) {
          i = 6;
          j = 3;
        } else {
          i = 7;
          j = 4;
        }
      }
    };
    const Da = a => {
      let b;
      Ba(a, a.dyn_ltree, a.l_desc.max_code);
      Ba(a, a.dyn_dtree, a.d_desc.max_code);
      Aa(a, a.bl_desc);
      for (b = P - 1; b >= 3; b--) {
        if (a.bl_tree[_[b] * 2 + 1] !== 0) {
          break;
        }
      }
      a.opt_len += (b + 1) * 3 + 5 + 5 + 4;
      return b;
    };
    const Ea = (a, b, c, d) => {
      let e;
      oa(a, b - 257, 5);
      oa(a, c - 1, 5);
      oa(a, d - 4, 4);
      for (e = 0; e < d; e++) {
        oa(a, a.bl_tree[_[e] * 2 + 1], 3);
      }
      Ca(a, a.dyn_ltree, b - 1);
      Ca(a, a.dyn_dtree, c - 1);
    };
    const Fa = a => {
      let b = 4093624447;
      let c;
      for (c = 0; c <= 31; c++, b >>>= 1) {
        if (b & 1 && a.dyn_ltree[c * 2] !== 0) {
          return C;
        }
      }
      if (a.dyn_ltree[18] !== 0 || a.dyn_ltree[20] !== 0 || a.dyn_ltree[26] !== 0) {
        return D;
      }
      for (c = 32; c < M; c++) {
        if (a.dyn_ltree[c * 2] !== 0) {
          return D;
        }
      }
      return C;
    };
    let Ga = false;
    const Ha = a => {
      if (!Ga) {
        ua();
        Ga = true;
      }
      a.l_desc = new la(a.dyn_ltree, ia);
      a.d_desc = new la(a.dyn_dtree, ja);
      a.bl_desc = new la(a.bl_tree, ka);
      a.bi_buf = 0;
      a.bi_valid = 0;
      va(a);
    };
    const Ia = (a, b, c, d) => {
      oa(a, (G << 1) + (d ? 1 : 0), 3);
      wa(a);
      na(a, c);
      na(a, ~c);
      if (c) {
        a.pending_buf.set(a.window.subarray(b, b + c), a.pending);
      }
      a.pending += c;
    };
    const Ja = a => {
      oa(a, H << 1, 3);
      pa(a, U, ba);
      ra(a);
    };
    const Ka = (a, b, c, d) => {
      let e;
      let f;
      let g = 0;
      if (a.level > 0) {
        if (a.strm.data_type === E) {
          a.strm.data_type = Fa(a);
        }
        Aa(a, a.l_desc);
        Aa(a, a.d_desc);
        g = Da(a);
        e = a.opt_len + 3 + 7 >>> 3;
        f = a.static_len + 3 + 7 >>> 3;
        if (f <= e) {
          e = f;
        }
      } else {
        e = f = c + 5;
      }
      if (c + 4 <= e && b !== -1) {
        Ia(a, b, c, d);
      } else if (a.strategy === B || f === e) {
        oa(a, (H << 1) + (d ? 1 : 0), 3);
        za(a, ba, ca);
      } else {
        oa(a, (I << 1) + (d ? 1 : 0), 3);
        Ea(a, a.l_desc.max_code + 1, a.d_desc.max_code + 1, g + 1);
        za(a, a.dyn_ltree, a.dyn_dtree);
      }
      va(a);
      if (d) {
        wa(a);
      }
    };
    const La = (a, b, c) => {
      a.pending_buf[a.sym_buf + a.sym_next++] = b;
      a.pending_buf[a.sym_buf + a.sym_next++] = b >> 8;
      a.pending_buf[a.sym_buf + a.sym_next++] = c;
      if (b === 0) {
        a.dyn_ltree[c * 2]++;
      } else {
        a.matches++;
        b--;
        a.dyn_ltree[(ea[c] + M + 1) * 2]++;
        a.dyn_dtree[ma(b) * 2]++;
      }
      return a.sym_next === a.sym_end;
    };
    var Ma = Ha;
    var Na = Ia;
    var Oa = Ka;
    var Pa = La;
    var Qa = Ja;
    var Ra = {
      _tr_init: Ma,
      _tr_stored_block: Na,
      _tr_flush_block: Oa,
      _tr_tally: Pa,
      _tr_align: Qa
    };
    var Sa = Ra;
    const Ta = (a, b, c, d) => {
      let e = a & 65535 | 0;
      let f = a >>> 16 & 65535 | 0;
      let g = 0;
      while (c !== 0) {
        g = c > 2000 ? 2000 : c;
        c -= g;
        do {
          e = e + b[d++] | 0;
          f = f + e | 0;
        } while (--g);
        e %= 65521;
        f %= 65521;
      }
      return e | f << 16 | 0;
    };
    var Ua = Ta;
    const Va = () => {
      let a;
      let b = [];
      for (var c = 0; c < 256; c++) {
        a = c;
        for (var d = 0; d < 8; d++) {
          a = a & 1 ? a >>> 1 ^ 3988292384 : a >>> 1;
        }
        b[c] = a;
      }
      return b;
    };
    const Wa = new Uint32Array(Va());
    const Xa = (a, b, c, d) => {
      const e = Wa;
      const f = d + c;
      a ^= -1;
      for (let g = d; g < f; g++) {
        a = a >>> 8 ^ e[(a ^ b[g]) & 255];
      }
      return a ^ -1;
    };
    var Ya = Xa;
    var Za = {
      "2": "need dictionary",
      "1": "stream end",
      "0": "",
      "-1": "file error",
      "-2": "stream error",
      "-3": "data error",
      "-4": "insufficient memory",
      "-5": "buffer error",
      "-6": "incompatible version"
    };
    var $a = {
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
    var _a = $a;
    const {
      _tr_init: ab,
      _tr_stored_block: bb,
      _tr_flush_block: cb,
      _tr_tally: db,
      _tr_align: eb
    } = Sa;
    const {
      Z_NO_FLUSH: fb,
      Z_PARTIAL_FLUSH: gb,
      Z_FULL_FLUSH: hb,
      Z_FINISH: ib,
      Z_BLOCK: jb,
      Z_OK: kb,
      Z_STREAM_END: lb,
      Z_STREAM_ERROR: mb,
      Z_DATA_ERROR: nb,
      Z_BUF_ERROR: ob,
      Z_DEFAULT_COMPRESSION: pb,
      Z_FILTERED: qb,
      Z_HUFFMAN_ONLY: rb,
      Z_RLE: sb,
      Z_FIXED: tb,
      Z_DEFAULT_STRATEGY: ub,
      Z_UNKNOWN: vb,
      Z_DEFLATED: wb
    } = _a;
    const xb = 9;
    const yb = 15;
    const zb = 8;
    const Ab = 29;
    const Bb = 256;
    const Cb = Bb + 1 + Ab;
    const Db = 30;
    const Eb = 19;
    const Fb = Cb * 2 + 1;
    const Gb = 15;
    const Hb = 3;
    const Ib = 258;
    const Jb = Ib + Hb + 1;
    const Kb = 32;
    const Lb = 42;
    const Mb = 57;
    const Nb = 69;
    const Ob = 73;
    const Pb = 91;
    const Qb = 103;
    const Rb = 113;
    const Sb = 666;
    const Tb = 1;
    const Ub = 2;
    const Vb = 3;
    const Wb = 4;
    const Xb = 3;
    const Yb = (a, b) => {
      a.msg = Za[b];
      return b;
    };
    const Zb = a => {
      return a * 2 - (a > 4 ? 9 : 0);
    };
    const $b = a => {
      let b = a.length;
      while (--b >= 0) {
        a[b] = 0;
      }
    };
    const _b = a => {
      let b;
      let c;
      let d;
      let e = a.w_size;
      b = a.hash_size;
      d = b;
      do {
        c = a.head[--d];
        a.head[d] = c >= e ? c - e : 0;
      } while (--b);
      b = e;
      d = b;
      do {
        c = a.prev[--d];
        a.prev[d] = c >= e ? c - e : 0;
      } while (--b);
    };
    let ac = (a, b, c) => (b << a.hash_shift ^ c) & a.hash_mask;
    let bc = ac;
    const cc = a => {
      const b = a.state;
      let c = b.pending;
      if (c > a.avail_out) {
        c = a.avail_out;
      }
      if (c === 0) {
        return;
      }
      a.output.set(b.pending_buf.subarray(b.pending_out, b.pending_out + c), a.next_out);
      a.next_out += c;
      b.pending_out += c;
      a.total_out += c;
      a.avail_out -= c;
      b.pending -= c;
      if (b.pending === 0) {
        b.pending_out = 0;
      }
    };
    const dc = (a, b) => {
      cb(a, a.block_start >= 0 ? a.block_start : -1, a.strstart - a.block_start, b);
      a.block_start = a.strstart;
      cc(a.strm);
    };
    const ec = (a, b) => {
      a.pending_buf[a.pending++] = b;
    };
    const fc = (a, b) => {
      a.pending_buf[a.pending++] = b >>> 8 & 255;
      a.pending_buf[a.pending++] = b & 255;
    };
    const gc = (a, b, c, d) => {
      let e = a.avail_in;
      if (e > d) {
        e = d;
      }
      if (e === 0) {
        return 0;
      }
      a.avail_in -= e;
      b.set(a.input.subarray(a.next_in, a.next_in + e), c);
      if (a.state.wrap === 1) {
        a.adler = Ua(a.adler, b, e, c);
      } else if (a.state.wrap === 2) {
        a.adler = Ya(a.adler, b, e, c);
      }
      a.next_in += e;
      a.total_in += e;
      return e;
    };
    const hc = (a, b) => {
      let c = a.max_chain_length;
      let d = a.strstart;
      let e;
      let f;
      let g = a.prev_length;
      let h = a.nice_match;
      const i = a.strstart > a.w_size - Jb ? a.strstart - (a.w_size - Jb) : 0;
      const j = a.window;
      const k = a.w_mask;
      const l = a.prev;
      const m = a.strstart + Ib;
      let n = j[d + g - 1];
      let o = j[d + g];
      if (a.prev_length >= a.good_match) {
        c >>= 2;
      }
      if (h > a.lookahead) {
        h = a.lookahead;
      }
      do {
        e = b;
        if (j[e + g] !== o || j[e + g - 1] !== n || j[e] !== j[d] || j[++e] !== j[d + 1]) {
          continue;
        }
        d += 2;
        e++;
        do {} while (j[++d] === j[++e] && j[++d] === j[++e] && j[++d] === j[++e] && j[++d] === j[++e] && j[++d] === j[++e] && j[++d] === j[++e] && j[++d] === j[++e] && j[++d] === j[++e] && d < m);
        f = Ib - (m - d);
        d = m - Ib;
        if (f > g) {
          a.match_start = b;
          g = f;
          if (f >= h) {
            break;
          }
          n = j[d + g - 1];
          o = j[d + g];
        }
      } while ((b = l[b & k]) > i && --c !== 0);
      if (g <= a.lookahead) {
        return g;
      }
      return a.lookahead;
    };
    const ic = a => {
      const b = a.w_size;
      let c;
      let d;
      let e;
      do {
        d = a.window_size - a.lookahead - a.strstart;
        if (a.strstart >= b + (b - Jb)) {
          a.window.set(a.window.subarray(b, b + b - d), 0);
          a.match_start -= b;
          a.strstart -= b;
          a.block_start -= b;
          if (a.insert > a.strstart) {
            a.insert = a.strstart;
          }
          _b(a);
          d += b;
        }
        if (a.strm.avail_in === 0) {
          break;
        }
        c = gc(a.strm, a.window, a.strstart + a.lookahead, d);
        a.lookahead += c;
        if (a.lookahead + a.insert >= Hb) {
          e = a.strstart - a.insert;
          a.ins_h = a.window[e];
          a.ins_h = bc(a, a.ins_h, a.window[e + 1]);
          while (a.insert) {
            a.ins_h = bc(a, a.ins_h, a.window[e + Hb - 1]);
            a.prev[e & a.w_mask] = a.head[a.ins_h];
            a.head[a.ins_h] = e;
            e++;
            a.insert--;
            if (a.lookahead + a.insert < Hb) {
              break;
            }
          }
        }
      } while (a.lookahead < Jb && a.strm.avail_in !== 0);
    };
    const jc = (a, b) => {
      let c = a.pending_buf_size - 5 > a.w_size ? a.w_size : a.pending_buf_size - 5;
      let d;
      let e;
      let f;
      let g = 0;
      let h = a.strm.avail_in;
      do {
        d = 65535;
        f = a.bi_valid + 42 >> 3;
        if (a.strm.avail_out < f) {
          break;
        }
        f = a.strm.avail_out - f;
        e = a.strstart - a.block_start;
        if (d > e + a.strm.avail_in) {
          d = e + a.strm.avail_in;
        }
        if (d > f) {
          d = f;
        }
        if (d < c && (d === 0 && b !== ib || b === fb || d !== e + a.strm.avail_in)) {
          break;
        }
        g = b === ib && d === e + a.strm.avail_in ? 1 : 0;
        bb(a, 0, 0, g);
        a.pending_buf[a.pending - 4] = d;
        a.pending_buf[a.pending - 3] = d >> 8;
        a.pending_buf[a.pending - 2] = ~d;
        a.pending_buf[a.pending - 1] = ~d >> 8;
        cc(a.strm);
        if (e) {
          if (e > d) {
            e = d;
          }
          a.strm.output.set(a.window.subarray(a.block_start, a.block_start + e), a.strm.next_out);
          a.strm.next_out += e;
          a.strm.avail_out -= e;
          a.strm.total_out += e;
          a.block_start += e;
          d -= e;
        }
        if (d) {
          gc(a.strm, a.strm.output, a.strm.next_out, d);
          a.strm.next_out += d;
          a.strm.avail_out -= d;
          a.strm.total_out += d;
        }
      } while (g === 0);
      h -= a.strm.avail_in;
      if (h) {
        if (h >= a.w_size) {
          a.matches = 2;
          a.window.set(a.strm.input.subarray(a.strm.next_in - a.w_size, a.strm.next_in), 0);
          a.strstart = a.w_size;
          a.insert = a.strstart;
        } else {
          if (a.window_size - a.strstart <= h) {
            a.strstart -= a.w_size;
            a.window.set(a.window.subarray(a.w_size, a.w_size + a.strstart), 0);
            if (a.matches < 2) {
              a.matches++;
            }
            if (a.insert > a.strstart) {
              a.insert = a.strstart;
            }
          }
          a.window.set(a.strm.input.subarray(a.strm.next_in - h, a.strm.next_in), a.strstart);
          a.strstart += h;
          a.insert += h > a.w_size - a.insert ? a.w_size - a.insert : h;
        }
        a.block_start = a.strstart;
      }
      if (a.high_water < a.strstart) {
        a.high_water = a.strstart;
      }
      if (g) {
        return Wb;
      }
      if (b !== fb && b !== ib && a.strm.avail_in === 0 && a.strstart === a.block_start) {
        return Ub;
      }
      f = a.window_size - a.strstart;
      if (a.strm.avail_in > f && a.block_start >= a.w_size) {
        a.block_start -= a.w_size;
        a.strstart -= a.w_size;
        a.window.set(a.window.subarray(a.w_size, a.w_size + a.strstart), 0);
        if (a.matches < 2) {
          a.matches++;
        }
        f += a.w_size;
        if (a.insert > a.strstart) {
          a.insert = a.strstart;
        }
      }
      if (f > a.strm.avail_in) {
        f = a.strm.avail_in;
      }
      if (f) {
        gc(a.strm, a.window, a.strstart, f);
        a.strstart += f;
        a.insert += f > a.w_size - a.insert ? a.w_size - a.insert : f;
      }
      if (a.high_water < a.strstart) {
        a.high_water = a.strstart;
      }
      f = a.bi_valid + 42 >> 3;
      f = a.pending_buf_size - f > 65535 ? 65535 : a.pending_buf_size - f;
      c = f > a.w_size ? a.w_size : f;
      e = a.strstart - a.block_start;
      if (e >= c || (e || b === ib) && b !== fb && a.strm.avail_in === 0 && e <= f) {
        d = e > f ? f : e;
        g = b === ib && a.strm.avail_in === 0 && d === e ? 1 : 0;
        bb(a, a.block_start, d, g);
        a.block_start += d;
        cc(a.strm);
      }
      if (g) {
        return Vb;
      } else {
        return Tb;
      }
    };
    const kc = (a, b) => {
      let c;
      let d;
      while (true) {
        if (a.lookahead < Jb) {
          ic(a);
          if (a.lookahead < Jb && b === fb) {
            return Tb;
          }
          if (a.lookahead === 0) {
            break;
          }
        }
        c = 0;
        if (a.lookahead >= Hb) {
          a.ins_h = bc(a, a.ins_h, a.window[a.strstart + Hb - 1]);
          c = a.prev[a.strstart & a.w_mask] = a.head[a.ins_h];
          a.head[a.ins_h] = a.strstart;
        }
        if (c !== 0 && a.strstart - c <= a.w_size - Jb) {
          a.match_length = hc(a, c);
        }
        if (a.match_length >= Hb) {
          d = db(a, a.strstart - a.match_start, a.match_length - Hb);
          a.lookahead -= a.match_length;
          if (a.match_length <= a.max_lazy_match && a.lookahead >= Hb) {
            a.match_length--;
            do {
              a.strstart++;
              a.ins_h = bc(a, a.ins_h, a.window[a.strstart + Hb - 1]);
              c = a.prev[a.strstart & a.w_mask] = a.head[a.ins_h];
              a.head[a.ins_h] = a.strstart;
            } while (--a.match_length !== 0);
            a.strstart++;
          } else {
            a.strstart += a.match_length;
            a.match_length = 0;
            a.ins_h = a.window[a.strstart];
            a.ins_h = bc(a, a.ins_h, a.window[a.strstart + 1]);
          }
        } else {
          d = db(a, 0, a.window[a.strstart]);
          a.lookahead--;
          a.strstart++;
        }
        if (d) {
          dc(a, false);
          if (a.strm.avail_out === 0) {
            return Tb;
          }
        }
      }
      a.insert = a.strstart < Hb - 1 ? a.strstart : Hb - 1;
      if (b === ib) {
        dc(a, true);
        if (a.strm.avail_out === 0) {
          return Vb;
        }
        return Wb;
      }
      if (a.sym_next) {
        dc(a, false);
        if (a.strm.avail_out === 0) {
          return Tb;
        }
      }
      return Ub;
    };
    const lc = (a, b) => {
      let c;
      let d;
      let e;
      while (true) {
        if (a.lookahead < Jb) {
          ic(a);
          if (a.lookahead < Jb && b === fb) {
            return Tb;
          }
          if (a.lookahead === 0) {
            break;
          }
        }
        c = 0;
        if (a.lookahead >= Hb) {
          a.ins_h = bc(a, a.ins_h, a.window[a.strstart + Hb - 1]);
          c = a.prev[a.strstart & a.w_mask] = a.head[a.ins_h];
          a.head[a.ins_h] = a.strstart;
        }
        a.prev_length = a.match_length;
        a.prev_match = a.match_start;
        a.match_length = Hb - 1;
        if (c !== 0 && a.prev_length < a.max_lazy_match && a.strstart - c <= a.w_size - Jb) {
          a.match_length = hc(a, c);
          if (a.match_length <= 5 && (a.strategy === qb || a.match_length === Hb && a.strstart - a.match_start > 4096)) {
            a.match_length = Hb - 1;
          }
        }
        if (a.prev_length >= Hb && a.match_length <= a.prev_length) {
          e = a.strstart + a.lookahead - Hb;
          d = db(a, a.strstart - 1 - a.prev_match, a.prev_length - Hb);
          a.lookahead -= a.prev_length - 1;
          a.prev_length -= 2;
          do {
            if (++a.strstart <= e) {
              a.ins_h = bc(a, a.ins_h, a.window[a.strstart + Hb - 1]);
              c = a.prev[a.strstart & a.w_mask] = a.head[a.ins_h];
              a.head[a.ins_h] = a.strstart;
            }
          } while (--a.prev_length !== 0);
          a.match_available = 0;
          a.match_length = Hb - 1;
          a.strstart++;
          if (d) {
            dc(a, false);
            if (a.strm.avail_out === 0) {
              return Tb;
            }
          }
        } else if (a.match_available) {
          d = db(a, 0, a.window[a.strstart - 1]);
          if (d) {
            dc(a, false);
          }
          a.strstart++;
          a.lookahead--;
          if (a.strm.avail_out === 0) {
            return Tb;
          }
        } else {
          a.match_available = 1;
          a.strstart++;
          a.lookahead--;
        }
      }
      if (a.match_available) {
        d = db(a, 0, a.window[a.strstart - 1]);
        a.match_available = 0;
      }
      a.insert = a.strstart < Hb - 1 ? a.strstart : Hb - 1;
      if (b === ib) {
        dc(a, true);
        if (a.strm.avail_out === 0) {
          return Vb;
        }
        return Wb;
      }
      if (a.sym_next) {
        dc(a, false);
        if (a.strm.avail_out === 0) {
          return Tb;
        }
      }
      return Ub;
    };
    const mc = (a, b) => {
      let c;
      let d;
      let e;
      let f;
      const g = a.window;
      while (true) {
        if (a.lookahead <= Ib) {
          ic(a);
          if (a.lookahead <= Ib && b === fb) {
            return Tb;
          }
          if (a.lookahead === 0) {
            break;
          }
        }
        a.match_length = 0;
        if (a.lookahead >= Hb && a.strstart > 0) {
          e = a.strstart - 1;
          d = g[e];
          if (d === g[++e] && d === g[++e] && d === g[++e]) {
            f = a.strstart + Ib;
            do {} while (d === g[++e] && d === g[++e] && d === g[++e] && d === g[++e] && d === g[++e] && d === g[++e] && d === g[++e] && d === g[++e] && e < f);
            a.match_length = Ib - (f - e);
            if (a.match_length > a.lookahead) {
              a.match_length = a.lookahead;
            }
          }
        }
        if (a.match_length >= Hb) {
          c = db(a, 1, a.match_length - Hb);
          a.lookahead -= a.match_length;
          a.strstart += a.match_length;
          a.match_length = 0;
        } else {
          c = db(a, 0, a.window[a.strstart]);
          a.lookahead--;
          a.strstart++;
        }
        if (c) {
          dc(a, false);
          if (a.strm.avail_out === 0) {
            return Tb;
          }
        }
      }
      a.insert = 0;
      if (b === ib) {
        dc(a, true);
        if (a.strm.avail_out === 0) {
          return Vb;
        }
        return Wb;
      }
      if (a.sym_next) {
        dc(a, false);
        if (a.strm.avail_out === 0) {
          return Tb;
        }
      }
      return Ub;
    };
    const nc = (a, b) => {
      let c;
      while (true) {
        if (a.lookahead === 0) {
          ic(a);
          if (a.lookahead === 0) {
            if (b === fb) {
              return Tb;
            }
            break;
          }
        }
        a.match_length = 0;
        c = db(a, 0, a.window[a.strstart]);
        a.lookahead--;
        a.strstart++;
        if (c) {
          dc(a, false);
          if (a.strm.avail_out === 0) {
            return Tb;
          }
        }
      }
      a.insert = 0;
      if (b === ib) {
        dc(a, true);
        if (a.strm.avail_out === 0) {
          return Vb;
        }
        return Wb;
      }
      if (a.sym_next) {
        dc(a, false);
        if (a.strm.avail_out === 0) {
          return Tb;
        }
      }
      return Ub;
    };
    function oc(a, b, c, d, e) {
      this.good_length = a;
      this.max_lazy = b;
      this.nice_length = c;
      this.max_chain = d;
      this.func = e;
    }
    const pc = [new oc(0, 0, 0, 0, jc), new oc(4, 4, 8, 4, kc), new oc(4, 5, 16, 8, kc), new oc(4, 6, 32, 32, kc), new oc(4, 4, 16, 16, lc), new oc(8, 16, 32, 32, lc), new oc(8, 16, 128, 128, lc), new oc(8, 32, 128, 256, lc), new oc(32, 128, 258, 1024, lc), new oc(32, 258, 258, 4096, lc)];
    const qc = a => {
      a.window_size = a.w_size * 2;
      $b(a.head);
      a.max_lazy_match = pc[a.level].max_lazy;
      a.good_match = pc[a.level].good_length;
      a.nice_match = pc[a.level].nice_length;
      a.max_chain_length = pc[a.level].max_chain;
      a.strstart = 0;
      a.block_start = 0;
      a.lookahead = 0;
      a.insert = 0;
      a.match_length = a.prev_length = Hb - 1;
      a.match_available = 0;
      a.ins_h = 0;
    };
    function rc() {
      this.strm = null;
      this.status = 0;
      this.pending_buf = null;
      this.pending_buf_size = 0;
      this.pending_out = 0;
      this.pending = 0;
      this.wrap = 0;
      this.gzhead = null;
      this.gzindex = 0;
      this.method = wb;
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
      this.dyn_ltree = new Uint16Array(Fb * 2);
      this.dyn_dtree = new Uint16Array((Db * 2 + 1) * 2);
      this.bl_tree = new Uint16Array((Eb * 2 + 1) * 2);
      $b(this.dyn_ltree);
      $b(this.dyn_dtree);
      $b(this.bl_tree);
      this.l_desc = null;
      this.d_desc = null;
      this.bl_desc = null;
      this.bl_count = new Uint16Array(Gb + 1);
      this.heap = new Uint16Array(Cb * 2 + 1);
      $b(this.heap);
      this.heap_len = 0;
      this.heap_max = 0;
      this.depth = new Uint16Array(Cb * 2 + 1);
      $b(this.depth);
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
    const sc = a => {
      if (!a) {
        return 1;
      }
      const b = a.state;
      if (!b || b.strm !== a || b.status !== Lb && b.status !== Mb && b.status !== Nb && b.status !== Ob && b.status !== Pb && b.status !== Qb && b.status !== Rb && b.status !== Sb) {
        return 1;
      }
      return 0;
    };
    const tc = a => {
      if (sc(a)) {
        return Yb(a, mb);
      }
      a.total_in = a.total_out = 0;
      a.data_type = vb;
      const b = a.state;
      b.pending = 0;
      b.pending_out = 0;
      if (b.wrap < 0) {
        b.wrap = -b.wrap;
      }
      b.status = b.wrap === 2 ? Mb : b.wrap ? Lb : Rb;
      a.adler = b.wrap === 2 ? 0 : 1;
      b.last_flush = -2;
      ab(b);
      return kb;
    };
    const uc = a => {
      const b = tc(a);
      if (b === kb) {
        qc(a.state);
      }
      return b;
    };
    const vc = (a, b) => {
      if (sc(a) || a.state.wrap !== 2) {
        return mb;
      }
      a.state.gzhead = b;
      return kb;
    };
    const wc = (a, b, c, d, e, f) => {
      if (!a) {
        return mb;
      }
      let g = 1;
      if (b === pb) {
        b = 6;
      }
      if (d < 0) {
        g = 0;
        d = -d;
      } else if (d > 15) {
        g = 2;
        d -= 16;
      }
      if (e < 1 || e > xb || c !== wb || d < 8 || d > 15 || b < 0 || b > 9 || f < 0 || f > tb || d === 8 && g !== 1) {
        return Yb(a, mb);
      }
      if (d === 8) {
        d = 9;
      }
      const h = new rc();
      a.state = h;
      h.strm = a;
      h.status = Lb;
      h.wrap = g;
      h.gzhead = null;
      h.w_bits = d;
      h.w_size = 1 << h.w_bits;
      h.w_mask = h.w_size - 1;
      h.hash_bits = e + 7;
      h.hash_size = 1 << h.hash_bits;
      h.hash_mask = h.hash_size - 1;
      h.hash_shift = ~~((h.hash_bits + Hb - 1) / Hb);
      h.window = new Uint8Array(h.w_size * 2);
      h.head = new Uint16Array(h.hash_size);
      h.prev = new Uint16Array(h.w_size);
      h.lit_bufsize = 1 << e + 6;
      h.pending_buf_size = h.lit_bufsize * 4;
      h.pending_buf = new Uint8Array(h.pending_buf_size);
      h.sym_buf = h.lit_bufsize;
      h.sym_end = (h.lit_bufsize - 1) * 3;
      h.level = b;
      h.strategy = f;
      h.method = c;
      return uc(a);
    };
    const xc = (a, b) => {
      return wc(a, b, wb, yb, zb, ub);
    };
    const yc = (a, b) => {
      if (sc(a) || b > jb || b < 0) {
        if (a) {
          return Yb(a, mb);
        } else {
          return mb;
        }
      }
      const c = a.state;
      if (!a.output || a.avail_in !== 0 && !a.input || c.status === Sb && b !== ib) {
        return Yb(a, a.avail_out === 0 ? ob : mb);
      }
      const d = c.last_flush;
      c.last_flush = b;
      if (c.pending !== 0) {
        cc(a);
        if (a.avail_out === 0) {
          c.last_flush = -1;
          return kb;
        }
      } else if (a.avail_in === 0 && Zb(b) <= Zb(d) && b !== ib) {
        return Yb(a, ob);
      }
      if (c.status === Sb && a.avail_in !== 0) {
        return Yb(a, ob);
      }
      if (c.status === Lb && c.wrap === 0) {
        c.status = Rb;
      }
      if (c.status === Lb) {
        let b = wb + (c.w_bits - 8 << 4) << 8;
        let d = -1;
        if (c.strategy >= rb || c.level < 2) {
          d = 0;
        } else if (c.level < 6) {
          d = 1;
        } else if (c.level === 6) {
          d = 2;
        } else {
          d = 3;
        }
        b |= d << 6;
        if (c.strstart !== 0) {
          b |= Kb;
        }
        b += 31 - b % 31;
        fc(c, b);
        if (c.strstart !== 0) {
          fc(c, a.adler >>> 16);
          fc(c, a.adler & 65535);
        }
        a.adler = 1;
        c.status = Rb;
        cc(a);
        if (c.pending !== 0) {
          c.last_flush = -1;
          return kb;
        }
      }
      if (c.status === Mb) {
        a.adler = 0;
        ec(c, 31);
        ec(c, 139);
        ec(c, 8);
        if (!c.gzhead) {
          ec(c, 0);
          ec(c, 0);
          ec(c, 0);
          ec(c, 0);
          ec(c, 0);
          ec(c, c.level === 9 ? 2 : c.strategy >= rb || c.level < 2 ? 4 : 0);
          ec(c, Xb);
          c.status = Rb;
          cc(a);
          if (c.pending !== 0) {
            c.last_flush = -1;
            return kb;
          }
        } else {
          ec(c, (c.gzhead.text ? 1 : 0) + (c.gzhead.hcrc ? 2 : 0) + (!c.gzhead.extra ? 0 : 4) + (!c.gzhead.name ? 0 : 8) + (!c.gzhead.comment ? 0 : 16));
          ec(c, c.gzhead.time & 255);
          ec(c, c.gzhead.time >> 8 & 255);
          ec(c, c.gzhead.time >> 16 & 255);
          ec(c, c.gzhead.time >> 24 & 255);
          ec(c, c.level === 9 ? 2 : c.strategy >= rb || c.level < 2 ? 4 : 0);
          ec(c, c.gzhead.os & 255);
          if (c.gzhead.extra && c.gzhead.extra.length) {
            ec(c, c.gzhead.extra.length & 255);
            ec(c, c.gzhead.extra.length >> 8 & 255);
          }
          if (c.gzhead.hcrc) {
            a.adler = Ya(a.adler, c.pending_buf, c.pending, 0);
          }
          c.gzindex = 0;
          c.status = Nb;
        }
      }
      if (c.status === Nb) {
        if (c.gzhead.extra) {
          let b = c.pending;
          let d = (c.gzhead.extra.length & 65535) - c.gzindex;
          while (c.pending + d > c.pending_buf_size) {
            let e = c.pending_buf_size - c.pending;
            c.pending_buf.set(c.gzhead.extra.subarray(c.gzindex, c.gzindex + e), c.pending);
            c.pending = c.pending_buf_size;
            if (c.gzhead.hcrc && c.pending > b) {
              a.adler = Ya(a.adler, c.pending_buf, c.pending - b, b);
            }
            c.gzindex += e;
            cc(a);
            if (c.pending !== 0) {
              c.last_flush = -1;
              return kb;
            }
            b = 0;
            d -= e;
          }
          let e = new Uint8Array(c.gzhead.extra);
          c.pending_buf.set(e.subarray(c.gzindex, c.gzindex + d), c.pending);
          c.pending += d;
          if (c.gzhead.hcrc && c.pending > b) {
            a.adler = Ya(a.adler, c.pending_buf, c.pending - b, b);
          }
          c.gzindex = 0;
        }
        c.status = Ob;
      }
      if (c.status === Ob) {
        if (c.gzhead.name) {
          let b = c.pending;
          let d;
          do {
            if (c.pending === c.pending_buf_size) {
              if (c.gzhead.hcrc && c.pending > b) {
                a.adler = Ya(a.adler, c.pending_buf, c.pending - b, b);
              }
              cc(a);
              if (c.pending !== 0) {
                c.last_flush = -1;
                return kb;
              }
              b = 0;
            }
            if (c.gzindex < c.gzhead.name.length) {
              d = c.gzhead.name.charCodeAt(c.gzindex++) & 255;
            } else {
              d = 0;
            }
            ec(c, d);
          } while (d !== 0);
          if (c.gzhead.hcrc && c.pending > b) {
            a.adler = Ya(a.adler, c.pending_buf, c.pending - b, b);
          }
          c.gzindex = 0;
        }
        c.status = Pb;
      }
      if (c.status === Pb) {
        if (c.gzhead.comment) {
          let b = c.pending;
          let d;
          do {
            if (c.pending === c.pending_buf_size) {
              if (c.gzhead.hcrc && c.pending > b) {
                a.adler = Ya(a.adler, c.pending_buf, c.pending - b, b);
              }
              cc(a);
              if (c.pending !== 0) {
                c.last_flush = -1;
                return kb;
              }
              b = 0;
            }
            if (c.gzindex < c.gzhead.comment.length) {
              d = c.gzhead.comment.charCodeAt(c.gzindex++) & 255;
            } else {
              d = 0;
            }
            ec(c, d);
          } while (d !== 0);
          if (c.gzhead.hcrc && c.pending > b) {
            a.adler = Ya(a.adler, c.pending_buf, c.pending - b, b);
          }
        }
        c.status = Qb;
      }
      if (c.status === Qb) {
        if (c.gzhead.hcrc) {
          if (c.pending + 2 > c.pending_buf_size) {
            cc(a);
            if (c.pending !== 0) {
              c.last_flush = -1;
              return kb;
            }
          }
          ec(c, a.adler & 255);
          ec(c, a.adler >> 8 & 255);
          a.adler = 0;
        }
        c.status = Rb;
        cc(a);
        if (c.pending !== 0) {
          c.last_flush = -1;
          return kb;
        }
      }
      if (a.avail_in !== 0 || c.lookahead !== 0 || b !== fb && c.status !== Sb) {
        let d = c.level === 0 ? jc(c, b) : c.strategy === rb ? nc(c, b) : c.strategy === sb ? mc(c, b) : pc[c.level].func(c, b);
        if (d === Vb || d === Wb) {
          c.status = Sb;
        }
        if (d === Tb || d === Vb) {
          if (a.avail_out === 0) {
            c.last_flush = -1;
          }
          return kb;
        }
        if (d === Ub) {
          if (b === gb) {
            eb(c);
          } else if (b !== jb) {
            bb(c, 0, 0, false);
            if (b === hb) {
              $b(c.head);
              if (c.lookahead === 0) {
                c.strstart = 0;
                c.block_start = 0;
                c.insert = 0;
              }
            }
          }
          cc(a);
          if (a.avail_out === 0) {
            c.last_flush = -1;
            return kb;
          }
        }
      }
      if (b !== ib) {
        return kb;
      }
      if (c.wrap <= 0) {
        return lb;
      }
      if (c.wrap === 2) {
        ec(c, a.adler & 255);
        ec(c, a.adler >> 8 & 255);
        ec(c, a.adler >> 16 & 255);
        ec(c, a.adler >> 24 & 255);
        ec(c, a.total_in & 255);
        ec(c, a.total_in >> 8 & 255);
        ec(c, a.total_in >> 16 & 255);
        ec(c, a.total_in >> 24 & 255);
      } else {
        fc(c, a.adler >>> 16);
        fc(c, a.adler & 65535);
      }
      cc(a);
      if (c.wrap > 0) {
        c.wrap = -c.wrap;
      }
      if (c.pending !== 0) {
        return kb;
      } else {
        return lb;
      }
    };
    const zc = a => {
      if (sc(a)) {
        return mb;
      }
      const b = a.state.status;
      a.state = null;
      if (b === Rb) {
        return Yb(a, nb);
      } else {
        return kb;
      }
    };
    const Ac = (a, b) => {
      let c = b.length;
      if (sc(a)) {
        return mb;
      }
      const d = a.state;
      const e = d.wrap;
      if (e === 2 || e === 1 && d.status !== Lb || d.lookahead) {
        return mb;
      }
      if (e === 1) {
        a.adler = Ua(a.adler, b, c, 0);
      }
      d.wrap = 0;
      if (c >= d.w_size) {
        if (e === 0) {
          $b(d.head);
          d.strstart = 0;
          d.block_start = 0;
          d.insert = 0;
        }
        let a = new Uint8Array(d.w_size);
        a.set(b.subarray(c - d.w_size, c), 0);
        b = a;
        c = d.w_size;
      }
      const f = a.avail_in;
      const g = a.next_in;
      const h = a.input;
      a.avail_in = c;
      a.next_in = 0;
      a.input = b;
      ic(d);
      while (d.lookahead >= Hb) {
        let a = d.strstart;
        let b = d.lookahead - (Hb - 1);
        do {
          d.ins_h = bc(d, d.ins_h, d.window[a + Hb - 1]);
          d.prev[a & d.w_mask] = d.head[d.ins_h];
          d.head[d.ins_h] = a;
          a++;
        } while (--b);
        d.strstart = a;
        d.lookahead = Hb - 1;
        ic(d);
      }
      d.strstart += d.lookahead;
      d.block_start = d.strstart;
      d.insert = d.lookahead;
      d.lookahead = 0;
      d.match_length = d.prev_length = Hb - 1;
      d.match_available = 0;
      a.next_in = g;
      a.input = h;
      a.avail_in = f;
      d.wrap = e;
      return kb;
    };
    var Bc = xc;
    var Cc = wc;
    var Dc = uc;
    var Ec = tc;
    var Fc = vc;
    var Gc = yc;
    var Hc = zc;
    var Ic = Ac;
    var Jc = "pako deflate (from Nodeca project)";
    var Kc = {
      deflateInit: Bc,
      deflateInit2: Cc,
      deflateReset: Dc,
      deflateResetKeep: Ec,
      deflateSetHeader: Fc,
      deflate: Gc,
      deflateEnd: Hc,
      deflateSetDictionary: Ic,
      deflateInfo: Jc
    };
    var Lc = Kc;
    const Mc = (a, b) => {
      return Object.prototype.hasOwnProperty.call(a, b);
    };
    function Nc(a) {
      const b = Array.prototype.slice.call(arguments, 1);
      while (b.length) {
        const c = b.shift();
        if (!c) {
          continue;
        }
        if (typeof c !== "object") {
          throw new TypeError(c + "must be non-object");
        }
        for (const b in c) {
          if (Mc(c, b)) {
            a[b] = c[b];
          }
        }
      }
      return a;
    }
    var Oc = a => {
      let b = 0;
      for (let c = 0, d = a.length; c < d; c++) {
        b += a[c].length;
      }
      const c = new Uint8Array(b);
      for (let b = 0, d = 0, e = a.length; b < e; b++) {
        let e = a[b];
        c.set(e, d);
        d += e.length;
      }
      return c;
    };
    var Pc = {
      assign: Nc,
      flattenChunks: Oc
    };
    var Qc = Pc;
    let Rc = true;
    try {
      String.fromCharCode.apply(null, new Uint8Array(1));
    } catch (a) {
      Rc = false;
    }
    const Sc = new Uint8Array(256);
    for (let a = 0; a < 256; a++) {
      Sc[a] = a >= 252 ? 6 : a >= 248 ? 5 : a >= 240 ? 4 : a >= 224 ? 3 : a >= 192 ? 2 : 1;
    }
    Sc[254] = Sc[254] = 1;
    var Tc = a => {
      if (typeof TextEncoder === "function" && TextEncoder.prototype.encode) {
        return new TextEncoder().encode(a);
      }
      let b;
      let c;
      let d;
      let e;
      let f;
      let g = a.length;
      let h = 0;
      for (e = 0; e < g; e++) {
        c = a.charCodeAt(e);
        if ((c & 64512) === 55296 && e + 1 < g) {
          d = a.charCodeAt(e + 1);
          if ((d & 64512) === 56320) {
            c = 65536 + (c - 55296 << 10) + (d - 56320);
            e++;
          }
        }
        h += c < 128 ? 1 : c < 2048 ? 2 : c < 65536 ? 3 : 4;
      }
      b = new Uint8Array(h);
      f = 0;
      e = 0;
      for (; f < h; e++) {
        c = a.charCodeAt(e);
        if ((c & 64512) === 55296 && e + 1 < g) {
          d = a.charCodeAt(e + 1);
          if ((d & 64512) === 56320) {
            c = 65536 + (c - 55296 << 10) + (d - 56320);
            e++;
          }
        }
        if (c < 128) {
          b[f++] = c;
        } else if (c < 2048) {
          b[f++] = c >>> 6 | 192;
          b[f++] = c & 63 | 128;
        } else if (c < 65536) {
          b[f++] = c >>> 12 | 224;
          b[f++] = c >>> 6 & 63 | 128;
          b[f++] = c & 63 | 128;
        } else {
          b[f++] = c >>> 18 | 240;
          b[f++] = c >>> 12 & 63 | 128;
          b[f++] = c >>> 6 & 63 | 128;
          b[f++] = c & 63 | 128;
        }
      }
      return b;
    };
    const Uc = (a, b) => {
      if (b < 65534) {
        if (a.subarray && Rc) {
          return String.fromCharCode.apply(null, a.length === b ? a : a.subarray(0, b));
        }
      }
      let c = "";
      for (let d = 0; d < b; d++) {
        c += String.fromCharCode(a[d]);
      }
      return c;
    };
    var Vc = (a, b) => {
      const c = b || a.length;
      if (typeof TextDecoder === "function" && TextDecoder.prototype.decode) {
        return new TextDecoder().decode(a.subarray(0, b));
      }
      let d;
      let e;
      const f = new Array(c * 2);
      e = 0;
      d = 0;
      while (d < c) {
        let b = a[d++];
        if (b < 128) {
          f[e++] = b;
          continue;
        }
        let g = Sc[b];
        if (g > 4) {
          f[e++] = 65533;
          d += g - 1;
          continue;
        }
        b &= g === 2 ? 31 : g === 3 ? 15 : 7;
        while (g > 1 && d < c) {
          b = b << 6 | a[d++] & 63;
          g--;
        }
        if (g > 1) {
          f[e++] = 65533;
          continue;
        }
        if (b < 65536) {
          f[e++] = b;
        } else {
          b -= 65536;
          f[e++] = b >> 10 & 1023 | 55296;
          f[e++] = b & 1023 | 56320;
        }
      }
      return Uc(f, e);
    };
    var Wc = (a, b) => {
      b = b || a.length;
      if (b > a.length) {
        b = a.length;
      }
      let c = b - 1;
      while (c >= 0 && (a[c] & 192) === 128) {
        c--;
      }
      if (c < 0) {
        return b;
      }
      if (c === 0) {
        return b;
      }
      if (c + Sc[a[c]] > b) {
        return c;
      } else {
        return b;
      }
    };
    var Xc = {
      string2buf: Tc,
      buf2string: Vc,
      utf8border: Wc
    };
    var Yc = Xc;
    function Zc() {
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
    var $c = Zc;
    const _c = Object.prototype.toString;
    const {
      Z_NO_FLUSH: ad,
      Z_SYNC_FLUSH: bd,
      Z_FULL_FLUSH: cd,
      Z_FINISH: dd,
      Z_OK: ed,
      Z_STREAM_END: fd,
      Z_DEFAULT_COMPRESSION: gd,
      Z_DEFAULT_STRATEGY: hd,
      Z_DEFLATED: id
    } = _a;
    function jd(a) {
      var b = {
        level: gd,
        method: id,
        chunkSize: 16384,
        windowBits: 15,
        memLevel: 8,
        strategy: hd
      };
      this.options = Qc.assign(b, a || {});
      let c = this.options;
      if (c.raw && c.windowBits > 0) {
        c.windowBits = -c.windowBits;
      } else if (c.gzip && c.windowBits > 0 && c.windowBits < 16) {
        c.windowBits += 16;
      }
      this.err = 0;
      this.msg = "";
      this.ended = false;
      this.chunks = [];
      this.strm = new $c();
      this.strm.avail_out = 0;
      let d = Lc.deflateInit2(this.strm, c.level, c.method, c.windowBits, c.memLevel, c.strategy);
      if (d !== ed) {
        throw new Error(Za[d]);
      }
      if (c.header) {
        Lc.deflateSetHeader(this.strm, c.header);
      }
      if (c.dictionary) {
        let a;
        if (typeof c.dictionary === "string") {
          a = Yc.string2buf(c.dictionary);
        } else if (_c.call(c.dictionary) === "[object ArrayBuffer]") {
          a = new Uint8Array(c.dictionary);
        } else {
          a = c.dictionary;
        }
        d = Lc.deflateSetDictionary(this.strm, a);
        if (d !== ed) {
          throw new Error(Za[d]);
        }
        this._dict_set = true;
      }
    }
    jd.prototype.push = function (a, b) {
      const c = this.strm;
      const d = this.options.chunkSize;
      let e;
      let f;
      if (this.ended) {
        return false;
      }
      if (b === ~~b) {
        f = b;
      } else {
        f = b === true ? dd : ad;
      }
      if (typeof a === "string") {
        c.input = Yc.string2buf(a);
      } else if (_c.call(a) === "[object ArrayBuffer]") {
        c.input = new Uint8Array(a);
      } else {
        c.input = a;
      }
      c.next_in = 0;
      c.avail_in = c.input.length;
      while (true) {
        if (c.avail_out === 0) {
          c.output = new Uint8Array(d);
          c.next_out = 0;
          c.avail_out = d;
        }
        if ((f === bd || f === cd) && c.avail_out <= 6) {
          this.onData(c.output.subarray(0, c.next_out));
          c.avail_out = 0;
          continue;
        }
        e = Lc.deflate(c, f);
        if (e === fd) {
          if (c.next_out > 0) {
            this.onData(c.output.subarray(0, c.next_out));
          }
          e = Lc.deflateEnd(this.strm);
          this.onEnd(e);
          this.ended = true;
          return e === ed;
        }
        if (c.avail_out === 0) {
          this.onData(c.output);
          continue;
        }
        if (f > 0 && c.next_out > 0) {
          this.onData(c.output.subarray(0, c.next_out));
          c.avail_out = 0;
          continue;
        }
        if (c.avail_in === 0) {
          break;
        }
      }
      return true;
    };
    jd.prototype.onData = function (a) {
      this.chunks.push(a);
    };
    jd.prototype.onEnd = function (a) {
      if (a === ed) {
        this.result = Qc.flattenChunks(this.chunks);
      }
      this.chunks = [];
      this.err = a;
      this.msg = this.strm.msg;
    };
    function kd(a, b) {
      const c = new jd(b);
      c.push(a, true);
      if (c.err) {
        throw c.msg || Za[c.err];
      }
      return c.result;
    }
    function ld(a, b) {
      b = b || {};
      b.raw = true;
      return kd(a, b);
    }
    function md(a, b) {
      b = b || {};
      b.gzip = true;
      return kd(a, b);
    }
    var nd = jd;
    var od = kd;
    var pd = ld;
    var qd = md;
    var rd = _a;
    var sd = {
      Deflate: nd,
      deflate: od,
      deflateRaw: pd,
      gzip: qd,
      constants: rd
    };
    var td = sd;
    const ud = 16209;
    const vd = 16191;
    var wd = function c(a, b) {
      let d;
      let e;
      let f;
      let g;
      let h;
      let i;
      let j;
      let k;
      let l;
      let m;
      let n;
      let o;
      let p;
      let q;
      let r;
      let s;
      let t;
      let u;
      let v;
      let w;
      let x;
      let y;
      let z;
      let A;
      const B = a.state;
      d = a.next_in;
      z = a.input;
      e = d + (a.avail_in - 5);
      f = a.next_out;
      A = a.output;
      g = f - (b - a.avail_out);
      h = f + (a.avail_out - 257);
      i = B.dmax;
      j = B.wsize;
      k = B.whave;
      l = B.wnext;
      m = B.window;
      n = B.hold;
      o = B.bits;
      p = B.lencode;
      q = B.distcode;
      r = (1 << B.lenbits) - 1;
      s = (1 << B.distbits) - 1;
      _0x23caf7: do {
        if (o < 15) {
          n += z[d++] << o;
          o += 8;
          n += z[d++] << o;
          o += 8;
        }
        t = p[n & r];
        _0x3671ea: while (true) {
          u = t >>> 24;
          n >>>= u;
          o -= u;
          u = t >>> 16 & 255;
          if (u === 0) {
            A[f++] = t & 65535;
          } else if (u & 16) {
            v = t & 65535;
            u &= 15;
            if (u) {
              if (o < u) {
                n += z[d++] << o;
                o += 8;
              }
              v += n & (1 << u) - 1;
              n >>>= u;
              o -= u;
            }
            if (o < 15) {
              n += z[d++] << o;
              o += 8;
              n += z[d++] << o;
              o += 8;
            }
            t = q[n & s];
            _0x228675: while (true) {
              u = t >>> 24;
              n >>>= u;
              o -= u;
              u = t >>> 16 & 255;
              if (u & 16) {
                w = t & 65535;
                u &= 15;
                if (o < u) {
                  n += z[d++] << o;
                  o += 8;
                  if (o < u) {
                    n += z[d++] << o;
                    o += 8;
                  }
                }
                w += n & (1 << u) - 1;
                if (w > i) {
                  a.msg = "invalid distance too far back";
                  B.mode = ud;
                  break _0x23caf7;
                }
                n >>>= u;
                o -= u;
                u = f - g;
                if (w > u) {
                  u = w - u;
                  if (u > k) {
                    if (B.sane) {
                      a.msg = "invalid distance too far back";
                      B.mode = ud;
                      break _0x23caf7;
                    }
                  }
                  x = 0;
                  y = m;
                  if (l === 0) {
                    x += j - u;
                    if (u < v) {
                      v -= u;
                      do {
                        A[f++] = m[x++];
                      } while (--u);
                      x = f - w;
                      y = A;
                    }
                  } else if (l < u) {
                    x += j + l - u;
                    u -= l;
                    if (u < v) {
                      v -= u;
                      do {
                        A[f++] = m[x++];
                      } while (--u);
                      x = 0;
                      if (l < v) {
                        u = l;
                        v -= u;
                        do {
                          A[f++] = m[x++];
                        } while (--u);
                        x = f - w;
                        y = A;
                      }
                    }
                  } else {
                    x += l - u;
                    if (u < v) {
                      v -= u;
                      do {
                        A[f++] = m[x++];
                      } while (--u);
                      x = f - w;
                      y = A;
                    }
                  }
                  while (v > 2) {
                    A[f++] = y[x++];
                    A[f++] = y[x++];
                    A[f++] = y[x++];
                    v -= 3;
                  }
                  if (v) {
                    A[f++] = y[x++];
                    if (v > 1) {
                      A[f++] = y[x++];
                    }
                  }
                } else {
                  x = f - w;
                  do {
                    A[f++] = A[x++];
                    A[f++] = A[x++];
                    A[f++] = A[x++];
                    v -= 3;
                  } while (v > 2);
                  if (v) {
                    A[f++] = A[x++];
                    if (v > 1) {
                      A[f++] = A[x++];
                    }
                  }
                }
              } else if ((u & 64) === 0) {
                t = q[(t & 65535) + (n & (1 << u) - 1)];
                continue _0x228675;
              } else {
                a.msg = "invalid distance code";
                B.mode = ud;
                break _0x23caf7;
              }
              break;
            }
          } else if ((u & 64) === 0) {
            t = p[(t & 65535) + (n & (1 << u) - 1)];
            continue _0x3671ea;
          } else if (u & 32) {
            B.mode = vd;
            break _0x23caf7;
          } else {
            a.msg = "invalid literal/length code";
            B.mode = ud;
            break _0x23caf7;
          }
          break;
        }
      } while (d < e && f < h);
      v = o >> 3;
      d -= v;
      o -= v << 3;
      n &= (1 << o) - 1;
      a.next_in = d;
      a.next_out = f;
      a.avail_in = d < e ? 5 + (e - d) : 5 - (d - e);
      a.avail_out = f < h ? 257 + (h - f) : 257 - (f - h);
      B.hold = n;
      B.bits = o;
      return;
    };
    const xd = 15;
    const yd = 852;
    const zd = 592;
    const Ad = 0;
    const Bd = 1;
    const Cd = 2;
    const Dd = new Uint16Array([3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0]);
    const Ed = new Uint8Array([16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 16, 72, 78]);
    const Fd = new Uint16Array([1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577, 0, 0]);
    const Gd = new Uint8Array([16, 16, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 27, 27, 28, 28, 29, 29, 64, 64]);
    const Hd = (a, b, c, d, e, f, g, h) => {
      const i = h.bits;
      let j = 0;
      let k = 0;
      let l = 0;
      let m = 0;
      let n = 0;
      let o = 0;
      let p = 0;
      let q = 0;
      let r = 0;
      let s = 0;
      let t;
      let u;
      let v;
      let w;
      let x;
      let y = null;
      let z;
      const A = new Uint16Array(xd + 1);
      const B = new Uint16Array(xd + 1);
      let C = null;
      let D;
      let E;
      let F;
      for (j = 0; j <= xd; j++) {
        A[j] = 0;
      }
      for (k = 0; k < d; k++) {
        A[b[c + k]]++;
      }
      n = i;
      for (m = xd; m >= 1; m--) {
        if (A[m] !== 0) {
          break;
        }
      }
      if (n > m) {
        n = m;
      }
      if (m === 0) {
        e[f++] = 20971520;
        e[f++] = 20971520;
        h.bits = 1;
        return 0;
      }
      for (l = 1; l < m; l++) {
        if (A[l] !== 0) {
          break;
        }
      }
      if (n < l) {
        n = l;
      }
      q = 1;
      for (j = 1; j <= xd; j++) {
        q <<= 1;
        q -= A[j];
        if (q < 0) {
          return -1;
        }
      }
      if (q > 0 && (a === Ad || m !== 1)) {
        return -1;
      }
      B[1] = 0;
      for (j = 1; j < xd; j++) {
        B[j + 1] = B[j] + A[j];
      }
      for (k = 0; k < d; k++) {
        if (b[c + k] !== 0) {
          g[B[b[c + k]]++] = k;
        }
      }
      if (a === Ad) {
        y = C = g;
        z = 20;
      } else if (a === Bd) {
        y = Dd;
        C = Ed;
        z = 257;
      } else {
        y = Fd;
        C = Gd;
        z = 0;
      }
      s = 0;
      k = 0;
      j = l;
      x = f;
      o = n;
      p = 0;
      v = -1;
      r = 1 << n;
      w = r - 1;
      if (a === Bd && r > yd || a === Cd && r > zd) {
        return 1;
      }
      while (true) {
        D = j - p;
        if (g[k] + 1 < z) {
          E = 0;
          F = g[k];
        } else if (g[k] >= z) {
          E = C[g[k] - z];
          F = y[g[k] - z];
        } else {
          E = 96;
          F = 0;
        }
        t = 1 << j - p;
        u = 1 << o;
        l = u;
        do {
          u -= t;
          e[x + (s >> p) + u] = D << 24 | E << 16 | F | 0;
        } while (u !== 0);
        t = 1 << j - 1;
        while (s & t) {
          t >>= 1;
        }
        if (t !== 0) {
          s &= t - 1;
          s += t;
        } else {
          s = 0;
        }
        k++;
        if (--A[j] === 0) {
          if (j === m) {
            break;
          }
          j = b[c + g[k]];
        }
        if (j > n && (s & w) !== v) {
          if (p === 0) {
            p = n;
          }
          x += l;
          o = j - p;
          q = 1 << o;
          while (o + p < m) {
            q -= A[o + p];
            if (q <= 0) {
              break;
            }
            o++;
            q <<= 1;
          }
          r += 1 << o;
          if (a === Bd && r > yd || a === Cd && r > zd) {
            return 1;
          }
          v = s & w;
          e[v] = n << 24 | o << 16 | x - f | 0;
        }
      }
      if (s !== 0) {
        e[x + s] = j - p << 24 | 4194304 | 0;
      }
      h.bits = n;
      return 0;
    };
    var Id = Hd;
    const Jd = 0;
    const Kd = 1;
    const Ld = 2;
    const {
      Z_FINISH: Md,
      Z_BLOCK: Nd,
      Z_TREES: Od,
      Z_OK: Pd,
      Z_STREAM_END: Qd,
      Z_NEED_DICT: Rd,
      Z_STREAM_ERROR: Sd,
      Z_DATA_ERROR: Td,
      Z_MEM_ERROR: Ud,
      Z_BUF_ERROR: Vd,
      Z_DEFLATED: Wd
    } = _a;
    const Xd = 16180;
    const Yd = 16181;
    const Zd = 16182;
    const $d = 16183;
    const _d = 16184;
    const ae = 16185;
    const be = 16186;
    const ce = 16187;
    const de = 16188;
    const ee = 16189;
    const fe = 16190;
    const ge = 16191;
    const he = 16192;
    const ie = 16193;
    const je = 16194;
    const ke = 16195;
    const le = 16196;
    const me = 16197;
    const ne = 16198;
    const oe = 16199;
    const pe = 16200;
    const qe = 16201;
    const re = 16202;
    const se = 16203;
    const te = 16204;
    const ue = 16205;
    const ve = 16206;
    const we = 16207;
    const xe = 16208;
    const ye = 16209;
    const ze = 16210;
    const Ae = 16211;
    const Be = 852;
    const Ce = 592;
    const De = 15;
    const Ee = De;
    const Fe = a => {
      return (a >>> 24 & 255) + (a >>> 8 & 65280) + ((a & 65280) << 8) + ((a & 255) << 24);
    };
    function Ge() {
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
    const He = a => {
      if (!a) {
        return 1;
      }
      const b = a.state;
      if (!b || b.strm !== a || b.mode < Xd || b.mode > Ae) {
        return 1;
      }
      return 0;
    };
    const Ie = a => {
      if (He(a)) {
        return Sd;
      }
      const b = a.state;
      a.total_in = a.total_out = b.total = 0;
      a.msg = "";
      if (b.wrap) {
        a.adler = b.wrap & 1;
      }
      b.mode = Xd;
      b.last = 0;
      b.havedict = 0;
      b.flags = -1;
      b.dmax = 32768;
      b.head = null;
      b.hold = 0;
      b.bits = 0;
      b.lencode = b.lendyn = new Int32Array(Be);
      b.distcode = b.distdyn = new Int32Array(Ce);
      b.sane = 1;
      b.back = -1;
      return Pd;
    };
    const Je = a => {
      if (He(a)) {
        return Sd;
      }
      const b = a.state;
      b.wsize = 0;
      b.whave = 0;
      b.wnext = 0;
      return Ie(a);
    };
    const Ke = (a, b) => {
      let c;
      if (He(a)) {
        return Sd;
      }
      const d = a.state;
      if (b < 0) {
        c = 0;
        b = -b;
      } else {
        c = (b >> 4) + 5;
        if (b < 48) {
          b &= 15;
        }
      }
      if (b && (b < 8 || b > 15)) {
        return Sd;
      }
      if (d.window !== null && d.wbits !== b) {
        d.window = null;
      }
      d.wrap = c;
      d.wbits = b;
      return Je(a);
    };
    const Le = (a, b) => {
      if (!a) {
        return Sd;
      }
      const c = new Ge();
      a.state = c;
      c.strm = a;
      c.window = null;
      c.mode = Xd;
      const d = Ke(a, b);
      if (d !== Pd) {
        a.state = null;
      }
      return d;
    };
    const Me = a => {
      return Le(a, Ee);
    };
    let Ne = true;
    let Oe;
    let Pe;
    const Qe = a => {
      if (Ne) {
        Oe = new Int32Array(512);
        Pe = new Int32Array(32);
        let b = 0;
        while (b < 144) {
          a.lens[b++] = 8;
        }
        while (b < 256) {
          a.lens[b++] = 9;
        }
        while (b < 280) {
          a.lens[b++] = 7;
        }
        while (b < 288) {
          a.lens[b++] = 8;
        }
        Id(Kd, a.lens, 0, 288, Oe, 0, a.work, {
          bits: 9
        });
        b = 0;
        while (b < 32) {
          a.lens[b++] = 5;
        }
        Id(Ld, a.lens, 0, 32, Pe, 0, a.work, {
          bits: 5
        });
        Ne = false;
      }
      a.lencode = Oe;
      a.lenbits = 9;
      a.distcode = Pe;
      a.distbits = 5;
    };
    const Re = (a, b, c, d) => {
      let e;
      const f = a.state;
      if (f.window === null) {
        f.wsize = 1 << f.wbits;
        f.wnext = 0;
        f.whave = 0;
        f.window = new Uint8Array(f.wsize);
      }
      if (d >= f.wsize) {
        f.window.set(b.subarray(c - f.wsize, c), 0);
        f.wnext = 0;
        f.whave = f.wsize;
      } else {
        e = f.wsize - f.wnext;
        if (e > d) {
          e = d;
        }
        f.window.set(b.subarray(c - d, c - d + e), f.wnext);
        d -= e;
        if (d) {
          f.window.set(b.subarray(c - d, c), 0);
          f.wnext = d;
          f.whave = f.wsize;
        } else {
          f.wnext += e;
          if (f.wnext === f.wsize) {
            f.wnext = 0;
          }
          if (f.whave < f.wsize) {
            f.whave += e;
          }
        }
      }
      return 0;
    };
    const Se = (a, b) => {
      let c;
      let d;
      let e;
      let f;
      let g;
      let h;
      let i;
      let j;
      let k;
      let l;
      let m;
      let n;
      let o;
      let p;
      let q = 0;
      let r;
      let s;
      let t;
      let u;
      let v;
      let w;
      let x;
      let y;
      const z = new Uint8Array(4);
      let A;
      let B;
      const C = new Uint8Array([16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15]);
      if (He(a) || !a.output || !a.input && a.avail_in !== 0) {
        return Sd;
      }
      c = a.state;
      if (c.mode === ge) {
        c.mode = he;
      }
      g = a.next_out;
      e = a.output;
      i = a.avail_out;
      f = a.next_in;
      d = a.input;
      h = a.avail_in;
      j = c.hold;
      k = c.bits;
      l = h;
      m = i;
      y = Pd;
      _0x21474f: while (true) {
        switch (c.mode) {
          case Xd:
            if (c.wrap === 0) {
              c.mode = he;
              break;
            }
            while (k < 16) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            if (c.wrap & 2 && j === 35615) {
              if (c.wbits === 0) {
                c.wbits = 15;
              }
              c.check = 0;
              z[0] = j & 255;
              z[1] = j >>> 8 & 255;
              c.check = Ya(c.check, z, 2, 0);
              j = 0;
              k = 0;
              c.mode = Yd;
              break;
            }
            if (c.head) {
              c.head.done = false;
            }
            if (!(c.wrap & 1) || (((j & 255) << 8) + (j >> 8)) % 31) {
              a.msg = "incorrect header check";
              c.mode = ye;
              break;
            }
            if ((j & 15) !== Wd) {
              a.msg = "unknown compression method";
              c.mode = ye;
              break;
            }
            j >>>= 4;
            k -= 4;
            x = (j & 15) + 8;
            if (c.wbits === 0) {
              c.wbits = x;
            }
            if (x > 15 || x > c.wbits) {
              a.msg = "invalid window size";
              c.mode = ye;
              break;
            }
            c.dmax = 1 << c.wbits;
            c.flags = 0;
            a.adler = c.check = 1;
            c.mode = j & 512 ? ee : ge;
            j = 0;
            k = 0;
            break;
          case Yd:
            while (k < 16) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            c.flags = j;
            if ((c.flags & 255) !== Wd) {
              a.msg = "unknown compression method";
              c.mode = ye;
              break;
            }
            if (c.flags & 57344) {
              a.msg = "unknown header flags set";
              c.mode = ye;
              break;
            }
            if (c.head) {
              c.head.text = j >> 8 & 1;
            }
            if (c.flags & 512 && c.wrap & 4) {
              z[0] = j & 255;
              z[1] = j >>> 8 & 255;
              c.check = Ya(c.check, z, 2, 0);
            }
            j = 0;
            k = 0;
            c.mode = Zd;
          case Zd:
            while (k < 32) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            if (c.head) {
              c.head.time = j;
            }
            if (c.flags & 512 && c.wrap & 4) {
              z[0] = j & 255;
              z[1] = j >>> 8 & 255;
              z[2] = j >>> 16 & 255;
              z[3] = j >>> 24 & 255;
              c.check = Ya(c.check, z, 4, 0);
            }
            j = 0;
            k = 0;
            c.mode = $d;
          case $d:
            while (k < 16) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            if (c.head) {
              c.head.xflags = j & 255;
              c.head.os = j >> 8;
            }
            if (c.flags & 512 && c.wrap & 4) {
              z[0] = j & 255;
              z[1] = j >>> 8 & 255;
              c.check = Ya(c.check, z, 2, 0);
            }
            j = 0;
            k = 0;
            c.mode = _d;
          case _d:
            if (c.flags & 1024) {
              while (k < 16) {
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              c.length = j;
              if (c.head) {
                c.head.extra_len = j;
              }
              if (c.flags & 512 && c.wrap & 4) {
                z[0] = j & 255;
                z[1] = j >>> 8 & 255;
                c.check = Ya(c.check, z, 2, 0);
              }
              j = 0;
              k = 0;
            } else if (c.head) {
              c.head.extra = null;
            }
            c.mode = ae;
          case ae:
            if (c.flags & 1024) {
              n = c.length;
              if (n > h) {
                n = h;
              }
              if (n) {
                if (c.head) {
                  x = c.head.extra_len - c.length;
                  if (!c.head.extra) {
                    c.head.extra = new Uint8Array(c.head.extra_len);
                  }
                  c.head.extra.set(d.subarray(f, f + n), x);
                }
                if (c.flags & 512 && c.wrap & 4) {
                  c.check = Ya(c.check, d, n, f);
                }
                h -= n;
                f += n;
                c.length -= n;
              }
              if (c.length) {
                break _0x21474f;
              }
            }
            c.length = 0;
            c.mode = be;
          case be:
            if (c.flags & 2048) {
              if (h === 0) {
                break _0x21474f;
              }
              n = 0;
              do {
                x = d[f + n++];
                if (c.head && x && c.length < 65536) {
                  c.head.name += String.fromCharCode(x);
                }
              } while (x && n < h);
              if (c.flags & 512 && c.wrap & 4) {
                c.check = Ya(c.check, d, n, f);
              }
              h -= n;
              f += n;
              if (x) {
                break _0x21474f;
              }
            } else if (c.head) {
              c.head.name = null;
            }
            c.length = 0;
            c.mode = ce;
          case ce:
            if (c.flags & 4096) {
              if (h === 0) {
                break _0x21474f;
              }
              n = 0;
              do {
                x = d[f + n++];
                if (c.head && x && c.length < 65536) {
                  c.head.comment += String.fromCharCode(x);
                }
              } while (x && n < h);
              if (c.flags & 512 && c.wrap & 4) {
                c.check = Ya(c.check, d, n, f);
              }
              h -= n;
              f += n;
              if (x) {
                break _0x21474f;
              }
            } else if (c.head) {
              c.head.comment = null;
            }
            c.mode = de;
          case de:
            if (c.flags & 512) {
              while (k < 16) {
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              if (c.wrap & 4 && j !== (c.check & 65535)) {
                a.msg = "header crc mismatch";
                c.mode = ye;
                break;
              }
              j = 0;
              k = 0;
            }
            if (c.head) {
              c.head.hcrc = c.flags >> 9 & 1;
              c.head.done = true;
            }
            a.adler = c.check = 0;
            c.mode = ge;
            break;
          case ee:
            while (k < 32) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            a.adler = c.check = Fe(j);
            j = 0;
            k = 0;
            c.mode = fe;
          case fe:
            if (c.havedict === 0) {
              a.next_out = g;
              a.avail_out = i;
              a.next_in = f;
              a.avail_in = h;
              c.hold = j;
              c.bits = k;
              return Rd;
            }
            a.adler = c.check = 1;
            c.mode = ge;
          case ge:
            if (b === Nd || b === Od) {
              break _0x21474f;
            }
          case he:
            if (c.last) {
              j >>>= k & 7;
              k -= k & 7;
              c.mode = ve;
              break;
            }
            while (k < 3) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            c.last = j & 1;
            j >>>= 1;
            k -= 1;
            switch (j & 3) {
              case 0:
                c.mode = ie;
                break;
              case 1:
                Qe(c);
                c.mode = oe;
                if (b === Od) {
                  j >>>= 2;
                  k -= 2;
                  break _0x21474f;
                }
                break;
              case 2:
                c.mode = le;
                break;
              case 3:
                a.msg = "invalid block type";
                c.mode = ye;
            }
            j >>>= 2;
            k -= 2;
            break;
          case ie:
            j >>>= k & 7;
            k -= k & 7;
            while (k < 32) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            if ((j & 65535) !== (j >>> 16 ^ 65535)) {
              a.msg = "invalid stored block lengths";
              c.mode = ye;
              break;
            }
            c.length = j & 65535;
            j = 0;
            k = 0;
            c.mode = je;
            if (b === Od) {
              break _0x21474f;
            }
          case je:
            c.mode = ke;
          case ke:
            n = c.length;
            if (n) {
              if (n > h) {
                n = h;
              }
              if (n > i) {
                n = i;
              }
              if (n === 0) {
                break _0x21474f;
              }
              e.set(d.subarray(f, f + n), g);
              h -= n;
              f += n;
              i -= n;
              g += n;
              c.length -= n;
              break;
            }
            c.mode = ge;
            break;
          case le:
            while (k < 14) {
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            c.nlen = (j & 31) + 257;
            j >>>= 5;
            k -= 5;
            c.ndist = (j & 31) + 1;
            j >>>= 5;
            k -= 5;
            c.ncode = (j & 15) + 4;
            j >>>= 4;
            k -= 4;
            if (c.nlen > 286 || c.ndist > 30) {
              a.msg = "too many length or distance symbols";
              c.mode = ye;
              break;
            }
            c.have = 0;
            c.mode = me;
          case me:
            while (c.have < c.ncode) {
              while (k < 3) {
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              c.lens[C[c.have++]] = j & 7;
              j >>>= 3;
              k -= 3;
            }
            while (c.have < 19) {
              c.lens[C[c.have++]] = 0;
            }
            c.lencode = c.lendyn;
            c.lenbits = 7;
            var D = {
              bits: c.lenbits
            };
            A = D;
            y = Id(Jd, c.lens, 0, 19, c.lencode, 0, c.work, A);
            c.lenbits = A.bits;
            if (y) {
              a.msg = "invalid code lengths set";
              c.mode = ye;
              break;
            }
            c.have = 0;
            c.mode = ne;
          case ne:
            while (c.have < c.nlen + c.ndist) {
              while (true) {
                q = c.lencode[j & (1 << c.lenbits) - 1];
                r = q >>> 24;
                s = q >>> 16 & 255;
                t = q & 65535;
                if (r <= k) {
                  break;
                }
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              if (t < 16) {
                j >>>= r;
                k -= r;
                c.lens[c.have++] = t;
              } else {
                if (t === 16) {
                  B = r + 2;
                  while (k < B) {
                    if (h === 0) {
                      break _0x21474f;
                    }
                    h--;
                    j += d[f++] << k;
                    k += 8;
                  }
                  j >>>= r;
                  k -= r;
                  if (c.have === 0) {
                    a.msg = "invalid bit length repeat";
                    c.mode = ye;
                    break;
                  }
                  x = c.lens[c.have - 1];
                  n = 3 + (j & 3);
                  j >>>= 2;
                  k -= 2;
                } else if (t === 17) {
                  B = r + 3;
                  while (k < B) {
                    if (h === 0) {
                      break _0x21474f;
                    }
                    h--;
                    j += d[f++] << k;
                    k += 8;
                  }
                  j >>>= r;
                  k -= r;
                  x = 0;
                  n = 3 + (j & 7);
                  j >>>= 3;
                  k -= 3;
                } else {
                  B = r + 7;
                  while (k < B) {
                    if (h === 0) {
                      break _0x21474f;
                    }
                    h--;
                    j += d[f++] << k;
                    k += 8;
                  }
                  j >>>= r;
                  k -= r;
                  x = 0;
                  n = 11 + (j & 127);
                  j >>>= 7;
                  k -= 7;
                }
                if (c.have + n > c.nlen + c.ndist) {
                  a.msg = "invalid bit length repeat";
                  c.mode = ye;
                  break;
                }
                while (n--) {
                  c.lens[c.have++] = x;
                }
              }
            }
            if (c.mode === ye) {
              break;
            }
            if (c.lens[256] === 0) {
              a.msg = "invalid code -- missing end-of-block";
              c.mode = ye;
              break;
            }
            c.lenbits = 9;
            var E = {
              bits: c.lenbits
            };
            A = E;
            y = Id(Kd, c.lens, 0, c.nlen, c.lencode, 0, c.work, A);
            c.lenbits = A.bits;
            if (y) {
              a.msg = "invalid literal/lengths set";
              c.mode = ye;
              break;
            }
            c.distbits = 6;
            c.distcode = c.distdyn;
            var F = {
              bits: c.distbits
            };
            A = F;
            y = Id(Ld, c.lens, c.nlen, c.ndist, c.distcode, 0, c.work, A);
            c.distbits = A.bits;
            if (y) {
              a.msg = "invalid distances set";
              c.mode = ye;
              break;
            }
            c.mode = oe;
            if (b === Od) {
              break _0x21474f;
            }
          case oe:
            c.mode = pe;
          case pe:
            if (h >= 6 && i >= 258) {
              a.next_out = g;
              a.avail_out = i;
              a.next_in = f;
              a.avail_in = h;
              c.hold = j;
              c.bits = k;
              wd(a, m);
              g = a.next_out;
              e = a.output;
              i = a.avail_out;
              f = a.next_in;
              d = a.input;
              h = a.avail_in;
              j = c.hold;
              k = c.bits;
              if (c.mode === ge) {
                c.back = -1;
              }
              break;
            }
            c.back = 0;
            while (true) {
              q = c.lencode[j & (1 << c.lenbits) - 1];
              r = q >>> 24;
              s = q >>> 16 & 255;
              t = q & 65535;
              if (r <= k) {
                break;
              }
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            if (s && (s & 240) === 0) {
              u = r;
              v = s;
              w = t;
              while (true) {
                q = c.lencode[w + ((j & (1 << u + v) - 1) >> u)];
                r = q >>> 24;
                s = q >>> 16 & 255;
                t = q & 65535;
                if (u + r <= k) {
                  break;
                }
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              j >>>= u;
              k -= u;
              c.back += u;
            }
            j >>>= r;
            k -= r;
            c.back += r;
            c.length = t;
            if (s === 0) {
              c.mode = ue;
              break;
            }
            if (s & 32) {
              c.back = -1;
              c.mode = ge;
              break;
            }
            if (s & 64) {
              a.msg = "invalid literal/length code";
              c.mode = ye;
              break;
            }
            c.extra = s & 15;
            c.mode = qe;
          case qe:
            if (c.extra) {
              B = c.extra;
              while (k < B) {
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              c.length += j & (1 << c.extra) - 1;
              j >>>= c.extra;
              k -= c.extra;
              c.back += c.extra;
            }
            c.was = c.length;
            c.mode = re;
          case re:
            while (true) {
              q = c.distcode[j & (1 << c.distbits) - 1];
              r = q >>> 24;
              s = q >>> 16 & 255;
              t = q & 65535;
              if (r <= k) {
                break;
              }
              if (h === 0) {
                break _0x21474f;
              }
              h--;
              j += d[f++] << k;
              k += 8;
            }
            if ((s & 240) === 0) {
              u = r;
              v = s;
              w = t;
              while (true) {
                q = c.distcode[w + ((j & (1 << u + v) - 1) >> u)];
                r = q >>> 24;
                s = q >>> 16 & 255;
                t = q & 65535;
                if (u + r <= k) {
                  break;
                }
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              j >>>= u;
              k -= u;
              c.back += u;
            }
            j >>>= r;
            k -= r;
            c.back += r;
            if (s & 64) {
              a.msg = "invalid distance code";
              c.mode = ye;
              break;
            }
            c.offset = t;
            c.extra = s & 15;
            c.mode = se;
          case se:
            if (c.extra) {
              B = c.extra;
              while (k < B) {
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              c.offset += j & (1 << c.extra) - 1;
              j >>>= c.extra;
              k -= c.extra;
              c.back += c.extra;
            }
            if (c.offset > c.dmax) {
              a.msg = "invalid distance too far back";
              c.mode = ye;
              break;
            }
            c.mode = te;
          case te:
            if (i === 0) {
              break _0x21474f;
            }
            n = m - i;
            if (c.offset > n) {
              n = c.offset - n;
              if (n > c.whave) {
                if (c.sane) {
                  a.msg = "invalid distance too far back";
                  c.mode = ye;
                  break;
                }
              }
              if (n > c.wnext) {
                n -= c.wnext;
                o = c.wsize - n;
              } else {
                o = c.wnext - n;
              }
              if (n > c.length) {
                n = c.length;
              }
              p = c.window;
            } else {
              p = e;
              o = g - c.offset;
              n = c.length;
            }
            if (n > i) {
              n = i;
            }
            i -= n;
            c.length -= n;
            do {
              e[g++] = p[o++];
            } while (--n);
            if (c.length === 0) {
              c.mode = pe;
            }
            break;
          case ue:
            if (i === 0) {
              break _0x21474f;
            }
            e[g++] = c.length;
            i--;
            c.mode = pe;
            break;
          case ve:
            if (c.wrap) {
              while (k < 32) {
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j |= d[f++] << k;
                k += 8;
              }
              m -= i;
              a.total_out += m;
              c.total += m;
              if (c.wrap & 4 && m) {
                a.adler = c.check = c.flags ? Ya(c.check, e, m, g - m) : Ua(c.check, e, m, g - m);
              }
              m = i;
              if (c.wrap & 4 && (c.flags ? j : Fe(j)) !== c.check) {
                a.msg = "incorrect data check";
                c.mode = ye;
                break;
              }
              j = 0;
              k = 0;
            }
            c.mode = we;
          case we:
            if (c.wrap && c.flags) {
              while (k < 32) {
                if (h === 0) {
                  break _0x21474f;
                }
                h--;
                j += d[f++] << k;
                k += 8;
              }
              if (c.wrap & 4 && j !== (c.total & 4294967295)) {
                a.msg = "incorrect length check";
                c.mode = ye;
                break;
              }
              j = 0;
              k = 0;
            }
            c.mode = xe;
          case xe:
            y = Qd;
            break _0x21474f;
          case ye:
            y = Td;
            break _0x21474f;
          case ze:
            return Ud;
          case Ae:
          default:
            return Sd;
        }
      }
      a.next_out = g;
      a.avail_out = i;
      a.next_in = f;
      a.avail_in = h;
      c.hold = j;
      c.bits = k;
      if (c.wsize || m !== a.avail_out && c.mode < ye && (c.mode < ve || b !== Md)) {
        if (Re(a, a.output, a.next_out, m - a.avail_out)) ;
      }
      l -= a.avail_in;
      m -= a.avail_out;
      a.total_in += l;
      a.total_out += m;
      c.total += m;
      if (c.wrap & 4 && m) {
        a.adler = c.check = c.flags ? Ya(c.check, e, m, a.next_out - m) : Ua(c.check, e, m, a.next_out - m);
      }
      a.data_type = c.bits + (c.last ? 64 : 0) + (c.mode === ge ? 128 : 0) + (c.mode === oe || c.mode === je ? 256 : 0);
      if ((l === 0 && m === 0 || b === Md) && y === Pd) {
        y = Vd;
      }
      return y;
    };
    const Te = a => {
      if (He(a)) {
        return Sd;
      }
      let b = a.state;
      b.window &&= null;
      a.state = null;
      return Pd;
    };
    const Ue = (a, b) => {
      if (He(a)) {
        return Sd;
      }
      const c = a.state;
      if ((c.wrap & 2) === 0) {
        return Sd;
      }
      c.head = b;
      b.done = false;
      return Pd;
    };
    const Ve = (a, b) => {
      const c = b.length;
      let d;
      let e;
      let f;
      if (He(a)) {
        return Sd;
      }
      d = a.state;
      if (d.wrap !== 0 && d.mode !== fe) {
        return Sd;
      }
      if (d.mode === fe) {
        e = 1;
        e = Ua(e, b, c, 0);
        if (e !== d.check) {
          return Td;
        }
      }
      f = Re(a, b, c, c);
      if (f) {
        d.mode = ze;
        return Ud;
      }
      d.havedict = 1;
      return Pd;
    };
    var We = Je;
    var Xe = Ke;
    var Ye = Ie;
    var Ze = Me;
    var $e = Le;
    var _e = Se;
    var af = Te;
    var bf = Ue;
    var cf = Ve;
    var df = "pako inflate (from Nodeca project)";
    var ef = {
      inflateReset: We,
      inflateReset2: Xe,
      inflateResetKeep: Ye,
      inflateInit: Ze,
      inflateInit2: $e,
      inflate: _e,
      inflateEnd: af,
      inflateGetHeader: bf,
      inflateSetDictionary: cf,
      inflateInfo: df
    };
    var ff = ef;
    function gf() {
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
    var hf = gf;
    const jf = Object.prototype.toString;
    const {
      Z_NO_FLUSH: kf,
      Z_FINISH: lf,
      Z_OK: mf,
      Z_STREAM_END: nf,
      Z_NEED_DICT: of,
      Z_STREAM_ERROR: pf,
      Z_DATA_ERROR: qf,
      Z_MEM_ERROR: rf
    } = _a;
    function sf(a) {
      this.options = Qc.assign({
        chunkSize: 65536,
        windowBits: 15,
        to: ""
      }, a || {});
      const b = this.options;
      if (b.raw && b.windowBits >= 0 && b.windowBits < 16) {
        b.windowBits = -b.windowBits;
        if (b.windowBits === 0) {
          b.windowBits = -15;
        }
      }
      if (b.windowBits >= 0 && b.windowBits < 16 && (!a || !a.windowBits)) {
        b.windowBits += 32;
      }
      if (b.windowBits > 15 && b.windowBits < 48) {
        if ((b.windowBits & 15) === 0) {
          b.windowBits |= 15;
        }
      }
      this.err = 0;
      this.msg = "";
      this.ended = false;
      this.chunks = [];
      this.strm = new $c();
      this.strm.avail_out = 0;
      let c = ff.inflateInit2(this.strm, b.windowBits);
      if (c !== mf) {
        throw new Error(Za[c]);
      }
      this.header = new hf();
      ff.inflateGetHeader(this.strm, this.header);
      if (b.dictionary) {
        if (typeof b.dictionary === "string") {
          b.dictionary = Yc.string2buf(b.dictionary);
        } else if (jf.call(b.dictionary) === "[object ArrayBuffer]") {
          b.dictionary = new Uint8Array(b.dictionary);
        }
        if (b.raw) {
          c = ff.inflateSetDictionary(this.strm, b.dictionary);
          if (c !== mf) {
            throw new Error(Za[c]);
          }
        }
      }
    }
    sf.prototype.push = function (a, b) {
      const c = this.strm;
      const d = this.options.chunkSize;
      const e = this.options.dictionary;
      let f;
      let g;
      let h;
      if (this.ended) {
        return false;
      }
      if (b === ~~b) {
        g = b;
      } else {
        g = b === true ? lf : kf;
      }
      if (jf.call(a) === "[object ArrayBuffer]") {
        c.input = new Uint8Array(a);
      } else {
        c.input = a;
      }
      c.next_in = 0;
      c.avail_in = c.input.length;
      while (true) {
        if (c.avail_out === 0) {
          c.output = new Uint8Array(d);
          c.next_out = 0;
          c.avail_out = d;
        }
        f = ff.inflate(c, g);
        if (f === of && e) {
          f = ff.inflateSetDictionary(c, e);
          if (f === mf) {
            f = ff.inflate(c, g);
          } else if (f === qf) {
            f = of;
          }
        }
        while (c.avail_in > 0 && f === nf && c.state.wrap > 0 && a[c.next_in] !== 0) {
          ff.inflateReset(c);
          f = ff.inflate(c, g);
        }
        switch (f) {
          case pf:
          case qf:
          case of:
          case rf:
            this.onEnd(f);
            this.ended = true;
            return false;
        }
        h = c.avail_out;
        if (c.next_out) {
          if (c.avail_out === 0 || f === nf) {
            if (this.options.to === "string") {
              let a = Yc.utf8border(c.output, c.next_out);
              let b = c.next_out - a;
              let e = Yc.buf2string(c.output, a);
              c.next_out = b;
              c.avail_out = d - b;
              if (b) {
                c.output.set(c.output.subarray(a, a + b), 0);
              }
              this.onData(e);
            } else {
              this.onData(c.output.length === c.next_out ? c.output : c.output.subarray(0, c.next_out));
            }
          }
        }
        if (f === mf && h === 0) {
          continue;
        }
        if (f === nf) {
          f = ff.inflateEnd(this.strm);
          this.onEnd(f);
          this.ended = true;
          return true;
        }
        if (c.avail_in === 0) {
          break;
        }
      }
      return true;
    };
    sf.prototype.onData = function (a) {
      this.chunks.push(a);
    };
    sf.prototype.onEnd = function (a) {
      if (a === mf) {
        if (this.options.to === "string") {
          this.result = this.chunks.join("");
        } else {
          this.result = Qc.flattenChunks(this.chunks);
        }
      }
      this.chunks = [];
      this.err = a;
      this.msg = this.strm.msg;
    };
    function tf(a, b) {
      const c = new sf(b);
      c.push(a);
      if (c.err) {
        throw c.msg || Za[c.err];
      }
      return c.result;
    }
    function uf(a, b) {
      b = b || {};
      b.raw = true;
      return tf(a, b);
    }
    var vf = sf;
    var wf = tf;
    var xf = uf;
    var yf = tf;
    var zf = _a;
    var Af = {
      Inflate: vf,
      inflate: wf,
      inflateRaw: xf,
      ungzip: yf,
      constants: zf
    };
    var Bf = Af;
    const {
      Deflate: Cf,
      deflate: Df,
      deflateRaw: Ef,
      gzip: Ff
    } = td;
    const {
      Inflate: Gf,
      inflate: Hf,
      inflateRaw: If,
      ungzip: Jf
    } = Bf;
    var Kf = Cf;
    var Lf = Df;
    var Mf = Ef;
    var Nf = Ff;
    var Of = Gf;
    var Pf = Hf;
    var Qf = If;
    var Rf = Jf;
    var Sf = _a;
    var Tf = {
      Deflate: Kf,
      deflate: Lf,
      deflateRaw: Mf,
      gzip: Nf,
      Inflate: Of,
      inflate: Pf,
      inflateRaw: Qf,
      ungzip: Rf,
      constants: Sf
    };
    var Uf = Tf;
    ;
    var Vf;
    (function (a) {
      a.assertEqual = a => a;
      function b(a) {}
      a.assertIs = b;
      function c(a) {
        throw new Error();
      }
      a.assertNever = c;
      a.arrayToEnum = a => {
        const b = {};
        for (const c of a) {
          b[c] = c;
        }
        return b;
      };
      a.getValidEnumValues = b => {
        const c = a.objectKeys(b).filter(a => typeof b[b[a]] !== "number");
        const d = {};
        for (const a of c) {
          d[a] = b[a];
        }
        return a.objectValues(d);
      };
      a.objectValues = b => {
        return a.objectKeys(b).map(function (a) {
          return b[a];
        });
      };
      a.objectKeys = typeof Object.keys === "function" ? a => Object.keys(a) : a => {
        const b = [];
        for (const c in a) {
          if (Object.prototype.hasOwnProperty.call(a, c)) {
            b.push(c);
          }
        }
        return b;
      };
      a.find = (a, b) => {
        for (const c of a) {
          if (b(c)) {
            return c;
          }
        }
        return undefined;
      };
      a.isInteger = typeof Number.isInteger === "function" ? a => Number.isInteger(a) : a => typeof a === "number" && isFinite(a) && Math.floor(a) === a;
      function d(a, b = " | ") {
        return a.map(a => typeof a === "string" ? "'" + a + "'" : a).join(b);
      }
      a.joinValues = d;
      a.jsonStringifyReplacer = (a, b) => {
        if (typeof b === "bigint") {
          return b.toString();
        }
        return b;
      };
    })(Vf ||= {});
    var Wf;
    (function (a) {
      a.mergeShapes = (a, b) => {
        var c = {
          ...a,
          ...b
        };
        return c;
      };
    })(Wf ||= {});
    const Xf = Vf.arrayToEnum(["string", "nan", "number", "integer", "float", "boolean", "date", "bigint", "symbol", "function", "undefined", "null", "array", "object", "unknown", "promise", "void", "never", "map", "set"]);
    const Yf = a => {
      const b = typeof a;
      switch (b) {
        case "undefined":
          return Xf.undefined;
        case "string":
          return Xf.string;
        case "number":
          if (isNaN(a)) {
            return Xf.nan;
          } else {
            return Xf.number;
          }
        case "boolean":
          return Xf.boolean;
        case "function":
          return Xf.function;
        case "bigint":
          return Xf.bigint;
        case "symbol":
          return Xf.symbol;
        case "object":
          if (Array.isArray(a)) {
            return Xf.array;
          }
          if (a === null) {
            return Xf.null;
          }
          if (a.then && typeof a.then === "function" && a.catch && typeof a.catch === "function") {
            return Xf.promise;
          }
          if (typeof Map !== "undefined" && a instanceof Map) {
            return Xf.map;
          }
          if (typeof Set !== "undefined" && a instanceof Set) {
            return Xf.set;
          }
          if (typeof Date !== "undefined" && a instanceof Date) {
            return Xf.date;
          }
          return Xf.object;
        default:
          return Xf.unknown;
      }
    };
    const Zf = Vf.arrayToEnum(["invalid_type", "invalid_literal", "custom", "invalid_union", "invalid_union_discriminator", "invalid_enum_value", "unrecognized_keys", "invalid_arguments", "invalid_return_type", "invalid_date", "invalid_string", "too_small", "too_big", "invalid_intersection_types", "not_multiple_of", "not_finite"]);
    const $f = a => {
      const b = JSON.stringify(a, null, 2);
      return b.replace(/"([^"]+)":/g, "$1:");
    };
    class _f extends Error {
      constructor(a) {
        super();
        this.issues = [];
        this.addIssue = a => {
          this.issues = [...this.issues, a];
        };
        this.addIssues = (a = undefined) => {
          if (a === undefined) a = [];
          this.issues = [...this.issues, ...a];
        };
        const b = new.target.prototype;
        if (Object.setPrototypeOf) {
          Object.setPrototypeOf(this, b);
        } else {
          this.__proto__ = b;
        }
        this.name = "ZodError";
        this.issues = a;
      }
      get errors() {
        return this.issues;
      }
      format(a) {
        const b = a || function (a) {
          return a.message;
        };
        const c = {
          _errors: []
        };
        const d = a => {
          for (const e of a.issues) {
            if (e.code === "invalid_union") {
              e.unionErrors.map(d);
            } else if (e.code === "invalid_return_type") {
              d(e.returnTypeError);
            } else if (e.code === "invalid_arguments") {
              d(e.argumentsError);
            } else if (e.path.length === 0) {
              c._errors.push(b(e));
            } else {
              let a = c;
              let d = 0;
              while (d < e.path.length) {
                const c = e.path[d];
                const f = d === e.path.length - 1;
                if (!f) {
                  a[c] = a[c] || {
                    _errors: []
                  };
                } else {
                  a[c] = a[c] || {
                    _errors: []
                  };
                  a[c]._errors.push(b(e));
                }
                a = a[c];
                d++;
              }
            }
          }
        };
        d(this);
        return c;
      }
      toString() {
        return this.message;
      }
      get message() {
        return JSON.stringify(this.issues, Vf.jsonStringifyReplacer, 2);
      }
      get isEmpty() {
        return this.issues.length === 0;
      }
      flatten(a = undefined) {
        if (a === undefined) a = a => a.message;
        const b = {};
        const c = [];
        for (const d of this.issues) {
          if (d.path.length > 0) {
            b[d.path[0]] = b[d.path[0]] || [];
            b[d.path[0]].push(a(d));
          } else {
            c.push(a(d));
          }
        }
        var d = {
          formErrors: c,
          fieldErrors: b
        };
        return d;
      }
      get formErrors() {
        return this.flatten();
      }
    }
    _f.create = a => {
      const b = new _f(a);
      return b;
    };
    const ag = (a, b) => {
      let c;
      switch (a.code) {
        case Zf.invalid_type:
          if (a.received === Xf.undefined) {
            c = "Required";
          } else {
            c = "Expected " + a.expected + ", received " + a.received;
          }
          break;
        case Zf.invalid_literal:
          c = "Invalid literal value, expected " + JSON.stringify(a.expected, Vf.jsonStringifyReplacer);
          break;
        case Zf.unrecognized_keys:
          c = "Unrecognized key(s) in object: " + Vf.joinValues(a.keys, ", ");
          break;
        case Zf.invalid_union:
          c = "Invalid input";
          break;
        case Zf.invalid_union_discriminator:
          c = "Invalid discriminator value. Expected " + Vf.joinValues(a.options);
          break;
        case Zf.invalid_enum_value:
          c = "Invalid enum value. Expected " + Vf.joinValues(a.options) + ", received '" + a.received + "'";
          break;
        case Zf.invalid_arguments:
          c = "Invalid function arguments";
          break;
        case Zf.invalid_return_type:
          c = "Invalid function return type";
          break;
        case Zf.invalid_date:
          c = "Invalid date";
          break;
        case Zf.invalid_string:
          if (typeof a.validation === "object") {
            if ("includes" in a.validation) {
              c = "Invalid input: must include \"" + a.validation.includes + "\"";
              if (typeof a.validation.position === "number") {
                c = c + " at one or more positions greater than or equal to " + a.validation.position;
              }
            } else if ("startsWith" in a.validation) {
              c = "Invalid input: must start with \"" + a.validation.startsWith + "\"";
            } else if ("endsWith" in a.validation) {
              c = "Invalid input: must end with \"" + a.validation.endsWith + "\"";
            } else {
              Vf.assertNever(a.validation);
            }
          } else if (a.validation !== "regex") {
            c = "Invalid " + a.validation;
          } else {
            c = "Invalid";
          }
          break;
        case Zf.too_small:
          if (a.type === "array") {
            c = "Array must contain " + (a.exact ? "exactly" : a.inclusive ? "at least" : "more than") + " " + a.minimum + " element(s)";
          } else if (a.type === "string") {
            c = "String must contain " + (a.exact ? "exactly" : a.inclusive ? "at least" : "over") + " " + a.minimum + " character(s)";
          } else if (a.type === "number") {
            c = "Number must be " + (a.exact ? "exactly equal to " : a.inclusive ? "greater than or equal to " : "greater than ") + a.minimum;
          } else if (a.type === "date") {
            c = "Date must be " + (a.exact ? "exactly equal to " : a.inclusive ? "greater than or equal to " : "greater than ") + new Date(Number(a.minimum));
          } else {
            c = "Invalid input";
          }
          break;
        case Zf.too_big:
          if (a.type === "array") {
            c = "Array must contain " + (a.exact ? "exactly" : a.inclusive ? "at most" : "less than") + " " + a.maximum + " element(s)";
          } else if (a.type === "string") {
            c = "String must contain " + (a.exact ? "exactly" : a.inclusive ? "at most" : "under") + " " + a.maximum + " character(s)";
          } else if (a.type === "number") {
            c = "Number must be " + (a.exact ? "exactly" : a.inclusive ? "less than or equal to" : "less than") + " " + a.maximum;
          } else if (a.type === "bigint") {
            c = "BigInt must be " + (a.exact ? "exactly" : a.inclusive ? "less than or equal to" : "less than") + " " + a.maximum;
          } else if (a.type === "date") {
            c = "Date must be " + (a.exact ? "exactly" : a.inclusive ? "smaller than or equal to" : "smaller than") + " " + new Date(Number(a.maximum));
          } else {
            c = "Invalid input";
          }
          break;
        case Zf.custom:
          c = "Invalid input";
          break;
        case Zf.invalid_intersection_types:
          c = "Intersection results could not be merged";
          break;
        case Zf.not_multiple_of:
          c = "Number must be a multiple of " + a.multipleOf;
          break;
        case Zf.not_finite:
          c = "Number must be finite";
          break;
        default:
          c = b.defaultError;
          Vf.assertNever(a);
      }
      var d = {
        message: c
      };
      return d;
    };
    let bg = ag;
    function cg(a) {
      bg = a;
    }
    function dg() {
      return bg;
    }
    const eg = a => {
      const {
        data: b,
        path: c,
        errorMaps: d,
        issueData: e
      } = a;
      const f = [...c, ...(e.path || [])];
      var g = {
        ...e
      };
      g.path = f;
      const h = g;
      let i = "";
      const j = d.filter(a => !!a).slice().reverse();
      for (const c of j) {
        i = c(h, {
          data: b,
          defaultError: i
        }).message;
      }
      var k = {
        ...e
      };
      k.path = f;
      k.message = e.message || i;
      return k;
    };
    const fg = [];
    function gg(a, b) {
      const c = eg({
        issueData: b,
        data: a.data,
        path: a.path,
        errorMaps: [a.common.contextualErrorMap, a.schemaErrorMap, dg(), ag].filter(a => !!a)
      });
      a.common.issues.push(c);
    }
    class hg {
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
      static mergeArray(a, b) {
        const c = [];
        for (const d of b) {
          if (d.status === "aborted") {
            return ig;
          }
          if (d.status === "dirty") {
            a.dirty();
          }
          c.push(d.value);
        }
        var d = {
          status: a.value,
          value: c
        };
        return d;
      }
      static async mergeObjectAsync(a, b) {
        const c = [];
        for (const e of b) {
          var d = {
            key: await e.key,
            value: await e.value
          };
          c.push(d);
        }
        return hg.mergeObjectSync(a, c);
      }
      static mergeObjectSync(a, b) {
        const c = {};
        for (const d of b) {
          const {
            key: b,
            value: e
          } = d;
          if (b.status === "aborted") {
            return ig;
          }
          if (e.status === "aborted") {
            return ig;
          }
          if (b.status === "dirty") {
            a.dirty();
          }
          if (e.status === "dirty") {
            a.dirty();
          }
          if (typeof e.value !== "undefined" || d.alwaysSet) {
            c[b.value] = e.value;
          }
        }
        var d = {
          status: a.value,
          value: c
        };
        return d;
      }
    }
    const ig = Object.freeze({
      status: "aborted"
    });
    const jg = a => ({
      status: "dirty",
      value: a
    });
    const kg = a => ({
      status: "valid",
      value: a
    });
    const lg = a => a.status === "aborted";
    const mg = a => a.status === "dirty";
    const ng = a => a.status === "valid";
    const og = a => typeof Promise !== "undefined" && a instanceof Promise;
    var pg;
    (function (a) {
      a.errToObj = a => typeof a === "string" ? {
        message: a
      } : a || {};
      a.toString = a => typeof a === "string" ? a : a?.message;
    })(pg ||= {});
    class qg {
      constructor(a, b, c, d) {
        this._cachedPath = [];
        this.parent = a;
        this.data = b;
        this._path = c;
        this._key = d;
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
    const rg = (a, b) => {
      if (ng(b)) {
        var c = {
          success: true,
          data: b.value
        };
        return c;
      } else {
        if (!a.common.issues.length) {
          throw new Error("Validation failed but no issues detected.");
        }
        return {
          success: false,
          get error() {
            if (this._error) {
              return this._error;
            }
            const b = new _f(a.common.issues);
            this._error = b;
            return this._error;
          }
        };
      }
    };
    function sg(a) {
      if (!a) {
        return {};
      }
      const {
        errorMap: b,
        invalid_type_error: c,
        required_error: d,
        description: e
      } = a;
      if (b && (c || d)) {
        throw new Error("Can't use \"invalid_type_error\" or \"required_error\" in conjunction with custom error map.");
      }
      if (b) {
        return {
          errorMap: b,
          description: e
        };
      }
      const f = (a, b) => {
        var e = {
          message: b.defaultError
        };
        if (a.code !== "invalid_type") {
          return e;
        }
        if (typeof b.data === "undefined") {
          var f = {
            message: d ?? b.defaultError
          };
          return f;
        }
        var g = {
          message: c ?? b.defaultError
        };
        return g;
      };
      var g = {
        errorMap: f,
        description: e
      };
      return g;
    }
    class tg {
      constructor(a) {
        this.spa = this.safeParseAsync;
        this._def = a;
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
      _getType(a) {
        return Yf(a.data);
      }
      _getOrReturnCtx(a, b) {
        return b || {
          common: a.parent.common,
          data: a.data,
          parsedType: Yf(a.data),
          schemaErrorMap: this._def.errorMap,
          path: a.path,
          parent: a.parent
        };
      }
      _processInputParams(a) {
        return {
          status: new hg(),
          ctx: {
            common: a.parent.common,
            data: a.data,
            parsedType: Yf(a.data),
            schemaErrorMap: this._def.errorMap,
            path: a.path,
            parent: a.parent
          }
        };
      }
      _parseSync(a) {
        const b = this._parse(a);
        if (og(b)) {
          throw new Error("Synchronous parse encountered promise.");
        }
        return b;
      }
      _parseAsync(a) {
        const b = this._parse(a);
        return Promise.resolve(b);
      }
      parse(a, b) {
        const c = this.safeParse(a, b);
        if (c.success) {
          return c.data;
        }
        throw c.error;
      }
      safeParse(a, b) {
        var c = {
          issues: [],
          async: b?.async ?? false,
          contextualErrorMap: b?.errorMap
        };
        const d = {
          common: c,
          path: b?.path || [],
          schemaErrorMap: this._def.errorMap,
          parent: null,
          data: a,
          parsedType: Yf(a)
        };
        var e = {
          data: a,
          path: d.path,
          parent: d
        };
        const f = this._parseSync(e);
        return rg(d, f);
      }
      async parseAsync(a, b) {
        const c = await this.safeParseAsync(a, b);
        if (c.success) {
          return c.data;
        }
        throw c.error;
      }
      async safeParseAsync(a, b) {
        var c = {
          issues: [],
          contextualErrorMap: b?.errorMap,
          async: true
        };
        const d = {
          common: c,
          path: b?.path || [],
          schemaErrorMap: this._def.errorMap,
          parent: null,
          data: a,
          parsedType: Yf(a)
        };
        var e = {
          data: a,
          path: d.path,
          parent: d
        };
        const f = this._parse(e);
        const g = await (og(f) ? f : Promise.resolve(f));
        return rg(d, g);
      }
      refine(a, b) {
        const c = a => {
          if (typeof b === "string" || typeof b === "undefined") {
            var c = {
              message: b
            };
            return c;
          } else if (typeof b === "function") {
            return b(a);
          } else {
            return b;
          }
        };
        return this._refinement((b, d) => {
          const e = a(b);
          const f = () => d.addIssue({
            code: Zf.custom,
            ...c(b)
          });
          if (typeof Promise !== "undefined" && e instanceof Promise) {
            return e.then(a => {
              if (!a) {
                f();
                return false;
              } else {
                return true;
              }
            });
          }
          if (!e) {
            f();
            return false;
          } else {
            return true;
          }
        });
      }
      refinement(a, b) {
        return this._refinement((c, d) => {
          if (!a(c)) {
            d.addIssue(typeof b === "function" ? b(c, d) : b);
            return false;
          } else {
            return true;
          }
        });
      }
      _refinement(a) {
        var b = {
          type: "refinement",
          refinement: a
        };
        var c = {
          schema: this,
          typeName: uh.ZodEffects,
          effect: b
        };
        return new ih(c);
      }
      superRefine(a) {
        return this._refinement(a);
      }
      optional() {
        return jh.create(this, this._def);
      }
      nullable() {
        return kh.create(this, this._def);
      }
      nullish() {
        return this.nullable().optional();
      }
      array() {
        return Rg.create(this, this._def);
      }
      promise() {
        return hh.create(this, this._def);
      }
      or(a) {
        return Ug.create([this, a], this._def);
      }
      and(a) {
        return Yg.create(this, a, this._def);
      }
      transform(a) {
        var b = {
          type: "transform",
          transform: a
        };
        return new ih({
          ...sg(this._def),
          schema: this,
          typeName: uh.ZodEffects,
          effect: b
        });
      }
      default(a) {
        const b = typeof a === "function" ? a : () => a;
        return new lh({
          ...sg(this._def),
          innerType: this,
          defaultValue: b,
          typeName: uh.ZodDefault
        });
      }
      brand() {
        return new ph({
          typeName: uh.ZodBranded,
          type: this,
          ...sg(this._def)
        });
      }
      catch(a) {
        const b = typeof a === "function" ? a : () => a;
        return new mh({
          ...sg(this._def),
          innerType: this,
          catchValue: b,
          typeName: uh.ZodCatch
        });
      }
      describe(a) {
        const b = this.constructor;
        var c = {
          ...this._def
        };
        c.description = a;
        return new b(c);
      }
      pipe(a) {
        return qh.create(this, a);
      }
      isOptional() {
        return this.safeParse(undefined).success;
      }
      isNullable() {
        return this.safeParse(null).success;
      }
    }
    const ug = /^c[^\s-]{8,}$/i;
    const vg = /^[a-z][a-z0-9]*$/;
    const wg = /[0-9A-HJKMNP-TV-Z]{26}/;
    const xg = /^([a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[a-f0-9]{4}-[a-f0-9]{12}|00000000-0000-0000-0000-000000000000)$/i;
    const yg = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\])|(\[IPv6:(([a-f0-9]{1,4}:){7}|::([a-f0-9]{1,4}:){0,6}|([a-f0-9]{1,4}:){1}:([a-f0-9]{1,4}:){0,5}|([a-f0-9]{1,4}:){2}:([a-f0-9]{1,4}:){0,4}|([a-f0-9]{1,4}:){3}:([a-f0-9]{1,4}:){0,3}|([a-f0-9]{1,4}:){4}:([a-f0-9]{1,4}:){0,2}|([a-f0-9]{1,4}:){5}:([a-f0-9]{1,4}:){0,1})([a-f0-9]{1,4}|(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2})))\])|([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])*(\.[A-Za-z]{2,})+))$/;
    const zg = /^(\p{Extended_Pictographic}|\p{Emoji_Component})+$/u;
    const Ag = /^(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))$/;
    const Bg = /^(([a-f0-9]{1,4}:){7}|::([a-f0-9]{1,4}:){0,6}|([a-f0-9]{1,4}:){1}:([a-f0-9]{1,4}:){0,5}|([a-f0-9]{1,4}:){2}:([a-f0-9]{1,4}:){0,4}|([a-f0-9]{1,4}:){3}:([a-f0-9]{1,4}:){0,3}|([a-f0-9]{1,4}:){4}:([a-f0-9]{1,4}:){0,2}|([a-f0-9]{1,4}:){5}:([a-f0-9]{1,4}:){0,1})([a-f0-9]{1,4}|(((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2}))\.){3}((25[0-5])|(2[0-4][0-9])|(1[0-9]{2})|([0-9]{1,2})))$/;
    const Cg = a => {
      if (a.precision) {
        if (a.offset) {
          return new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{" + a.precision + "}(([+-]\\d{2}(:?\\d{2})?)|Z)$");
        } else {
          return new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{" + a.precision + "}Z$");
        }
      } else if (a.precision === 0) {
        if (a.offset) {
          return new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(([+-]\\d{2}(:?\\d{2})?)|Z)$");
        } else {
          return new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z$");
        }
      } else if (a.offset) {
        return new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(([+-]\\d{2}(:?\\d{2})?)|Z)$");
      } else {
        return new RegExp("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?Z$");
      }
    };
    function Dg(a, b) {
      if ((b === "v4" || !b) && Ag.test(a)) {
        return true;
      }
      if ((b === "v6" || !b) && Bg.test(a)) {
        return true;
      }
      return false;
    }
    class Eg extends tg {
      constructor() {
        super(...arguments);
        this._regex = (a, b, c) => this.refinement(b => a.test(b), {
          validation: b,
          code: Zf.invalid_string,
          ...pg.errToObj(c)
        });
        this.nonempty = a => this.min(1, pg.errToObj(a));
        this.trim = () => new Eg({
          ...this._def,
          checks: [...this._def.checks, {
            kind: "trim"
          }]
        });
        this.toLowerCase = () => new Eg({
          ...this._def,
          checks: [...this._def.checks, {
            kind: "toLowerCase"
          }]
        });
        this.toUpperCase = () => new Eg({
          ...this._def,
          checks: [...this._def.checks, {
            kind: "toUpperCase"
          }]
        });
      }
      _parse(a) {
        if (this._def.coerce) {
          a.data = String(a.data);
        }
        const b = this._getType(a);
        if (b !== Xf.string) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.string,
            received: b.parsedType
          });
          return ig;
        }
        const c = new hg();
        let d = undefined;
        for (const b of this._def.checks) {
          if (b.kind === "min") {
            if (a.data.length < b.value) {
              d = this._getOrReturnCtx(a, d);
              var e = {
                code: Zf.too_small,
                minimum: b.value,
                type: "string",
                inclusive: true,
                exact: false,
                message: b.message
              };
              gg(d, e);
              c.dirty();
            }
          } else if (b.kind === "max") {
            if (a.data.length > b.value) {
              d = this._getOrReturnCtx(a, d);
              var f = {
                code: Zf.too_big,
                maximum: b.value,
                type: "string",
                inclusive: true,
                exact: false,
                message: b.message
              };
              gg(d, f);
              c.dirty();
            }
          } else if (b.kind === "length") {
            const e = a.data.length > b.value;
            const f = a.data.length < b.value;
            if (e || f) {
              d = this._getOrReturnCtx(a, d);
              if (e) {
                var g = {
                  code: Zf.too_big,
                  maximum: b.value,
                  type: "string",
                  inclusive: true,
                  exact: true,
                  message: b.message
                };
                gg(d, g);
              } else if (f) {
                var h = {
                  code: Zf.too_small,
                  minimum: b.value,
                  type: "string",
                  inclusive: true,
                  exact: true,
                  message: b.message
                };
                gg(d, h);
              }
              c.dirty();
            }
          } else if (b.kind === "email") {
            if (!yg.test(a.data)) {
              d = this._getOrReturnCtx(a, d);
              var i = {
                validation: "email",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, i);
              c.dirty();
            }
          } else if (b.kind === "emoji") {
            if (!zg.test(a.data)) {
              d = this._getOrReturnCtx(a, d);
              var j = {
                validation: "emoji",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, j);
              c.dirty();
            }
          } else if (b.kind === "uuid") {
            if (!xg.test(a.data)) {
              d = this._getOrReturnCtx(a, d);
              var k = {
                validation: "uuid",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, k);
              c.dirty();
            }
          } else if (b.kind === "cuid") {
            if (!ug.test(a.data)) {
              d = this._getOrReturnCtx(a, d);
              var l = {
                validation: "cuid",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, l);
              c.dirty();
            }
          } else if (b.kind === "cuid2") {
            if (!vg.test(a.data)) {
              d = this._getOrReturnCtx(a, d);
              var m = {
                validation: "cuid2",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, m);
              c.dirty();
            }
          } else if (b.kind === "ulid") {
            if (!wg.test(a.data)) {
              d = this._getOrReturnCtx(a, d);
              var n = {
                validation: "ulid",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, n);
              c.dirty();
            }
          } else if (b.kind === "url") {
            try {
              new URL(a.data);
            } catch (e) {
              d = this._getOrReturnCtx(a, d);
              var o = {
                validation: "url",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, o);
              c.dirty();
            }
          } else if (b.kind === "regex") {
            b.regex.lastIndex = 0;
            const e = b.regex.test(a.data);
            if (!e) {
              d = this._getOrReturnCtx(a, d);
              var p = {
                validation: "regex",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, p);
              c.dirty();
            }
          } else if (b.kind === "trim") {
            a.data = a.data.trim();
          } else if (b.kind === "includes") {
            if (!a.data.includes(b.value, b.position)) {
              d = this._getOrReturnCtx(a, d);
              var q = {
                includes: b.value,
                position: b.position
              };
              var r = {
                code: Zf.invalid_string,
                validation: q,
                message: b.message
              };
              gg(d, r);
              c.dirty();
            }
          } else if (b.kind === "toLowerCase") {
            a.data = a.data.toLowerCase();
          } else if (b.kind === "toUpperCase") {
            a.data = a.data.toUpperCase();
          } else if (b.kind === "startsWith") {
            if (!a.data.startsWith(b.value)) {
              d = this._getOrReturnCtx(a, d);
              var s = {
                startsWith: b.value
              };
              var t = {
                code: Zf.invalid_string,
                validation: s,
                message: b.message
              };
              gg(d, t);
              c.dirty();
            }
          } else if (b.kind === "endsWith") {
            if (!a.data.endsWith(b.value)) {
              d = this._getOrReturnCtx(a, d);
              var u = {
                endsWith: b.value
              };
              var v = {
                code: Zf.invalid_string,
                validation: u,
                message: b.message
              };
              gg(d, v);
              c.dirty();
            }
          } else if (b.kind === "datetime") {
            const e = Cg(b);
            if (!e.test(a.data)) {
              d = this._getOrReturnCtx(a, d);
              var w = {
                code: Zf.invalid_string,
                validation: "datetime",
                message: b.message
              };
              gg(d, w);
              c.dirty();
            }
          } else if (b.kind === "ip") {
            if (!Dg(a.data, b.version)) {
              d = this._getOrReturnCtx(a, d);
              var x = {
                validation: "ip",
                code: Zf.invalid_string,
                message: b.message
              };
              gg(d, x);
              c.dirty();
            }
          } else {
            Vf.assertNever(b);
          }
        }
        var y = {
          status: c.value,
          value: a.data
        };
        return y;
      }
      _addCheck(a) {
        var b = {
          ...this._def
        };
        b.checks = [...this._def.checks, a];
        return new Eg(b);
      }
      email(a) {
        return this._addCheck({
          kind: "email",
          ...pg.errToObj(a)
        });
      }
      url(a) {
        return this._addCheck({
          kind: "url",
          ...pg.errToObj(a)
        });
      }
      emoji(a) {
        return this._addCheck({
          kind: "emoji",
          ...pg.errToObj(a)
        });
      }
      uuid(a) {
        return this._addCheck({
          kind: "uuid",
          ...pg.errToObj(a)
        });
      }
      cuid(a) {
        return this._addCheck({
          kind: "cuid",
          ...pg.errToObj(a)
        });
      }
      cuid2(a) {
        return this._addCheck({
          kind: "cuid2",
          ...pg.errToObj(a)
        });
      }
      ulid(a) {
        return this._addCheck({
          kind: "ulid",
          ...pg.errToObj(a)
        });
      }
      ip(a) {
        return this._addCheck({
          kind: "ip",
          ...pg.errToObj(a)
        });
      }
      datetime(a) {
        if (typeof a === "string") {
          var b = {
            kind: "datetime",
            precision: null,
            offset: false,
            message: a
          };
          return this._addCheck(b);
        }
        return this._addCheck({
          kind: "datetime",
          precision: typeof a?.precision === "undefined" ? null : a?.precision,
          offset: a?.offset ?? false,
          ...pg.errToObj(a?.message)
        });
      }
      regex(a, b) {
        return this._addCheck({
          kind: "regex",
          regex: a,
          ...pg.errToObj(b)
        });
      }
      includes(a, b) {
        return this._addCheck({
          kind: "includes",
          value: a,
          position: b?.position,
          ...pg.errToObj(b?.message)
        });
      }
      startsWith(a, b) {
        return this._addCheck({
          kind: "startsWith",
          value: a,
          ...pg.errToObj(b)
        });
      }
      endsWith(a, b) {
        return this._addCheck({
          kind: "endsWith",
          value: a,
          ...pg.errToObj(b)
        });
      }
      min(a, b) {
        return this._addCheck({
          kind: "min",
          value: a,
          ...pg.errToObj(b)
        });
      }
      max(a, b) {
        return this._addCheck({
          kind: "max",
          value: a,
          ...pg.errToObj(b)
        });
      }
      length(a, b) {
        return this._addCheck({
          kind: "length",
          value: a,
          ...pg.errToObj(b)
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
          if (b.kind === "min") {
            if (a === null || b.value > a) {
              a = b.value;
            }
          }
        }
        return a;
      }
      get maxLength() {
        let a = null;
        for (const b of this._def.checks) {
          if (b.kind === "max") {
            if (a === null || b.value < a) {
              a = b.value;
            }
          }
        }
        return a;
      }
    }
    Eg.create = a => {
      return new Eg({
        checks: [],
        typeName: uh.ZodString,
        coerce: a?.coerce ?? false,
        ...sg(a)
      });
    };
    function Fg(a, b) {
      const c = (a.toString().split(".")[1] || "").length;
      const d = (b.toString().split(".")[1] || "").length;
      const e = c > d ? c : d;
      const f = parseInt(a.toFixed(e).replace(".", ""));
      const g = parseInt(b.toFixed(e).replace(".", ""));
      return f % g / Math.pow(10, e);
    }
    class Gg extends tg {
      constructor() {
        super(...arguments);
        this.min = this.gte;
        this.max = this.lte;
        this.step = this.multipleOf;
      }
      _parse(a) {
        if (this._def.coerce) {
          a.data = Number(a.data);
        }
        const b = this._getType(a);
        if (b !== Xf.number) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.number,
            received: b.parsedType
          });
          return ig;
        }
        let c = undefined;
        const d = new hg();
        for (const b of this._def.checks) {
          if (b.kind === "int") {
            if (!Vf.isInteger(a.data)) {
              c = this._getOrReturnCtx(a, c);
              var e = {
                code: Zf.invalid_type,
                expected: "integer",
                received: "float",
                message: b.message
              };
              gg(c, e);
              d.dirty();
            }
          } else if (b.kind === "min") {
            const e = b.inclusive ? a.data < b.value : a.data <= b.value;
            if (e) {
              c = this._getOrReturnCtx(a, c);
              var f = {
                code: Zf.too_small,
                minimum: b.value,
                type: "number",
                inclusive: b.inclusive,
                exact: false,
                message: b.message
              };
              gg(c, f);
              d.dirty();
            }
          } else if (b.kind === "max") {
            const e = b.inclusive ? a.data > b.value : a.data >= b.value;
            if (e) {
              c = this._getOrReturnCtx(a, c);
              var g = {
                code: Zf.too_big,
                maximum: b.value,
                type: "number",
                inclusive: b.inclusive,
                exact: false,
                message: b.message
              };
              gg(c, g);
              d.dirty();
            }
          } else if (b.kind === "multipleOf") {
            if (Fg(a.data, b.value) !== 0) {
              c = this._getOrReturnCtx(a, c);
              var h = {
                code: Zf.not_multiple_of,
                multipleOf: b.value,
                message: b.message
              };
              gg(c, h);
              d.dirty();
            }
          } else if (b.kind === "finite") {
            if (!Number.isFinite(a.data)) {
              c = this._getOrReturnCtx(a, c);
              var i = {
                code: Zf.not_finite,
                message: b.message
              };
              gg(c, i);
              d.dirty();
            }
          } else {
            Vf.assertNever(b);
          }
        }
        var j = {
          status: d.value,
          value: a.data
        };
        return j;
      }
      gte(a, b) {
        return this.setLimit("min", a, true, pg.toString(b));
      }
      gt(a, b) {
        return this.setLimit("min", a, false, pg.toString(b));
      }
      lte(a, b) {
        return this.setLimit("max", a, true, pg.toString(b));
      }
      lt(a, b) {
        return this.setLimit("max", a, false, pg.toString(b));
      }
      setLimit(a, b, c, d) {
        return new Gg({
          ...this._def,
          checks: [...this._def.checks, {
            kind: a,
            value: b,
            inclusive: c,
            message: pg.toString(d)
          }]
        });
      }
      _addCheck(a) {
        var b = {
          ...this._def
        };
        b.checks = [...this._def.checks, a];
        return new Gg(b);
      }
      int(a) {
        return this._addCheck({
          kind: "int",
          message: pg.toString(a)
        });
      }
      positive(a) {
        return this._addCheck({
          kind: "min",
          value: 0,
          inclusive: false,
          message: pg.toString(a)
        });
      }
      negative(a) {
        return this._addCheck({
          kind: "max",
          value: 0,
          inclusive: false,
          message: pg.toString(a)
        });
      }
      nonpositive(a) {
        return this._addCheck({
          kind: "max",
          value: 0,
          inclusive: true,
          message: pg.toString(a)
        });
      }
      nonnegative(a) {
        return this._addCheck({
          kind: "min",
          value: 0,
          inclusive: true,
          message: pg.toString(a)
        });
      }
      multipleOf(a, b) {
        return this._addCheck({
          kind: "multipleOf",
          value: a,
          message: pg.toString(b)
        });
      }
      finite(a) {
        return this._addCheck({
          kind: "finite",
          message: pg.toString(a)
        });
      }
      safe(a) {
        return this._addCheck({
          kind: "min",
          inclusive: true,
          value: Number.MIN_SAFE_INTEGER,
          message: pg.toString(a)
        })._addCheck({
          kind: "max",
          inclusive: true,
          value: Number.MAX_SAFE_INTEGER,
          message: pg.toString(a)
        });
      }
      get minValue() {
        let a = null;
        for (const b of this._def.checks) {
          if (b.kind === "min") {
            if (a === null || b.value > a) {
              a = b.value;
            }
          }
        }
        return a;
      }
      get maxValue() {
        let a = null;
        for (const b of this._def.checks) {
          if (b.kind === "max") {
            if (a === null || b.value < a) {
              a = b.value;
            }
          }
        }
        return a;
      }
      get isInt() {
        return !!this._def.checks.find(a => a.kind === "int" || a.kind === "multipleOf" && Vf.isInteger(a.value));
      }
      get isFinite() {
        let a = null;
        let b = null;
        for (const c of this._def.checks) {
          if (c.kind === "finite" || c.kind === "int" || c.kind === "multipleOf") {
            return true;
          } else if (c.kind === "min") {
            if (b === null || c.value > b) {
              b = c.value;
            }
          } else if (c.kind === "max") {
            if (a === null || c.value < a) {
              a = c.value;
            }
          }
        }
        return Number.isFinite(b) && Number.isFinite(a);
      }
    }
    Gg.create = a => {
      return new Gg({
        checks: [],
        typeName: uh.ZodNumber,
        coerce: a?.coerce || false,
        ...sg(a)
      });
    };
    class Hg extends tg {
      constructor() {
        super(...arguments);
        this.min = this.gte;
        this.max = this.lte;
      }
      _parse(a) {
        if (this._def.coerce) {
          a.data = BigInt(a.data);
        }
        const b = this._getType(a);
        if (b !== Xf.bigint) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.bigint,
            received: b.parsedType
          });
          return ig;
        }
        let c = undefined;
        const d = new hg();
        for (const b of this._def.checks) {
          if (b.kind === "min") {
            const f = b.inclusive ? a.data < b.value : a.data <= b.value;
            if (f) {
              c = this._getOrReturnCtx(a, c);
              var e = {
                code: Zf.too_small,
                type: "bigint",
                minimum: b.value,
                inclusive: b.inclusive,
                message: b.message
              };
              gg(c, e);
              d.dirty();
            }
          } else if (b.kind === "max") {
            const e = b.inclusive ? a.data > b.value : a.data >= b.value;
            if (e) {
              c = this._getOrReturnCtx(a, c);
              var f = {
                code: Zf.too_big,
                type: "bigint",
                maximum: b.value,
                inclusive: b.inclusive,
                message: b.message
              };
              gg(c, f);
              d.dirty();
            }
          } else if (b.kind === "multipleOf") {
            if (a.data % b.value !== BigInt(0)) {
              c = this._getOrReturnCtx(a, c);
              var g = {
                code: Zf.not_multiple_of,
                multipleOf: b.value,
                message: b.message
              };
              gg(c, g);
              d.dirty();
            }
          } else {
            Vf.assertNever(b);
          }
        }
        var h = {
          status: d.value,
          value: a.data
        };
        return h;
      }
      gte(a, b) {
        return this.setLimit("min", a, true, pg.toString(b));
      }
      gt(a, b) {
        return this.setLimit("min", a, false, pg.toString(b));
      }
      lte(a, b) {
        return this.setLimit("max", a, true, pg.toString(b));
      }
      lt(a, b) {
        return this.setLimit("max", a, false, pg.toString(b));
      }
      setLimit(a, b, c, d) {
        return new Hg({
          ...this._def,
          checks: [...this._def.checks, {
            kind: a,
            value: b,
            inclusive: c,
            message: pg.toString(d)
          }]
        });
      }
      _addCheck(a) {
        var b = {
          ...this._def
        };
        b.checks = [...this._def.checks, a];
        return new Hg(b);
      }
      positive(a) {
        return this._addCheck({
          kind: "min",
          value: BigInt(0),
          inclusive: false,
          message: pg.toString(a)
        });
      }
      negative(a) {
        return this._addCheck({
          kind: "max",
          value: BigInt(0),
          inclusive: false,
          message: pg.toString(a)
        });
      }
      nonpositive(a) {
        return this._addCheck({
          kind: "max",
          value: BigInt(0),
          inclusive: true,
          message: pg.toString(a)
        });
      }
      nonnegative(a) {
        return this._addCheck({
          kind: "min",
          value: BigInt(0),
          inclusive: true,
          message: pg.toString(a)
        });
      }
      multipleOf(a, b) {
        return this._addCheck({
          kind: "multipleOf",
          value: a,
          message: pg.toString(b)
        });
      }
      get minValue() {
        let a = null;
        for (const b of this._def.checks) {
          if (b.kind === "min") {
            if (a === null || b.value > a) {
              a = b.value;
            }
          }
        }
        return a;
      }
      get maxValue() {
        let a = null;
        for (const b of this._def.checks) {
          if (b.kind === "max") {
            if (a === null || b.value < a) {
              a = b.value;
            }
          }
        }
        return a;
      }
    }
    Hg.create = a => {
      return new Hg({
        checks: [],
        typeName: uh.ZodBigInt,
        coerce: a?.coerce ?? false,
        ...sg(a)
      });
    };
    class Ig extends tg {
      _parse(a) {
        if (this._def.coerce) {
          a.data = Boolean(a.data);
        }
        const b = this._getType(a);
        if (b !== Xf.boolean) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.boolean,
            received: b.parsedType
          });
          return ig;
        }
        return kg(a.data);
      }
    }
    Ig.create = a => {
      return new Ig({
        typeName: uh.ZodBoolean,
        coerce: a?.coerce || false,
        ...sg(a)
      });
    };
    class Jg extends tg {
      _parse(a) {
        if (this._def.coerce) {
          a.data = new Date(a.data);
        }
        const b = this._getType(a);
        if (b !== Xf.date) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.date,
            received: b.parsedType
          });
          return ig;
        }
        if (isNaN(a.data.getTime())) {
          const b = this._getOrReturnCtx(a);
          var c = {
            code: Zf.invalid_date
          };
          gg(b, c);
          return ig;
        }
        const d = new hg();
        let e = undefined;
        for (const b of this._def.checks) {
          if (b.kind === "min") {
            if (a.data.getTime() < b.value) {
              e = this._getOrReturnCtx(a, e);
              var f = {
                code: Zf.too_small,
                message: b.message,
                inclusive: true,
                exact: false,
                minimum: b.value,
                type: "date"
              };
              gg(e, f);
              d.dirty();
            }
          } else if (b.kind === "max") {
            if (a.data.getTime() > b.value) {
              e = this._getOrReturnCtx(a, e);
              var g = {
                code: Zf.too_big,
                message: b.message,
                inclusive: true,
                exact: false,
                maximum: b.value,
                type: "date"
              };
              gg(e, g);
              d.dirty();
            }
          } else {
            Vf.assertNever(b);
          }
        }
        return {
          status: d.value,
          value: new Date(a.data.getTime())
        };
      }
      _addCheck(a) {
        var b = {
          ...this._def
        };
        b.checks = [...this._def.checks, a];
        return new Jg(b);
      }
      min(a, b) {
        return this._addCheck({
          kind: "min",
          value: a.getTime(),
          message: pg.toString(b)
        });
      }
      max(a, b) {
        return this._addCheck({
          kind: "max",
          value: a.getTime(),
          message: pg.toString(b)
        });
      }
      get minDate() {
        let a = null;
        for (const b of this._def.checks) {
          if (b.kind === "min") {
            if (a === null || b.value > a) {
              a = b.value;
            }
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
          if (b.kind === "max") {
            if (a === null || b.value < a) {
              a = b.value;
            }
          }
        }
        if (a != null) {
          return new Date(a);
        } else {
          return null;
        }
      }
    }
    Jg.create = a => {
      return new Jg({
        checks: [],
        coerce: a?.coerce || false,
        typeName: uh.ZodDate,
        ...sg(a)
      });
    };
    class Kg extends tg {
      _parse(a) {
        const b = this._getType(a);
        if (b !== Xf.symbol) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.symbol,
            received: b.parsedType
          });
          return ig;
        }
        return kg(a.data);
      }
    }
    Kg.create = a => {
      return new Kg({
        typeName: uh.ZodSymbol,
        ...sg(a)
      });
    };
    class Lg extends tg {
      _parse(a) {
        const b = this._getType(a);
        if (b !== Xf.undefined) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.undefined,
            received: b.parsedType
          });
          return ig;
        }
        return kg(a.data);
      }
    }
    Lg.create = a => {
      return new Lg({
        typeName: uh.ZodUndefined,
        ...sg(a)
      });
    };
    class Mg extends tg {
      _parse(a) {
        const b = this._getType(a);
        if (b !== Xf.null) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.null,
            received: b.parsedType
          });
          return ig;
        }
        return kg(a.data);
      }
    }
    Mg.create = a => {
      return new Mg({
        typeName: uh.ZodNull,
        ...sg(a)
      });
    };
    class Ng extends tg {
      constructor() {
        super(...arguments);
        this._any = true;
      }
      _parse(a) {
        return kg(a.data);
      }
    }
    Ng.create = a => {
      return new Ng({
        typeName: uh.ZodAny,
        ...sg(a)
      });
    };
    class Og extends tg {
      constructor() {
        super(...arguments);
        this._unknown = true;
      }
      _parse(a) {
        return kg(a.data);
      }
    }
    Og.create = a => {
      return new Og({
        typeName: uh.ZodUnknown,
        ...sg(a)
      });
    };
    class Pg extends tg {
      _parse(a) {
        const b = this._getOrReturnCtx(a);
        gg(b, {
          code: Zf.invalid_type,
          expected: Xf.never,
          received: b.parsedType
        });
        return ig;
      }
    }
    Pg.create = a => {
      return new Pg({
        typeName: uh.ZodNever,
        ...sg(a)
      });
    };
    class Qg extends tg {
      _parse(a) {
        const b = this._getType(a);
        if (b !== Xf.undefined) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.void,
            received: b.parsedType
          });
          return ig;
        }
        return kg(a.data);
      }
    }
    Qg.create = a => {
      return new Qg({
        typeName: uh.ZodVoid,
        ...sg(a)
      });
    };
    class Rg extends tg {
      _parse(a) {
        const {
          ctx: b,
          status: c
        } = this._processInputParams(a);
        const d = this._def;
        if (b.parsedType !== Xf.array) {
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.array,
            received: b.parsedType
          });
          return ig;
        }
        if (d.exactLength !== null) {
          const a = b.data.length > d.exactLength.value;
          const f = b.data.length < d.exactLength.value;
          if (a || f) {
            var e = {
              code: a ? Zf.too_big : Zf.too_small,
              minimum: f ? d.exactLength.value : undefined,
              maximum: a ? d.exactLength.value : undefined,
              type: "array",
              inclusive: true,
              exact: true,
              message: d.exactLength.message
            };
            gg(b, e);
            c.dirty();
          }
        }
        if (d.minLength !== null) {
          if (b.data.length < d.minLength.value) {
            var f = {
              code: Zf.too_small,
              minimum: d.minLength.value,
              type: "array",
              inclusive: true,
              exact: false,
              message: d.minLength.message
            };
            gg(b, f);
            c.dirty();
          }
        }
        if (d.maxLength !== null) {
          if (b.data.length > d.maxLength.value) {
            var g = {
              code: Zf.too_big,
              maximum: d.maxLength.value,
              type: "array",
              inclusive: true,
              exact: false,
              message: d.maxLength.message
            };
            gg(b, g);
            c.dirty();
          }
        }
        if (b.common.async) {
          return Promise.all([...b.data].map((a, c) => {
            return d.type._parseAsync(new qg(b, a, b.path, c));
          })).then(a => {
            return hg.mergeArray(c, a);
          });
        }
        const h = [...b.data].map((a, c) => {
          return d.type._parseSync(new qg(b, a, b.path, c));
        });
        return hg.mergeArray(c, h);
      }
      get element() {
        return this._def.type;
      }
      min(a, b) {
        return new Rg({
          ...this._def,
          minLength: {
            value: a,
            message: pg.toString(b)
          }
        });
      }
      max(a, b) {
        return new Rg({
          ...this._def,
          maxLength: {
            value: a,
            message: pg.toString(b)
          }
        });
      }
      length(a, b) {
        return new Rg({
          ...this._def,
          exactLength: {
            value: a,
            message: pg.toString(b)
          }
        });
      }
      nonempty(a) {
        return this.min(1, a);
      }
    }
    Rg.create = (a, b) => {
      return new Rg({
        type: a,
        minLength: null,
        maxLength: null,
        exactLength: null,
        typeName: uh.ZodArray,
        ...sg(b)
      });
    };
    function Sg(a) {
      if (a instanceof Tg) {
        const c = {};
        for (const b in a.shape) {
          const d = a.shape[b];
          c[b] = jh.create(Sg(d));
        }
        var b = {
          ...a._def
        };
        b.shape = () => c;
        return new Tg(b);
      } else if (a instanceof Rg) {
        return new Rg({
          ...a._def,
          type: Sg(a.element)
        });
      } else if (a instanceof jh) {
        return jh.create(Sg(a.unwrap()));
      } else if (a instanceof kh) {
        return kh.create(Sg(a.unwrap()));
      } else if (a instanceof Zg) {
        return Zg.create(a.items.map(a => Sg(a)));
      } else {
        return a;
      }
    }
    class Tg extends tg {
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
        const b = Vf.objectKeys(a);
        var c = {
          shape: a,
          keys: b
        };
        return this._cached = c;
      }
      _parse(a) {
        const b = this._getType(a);
        if (b !== Xf.object) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.object,
            received: b.parsedType
          });
          return ig;
        }
        const {
          status: c,
          ctx: d
        } = this._processInputParams(a);
        const {
          shape: e,
          keys: f
        } = this._getCached();
        const g = [];
        if (!(this._def.catchall instanceof Pg) || this._def.unknownKeys !== "strip") {
          for (const a in d.data) {
            if (!f.includes(a)) {
              g.push(a);
            }
          }
        }
        const h = [];
        for (const b of f) {
          const a = e[b];
          const c = d.data[b];
          var i = {
            status: "valid",
            value: b
          };
          h.push({
            key: i,
            value: a._parse(new qg(d, c, d.path, b)),
            alwaysSet: b in d.data
          });
        }
        if (this._def.catchall instanceof Pg) {
          const a = this._def.unknownKeys;
          if (a === "passthrough") {
            for (const a of g) {
              var j = {
                status: "valid",
                value: a
              };
              var k = {
                status: "valid",
                value: d.data[a]
              };
              var l = {
                key: j,
                value: k
              };
              h.push(l);
            }
          } else if (a === "strict") {
            if (g.length > 0) {
              var m = {
                code: Zf.unrecognized_keys,
                keys: g
              };
              gg(d, m);
              c.dirty();
            }
          } else if (a === "strip") ;else {
            throw new Error("Internal ZodObject error: invalid unknownKeys value.");
          }
        } else {
          const a = this._def.catchall;
          for (const b of g) {
            const c = d.data[b];
            var n = {
              status: "valid",
              value: b
            };
            h.push({
              key: n,
              value: a._parse(new qg(d, c, d.path, b)),
              alwaysSet: b in d.data
            });
          }
        }
        if (d.common.async) {
          return Promise.resolve().then(async () => {
            const a = [];
            for (const c of h) {
              const d = await c.key;
              var b = {
                key: d,
                value: await c.value,
                alwaysSet: c.alwaysSet
              };
              a.push(b);
            }
            return a;
          }).then(a => {
            return hg.mergeObjectSync(c, a);
          });
        } else {
          return hg.mergeObjectSync(c, h);
        }
      }
      get shape() {
        return this._def.shape();
      }
      strict(a) {
        pg.errToObj;
        return new Tg({
          ...this._def,
          unknownKeys: "strict",
          ...(a !== undefined ? {
            errorMap: (b, c) => {
              var d;
              var e;
              const f = ((e = (d = this._def).errorMap) === null || e === undefined ? undefined : e.call(d, b, c).message) ?? c.defaultError;
              if (b.code === "unrecognized_keys") {
                return {
                  message: pg.errToObj(a).message ?? f
                };
              }
              var g = {
                message: f
              };
              return g;
            }
          } : {})
        });
      }
      strip() {
        var a = {
          ...this._def
        };
        a.unknownKeys = "strip";
        return new Tg(a);
      }
      passthrough() {
        var a = {
          ...this._def
        };
        a.unknownKeys = "passthrough";
        return new Tg(a);
      }
      extend(a) {
        return new Tg({
          ...this._def,
          shape: () => ({
            ...this._def.shape(),
            ...a
          })
        });
      }
      merge(a) {
        const b = new Tg({
          unknownKeys: a._def.unknownKeys,
          catchall: a._def.catchall,
          shape: () => ({
            ...this._def.shape(),
            ...a._def.shape()
          }),
          typeName: uh.ZodObject
        });
        return b;
      }
      setKey(a, b) {
        var c = {
          [a]: b
        };
        return this.augment(c);
      }
      catchall(a) {
        var b = {
          ...this._def
        };
        b.catchall = a;
        return new Tg(b);
      }
      pick(a) {
        const b = {};
        Vf.objectKeys(a).forEach(c => {
          if (a[c] && this.shape[c]) {
            b[c] = this.shape[c];
          }
        });
        var c = {
          ...this._def
        };
        c.shape = () => b;
        return new Tg(c);
      }
      omit(a) {
        const b = {};
        Vf.objectKeys(this.shape).forEach(c => {
          if (!a[c]) {
            b[c] = this.shape[c];
          }
        });
        var c = {
          ...this._def
        };
        c.shape = () => b;
        return new Tg(c);
      }
      deepPartial() {
        return Sg(this);
      }
      partial(a) {
        const b = {};
        Vf.objectKeys(this.shape).forEach(c => {
          const d = this.shape[c];
          if (a && !a[c]) {
            b[c] = d;
          } else {
            b[c] = d.optional();
          }
        });
        var c = {
          ...this._def
        };
        c.shape = () => b;
        return new Tg(c);
      }
      required(a) {
        const b = {};
        Vf.objectKeys(this.shape).forEach(c => {
          if (a && !a[c]) {
            b[c] = this.shape[c];
          } else {
            const a = this.shape[c];
            let d = a;
            while (d instanceof jh) {
              d = d._def.innerType;
            }
            b[c] = d;
          }
        });
        var c = {
          ...this._def
        };
        c.shape = () => b;
        return new Tg(c);
      }
      keyof() {
        return eh(Vf.objectKeys(this.shape));
      }
    }
    Tg.create = (a, b) => {
      return new Tg({
        shape: () => a,
        unknownKeys: "strip",
        catchall: Pg.create(),
        typeName: uh.ZodObject,
        ...sg(b)
      });
    };
    Tg.strictCreate = (a, b) => {
      return new Tg({
        shape: () => a,
        unknownKeys: "strict",
        catchall: Pg.create(),
        typeName: uh.ZodObject,
        ...sg(b)
      });
    };
    Tg.lazycreate = (a, b) => {
      return new Tg({
        shape: a,
        unknownKeys: "strip",
        catchall: Pg.create(),
        typeName: uh.ZodObject,
        ...sg(b)
      });
    };
    class Ug extends tg {
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        const c = this._def.options;
        function d(a) {
          for (const b of a) {
            if (b.result.status === "valid") {
              return b.result;
            }
          }
          for (const c of a) {
            if (c.result.status === "dirty") {
              b.common.issues.push(...c.ctx.common.issues);
              return c.result;
            }
          }
          const c = a.map(a => new _f(a.ctx.common.issues));
          var d = {
            code: Zf.invalid_union,
            unionErrors: c
          };
          gg(b, d);
          return ig;
        }
        if (b.common.async) {
          return Promise.all(c.map(async a => {
            var c = {
              ...b
            };
            c.common = {
              ...b.common
            };
            c.parent = null;
            c.common.issues = [];
            const d = c;
            var e = {
              data: b.data,
              path: b.path,
              parent: d
            };
            return {
              result: await a._parseAsync(e),
              ctx: d
            };
          })).then(d);
        } else {
          let a = undefined;
          const d = [];
          for (const h of c) {
            var e = {
              ...b
            };
            e.common = {
              ...b.common
            };
            e.parent = null;
            e.common.issues = [];
            const c = e;
            var f = {
              data: b.data,
              path: b.path,
              parent: c
            };
            const i = h._parseSync(f);
            if (i.status === "valid") {
              return i;
            } else if (i.status === "dirty" && !a) {
              var g = {
                result: i,
                ctx: c
              };
              a = g;
            }
            if (c.common.issues.length) {
              d.push(c.common.issues);
            }
          }
          if (a) {
            b.common.issues.push(...a.ctx.common.issues);
            return a.result;
          }
          const i = d.map(a => new _f(a));
          var h = {
            code: Zf.invalid_union,
            unionErrors: i
          };
          gg(b, h);
          return ig;
        }
      }
      get options() {
        return this._def.options;
      }
    }
    Ug.create = (a, b) => {
      return new Ug({
        options: a,
        typeName: uh.ZodUnion,
        ...sg(b)
      });
    };
    const Vg = a => {
      if (a instanceof ch) {
        return Vg(a.schema);
      } else if (a instanceof ih) {
        return Vg(a.innerType());
      } else if (a instanceof dh) {
        return [a.value];
      } else if (a instanceof fh) {
        return a.options;
      } else if (a instanceof gh) {
        return Object.keys(a.enum);
      } else if (a instanceof lh) {
        return Vg(a._def.innerType);
      } else if (a instanceof Lg) {
        return [undefined];
      } else if (a instanceof Mg) {
        return [null];
      } else {
        return null;
      }
    };
    class Wg extends tg {
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        if (b.parsedType !== Xf.object) {
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.object,
            received: b.parsedType
          });
          return ig;
        }
        const c = this.discriminator;
        const d = b.data[c];
        const e = this.optionsMap.get(d);
        if (!e) {
          gg(b, {
            code: Zf.invalid_union_discriminator,
            options: Array.from(this.optionsMap.keys()),
            path: [c]
          });
          return ig;
        }
        if (b.common.async) {
          var f = {
            data: b.data,
            path: b.path,
            parent: b
          };
          return e._parseAsync(f);
        } else {
          var g = {
            data: b.data,
            path: b.path,
            parent: b
          };
          return e._parseSync(g);
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
      static create(a, b, c) {
        const d = new Map();
        for (const e of b) {
          const b = Vg(e.shape[a]);
          if (!b) {
            throw new Error("A discriminator value for key `" + a + "` could not be extracted from all schema options");
          }
          for (const c of b) {
            if (d.has(c)) {
              throw new Error("Discriminator property " + String(a) + " has duplicate value " + String(c));
            }
            d.set(c, e);
          }
        }
        return new Wg({
          typeName: uh.ZodDiscriminatedUnion,
          discriminator: a,
          options: b,
          optionsMap: d,
          ...sg(c)
        });
      }
    }
    function Xg(a, b) {
      const c = Yf(a);
      const d = Yf(b);
      if (a === b) {
        var e = {
          valid: true,
          data: a
        };
        return e;
      } else if (c === Xf.object && d === Xf.object) {
        const c = Vf.objectKeys(b);
        const d = Vf.objectKeys(a).filter(a => c.indexOf(a) !== -1);
        var f = {
          ...a,
          ...b
        };
        const e = f;
        for (const c of d) {
          const d = Xg(a[c], b[c]);
          if (!d.valid) {
            return {
              valid: false
            };
          }
          e[c] = d.data;
        }
        var g = {
          valid: true,
          data: e
        };
        return g;
      } else if (c === Xf.array && d === Xf.array) {
        if (a.length !== b.length) {
          return {
            valid: false
          };
        }
        const c = [];
        for (let d = 0; d < a.length; d++) {
          const e = a[d];
          const f = b[d];
          const g = Xg(e, f);
          if (!g.valid) {
            return {
              valid: false
            };
          }
          c.push(g.data);
        }
        var h = {
          valid: true,
          data: c
        };
        return h;
      } else if (c === Xf.date && d === Xf.date && +a === +b) {
        var i = {
          valid: true,
          data: a
        };
        return i;
      } else {
        return {
          valid: false
        };
      }
    }
    class Yg extends tg {
      _parse(a) {
        const {
          status: b,
          ctx: c
        } = this._processInputParams(a);
        const d = (a, d) => {
          if (lg(a) || lg(d)) {
            return ig;
          }
          const e = Xg(a.value, d.value);
          if (!e.valid) {
            var f = {
              code: Zf.invalid_intersection_types
            };
            gg(c, f);
            return ig;
          }
          if (mg(a) || mg(d)) {
            b.dirty();
          }
          var g = {
            status: b.value,
            value: e.data
          };
          return g;
        };
        if (c.common.async) {
          var e = {
            data: c.data,
            path: c.path,
            parent: c
          };
          var f = {
            data: c.data,
            path: c.path,
            parent: c
          };
          return Promise.all([this._def.left._parseAsync(e), this._def.right._parseAsync(f)]).then(([a, b]) => d(a, b));
        } else {
          var g = {
            data: c.data,
            path: c.path,
            parent: c
          };
          var h = {
            data: c.data,
            path: c.path,
            parent: c
          };
          return d(this._def.left._parseSync(g), this._def.right._parseSync(h));
        }
      }
    }
    Yg.create = (a, b, c) => {
      return new Yg({
        left: a,
        right: b,
        typeName: uh.ZodIntersection,
        ...sg(c)
      });
    };
    class Zg extends tg {
      _parse(a) {
        const {
          status: b,
          ctx: c
        } = this._processInputParams(a);
        if (c.parsedType !== Xf.array) {
          gg(c, {
            code: Zf.invalid_type,
            expected: Xf.array,
            received: c.parsedType
          });
          return ig;
        }
        if (c.data.length < this._def.items.length) {
          var d = {
            code: Zf.too_small,
            minimum: this._def.items.length,
            inclusive: true,
            exact: false,
            type: "array"
          };
          gg(c, d);
          return ig;
        }
        const e = this._def.rest;
        if (!e && c.data.length > this._def.items.length) {
          var f = {
            code: Zf.too_big,
            maximum: this._def.items.length,
            inclusive: true,
            exact: false,
            type: "array"
          };
          gg(c, f);
          b.dirty();
        }
        const g = [...c.data].map((a, b) => {
          const d = this._def.items[b] || this._def.rest;
          if (!d) {
            return null;
          }
          return d._parse(new qg(c, a, c.path, b));
        }).filter(a => !!a);
        if (c.common.async) {
          return Promise.all(g).then(a => {
            return hg.mergeArray(b, a);
          });
        } else {
          return hg.mergeArray(b, g);
        }
      }
      get items() {
        return this._def.items;
      }
      rest(a) {
        var b = {
          ...this._def
        };
        b.rest = a;
        return new Zg(b);
      }
    }
    Zg.create = (a, b) => {
      if (!Array.isArray(a)) {
        throw new Error("You must pass an array of schemas to z.tuple([ ... ])");
      }
      return new Zg({
        items: a,
        typeName: uh.ZodTuple,
        rest: null,
        ...sg(b)
      });
    };
    class $g extends tg {
      get keySchema() {
        return this._def.keyType;
      }
      get valueSchema() {
        return this._def.valueType;
      }
      _parse(a) {
        const {
          status: b,
          ctx: c
        } = this._processInputParams(a);
        if (c.parsedType !== Xf.object) {
          gg(c, {
            code: Zf.invalid_type,
            expected: Xf.object,
            received: c.parsedType
          });
          return ig;
        }
        const d = [];
        const e = this._def.keyType;
        const f = this._def.valueType;
        for (const b in c.data) {
          d.push({
            key: e._parse(new qg(c, b, c.path, b)),
            value: f._parse(new qg(c, c.data[b], c.path, b))
          });
        }
        if (c.common.async) {
          return hg.mergeObjectAsync(b, d);
        } else {
          return hg.mergeObjectSync(b, d);
        }
      }
      get element() {
        return this._def.valueType;
      }
      static create(a, b, c) {
        if (b instanceof tg) {
          return new $g({
            keyType: a,
            valueType: b,
            typeName: uh.ZodRecord,
            ...sg(c)
          });
        }
        return new $g({
          keyType: Eg.create(),
          valueType: a,
          typeName: uh.ZodRecord,
          ...sg(b)
        });
      }
    }
    class _g extends tg {
      _parse(a) {
        const {
          status: b,
          ctx: c
        } = this._processInputParams(a);
        if (c.parsedType !== Xf.map) {
          gg(c, {
            code: Zf.invalid_type,
            expected: Xf.map,
            received: c.parsedType
          });
          return ig;
        }
        const d = this._def.keyType;
        const e = this._def.valueType;
        const f = [...c.data.entries()].map(([a, b], f) => {
          return {
            key: d._parse(new qg(c, a, c.path, [f, "key"])),
            value: e._parse(new qg(c, b, c.path, [f, "value"]))
          };
        });
        if (c.common.async) {
          const a = new Map();
          return Promise.resolve().then(async () => {
            for (const c of f) {
              const d = await c.key;
              const e = await c.value;
              if (d.status === "aborted" || e.status === "aborted") {
                return ig;
              }
              if (d.status === "dirty" || e.status === "dirty") {
                b.dirty();
              }
              a.set(d.value, e.value);
            }
            var c = {
              status: b.value,
              value: a
            };
            return c;
          });
        } else {
          const a = new Map();
          for (const c of f) {
            const d = c.key;
            const e = c.value;
            if (d.status === "aborted" || e.status === "aborted") {
              return ig;
            }
            if (d.status === "dirty" || e.status === "dirty") {
              b.dirty();
            }
            a.set(d.value, e.value);
          }
          var g = {
            status: b.value,
            value: a
          };
          return g;
        }
      }
    }
    _g.create = (a, b, c) => {
      return new _g({
        valueType: b,
        keyType: a,
        typeName: uh.ZodMap,
        ...sg(c)
      });
    };
    class ah extends tg {
      _parse(a) {
        const {
          status: b,
          ctx: c
        } = this._processInputParams(a);
        if (c.parsedType !== Xf.set) {
          gg(c, {
            code: Zf.invalid_type,
            expected: Xf.set,
            received: c.parsedType
          });
          return ig;
        }
        const d = this._def;
        if (d.minSize !== null) {
          if (c.data.size < d.minSize.value) {
            var e = {
              code: Zf.too_small,
              minimum: d.minSize.value,
              type: "set",
              inclusive: true,
              exact: false,
              message: d.minSize.message
            };
            gg(c, e);
            b.dirty();
          }
        }
        if (d.maxSize !== null) {
          if (c.data.size > d.maxSize.value) {
            var f = {
              code: Zf.too_big,
              maximum: d.maxSize.value,
              type: "set",
              inclusive: true,
              exact: false,
              message: d.maxSize.message
            };
            gg(c, f);
            b.dirty();
          }
        }
        const g = this._def.valueType;
        function h(a) {
          const c = new Set();
          for (const d of a) {
            if (d.status === "aborted") {
              return ig;
            }
            if (d.status === "dirty") {
              b.dirty();
            }
            c.add(d.value);
          }
          var d = {
            status: b.value,
            value: c
          };
          return d;
        }
        const i = [...c.data.values()].map((a, b) => g._parse(new qg(c, a, c.path, b)));
        if (c.common.async) {
          return Promise.all(i).then(a => h(a));
        } else {
          return h(i);
        }
      }
      min(a, b) {
        return new ah({
          ...this._def,
          minSize: {
            value: a,
            message: pg.toString(b)
          }
        });
      }
      max(a, b) {
        return new ah({
          ...this._def,
          maxSize: {
            value: a,
            message: pg.toString(b)
          }
        });
      }
      size(a, b) {
        return this.min(a, b).max(a, b);
      }
      nonempty(a) {
        return this.min(1, a);
      }
    }
    ah.create = (a, b) => {
      return new ah({
        valueType: a,
        minSize: null,
        maxSize: null,
        typeName: uh.ZodSet,
        ...sg(b)
      });
    };
    class bh extends tg {
      constructor() {
        super(...arguments);
        this.validate = this.implement;
      }
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        if (b.parsedType !== Xf.function) {
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.function,
            received: b.parsedType
          });
          return ig;
        }
        function c(a, c) {
          var d = {
            code: Zf.invalid_arguments,
            argumentsError: c
          };
          return eg({
            data: a,
            path: b.path,
            errorMaps: [b.common.contextualErrorMap, b.schemaErrorMap, dg(), ag].filter(a => !!a),
            issueData: d
          });
        }
        function d(a, c) {
          var d = {
            code: Zf.invalid_return_type,
            returnTypeError: c
          };
          return eg({
            data: a,
            path: b.path,
            errorMaps: [b.common.contextualErrorMap, b.schemaErrorMap, dg(), ag].filter(a => !!a),
            issueData: d
          });
        }
        var e = {
          errorMap: b.common.contextualErrorMap
        };
        const f = e;
        const g = b.data;
        if (this._def.returns instanceof hh) {
          return kg(async (...a) => {
            const b = new _f([]);
            const e = await this._def.args.parseAsync(a, f).catch(d => {
              b.addIssue(c(a, d));
              throw b;
            });
            const h = await g(...e);
            const i = await this._def.returns._def.type.parseAsync(h, f).catch(a => {
              b.addIssue(d(h, a));
              throw b;
            });
            return i;
          });
        } else {
          return kg((...a) => {
            const b = this._def.args.safeParse(a, f);
            if (!b.success) {
              throw new _f([c(a, b.error)]);
            }
            const e = g(...b.data);
            const h = this._def.returns.safeParse(e, f);
            if (!h.success) {
              throw new _f([d(e, h.error)]);
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
      args(...a) {
        return new bh({
          ...this._def,
          args: Zg.create(a).rest(Og.create())
        });
      }
      returns(a) {
        var b = {
          ...this._def
        };
        b.returns = a;
        return new bh(b);
      }
      implement(a) {
        const b = this.parse(a);
        return b;
      }
      strictImplement(a) {
        const b = this.parse(a);
        return b;
      }
      static create(a, b, c) {
        return new bh({
          args: a ? a : Zg.create([]).rest(Og.create()),
          returns: b || Og.create(),
          typeName: uh.ZodFunction,
          ...sg(c)
        });
      }
    }
    class ch extends tg {
      get schema() {
        return this._def.getter();
      }
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        const c = this._def.getter();
        var d = {
          data: b.data,
          path: b.path,
          parent: b
        };
        return c._parse(d);
      }
    }
    ch.create = (a, b) => {
      return new ch({
        getter: a,
        typeName: uh.ZodLazy,
        ...sg(b)
      });
    };
    class dh extends tg {
      _parse(a) {
        if (a.data !== this._def.value) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            received: b.data,
            code: Zf.invalid_literal,
            expected: this._def.value
          });
          return ig;
        }
        var b = {
          status: "valid",
          value: a.data
        };
        return b;
      }
      get value() {
        return this._def.value;
      }
    }
    dh.create = (a, b) => {
      return new dh({
        value: a,
        typeName: uh.ZodLiteral,
        ...sg(b)
      });
    };
    function eh(a, b) {
      return new fh({
        values: a,
        typeName: uh.ZodEnum,
        ...sg(b)
      });
    }
    class fh extends tg {
      _parse(a) {
        if (typeof a.data !== "string") {
          const b = this._getOrReturnCtx(a);
          const c = this._def.values;
          gg(b, {
            expected: Vf.joinValues(c),
            received: b.parsedType,
            code: Zf.invalid_type
          });
          return ig;
        }
        if (this._def.values.indexOf(a.data) === -1) {
          const b = this._getOrReturnCtx(a);
          const c = this._def.values;
          gg(b, {
            received: b.data,
            code: Zf.invalid_enum_value,
            options: c
          });
          return ig;
        }
        return kg(a.data);
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
      extract(a) {
        return fh.create(a);
      }
      exclude(a) {
        return fh.create(this.options.filter(b => !a.includes(b)));
      }
    }
    fh.create = eh;
    class gh extends tg {
      _parse(a) {
        const b = Vf.getValidEnumValues(this._def.values);
        const c = this._getOrReturnCtx(a);
        if (c.parsedType !== Xf.string && c.parsedType !== Xf.number) {
          const a = Vf.objectValues(b);
          gg(c, {
            expected: Vf.joinValues(a),
            received: c.parsedType,
            code: Zf.invalid_type
          });
          return ig;
        }
        if (b.indexOf(a.data) === -1) {
          const a = Vf.objectValues(b);
          gg(c, {
            received: c.data,
            code: Zf.invalid_enum_value,
            options: a
          });
          return ig;
        }
        return kg(a.data);
      }
      get enum() {
        return this._def.values;
      }
    }
    gh.create = (a, b) => {
      return new gh({
        values: a,
        typeName: uh.ZodNativeEnum,
        ...sg(b)
      });
    };
    class hh extends tg {
      unwrap() {
        return this._def.type;
      }
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        if (b.parsedType !== Xf.promise && b.common.async === false) {
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.promise,
            received: b.parsedType
          });
          return ig;
        }
        const c = b.parsedType === Xf.promise ? b.data : Promise.resolve(b.data);
        return kg(c.then(a => {
          var c = {
            path: b.path,
            errorMap: b.common.contextualErrorMap
          };
          return this._def.type.parseAsync(a, c);
        }));
      }
    }
    hh.create = (a, b) => {
      return new hh({
        type: a,
        typeName: uh.ZodPromise,
        ...sg(b)
      });
    };
    class ih extends tg {
      innerType() {
        return this._def.schema;
      }
      sourceType() {
        if (this._def.schema._def.typeName === uh.ZodEffects) {
          return this._def.schema.sourceType();
        } else {
          return this._def.schema;
        }
      }
      _parse(a) {
        const {
          status: b,
          ctx: c
        } = this._processInputParams(a);
        const d = this._def.effect || null;
        if (d.type === "preprocess") {
          const a = d.transform(c.data);
          if (c.common.async) {
            return Promise.resolve(a).then(a => {
              var b = {
                data: a,
                path: c.path,
                parent: c
              };
              return this._def.schema._parseAsync(b);
            });
          } else {
            var e = {
              data: a,
              path: c.path,
              parent: c
            };
            return this._def.schema._parseSync(e);
          }
        }
        const f = {
          addIssue: a => {
            gg(c, a);
            if (a.fatal) {
              b.abort();
            } else {
              b.dirty();
            }
          },
          get path() {
            return c.path;
          }
        };
        f.addIssue = f.addIssue.bind(f);
        if (d.type === "refinement") {
          const a = a => {
            const b = d.refinement(a, f);
            if (c.common.async) {
              return Promise.resolve(b);
            }
            if (b instanceof Promise) {
              throw new Error("Async refinement encountered during synchronous parse operation. Use .parseAsync instead.");
            }
            return a;
          };
          if (c.common.async === false) {
            var g = {
              data: c.data,
              path: c.path,
              parent: c
            };
            const d = this._def.schema._parseSync(g);
            if (d.status === "aborted") {
              return ig;
            }
            if (d.status === "dirty") {
              b.dirty();
            }
            a(d.value);
            var h = {
              status: b.value,
              value: d.value
            };
            return h;
          } else {
            var i = {
              data: c.data,
              path: c.path,
              parent: c
            };
            return this._def.schema._parseAsync(i).then(c => {
              if (c.status === "aborted") {
                return ig;
              }
              if (c.status === "dirty") {
                b.dirty();
              }
              return a(c.value).then(() => {
                var a = {
                  status: b.value,
                  value: c.value
                };
                return a;
              });
            });
          }
        }
        if (d.type === "transform") {
          if (c.common.async === false) {
            var j = {
              data: c.data,
              path: c.path,
              parent: c
            };
            const a = this._def.schema._parseSync(j);
            if (!ng(a)) {
              return a;
            }
            const e = d.transform(a.value, f);
            if (e instanceof Promise) {
              throw new Error("Asynchronous transform encountered during synchronous parse operation. Use .parseAsync instead.");
            }
            var k = {
              status: b.value,
              value: e
            };
            return k;
          } else {
            var l = {
              data: c.data,
              path: c.path,
              parent: c
            };
            return this._def.schema._parseAsync(l).then(a => {
              if (!ng(a)) {
                return a;
              }
              return Promise.resolve(d.transform(a.value, f)).then(a => ({
                status: b.value,
                value: a
              }));
            });
          }
        }
        Vf.assertNever(d);
      }
    }
    ih.create = (a, b, c) => {
      return new ih({
        schema: a,
        typeName: uh.ZodEffects,
        effect: b,
        ...sg(c)
      });
    };
    ih.createWithPreprocess = (a, b, c) => {
      var d = {
        type: "preprocess",
        transform: a
      };
      return new ih({
        schema: b,
        effect: d,
        typeName: uh.ZodEffects,
        ...sg(c)
      });
    };
    class jh extends tg {
      _parse(a) {
        const b = this._getType(a);
        if (b === Xf.undefined) {
          return kg(undefined);
        }
        return this._def.innerType._parse(a);
      }
      unwrap() {
        return this._def.innerType;
      }
    }
    jh.create = (a, b) => {
      return new jh({
        innerType: a,
        typeName: uh.ZodOptional,
        ...sg(b)
      });
    };
    class kh extends tg {
      _parse(a) {
        const b = this._getType(a);
        if (b === Xf.null) {
          return kg(null);
        }
        return this._def.innerType._parse(a);
      }
      unwrap() {
        return this._def.innerType;
      }
    }
    kh.create = (a, b) => {
      return new kh({
        innerType: a,
        typeName: uh.ZodNullable,
        ...sg(b)
      });
    };
    class lh extends tg {
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        let c = b.data;
        if (b.parsedType === Xf.undefined) {
          c = this._def.defaultValue();
        }
        var d = {
          data: c,
          path: b.path,
          parent: b
        };
        return this._def.innerType._parse(d);
      }
      removeDefault() {
        return this._def.innerType;
      }
    }
    lh.create = (a, b) => {
      return new lh({
        innerType: a,
        typeName: uh.ZodDefault,
        defaultValue: typeof b.default === "function" ? b.default : () => b.default,
        ...sg(b)
      });
    };
    class mh extends tg {
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        var c = {
          ...b
        };
        c.common = {
          ...b.common
        };
        c.common.issues = [];
        const d = c;
        var e = {
          data: d.data,
          path: d.path,
          parent: {
            ...d
          }
        };
        const f = this._def.innerType._parse(e);
        if (og(f)) {
          return f.then(a => {
            return {
              status: "valid",
              value: a.status === "valid" ? a.value : this._def.catchValue({
                get error() {
                  return new _f(d.common.issues);
                },
                input: d.data
              })
            };
          });
        } else {
          return {
            status: "valid",
            value: f.status === "valid" ? f.value : this._def.catchValue({
              get error() {
                return new _f(d.common.issues);
              },
              input: d.data
            })
          };
        }
      }
      removeCatch() {
        return this._def.innerType;
      }
    }
    mh.create = (a, b) => {
      return new mh({
        innerType: a,
        typeName: uh.ZodCatch,
        catchValue: typeof b.catch === "function" ? b.catch : () => b.catch,
        ...sg(b)
      });
    };
    class nh extends tg {
      _parse(a) {
        const b = this._getType(a);
        if (b !== Xf.nan) {
          const b = this._getOrReturnCtx(a);
          gg(b, {
            code: Zf.invalid_type,
            expected: Xf.nan,
            received: b.parsedType
          });
          return ig;
        }
        var c = {
          status: "valid",
          value: a.data
        };
        return c;
      }
    }
    nh.create = a => {
      return new nh({
        typeName: uh.ZodNaN,
        ...sg(a)
      });
    };
    const oh = Symbol("zod_brand");
    class ph extends tg {
      _parse(a) {
        const {
          ctx: b
        } = this._processInputParams(a);
        const c = b.data;
        var d = {
          data: c,
          path: b.path,
          parent: b
        };
        return this._def.type._parse(d);
      }
      unwrap() {
        return this._def.type;
      }
    }
    class qh extends tg {
      _parse(a) {
        const {
          status: b,
          ctx: c
        } = this._processInputParams(a);
        if (c.common.async) {
          const a = async () => {
            var a = {
              data: c.data,
              path: c.path,
              parent: c
            };
            const d = await this._def.in._parseAsync(a);
            if (d.status === "aborted") {
              return ig;
            }
            if (d.status === "dirty") {
              b.dirty();
              return jg(d.value);
            } else {
              var e = {
                data: d.value,
                path: c.path,
                parent: c
              };
              return this._def.out._parseAsync(e);
            }
          };
          return a();
        } else {
          var d = {
            data: c.data,
            path: c.path,
            parent: c
          };
          const a = this._def.in._parseSync(d);
          if (a.status === "aborted") {
            return ig;
          }
          if (a.status === "dirty") {
            b.dirty();
            var e = {
              status: "dirty",
              value: a.value
            };
            return e;
          } else {
            var f = {
              data: a.value,
              path: c.path,
              parent: c
            };
            return this._def.out._parseSync(f);
          }
        }
      }
      static create(a, b) {
        var c = {
          in: a,
          out: b,
          typeName: uh.ZodPipeline
        };
        return new qh(c);
      }
    }
    const rh = (a, b = undefined, c) => {
      if (b === undefined) b = {};
      if (a) {
        return Ng.create().superRefine((d, e) => {
          if (!a(d)) {
            const a = typeof b === "function" ? b(d) : typeof b === "string" ? {
              message: b
            } : b;
            const g = a.fatal ?? c ?? true;
            const h = typeof a === "string" ? {
              message: a
            } : a;
            var f = {
              code: "custom",
              ...h
            };
            f.fatal = g;
            e.addIssue(f);
          }
        });
      }
      return Ng.create();
    };
    var sh = {
      object: Tg.lazycreate
    };
    const th = sh;
    var uh;
    (function (a) {
      a.ZodString = "ZodString";
      a.ZodNumber = "ZodNumber";
      a.ZodNaN = "ZodNaN";
      a.ZodBigInt = "ZodBigInt";
      a.ZodBoolean = "ZodBoolean";
      a.ZodDate = "ZodDate";
      a.ZodSymbol = "ZodSymbol";
      a.ZodUndefined = "ZodUndefined";
      a.ZodNull = "ZodNull";
      a.ZodAny = "ZodAny";
      a.ZodUnknown = "ZodUnknown";
      a.ZodNever = "ZodNever";
      a.ZodVoid = "ZodVoid";
      a.ZodArray = "ZodArray";
      a.ZodObject = "ZodObject";
      a.ZodUnion = "ZodUnion";
      a.ZodDiscriminatedUnion = "ZodDiscriminatedUnion";
      a.ZodIntersection = "ZodIntersection";
      a.ZodTuple = "ZodTuple";
      a.ZodRecord = "ZodRecord";
      a.ZodMap = "ZodMap";
      a.ZodSet = "ZodSet";
      a.ZodFunction = "ZodFunction";
      a.ZodLazy = "ZodLazy";
      a.ZodLiteral = "ZodLiteral";
      a.ZodEnum = "ZodEnum";
      a.ZodEffects = "ZodEffects";
      a.ZodNativeEnum = "ZodNativeEnum";
      a.ZodOptional = "ZodOptional";
      a.ZodNullable = "ZodNullable";
      a.ZodDefault = "ZodDefault";
      a.ZodCatch = "ZodCatch";
      a.ZodPromise = "ZodPromise";
      a.ZodBranded = "ZodBranded";
      a.ZodPipeline = "ZodPipeline";
    })(uh ||= {});
    const vh = (a, b = undefined) => {
      if (b === undefined) b = {
        message: "Input not instance of " + a.name
      };
      return rh(b => b instanceof a, b);
    };
    const wh = Eg.create;
    const xh = Gg.create;
    const yh = nh.create;
    const zh = Hg.create;
    const Ah = Ig.create;
    const Bh = Jg.create;
    const Ch = Kg.create;
    const Dh = Lg.create;
    const Eh = Mg.create;
    const Fh = Ng.create;
    const Gh = Og.create;
    const Hh = Pg.create;
    const Ih = Qg.create;
    const Jh = Rg.create;
    const Kh = Tg.create;
    const Lh = Tg.strictCreate;
    const Mh = Ug.create;
    const Nh = Wg.create;
    const Oh = Yg.create;
    const Ph = Zg.create;
    const Qh = $g.create;
    const Rh = _g.create;
    const Sh = ah.create;
    const Th = bh.create;
    const Uh = ch.create;
    const Vh = dh.create;
    const Wh = fh.create;
    const Xh = gh.create;
    const Yh = hh.create;
    const Zh = ih.create;
    const $h = jh.create;
    const _h = kh.create;
    const ai = ih.createWithPreprocess;
    const bi = qh.create;
    const ci = () => wh().optional();
    const di = () => xh().optional();
    const ei = () => Ah().optional();
    const fi = {
      string: a => Eg.create({
        ...a,
        coerce: true
      }),
      number: a => Gg.create({
        ...a,
        coerce: true
      }),
      boolean: a => Ig.create({
        ...a,
        coerce: true
      }),
      bigint: a => Hg.create({
        ...a,
        coerce: true
      }),
      date: a => Jg.create({
        ...a,
        coerce: true
      })
    };
    const gi = ig;
    var hi = {
      get util() {
        return Vf;
      },
      get objectUtil() {
        return Wf;
      },
      get ZodFirstPartyTypeKind() {
        return uh;
      }
    };
    hi.__proto__ = null;
    hi.defaultErrorMap = ag;
    hi.setErrorMap = cg;
    hi.getErrorMap = dg;
    hi.makeIssue = eg;
    hi.EMPTY_PATH = fg;
    hi.addIssueToContext = gg;
    hi.ParseStatus = hg;
    hi.INVALID = ig;
    hi.DIRTY = jg;
    hi.OK = kg;
    hi.isAborted = lg;
    hi.isDirty = mg;
    hi.isValid = ng;
    hi.isAsync = og;
    hi.ZodParsedType = Xf;
    hi.getParsedType = Yf;
    hi.ZodType = tg;
    hi.ZodString = Eg;
    hi.ZodNumber = Gg;
    hi.ZodBigInt = Hg;
    hi.ZodBoolean = Ig;
    hi.ZodDate = Jg;
    hi.ZodSymbol = Kg;
    hi.ZodUndefined = Lg;
    hi.ZodNull = Mg;
    hi.ZodAny = Ng;
    hi.ZodUnknown = Og;
    hi.ZodNever = Pg;
    hi.ZodVoid = Qg;
    hi.ZodArray = Rg;
    hi.ZodObject = Tg;
    hi.ZodUnion = Ug;
    hi.ZodDiscriminatedUnion = Wg;
    hi.ZodIntersection = Yg;
    hi.ZodTuple = Zg;
    hi.ZodRecord = $g;
    hi.ZodMap = _g;
    hi.ZodSet = ah;
    hi.ZodFunction = bh;
    hi.ZodLazy = ch;
    hi.ZodLiteral = dh;
    hi.ZodEnum = fh;
    hi.ZodNativeEnum = gh;
    hi.ZodPromise = hh;
    hi.ZodEffects = ih;
    hi.ZodTransformer = ih;
    hi.ZodOptional = jh;
    hi.ZodNullable = kh;
    hi.ZodDefault = lh;
    hi.ZodCatch = mh;
    hi.ZodNaN = nh;
    hi.BRAND = oh;
    hi.ZodBranded = ph;
    hi.ZodPipeline = qh;
    hi.custom = rh;
    hi.Schema = tg;
    hi.ZodSchema = tg;
    hi.late = th;
    hi.coerce = fi;
    hi.any = Fh;
    hi.array = Jh;
    hi.bigint = zh;
    hi.boolean = Ah;
    hi.date = Bh;
    hi.discriminatedUnion = Nh;
    hi.effect = Zh;
    hi.enum = Wh;
    hi.function = Th;
    hi.instanceof = vh;
    hi.intersection = Oh;
    hi.lazy = Uh;
    hi.literal = Vh;
    hi.map = Rh;
    hi.nan = yh;
    hi.nativeEnum = Xh;
    hi.never = Hh;
    hi.null = Eh;
    hi.nullable = _h;
    hi.number = xh;
    hi.object = Kh;
    hi.oboolean = ei;
    hi.onumber = di;
    hi.optional = $h;
    hi.ostring = ci;
    hi.pipeline = bi;
    hi.preprocess = ai;
    hi.promise = Yh;
    hi.record = Qh;
    hi.set = Sh;
    hi.strictObject = Lh;
    hi.string = wh;
    hi.symbol = Ch;
    hi.transformer = Zh;
    hi.tuple = Ph;
    hi.undefined = Dh;
    hi.union = Mh;
    hi.unknown = Gh;
    hi.void = Ih;
    hi.NEVER = gi;
    hi.ZodIssueCode = Zf;
    hi.quotelessJson = $f;
    hi.ZodError = _f;
    var ii = Object.freeze(hi);
    ;
    var ji = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/;
    var ki = ii.object({
      codename: ii.string(),
      version: ii.string().regex(ji),
      permissions: ii.string().array()
    });
    var li = ki.omit({
      permissions: true
    });
    var mi = ii.object({
      API_URL: ii.string().url(),
      API_KEY: ii.string(),
      KEYS: ii.string().array()
    });
    var ni = ii.object({
      id: ii.number(),
      origin: ii.string()
    });
    var oi = ii.tuple([ii.boolean(), ii.any()]);
    var pi = ii.object({
      resolve: ii.function().args(ii.any()).returns(ii.void()),
      reject: ii.function().args(ii.any()).returns(ii.void()),
      timeout: ii.number()
    });
    var qi = ii.object({
      id: ii.number(),
      resource: ii.string()
    });
    var ri = ii.tuple([ii.boolean(), ii.any()]);
    var si = ii.object({
      resolve: ii.function().args(ii.any()).returns(ii.void()),
      reject: ii.function().args(ii.any()).returns(ii.void()),
      timeout: ii.number()
    });
    ;
    var ti = Object.create;
    var ui = Object.defineProperty;
    var vi = Object.getOwnPropertyDescriptor;
    var wi = Object.getOwnPropertyNames;
    var xi = Object.getPrototypeOf;
    var yi = Object.prototype.hasOwnProperty;
    var zi = (a, b) => function c() {
      if (!b) {
        (0, a[wi(a)[0]])((b = {
          exports: {}
        }).exports, b);
      }
      return b.exports;
    };
    var Ai = (a, b) => {
      for (var c in b) {
        ui(a, c, {
          get: b[c],
          enumerable: true
        });
      }
    };
    var Bi = (a, b, c, d) => {
      if (b && typeof b === "object" || typeof b === "function") {
        for (let e of wi(b)) {
          if (!yi.call(a, e) && e !== c) {
            ui(a, e, {
              get: () => b[e],
              enumerable: !(d = vi(b, e)) || d.enumerable
            });
          }
        }
      }
      return a;
    };
    var Ci = (a, b, c) => {
      c = a != null ? ti(xi(a)) : {};
      return Bi(b || !a || !a.__esModule ? ui(c, "default", {
        value: a,
        enumerable: true
      }) : c, a);
    };
    var Di = (a, b, c) => {
      if (!b.has(a)) {
        throw TypeError("Cannot " + c);
      }
    };
    var Ei = (a, b, c) => {
      Di(a, b, "read from private field");
      if (c) {
        return c.call(a);
      } else {
        return b.get(a);
      }
    };
    var Fi = (a, b, c) => {
      if (b.has(a)) {
        throw TypeError("Cannot add the same private member more than once");
      }
      if (b instanceof WeakSet) {
        b.add(a);
      } else {
        b.set(a, c);
      }
    };
    var Gi = (a, b, c, d) => {
      Di(a, b, "write to private field");
      if (d) {
        d.call(a, c);
      } else {
        b.set(a, c);
      }
      return c;
    };
    var Hi = (a, b, c, d) => ({
      set _(d) {
        Gi(a, b, d, c);
      },
      get _() {
        return Ei(a, b, d);
      }
    });
    var Ii = (a, b, c) => {
      Di(a, b, "access private method");
      return c;
    };
    var Ji = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/core.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d();
          } else if (typeof define === "function" && define.amd) {
            define([], d);
          } else {
            c.CryptoJS = d();
          }
        })(a, function () {
          var a = a || function (a, b) {
            var c = Object.create || function () {
              function a() {}
              ;
              return function (b) {
                var c;
                a.prototype = b;
                c = new a();
                a.prototype = null;
                return c;
              };
            }();
            var d = {};
            var e = d.lib = {};
            var f = e.Base = function () {
              return {
                extend: function (a) {
                  var b = c(this);
                  if (a) {
                    b.mixIn(a);
                  }
                  if (!b.hasOwnProperty("init") || this.init === b.init) {
                    b.init = function () {
                      b.$super.init.apply(this, arguments);
                    };
                  }
                  b.init.prototype = b;
                  b.$super = this;
                  return b;
                },
                create: function () {
                  var a = this.extend();
                  a.init.apply(a, arguments);
                  return a;
                },
                init: function () {},
                mixIn: function (a) {
                  for (var b in a) {
                    if (a.hasOwnProperty(b)) {
                      this[b] = a[b];
                    }
                  }
                  if (a.hasOwnProperty("toString")) {
                    this.toString = a.toString;
                  }
                },
                clone: function () {
                  return this.init.prototype.extend(this);
                }
              };
            }();
            var g = e.WordArray = f.extend({
              init: function (a, c) {
                a = this.words = a || [];
                if (c != b) {
                  this.sigBytes = c;
                } else {
                  this.sigBytes = a.length * 4;
                }
              },
              toString: function (a) {
                return (a || i).stringify(this);
              },
              concat: function (a) {
                var b = this.words;
                var c = a.words;
                var d = this.sigBytes;
                var e = a.sigBytes;
                this.clamp();
                if (d % 4) {
                  for (var f = 0; f < e; f++) {
                    var g = c[f >>> 2] >>> 24 - f % 4 * 8 & 255;
                    b[d + f >>> 2] |= g << 24 - (d + f) % 4 * 8;
                  }
                } else {
                  for (var f = 0; f < e; f += 4) {
                    b[d + f >>> 2] = c[f >>> 2];
                  }
                }
                this.sigBytes += e;
                return this;
              },
              clamp: function () {
                var b = this.words;
                var c = this.sigBytes;
                b[c >>> 2] &= 4294967295 << 32 - c % 4 * 8;
                b.length = a.ceil(c / 4);
              },
              clone: function () {
                var a = f.clone.call(this);
                a.words = this.words.slice(0);
                return a;
              },
              random: function (b) {
                var c = [];
                function d(b) {
                  var b = b;
                  var c = 987654321;
                  var d = 4294967295;
                  return function () {
                    c = (c & 65535) * 36969 + (c >> 16) & d;
                    b = (b & 65535) * 18000 + (b >> 16) & d;
                    var e = (c << 16) + b & d;
                    e /= 4294967296;
                    e += 0.5;
                    return e * (a.random() > 0.5 ? 1 : -1);
                  };
                }
                for (var e = 0, f; e < b; e += 4) {
                  var h = d((f || a.random()) * 4294967296);
                  f = h() * 987654071;
                  c.push(h() * 4294967296 | 0);
                }
                return new g.init(c, b);
              }
            });
            var h = d.enc = {};
            var i = h.Hex = {
              stringify: function (a) {
                var b = a.words;
                var c = a.sigBytes;
                var d = [];
                for (var e = 0; e < c; e++) {
                  var f = b[e >>> 2] >>> 24 - e % 4 * 8 & 255;
                  d.push((f >>> 4).toString(16));
                  d.push((f & 15).toString(16));
                }
                return d.join("");
              },
              parse: function (a) {
                var b = a.length;
                var c = [];
                for (var d = 0; d < b; d += 2) {
                  c[d >>> 3] |= parseInt(a.substr(d, 2), 16) << 24 - d % 8 * 4;
                }
                return new g.init(c, b / 2);
              }
            };
            var j = h.Latin1 = {
              stringify: function (a) {
                var b = a.words;
                var c = a.sigBytes;
                var d = [];
                for (var e = 0; e < c; e++) {
                  var f = b[e >>> 2] >>> 24 - e % 4 * 8 & 255;
                  d.push(String.fromCharCode(f));
                }
                return d.join("");
              },
              parse: function (a) {
                var b = a.length;
                var c = [];
                for (var d = 0; d < b; d++) {
                  c[d >>> 2] |= (a.charCodeAt(d) & 255) << 24 - d % 4 * 8;
                }
                return new g.init(c, b);
              }
            };
            var k = h.Utf8 = {
              stringify: function (a) {
                try {
                  return decodeURIComponent(escape(j.stringify(a)));
                } catch (a) {
                  throw new Error("Malformed UTF-8 data");
                }
              },
              parse: function (a) {
                return j.parse(unescape(encodeURIComponent(a)));
              }
            };
            var l = e.BufferedBlockAlgorithm = f.extend({
              reset: function () {
                this._data = new g.init();
                this._nDataBytes = 0;
              },
              _append: function (a) {
                if (typeof a == "string") {
                  a = k.parse(a);
                }
                this._data.concat(a);
                this._nDataBytes += a.sigBytes;
              },
              _process: function (b) {
                var c = this._data;
                var d = c.words;
                var e = c.sigBytes;
                var f = this.blockSize;
                var h = f * 4;
                var i = e / h;
                if (b) {
                  i = a.ceil(i);
                } else {
                  i = a.max((i | 0) - this._minBufferSize, 0);
                }
                var j = i * f;
                var k = a.min(j * 4, e);
                if (j) {
                  for (var l = 0; l < j; l += f) {
                    this._doProcessBlock(d, l);
                  }
                  var m = d.splice(0, j);
                  c.sigBytes -= k;
                }
                return new g.init(m, k);
              },
              clone: function () {
                var a = f.clone.call(this);
                a._data = this._data.clone();
                return a;
              },
              _minBufferSize: 0
            });
            var m = e.Hasher = l.extend({
              cfg: f.extend(),
              init: function (a) {
                this.cfg = this.cfg.extend(a);
                this.reset();
              },
              reset: function () {
                l.reset.call(this);
                this._doReset();
              },
              update: function (a) {
                this._append(a);
                this._process();
                return this;
              },
              finalize: function (a) {
                if (a) {
                  this._append(a);
                }
                var b = this._doFinalize();
                return b;
              },
              blockSize: 16,
              _createHelper: function (a) {
                return function (b, c) {
                  return new a.init(c).finalize(b);
                };
              },
              _createHmacHelper: function (a) {
                return function (b, c) {
                  return new n.HMAC.init(a, c).finalize(b);
                };
              }
            });
            var n = d.algo = {};
            return d;
          }(Math);
          return a;
        });
      }
    });
    var Ki = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/x64-core.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function (b) {
            var c = a;
            var d = c.lib;
            var e = d.Base;
            var f = d.WordArray;
            var g = c.x64 = {};
            var h = {
              init: function (a, b) {
                this.high = a;
                this.low = b;
              }
            };
            var i = g.Word = e.extend(h);
            var j = g.WordArray = e.extend({
              init: function (a, c) {
                a = this.words = a || [];
                if (c != b) {
                  this.sigBytes = c;
                } else {
                  this.sigBytes = a.length * 8;
                }
              },
              toX32: function () {
                var a = this.words;
                var b = a.length;
                var c = [];
                for (var d = 0; d < b; d++) {
                  var e = a[d];
                  c.push(e.high);
                  c.push(e.low);
                }
                return f.create(c, this.sigBytes);
              },
              clone: function () {
                var a = e.clone.call(this);
                var b = a.words = this.words.slice(0);
                var c = b.length;
                for (var d = 0; d < c; d++) {
                  b[d] = b[d].clone();
                }
                return a;
              }
            });
          })();
          return a;
        });
      }
    });
    var Li = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/lib-typedarrays.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            if (typeof ArrayBuffer != "function") {
              return;
            }
            var b = a;
            var c = b.lib;
            var d = c.WordArray;
            var e = d.init;
            var f = d.init = function (a) {
              if (a instanceof ArrayBuffer) {
                a = new Uint8Array(a);
              }
              if (a instanceof Int8Array || typeof Uint8ClampedArray !== "undefined" && a instanceof Uint8ClampedArray || a instanceof Int16Array || a instanceof Uint16Array || a instanceof Int32Array || a instanceof Uint32Array || a instanceof Float32Array || a instanceof Float64Array) {
                a = new Uint8Array(a.buffer, a.byteOffset, a.byteLength);
              }
              if (a instanceof Uint8Array) {
                var b = a.byteLength;
                var c = [];
                for (var d = 0; d < b; d++) {
                  c[d >>> 2] |= a[d] << 24 - d % 4 * 8;
                }
                e.call(this, c, b);
              } else {
                e.apply(this, arguments);
              }
            };
            f.prototype = d;
          })();
          return a.lib.WordArray;
        });
      }
    });
    var Mi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/enc-utf16.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.WordArray;
            var e = b.enc;
            var f = e.Utf16 = e.Utf16BE = {
              stringify: function (a) {
                var b = a.words;
                var c = a.sigBytes;
                var d = [];
                for (var e = 0; e < c; e += 2) {
                  var f = b[e >>> 2] >>> 16 - e % 4 * 8 & 65535;
                  d.push(String.fromCharCode(f));
                }
                return d.join("");
              },
              parse: function (a) {
                var b = a.length;
                var c = [];
                for (var e = 0; e < b; e++) {
                  c[e >>> 1] |= a.charCodeAt(e) << 16 - e % 2 * 16;
                }
                return d.create(c, b * 2);
              }
            };
            e.Utf16LE = {
              stringify: function (a) {
                var b = a.words;
                var c = a.sigBytes;
                var d = [];
                for (var e = 0; e < c; e += 2) {
                  var f = g(b[e >>> 2] >>> 16 - e % 4 * 8 & 65535);
                  d.push(String.fromCharCode(f));
                }
                return d.join("");
              },
              parse: function (a) {
                var b = a.length;
                var c = [];
                for (var e = 0; e < b; e++) {
                  c[e >>> 1] |= g(a.charCodeAt(e) << 16 - e % 2 * 16);
                }
                return d.create(c, b * 2);
              }
            };
            function g(a) {
              return a << 8 & 4278255360 | a >>> 8 & 16711935;
            }
          })();
          return a.enc.Utf16;
        });
      }
    });
    var Ni = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/enc-base64.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.WordArray;
            var e = b.enc;
            var f = e.Base64 = {
              stringify: function (a) {
                var b = a.words;
                var c = a.sigBytes;
                var d = this._map;
                a.clamp();
                var e = [];
                for (var f = 0; f < c; f += 3) {
                  var g = b[f >>> 2] >>> 24 - f % 4 * 8 & 255;
                  var h = b[f + 1 >>> 2] >>> 24 - (f + 1) % 4 * 8 & 255;
                  var i = b[f + 2 >>> 2] >>> 24 - (f + 2) % 4 * 8 & 255;
                  var j = g << 16 | h << 8 | i;
                  for (var k = 0; k < 4 && f + k * 0.75 < c; k++) {
                    e.push(d.charAt(j >>> (3 - k) * 6 & 63));
                  }
                }
                var l = d.charAt(64);
                if (l) {
                  while (e.length % 4) {
                    e.push(l);
                  }
                }
                return e.join("");
              },
              parse: function (a) {
                var b = a.length;
                var c = this._map;
                var d = this._reverseMap;
                if (!d) {
                  d = this._reverseMap = [];
                  for (var e = 0; e < c.length; e++) {
                    d[c.charCodeAt(e)] = e;
                  }
                }
                var f = c.charAt(64);
                if (f) {
                  var h = a.indexOf(f);
                  if (h !== -1) {
                    b = h;
                  }
                }
                return g(a, b, d);
              },
              _map: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
            };
            function g(a, b, c) {
              var e = [];
              var f = 0;
              for (var g = 0; g < b; g++) {
                if (g % 4) {
                  var h = c[a.charCodeAt(g - 1)] << g % 4 * 2;
                  var i = c[a.charCodeAt(g)] >>> 6 - g % 4 * 2;
                  e[f >>> 2] |= (h | i) << 24 - f % 4 * 8;
                  f++;
                }
              }
              return d.create(e, f);
            }
          })();
          return a.enc.Base64;
        });
      }
    });
    var Oi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/md5.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function (b) {
            var c = a;
            var d = c.lib;
            var e = d.WordArray;
            var f = d.Hasher;
            var g = c.algo;
            var h = [];
            (function () {
              for (var a = 0; a < 64; a++) {
                h[a] = b.abs(b.sin(a + 1)) * 4294967296 | 0;
              }
            })();
            var i = g.MD5 = f.extend({
              _doReset: function () {
                this._hash = new e.init([1732584193, 4023233417, 2562383102, 271733878]);
              },
              _doProcessBlock: function (a, b) {
                for (var c = 0; c < 16; c++) {
                  var d = b + c;
                  var e = a[d];
                  a[d] = (e << 8 | e >>> 24) & 16711935 | (e << 24 | e >>> 8) & 4278255360;
                }
                var f = this._hash.words;
                var g = a[b + 0];
                var i = a[b + 1];
                var n = a[b + 2];
                var o = a[b + 3];
                var p = a[b + 4];
                var q = a[b + 5];
                var r = a[b + 6];
                var s = a[b + 7];
                var t = a[b + 8];
                var u = a[b + 9];
                var v = a[b + 10];
                var w = a[b + 11];
                var x = a[b + 12];
                var y = a[b + 13];
                var z = a[b + 14];
                var A = a[b + 15];
                var B = f[0];
                var C = f[1];
                var D = f[2];
                var E = f[3];
                B = j(B, C, D, E, g, 7, h[0]);
                E = j(E, B, C, D, i, 12, h[1]);
                D = j(D, E, B, C, n, 17, h[2]);
                C = j(C, D, E, B, o, 22, h[3]);
                B = j(B, C, D, E, p, 7, h[4]);
                E = j(E, B, C, D, q, 12, h[5]);
                D = j(D, E, B, C, r, 17, h[6]);
                C = j(C, D, E, B, s, 22, h[7]);
                B = j(B, C, D, E, t, 7, h[8]);
                E = j(E, B, C, D, u, 12, h[9]);
                D = j(D, E, B, C, v, 17, h[10]);
                C = j(C, D, E, B, w, 22, h[11]);
                B = j(B, C, D, E, x, 7, h[12]);
                E = j(E, B, C, D, y, 12, h[13]);
                D = j(D, E, B, C, z, 17, h[14]);
                C = j(C, D, E, B, A, 22, h[15]);
                B = k(B, C, D, E, i, 5, h[16]);
                E = k(E, B, C, D, r, 9, h[17]);
                D = k(D, E, B, C, w, 14, h[18]);
                C = k(C, D, E, B, g, 20, h[19]);
                B = k(B, C, D, E, q, 5, h[20]);
                E = k(E, B, C, D, v, 9, h[21]);
                D = k(D, E, B, C, A, 14, h[22]);
                C = k(C, D, E, B, p, 20, h[23]);
                B = k(B, C, D, E, u, 5, h[24]);
                E = k(E, B, C, D, z, 9, h[25]);
                D = k(D, E, B, C, o, 14, h[26]);
                C = k(C, D, E, B, t, 20, h[27]);
                B = k(B, C, D, E, y, 5, h[28]);
                E = k(E, B, C, D, n, 9, h[29]);
                D = k(D, E, B, C, s, 14, h[30]);
                C = k(C, D, E, B, x, 20, h[31]);
                B = l(B, C, D, E, q, 4, h[32]);
                E = l(E, B, C, D, t, 11, h[33]);
                D = l(D, E, B, C, w, 16, h[34]);
                C = l(C, D, E, B, z, 23, h[35]);
                B = l(B, C, D, E, i, 4, h[36]);
                E = l(E, B, C, D, p, 11, h[37]);
                D = l(D, E, B, C, s, 16, h[38]);
                C = l(C, D, E, B, v, 23, h[39]);
                B = l(B, C, D, E, y, 4, h[40]);
                E = l(E, B, C, D, g, 11, h[41]);
                D = l(D, E, B, C, o, 16, h[42]);
                C = l(C, D, E, B, r, 23, h[43]);
                B = l(B, C, D, E, u, 4, h[44]);
                E = l(E, B, C, D, x, 11, h[45]);
                D = l(D, E, B, C, A, 16, h[46]);
                C = l(C, D, E, B, n, 23, h[47]);
                B = m(B, C, D, E, g, 6, h[48]);
                E = m(E, B, C, D, s, 10, h[49]);
                D = m(D, E, B, C, z, 15, h[50]);
                C = m(C, D, E, B, q, 21, h[51]);
                B = m(B, C, D, E, x, 6, h[52]);
                E = m(E, B, C, D, o, 10, h[53]);
                D = m(D, E, B, C, v, 15, h[54]);
                C = m(C, D, E, B, i, 21, h[55]);
                B = m(B, C, D, E, t, 6, h[56]);
                E = m(E, B, C, D, A, 10, h[57]);
                D = m(D, E, B, C, r, 15, h[58]);
                C = m(C, D, E, B, y, 21, h[59]);
                B = m(B, C, D, E, p, 6, h[60]);
                E = m(E, B, C, D, w, 10, h[61]);
                D = m(D, E, B, C, n, 15, h[62]);
                C = m(C, D, E, B, u, 21, h[63]);
                f[0] = f[0] + B | 0;
                f[1] = f[1] + C | 0;
                f[2] = f[2] + D | 0;
                f[3] = f[3] + E | 0;
              },
              _doFinalize: function () {
                var a = this._data;
                var c = a.words;
                var d = this._nDataBytes * 8;
                var e = a.sigBytes * 8;
                c[e >>> 5] |= 128 << 24 - e % 32;
                var f = b.floor(d / 4294967296);
                var g = d;
                c[(e + 64 >>> 9 << 4) + 15] = (f << 8 | f >>> 24) & 16711935 | (f << 24 | f >>> 8) & 4278255360;
                c[(e + 64 >>> 9 << 4) + 14] = (g << 8 | g >>> 24) & 16711935 | (g << 24 | g >>> 8) & 4278255360;
                a.sigBytes = (c.length + 1) * 4;
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
            function j(a, b, c, d, e, f, g) {
              var h = a + (b & c | ~b & d) + e + g;
              return (h << f | h >>> 32 - f) + b;
            }
            function k(a, b, c, d, e, f, g) {
              var h = a + (b & d | c & ~d) + e + g;
              return (h << f | h >>> 32 - f) + b;
            }
            function l(a, b, c, d, e, f, g) {
              var h = a + (b ^ c ^ d) + e + g;
              return (h << f | h >>> 32 - f) + b;
            }
            function m(a, b, c, d, e, f, g) {
              var h = a + (c ^ (b | ~d)) + e + g;
              return (h << f | h >>> 32 - f) + b;
            }
            c.MD5 = f._createHelper(i);
            c.HmacMD5 = f._createHmacHelper(i);
          })(Math);
          return a.MD5;
        });
      }
    });
    var Pi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha1.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.WordArray;
            var e = c.Hasher;
            var f = b.algo;
            var g = [];
            var h = f.SHA1 = e.extend({
              _doReset: function () {
                this._hash = new d.init([1732584193, 4023233417, 2562383102, 271733878, 3285377520]);
              },
              _doProcessBlock: function (a, b) {
                var c = this._hash.words;
                var d = c[0];
                var e = c[1];
                var f = c[2];
                var h = c[3];
                var i = c[4];
                for (var j = 0; j < 80; j++) {
                  if (j < 16) {
                    g[j] = a[b + j] | 0;
                  } else {
                    var k = g[j - 3] ^ g[j - 8] ^ g[j - 14] ^ g[j - 16];
                    g[j] = k << 1 | k >>> 31;
                  }
                  var l = (d << 5 | d >>> 27) + i + g[j];
                  if (j < 20) {
                    l += (e & f | ~e & h) + 1518500249;
                  } else if (j < 40) {
                    l += (e ^ f ^ h) + 1859775393;
                  } else if (j < 60) {
                    l += (e & f | e & h | f & h) - 1894007588;
                  } else {
                    l += (e ^ f ^ h) - 899497514;
                  }
                  i = h;
                  h = f;
                  f = e << 30 | e >>> 2;
                  e = d;
                  d = l;
                }
                c[0] = c[0] + d | 0;
                c[1] = c[1] + e | 0;
                c[2] = c[2] + f | 0;
                c[3] = c[3] + h | 0;
                c[4] = c[4] + i | 0;
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
            b.SHA1 = e._createHelper(h);
            b.HmacSHA1 = e._createHmacHelper(h);
          })();
          return a.SHA1;
        });
      }
    });
    var Qi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha256.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function (b) {
            var c = a;
            var d = c.lib;
            var e = d.WordArray;
            var f = d.Hasher;
            var g = c.algo;
            var h = [];
            var i = [];
            (function () {
              function a(a) {
                var c = b.sqrt(a);
                for (var d = 2; d <= c; d++) {
                  if (!(a % d)) {
                    return false;
                  }
                }
                return true;
              }
              function c(a) {
                return (a - (a | 0)) * 4294967296 | 0;
              }
              var d = 2;
              var e = 0;
              while (e < 64) {
                if (a(d)) {
                  if (e < 8) {
                    h[e] = c(b.pow(d, 1 / 2));
                  }
                  i[e] = c(b.pow(d, 1 / 3));
                  e++;
                }
                d++;
              }
            })();
            var j = [];
            var k = g.SHA256 = f.extend({
              _doReset: function () {
                this._hash = new e.init(h.slice(0));
              },
              _doProcessBlock: function (a, b) {
                var c = this._hash.words;
                var d = c[0];
                var e = c[1];
                var f = c[2];
                var g = c[3];
                var h = c[4];
                var k = c[5];
                var l = c[6];
                var m = c[7];
                for (var n = 0; n < 64; n++) {
                  if (n < 16) {
                    j[n] = a[b + n] | 0;
                  } else {
                    var o = j[n - 15];
                    var p = (o << 25 | o >>> 7) ^ (o << 14 | o >>> 18) ^ o >>> 3;
                    var q = j[n - 2];
                    var r = (q << 15 | q >>> 17) ^ (q << 13 | q >>> 19) ^ q >>> 10;
                    j[n] = p + j[n - 7] + r + j[n - 16];
                  }
                  var s = h & k ^ ~h & l;
                  var t = d & e ^ d & f ^ e & f;
                  var u = (d << 30 | d >>> 2) ^ (d << 19 | d >>> 13) ^ (d << 10 | d >>> 22);
                  var v = (h << 26 | h >>> 6) ^ (h << 21 | h >>> 11) ^ (h << 7 | h >>> 25);
                  var w = m + v + s + i[n] + j[n];
                  var x = u + t;
                  m = l;
                  l = k;
                  k = h;
                  h = g + w | 0;
                  g = f;
                  f = e;
                  e = d;
                  d = w + x | 0;
                }
                c[0] = c[0] + d | 0;
                c[1] = c[1] + e | 0;
                c[2] = c[2] + f | 0;
                c[3] = c[3] + g | 0;
                c[4] = c[4] + h | 0;
                c[5] = c[5] + k | 0;
                c[6] = c[6] + l | 0;
                c[7] = c[7] + m | 0;
              },
              _doFinalize: function () {
                var a = this._data;
                var c = a.words;
                var d = this._nDataBytes * 8;
                var e = a.sigBytes * 8;
                c[e >>> 5] |= 128 << 24 - e % 32;
                c[(e + 64 >>> 9 << 4) + 14] = b.floor(d / 4294967296);
                c[(e + 64 >>> 9 << 4) + 15] = d;
                a.sigBytes = c.length * 4;
                this._process();
                return this._hash;
              },
              clone: function () {
                var a = f.clone.call(this);
                a._hash = this._hash.clone();
                return a;
              }
            });
            c.SHA256 = f._createHelper(k);
            c.HmacSHA256 = f._createHmacHelper(k);
          })(Math);
          return a.SHA256;
        });
      }
    });
    var Ri = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha224.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Qi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./sha256"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.WordArray;
            var e = b.algo;
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
            b.SHA224 = f._createHelper(g);
            b.HmacSHA224 = f._createHmacHelper(g);
          })();
          return a.SHA224;
        });
      }
    });
    var Si = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha512.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ki());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./x64-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.Hasher;
            var e = b.x64;
            var f = e.Word;
            var g = e.WordArray;
            var h = b.algo;
            function i() {
              return f.create.apply(f, arguments);
            }
            var j = [i(1116352408, 3609767458), i(1899447441, 602891725), i(3049323471, 3964484399), i(3921009573, 2173295548), i(961987163, 4081628472), i(1508970993, 3053834265), i(2453635748, 2937671579), i(2870763221, 3664609560), i(3624381080, 2734883394), i(310598401, 1164996542), i(607225278, 1323610764), i(1426881987, 3590304994), i(1925078388, 4068182383), i(2162078206, 991336113), i(2614888103, 633803317), i(3248222580, 3479774868), i(3835390401, 2666613458), i(4022224774, 944711139), i(264347078, 2341262773), i(604807628, 2007800933), i(770255983, 1495990901), i(1249150122, 1856431235), i(1555081692, 3175218132), i(1996064986, 2198950837), i(2554220882, 3999719339), i(2821834349, 766784016), i(2952996808, 2566594879), i(3210313671, 3203337956), i(3336571891, 1034457026), i(3584528711, 2466948901), i(113926993, 3758326383), i(338241895, 168717936), i(666307205, 1188179964), i(773529912, 1546045734), i(1294757372, 1522805485), i(1396182291, 2643833823), i(1695183700, 2343527390), i(1986661051, 1014477480), i(2177026350, 1206759142), i(2456956037, 344077627), i(2730485921, 1290863460), i(2820302411, 3158454273), i(3259730800, 3505952657), i(3345764771, 106217008), i(3516065817, 3606008344), i(3600352804, 1432725776), i(4094571909, 1467031594), i(275423344, 851169720), i(430227734, 3100823752), i(506948616, 1363258195), i(659060556, 3750685593), i(883997877, 3785050280), i(958139571, 3318307427), i(1322822218, 3812723403), i(1537002063, 2003034995), i(1747873779, 3602036899), i(1955562222, 1575990012), i(2024104815, 1125592928), i(2227730452, 2716904306), i(2361852424, 442776044), i(2428436474, 593698344), i(2756734187, 3733110249), i(3204031479, 2999351573), i(3329325298, 3815920427), i(3391569614, 3928383900), i(3515267271, 566280711), i(3940187606, 3454069534), i(4118630271, 4000239992), i(116418474, 1914138554), i(174292421, 2731055270), i(289380356, 3203993006), i(460393269, 320620315), i(685471733, 587496836), i(852142971, 1086792851), i(1017036298, 365543100), i(1126000580, 2618297676), i(1288033470, 3409855158), i(1501505948, 4234509866), i(1607167915, 987167468), i(1816402316, 1246189591)];
            var k = [];
            (function () {
              for (var a = 0; a < 80; a++) {
                k[a] = i();
              }
            })();
            var l = h.SHA512 = d.extend({
              _doReset: function () {
                this._hash = new g.init([new f.init(1779033703, 4089235720), new f.init(3144134277, 2227873595), new f.init(1013904242, 4271175723), new f.init(2773480762, 1595750129), new f.init(1359893119, 2917565137), new f.init(2600822924, 725511199), new f.init(528734635, 4215389547), new f.init(1541459225, 327033209)]);
              },
              _doProcessBlock: function (a, b) {
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
                var q = e.low;
                var r = f.high;
                var s = f.low;
                var t = g.high;
                var u = g.low;
                var v = h.high;
                var w = h.low;
                var x = i.high;
                var y = i.low;
                var z = l.high;
                var A = l.low;
                var B = m.high;
                var C = m.low;
                var D = n;
                var E = o;
                var F = p;
                var G = q;
                var H = r;
                var I = s;
                var J = t;
                var K = u;
                var L = v;
                var M = w;
                var N = x;
                var O = y;
                var P = z;
                var Q = A;
                var R = B;
                var S = C;
                for (var T = 0; T < 80; T++) {
                  var U = k[T];
                  if (T < 16) {
                    var V = U.high = a[b + T * 2] | 0;
                    var W = U.low = a[b + T * 2 + 1] | 0;
                  } else {
                    var X = k[T - 15];
                    var Y = X.high;
                    var Z = X.low;
                    var $ = (Y >>> 1 | Z << 31) ^ (Y >>> 8 | Z << 24) ^ Y >>> 7;
                    var _ = (Z >>> 1 | Y << 31) ^ (Z >>> 8 | Y << 24) ^ (Z >>> 7 | Y << 25);
                    var aa = k[T - 2];
                    var ba = aa.high;
                    var ca = aa.low;
                    var da = (ba >>> 19 | ca << 13) ^ (ba << 3 | ca >>> 29) ^ ba >>> 6;
                    var ea = (ca >>> 19 | ba << 13) ^ (ca << 3 | ba >>> 29) ^ (ca >>> 6 | ba << 26);
                    var fa = k[T - 7];
                    var ga = fa.high;
                    var ha = fa.low;
                    var ia = k[T - 16];
                    var ja = ia.high;
                    var ka = ia.low;
                    var W = _ + ha;
                    var V = $ + ga + (W >>> 0 < _ >>> 0 ? 1 : 0);
                    var W = W + ea;
                    var V = V + da + (W >>> 0 < ea >>> 0 ? 1 : 0);
                    var W = W + ka;
                    var V = V + ja + (W >>> 0 < ka >>> 0 ? 1 : 0);
                    U.high = V;
                    U.low = W;
                  }
                  var la = L & N ^ ~L & P;
                  var ma = M & O ^ ~M & Q;
                  var na = D & F ^ D & H ^ F & H;
                  var oa = E & G ^ E & I ^ G & I;
                  var pa = (D >>> 28 | E << 4) ^ (D << 30 | E >>> 2) ^ (D << 25 | E >>> 7);
                  var qa = (E >>> 28 | D << 4) ^ (E << 30 | D >>> 2) ^ (E << 25 | D >>> 7);
                  var ra = (L >>> 14 | M << 18) ^ (L >>> 18 | M << 14) ^ (L << 23 | M >>> 9);
                  var sa = (M >>> 14 | L << 18) ^ (M >>> 18 | L << 14) ^ (M << 23 | L >>> 9);
                  var ta = j[T];
                  var ua = ta.high;
                  var va = ta.low;
                  var wa = S + sa;
                  var xa = R + ra + (wa >>> 0 < S >>> 0 ? 1 : 0);
                  var wa = wa + ma;
                  var xa = xa + la + (wa >>> 0 < ma >>> 0 ? 1 : 0);
                  var wa = wa + va;
                  var xa = xa + ua + (wa >>> 0 < va >>> 0 ? 1 : 0);
                  var wa = wa + W;
                  var xa = xa + V + (wa >>> 0 < W >>> 0 ? 1 : 0);
                  var ya = qa + oa;
                  var za = pa + na + (ya >>> 0 < qa >>> 0 ? 1 : 0);
                  R = P;
                  S = Q;
                  P = N;
                  Q = O;
                  N = L;
                  O = M;
                  M = K + wa | 0;
                  L = J + xa + (M >>> 0 < K >>> 0 ? 1 : 0) | 0;
                  J = H;
                  K = I;
                  H = F;
                  I = G;
                  F = D;
                  G = E;
                  E = wa + ya | 0;
                  D = xa + za + (E >>> 0 < wa >>> 0 ? 1 : 0) | 0;
                }
                o = d.low = o + E;
                d.high = n + D + (o >>> 0 < E >>> 0 ? 1 : 0);
                q = e.low = q + G;
                e.high = p + F + (q >>> 0 < G >>> 0 ? 1 : 0);
                s = f.low = s + I;
                f.high = r + H + (s >>> 0 < I >>> 0 ? 1 : 0);
                u = g.low = u + K;
                g.high = t + J + (u >>> 0 < K >>> 0 ? 1 : 0);
                w = h.low = w + M;
                h.high = v + L + (w >>> 0 < M >>> 0 ? 1 : 0);
                y = i.low = y + O;
                i.high = x + N + (y >>> 0 < O >>> 0 ? 1 : 0);
                A = l.low = A + Q;
                l.high = z + P + (A >>> 0 < Q >>> 0 ? 1 : 0);
                C = m.low = C + S;
                m.high = B + R + (C >>> 0 < S >>> 0 ? 1 : 0);
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
            b.SHA512 = d._createHelper(l);
            b.HmacSHA512 = d._createHmacHelper(l);
          })();
          return a.SHA512;
        });
      }
    });
    var Ti = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha384.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ki(), Si());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./x64-core", "./sha512"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.x64;
            var d = c.Word;
            var e = c.WordArray;
            var f = b.algo;
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
            b.SHA384 = g._createHelper(h);
            b.HmacSHA384 = g._createHmacHelper(h);
          })();
          return a.SHA384;
        });
      }
    });
    var Ui = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/sha3.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ki());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./x64-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function (b) {
            var c = a;
            var d = c.lib;
            var e = d.WordArray;
            var f = d.Hasher;
            var g = c.x64;
            var h = g.Word;
            var i = c.algo;
            var j = [];
            var k = [];
            var l = [];
            (function () {
              var a = 1;
              var b = 0;
              for (var c = 0; c < 24; c++) {
                j[a + b * 5] = (c + 1) * (c + 2) / 2 % 64;
                var d = b % 5;
                var e = (a * 2 + b * 3) % 5;
                a = d;
                b = e;
              }
              for (var a = 0; a < 5; a++) {
                for (var b = 0; b < 5; b++) {
                  k[a + b * 5] = b + (a * 2 + b * 3) % 5 * 5;
                }
              }
              var f = 1;
              for (var g = 0; g < 24; g++) {
                var i = 0;
                var m = 0;
                for (var n = 0; n < 7; n++) {
                  if (f & 1) {
                    var o = (1 << n) - 1;
                    if (o < 32) {
                      m ^= 1 << o;
                    } else {
                      i ^= 1 << o - 32;
                    }
                  }
                  if (f & 128) {
                    f = f << 1 ^ 113;
                  } else {
                    f <<= 1;
                  }
                }
                l[g] = h.create(i, m);
              }
            })();
            var m = [];
            (function () {
              for (var a = 0; a < 25; a++) {
                m[a] = h.create();
              }
            })();
            var n = i.SHA3 = f.extend({
              cfg: f.cfg.extend({
                outputLength: 512
              }),
              _doReset: function () {
                var a = this._state = [];
                for (var b = 0; b < 25; b++) {
                  a[b] = new h.init();
                }
                this.blockSize = (1600 - this.cfg.outputLength * 2) / 32;
              },
              _doProcessBlock: function (a, b) {
                var c = this._state;
                var d = this.blockSize / 2;
                for (var e = 0; e < d; e++) {
                  var f = a[b + e * 2];
                  var g = a[b + e * 2 + 1];
                  f = (f << 8 | f >>> 24) & 16711935 | (f << 24 | f >>> 8) & 4278255360;
                  g = (g << 8 | g >>> 24) & 16711935 | (g << 24 | g >>> 8) & 4278255360;
                  var h = c[e];
                  h.high ^= g;
                  h.low ^= f;
                }
                for (var i = 0; i < 24; i++) {
                  for (var n = 0; n < 5; n++) {
                    var o = 0;
                    var p = 0;
                    for (var q = 0; q < 5; q++) {
                      var h = c[n + q * 5];
                      o ^= h.high;
                      p ^= h.low;
                    }
                    var r = m[n];
                    r.high = o;
                    r.low = p;
                  }
                  for (var n = 0; n < 5; n++) {
                    var s = m[(n + 4) % 5];
                    var t = m[(n + 1) % 5];
                    var u = t.high;
                    var v = t.low;
                    var o = s.high ^ (u << 1 | v >>> 31);
                    var p = s.low ^ (v << 1 | u >>> 31);
                    for (var q = 0; q < 5; q++) {
                      var h = c[n + q * 5];
                      h.high ^= o;
                      h.low ^= p;
                    }
                  }
                  for (var w = 1; w < 25; w++) {
                    var h = c[w];
                    var x = h.high;
                    var y = h.low;
                    var z = j[w];
                    if (z < 32) {
                      var o = x << z | y >>> 32 - z;
                      var p = y << z | x >>> 32 - z;
                    } else {
                      var o = y << z - 32 | x >>> 64 - z;
                      var p = x << z - 32 | y >>> 64 - z;
                    }
                    var A = m[k[w]];
                    A.high = o;
                    A.low = p;
                  }
                  var B = m[0];
                  var C = c[0];
                  B.high = C.high;
                  B.low = C.low;
                  for (var n = 0; n < 5; n++) {
                    for (var q = 0; q < 5; q++) {
                      var w = n + q * 5;
                      var h = c[w];
                      var D = m[w];
                      var E = m[(n + 1) % 5 + q * 5];
                      var F = m[(n + 2) % 5 + q * 5];
                      h.high = D.high ^ ~E.high & F.high;
                      h.low = D.low ^ ~E.low & F.low;
                    }
                  }
                  var h = c[0];
                  var G = l[i];
                  h.high ^= G.high;
                  h.low ^= G.low;
                  ;
                }
              },
              _doFinalize: function () {
                var a = this._data;
                var c = a.words;
                var d = this._nDataBytes * 8;
                var f = a.sigBytes * 8;
                var g = this.blockSize * 32;
                c[f >>> 5] |= 1 << 24 - f % 32;
                c[(b.ceil((f + 1) / g) * g >>> 5) - 1] |= 128;
                a.sigBytes = c.length * 4;
                this._process();
                var h = this._state;
                var i = this.cfg.outputLength / 8;
                var j = i / 8;
                var k = [];
                for (var l = 0; l < j; l++) {
                  var m = h[l];
                  var n = m.high;
                  var o = m.low;
                  n = (n << 8 | n >>> 24) & 16711935 | (n << 24 | n >>> 8) & 4278255360;
                  o = (o << 8 | o >>> 24) & 16711935 | (o << 24 | o >>> 8) & 4278255360;
                  k.push(o);
                  k.push(n);
                }
                return new e.init(k, i);
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
            c.SHA3 = f._createHelper(n);
            c.HmacSHA3 = f._createHmacHelper(n);
          })(Math);
          return a.SHA3;
        });
      }
    });
    var Vi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/ripemd160.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function (b) {
            var c = a;
            var d = c.lib;
            var e = d.WordArray;
            var f = d.Hasher;
            var g = c.algo;
            var h = e.create([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 7, 4, 13, 1, 10, 6, 15, 3, 12, 0, 9, 5, 2, 14, 11, 8, 3, 10, 14, 4, 9, 15, 8, 1, 2, 7, 0, 6, 13, 11, 5, 12, 1, 9, 11, 10, 0, 8, 12, 4, 13, 3, 7, 15, 14, 5, 6, 2, 4, 0, 5, 9, 7, 12, 2, 10, 14, 1, 3, 8, 11, 6, 15, 13]);
            var i = e.create([5, 14, 7, 0, 9, 2, 11, 4, 13, 6, 15, 8, 1, 10, 3, 12, 6, 11, 3, 7, 0, 13, 5, 10, 14, 15, 8, 12, 4, 9, 1, 2, 15, 5, 1, 3, 7, 14, 6, 9, 11, 8, 12, 2, 10, 0, 4, 13, 8, 6, 4, 1, 3, 11, 15, 0, 5, 12, 2, 13, 9, 7, 10, 14, 12, 15, 10, 4, 1, 5, 8, 7, 6, 2, 13, 14, 0, 3, 9, 11]);
            var j = e.create([11, 14, 15, 12, 5, 8, 7, 9, 11, 13, 14, 15, 6, 7, 9, 8, 7, 6, 8, 13, 11, 9, 7, 15, 7, 12, 15, 9, 11, 7, 13, 12, 11, 13, 6, 7, 14, 9, 13, 15, 14, 8, 13, 6, 5, 12, 7, 5, 11, 12, 14, 15, 14, 15, 9, 8, 9, 14, 5, 6, 8, 6, 5, 12, 9, 15, 5, 11, 6, 8, 13, 12, 5, 12, 13, 14, 11, 8, 5, 6]);
            var k = e.create([8, 9, 9, 11, 13, 15, 15, 5, 7, 7, 8, 11, 14, 14, 12, 6, 9, 13, 15, 7, 12, 8, 9, 11, 7, 7, 12, 7, 6, 15, 13, 11, 9, 7, 15, 11, 8, 6, 6, 14, 12, 13, 5, 14, 13, 13, 7, 5, 15, 5, 8, 11, 14, 14, 6, 14, 6, 9, 12, 9, 12, 5, 15, 8, 8, 5, 12, 9, 12, 5, 14, 6, 8, 13, 6, 5, 15, 13, 11, 11]);
            var l = e.create([0, 1518500249, 1859775393, 2400959708, 2840853838]);
            var m = e.create([1352829926, 1548603684, 1836072691, 2053994217, 0]);
            var n = g.RIPEMD160 = f.extend({
              _doReset: function () {
                this._hash = e.create([1732584193, 4023233417, 2562383102, 271733878, 3285377520]);
              },
              _doProcessBlock: function (a, b) {
                for (var c = 0; c < 16; c++) {
                  var d = b + c;
                  var e = a[d];
                  a[d] = (e << 8 | e >>> 24) & 16711935 | (e << 24 | e >>> 8) & 4278255360;
                }
                var f = this._hash.words;
                var g = l.words;
                var n = m.words;
                var u = h.words;
                var v = i.words;
                var w = j.words;
                var x = k.words;
                var y;
                var z;
                var A;
                var B;
                var C;
                var D;
                var E;
                var F;
                var G;
                var H;
                D = y = f[0];
                E = z = f[1];
                F = A = f[2];
                G = B = f[3];
                H = C = f[4];
                var I;
                for (var c = 0; c < 80; c += 1) {
                  I = y + a[b + u[c]] | 0;
                  if (c < 16) {
                    I += o(z, A, B) + g[0];
                  } else if (c < 32) {
                    I += p(z, A, B) + g[1];
                  } else if (c < 48) {
                    I += q(z, A, B) + g[2];
                  } else if (c < 64) {
                    I += r(z, A, B) + g[3];
                  } else {
                    I += s(z, A, B) + g[4];
                  }
                  I = I | 0;
                  I = t(I, w[c]);
                  I = I + C | 0;
                  y = C;
                  C = B;
                  B = t(A, 10);
                  A = z;
                  z = I;
                  I = D + a[b + v[c]] | 0;
                  if (c < 16) {
                    I += s(E, F, G) + n[0];
                  } else if (c < 32) {
                    I += r(E, F, G) + n[1];
                  } else if (c < 48) {
                    I += q(E, F, G) + n[2];
                  } else if (c < 64) {
                    I += p(E, F, G) + n[3];
                  } else {
                    I += o(E, F, G) + n[4];
                  }
                  I = I | 0;
                  I = t(I, x[c]);
                  I = I + H | 0;
                  D = H;
                  H = G;
                  G = t(F, 10);
                  F = E;
                  E = I;
                }
                I = f[1] + A + G | 0;
                f[1] = f[2] + B + H | 0;
                f[2] = f[3] + C + D | 0;
                f[3] = f[4] + y + E | 0;
                f[4] = f[0] + z + F | 0;
                f[0] = I;
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
            function o(a, b, c) {
              return a ^ b ^ c;
            }
            function p(a, b, c) {
              return a & b | ~a & c;
            }
            function q(a, b, c) {
              return (a | ~b) ^ c;
            }
            function r(a, b, c) {
              return a & c | b & ~c;
            }
            function s(a, b, c) {
              return a ^ (b | ~c);
            }
            function t(a, b) {
              return a << b | a >>> 32 - b;
            }
            c.RIPEMD160 = f._createHelper(n);
            c.HmacRIPEMD160 = f._createHmacHelper(n);
          })(Math);
          return a.RIPEMD160;
        });
      }
    });
    var Wi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/hmac.js"(a, b) {
        'use strict';
  
        (function (c, d) {
          if (typeof a === "object") {
            b.exports = a = d(Ji());
          } else if (typeof define === "function" && define.amd) {
            define(["./core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.Base;
            var e = b.enc;
            var f = e.Utf8;
            var g = b.algo;
            var h = g.HMAC = d.extend({
              init: function (a, b) {
                a = this._hasher = new a.init();
                if (typeof b == "string") {
                  b = f.parse(b);
                }
                var c = a.blockSize;
                var d = c * 4;
                if (b.sigBytes > d) {
                  b = a.finalize(b);
                }
                b.clamp();
                var e = this._oKey = b.clone();
                var g = this._iKey = b.clone();
                var h = e.words;
                var i = g.words;
                for (var j = 0; j < c; j++) {
                  h[j] ^= 1549556828;
                  i[j] ^= 909522486;
                }
                e.sigBytes = g.sigBytes = d;
                this.reset();
              },
              reset: function () {
                var a = this._hasher;
                a.reset();
                a.update(this._iKey);
              },
              update: function (a) {
                this._hasher.update(a);
                return this;
              },
              finalize: function (a) {
                var b = this._hasher;
                var c = b.finalize(a);
                b.reset();
                var d = b.finalize(this._oKey.clone().concat(c));
                return d;
              }
            });
          })();
        });
      }
    });
    var Xi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pbkdf2.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Pi(), Wi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./sha1", "./hmac"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.Base;
            var e = c.WordArray;
            var f = b.algo;
            var g = f.SHA1;
            var h = f.HMAC;
            var i = {
              keySize: 4,
              hasher: g,
              iterations: 1
            };
            var j = f.PBKDF2 = d.extend({
              cfg: d.extend(i),
              init: function (a) {
                this.cfg = this.cfg.extend(a);
              },
              compute: function (a, b) {
                var c = this.cfg;
                var d = h.create(c.hasher, a);
                var f = e.create();
                var g = e.create([1]);
                var i = f.words;
                var j = g.words;
                var k = c.keySize;
                var l = c.iterations;
                while (i.length < k) {
                  var m = d.update(b).finalize(g);
                  d.reset();
                  var n = m.words;
                  var o = n.length;
                  var p = m;
                  for (var q = 1; q < l; q++) {
                    p = d.finalize(p);
                    d.reset();
                    var r = p.words;
                    for (var s = 0; s < o; s++) {
                      n[s] ^= r[s];
                    }
                  }
                  f.concat(m);
                  j[0]++;
                }
                f.sigBytes = k * 4;
                return f;
              }
            });
            b.PBKDF2 = function (a, b, c) {
              return j.create(c).compute(a, b);
            };
          })();
          return a.PBKDF2;
        });
      }
    });
    var Yi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/evpkdf.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Pi(), Wi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./sha1", "./hmac"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.Base;
            var e = c.WordArray;
            var f = b.algo;
            var g = f.MD5;
            var h = {
              keySize: 4,
              hasher: g,
              iterations: 1
            };
            var i = f.EvpKDF = d.extend({
              cfg: d.extend(h),
              init: function (a) {
                this.cfg = this.cfg.extend(a);
              },
              compute: function (a, b) {
                var c = this.cfg;
                var d = c.hasher.create();
                var f = e.create();
                var g = f.words;
                var h = c.keySize;
                var i = c.iterations;
                while (g.length < h) {
                  if (j) {
                    d.update(j);
                  }
                  var j = d.update(a).finalize(b);
                  d.reset();
                  for (var k = 1; k < i; k++) {
                    j = d.finalize(j);
                    d.reset();
                  }
                  f.concat(j);
                }
                f.sigBytes = h * 4;
                return f;
              }
            });
            b.EvpKDF = function (a, b, c) {
              return i.create(c).compute(a, b);
            };
          })();
          return a.EvpKDF;
        });
      }
    });
    var Zi = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/cipher-core.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Yi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./evpkdf"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          if (!a.lib.Cipher) {
            (function (b) {
              var c = a;
              var d = c.lib;
              var e = d.Base;
              var f = d.WordArray;
              var g = d.BufferedBlockAlgorithm;
              var h = c.enc;
              var i = h.Utf8;
              var j = h.Base64;
              var k = c.algo;
              var l = k.EvpKDF;
              var m = d.Cipher = g.extend({
                cfg: e.extend(),
                createEncryptor: function (a, b) {
                  return this.create(this._ENC_XFORM_MODE, a, b);
                },
                createDecryptor: function (a, b) {
                  return this.create(this._DEC_XFORM_MODE, a, b);
                },
                init: function (a, b, c) {
                  this.cfg = this.cfg.extend(c);
                  this._xformMode = a;
                  this._key = b;
                  this.reset();
                },
                reset: function () {
                  g.reset.call(this);
                  this._doReset();
                },
                process: function (a) {
                  this._append(a);
                  return this._process();
                },
                finalize: function (a) {
                  if (a) {
                    this._append(a);
                  }
                  var b = this._doFinalize();
                  return b;
                },
                keySize: 4,
                ivSize: 4,
                _ENC_XFORM_MODE: 1,
                _DEC_XFORM_MODE: 2,
                _createHelper: function () {
                  function a(a) {
                    if (typeof a == "string") {
                      return D;
                    } else {
                      return z;
                    }
                  }
                  return function (b) {
                    return {
                      encrypt: function (c, d, e) {
                        return a(d).encrypt(b, c, d, e);
                      },
                      decrypt: function (c, d, e) {
                        return a(d).decrypt(b, c, d, e);
                      }
                    };
                  };
                }()
              });
              var n = d.StreamCipher = m.extend({
                _doFinalize: function () {
                  var a = this._process(true);
                  return a;
                },
                blockSize: 1
              });
              var o = c.mode = {};
              var p = d.BlockCipherMode = e.extend({
                createEncryptor: function (a, b) {
                  return this.Encryptor.create(a, b);
                },
                createDecryptor: function (a, b) {
                  return this.Decryptor.create(a, b);
                },
                init: function (a, b) {
                  this._cipher = a;
                  this._iv = b;
                }
              });
              var q = o.CBC = function () {
                var a = p.extend();
                a.Encryptor = a.extend({
                  processBlock: function (a, b) {
                    var d = this._cipher;
                    var e = d.blockSize;
                    c.call(this, a, b, e);
                    d.encryptBlock(a, b);
                    this._prevBlock = a.slice(b, b + e);
                  }
                });
                a.Decryptor = a.extend({
                  processBlock: function (a, b) {
                    var d = this._cipher;
                    var e = d.blockSize;
                    var f = a.slice(b, b + e);
                    d.decryptBlock(a, b);
                    c.call(this, a, b, e);
                    this._prevBlock = f;
                  }
                });
                function c(a, c, d) {
                  var e = this._iv;
                  if (e) {
                    var f = e;
                    this._iv = b;
                  } else {
                    var f = this._prevBlock;
                  }
                  for (var g = 0; g < d; g++) {
                    a[c + g] ^= f[g];
                  }
                }
                return a;
              }();
              var r = c.pad = {};
              var s = r.Pkcs7 = {
                pad: function (a, b) {
                  var c = b * 4;
                  var d = c - a.sigBytes % c;
                  var e = d << 24 | d << 16 | d << 8 | d;
                  var g = [];
                  for (var h = 0; h < d; h += 4) {
                    g.push(e);
                  }
                  var i = f.create(g, d);
                  a.concat(i);
                },
                unpad: function (a) {
                  var b = a.words[a.sigBytes - 1 >>> 2] & 255;
                  a.sigBytes -= b;
                }
              };
              var t = {
                mode: q,
                padding: s
              };
              var u = d.BlockCipher = m.extend({
                cfg: m.cfg.extend(t),
                reset: function () {
                  m.reset.call(this);
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
                _doProcessBlock: function (a, b) {
                  this._mode.processBlock(a, b);
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
              var v = d.CipherParams = e.extend({
                init: function (a) {
                  this.mixIn(a);
                },
                toString: function (a) {
                  return (a || this.formatter).stringify(this);
                }
              });
              var w = c.format = {};
              var x = w.OpenSSL = {
                stringify: function (a) {
                  var b = a.ciphertext;
                  var c = a.salt;
                  if (c) {
                    var d = f.create([1398893684, 1701076831]).concat(c).concat(b);
                  } else {
                    var d = b;
                  }
                  return d.toString(j);
                },
                parse: function (a) {
                  var b = j.parse(a);
                  var c = b.words;
                  if (c[0] == 1398893684 && c[1] == 1701076831) {
                    var d = f.create(c.slice(2, 4));
                    c.splice(0, 4);
                    b.sigBytes -= 16;
                  }
                  var e = {
                    ciphertext: b,
                    salt: d
                  };
                  return v.create(e);
                }
              };
              var y = {
                format: x
              };
              var z = d.SerializableCipher = e.extend({
                cfg: e.extend(y),
                encrypt: function (a, b, c, d) {
                  d = this.cfg.extend(d);
                  var e = a.createEncryptor(c, d);
                  var f = e.finalize(b);
                  var g = e.cfg;
                  var h = {
                    ciphertext: f,
                    key: c,
                    iv: g.iv,
                    algorithm: a,
                    mode: g.mode,
                    padding: g.padding,
                    blockSize: a.blockSize,
                    formatter: d.format
                  };
                  return v.create(h);
                },
                decrypt: function (a, b, c, d) {
                  d = this.cfg.extend(d);
                  b = this._parse(b, d.format);
                  var e = a.createDecryptor(c, d).finalize(b.ciphertext);
                  return e;
                },
                _parse: function (a, b) {
                  if (typeof a == "string") {
                    return b.parse(a, this);
                  } else {
                    return a;
                  }
                }
              });
              var A = c.kdf = {};
              var B = A.OpenSSL = {
                execute: function (a, b, c, d) {
                  if (!d) {
                    d = f.random(8);
                  }
                  var e = {
                    keySize: b + c
                  };
                  var g = l.create(e).compute(a, d);
                  var h = f.create(g.words.slice(b), c * 4);
                  g.sigBytes = b * 4;
                  var i = {
                    key: g,
                    iv: h,
                    salt: d
                  };
                  return v.create(i);
                }
              };
              var C = {
                kdf: B
              };
              var D = d.PasswordBasedCipher = z.extend({
                cfg: z.cfg.extend(C),
                encrypt: function (a, b, c, d) {
                  d = this.cfg.extend(d);
                  var e = d.kdf.execute(c, a.keySize, a.ivSize);
                  d.iv = e.iv;
                  var f = z.encrypt.call(this, a, b, e.key, d);
                  f.mixIn(e);
                  return f;
                },
                decrypt: function (a, b, c, d) {
                  d = this.cfg.extend(d);
                  b = this._parse(b, d.format);
                  var e = d.kdf.execute(c, a.keySize, a.ivSize, b.salt);
                  d.iv = e.iv;
                  var f = z.decrypt.call(this, a, b, e.key, d);
                  return f;
                }
              });
            })();
          }
        });
      }
    });
    var $i = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-cfb.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.mode.CFB = function () {
            var b = a.lib.BlockCipherMode.extend();
            b.Encryptor = b.extend({
              processBlock: function (a, b) {
                var d = this._cipher;
                var e = d.blockSize;
                c.call(this, a, b, e, d);
                this._prevBlock = a.slice(b, b + e);
              }
            });
            b.Decryptor = b.extend({
              processBlock: function (a, b) {
                var d = this._cipher;
                var e = d.blockSize;
                var f = a.slice(b, b + e);
                c.call(this, a, b, e, d);
                this._prevBlock = f;
              }
            });
            function c(a, b, c, d) {
              var e = this._iv;
              if (e) {
                var f = e.slice(0);
                this._iv = undefined;
              } else {
                var f = this._prevBlock;
              }
              d.encryptBlock(f, 0);
              for (var g = 0; g < c; g++) {
                a[b + g] ^= f[g];
              }
            }
            return b;
          }();
          return a.mode.CFB;
        });
      }
    });
    var _i = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ctr.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.mode.CTR = function () {
            var b = a.lib.BlockCipherMode.extend();
            var c = b.Encryptor = b.extend({
              processBlock: function (a, b) {
                var c = this._cipher;
                var d = c.blockSize;
                var e = this._iv;
                var f = this._counter;
                if (e) {
                  f = this._counter = e.slice(0);
                  this._iv = undefined;
                }
                var g = f.slice(0);
                c.encryptBlock(g, 0);
                f[d - 1] = f[d - 1] + 1 | 0;
                for (var h = 0; h < d; h++) {
                  a[b + h] ^= g[h];
                }
              }
            });
            b.Decryptor = c;
            return b;
          }();
          return a.mode.CTR;
        });
      }
    });
    var aj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ctr-gladman.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.mode.CTRGladman = function () {
            var b = a.lib.BlockCipherMode.extend();
            function c(a) {
              if ((a >> 24 & 255) === 255) {
                var b = a >> 16 & 255;
                var c = a >> 8 & 255;
                var d = a & 255;
                if (b === 255) {
                  b = 0;
                  if (c === 255) {
                    c = 0;
                    if (d === 255) {
                      d = 0;
                    } else {
                      ++d;
                    }
                  } else {
                    ++c;
                  }
                } else {
                  ++b;
                }
                a = 0;
                a += b << 16;
                a += c << 8;
                a += d;
              } else {
                a += 16777216;
              }
              return a;
            }
            function d(a) {
              if ((a[0] = c(a[0])) === 0) {
                a[1] = c(a[1]);
              }
              return a;
            }
            var e = b.Encryptor = b.extend({
              processBlock: function (a, b) {
                var c = this._cipher;
                var e = c.blockSize;
                var f = this._iv;
                var g = this._counter;
                if (f) {
                  g = this._counter = f.slice(0);
                  this._iv = undefined;
                }
                d(g);
                var h = g.slice(0);
                c.encryptBlock(h, 0);
                for (var i = 0; i < e; i++) {
                  a[b + i] ^= h[i];
                }
              }
            });
            b.Decryptor = e;
            return b;
          }();
          return a.mode.CTRGladman;
        });
      }
    });
    var bj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ofb.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.mode.OFB = function () {
            var b = a.lib.BlockCipherMode.extend();
            var c = b.Encryptor = b.extend({
              processBlock: function (a, b) {
                var c = this._cipher;
                var d = c.blockSize;
                var e = this._iv;
                var f = this._keystream;
                if (e) {
                  f = this._keystream = e.slice(0);
                  this._iv = undefined;
                }
                c.encryptBlock(f, 0);
                for (var g = 0; g < d; g++) {
                  a[b + g] ^= f[g];
                }
              }
            });
            b.Decryptor = c;
            return b;
          }();
          return a.mode.OFB;
        });
      }
    });
    var cj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/mode-ecb.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.mode.ECB = function () {
            var b = a.lib.BlockCipherMode.extend();
            b.Encryptor = b.extend({
              processBlock: function (a, b) {
                this._cipher.encryptBlock(a, b);
              }
            });
            b.Decryptor = b.extend({
              processBlock: function (a, b) {
                this._cipher.decryptBlock(a, b);
              }
            });
            return b;
          }();
          return a.mode.ECB;
        });
      }
    });
    var dj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-ansix923.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.pad.AnsiX923 = {
            pad: function (a, b) {
              var c = a.sigBytes;
              var d = b * 4;
              var e = d - c % d;
              var f = c + e - 1;
              a.clamp();
              a.words[f >>> 2] |= e << 24 - f % 4 * 8;
              a.sigBytes += e;
            },
            unpad: function (a) {
              var b = a.words[a.sigBytes - 1 >>> 2] & 255;
              a.sigBytes -= b;
            }
          };
          return a.pad.Ansix923;
        });
      }
    });
    var ej = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-iso10126.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.pad.Iso10126 = {
            pad: function (b, c) {
              var d = c * 4;
              var e = d - b.sigBytes % d;
              b.concat(a.lib.WordArray.random(e - 1)).concat(a.lib.WordArray.create([e << 24], 1));
            },
            unpad: function (a) {
              var b = a.words[a.sigBytes - 1 >>> 2] & 255;
              a.sigBytes -= b;
            }
          };
          return a.pad.Iso10126;
        });
      }
    });
    var fj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-iso97971.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.pad.Iso97971 = {
            pad: function (b, c) {
              b.concat(a.lib.WordArray.create([2147483648], 1));
              a.pad.ZeroPadding.pad(b, c);
            },
            unpad: function (b) {
              a.pad.ZeroPadding.unpad(b);
              b.sigBytes--;
            }
          };
          return a.pad.Iso97971;
        });
      }
    });
    var gj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-zeropadding.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          a.pad.ZeroPadding = {
            pad: function (a, b) {
              var c = b * 4;
              a.clamp();
              a.sigBytes += c - (a.sigBytes % c || c);
            },
            unpad: function (a) {
              var b = a.words;
              var c = a.sigBytes - 1;
              while (!(b[c >>> 2] >>> 24 - c % 4 * 8 & 255)) {
                c--;
              }
              a.sigBytes = c + 1;
            }
          };
          return a.pad.ZeroPadding;
        });
      }
    });
    var hj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/pad-nopadding.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          var b = {
            pad: function () {},
            unpad: function () {}
          };
          a.pad.NoPadding = b;
          return a.pad.NoPadding;
        });
      }
    });
    var ij = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/format-hex.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function (b) {
            var c = a;
            var d = c.lib;
            var e = d.CipherParams;
            var f = c.enc;
            var g = f.Hex;
            var h = c.format;
            var i = h.Hex = {
              stringify: function (a) {
                return a.ciphertext.toString(g);
              },
              parse: function (a) {
                var b = g.parse(a);
                var c = {
                  ciphertext: b
                };
                return e.create(c);
              }
            };
          })();
          return a.format.Hex;
        });
      }
    });
    var jj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/aes.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ni(), Oi(), Yi(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.BlockCipher;
            var e = b.algo;
            var f = [];
            var g = [];
            var h = [];
            var i = [];
            var j = [];
            var k = [];
            var l = [];
            var m = [];
            var n = [];
            var o = [];
            (function () {
              var a = [];
              for (var b = 0; b < 256; b++) {
                if (b < 128) {
                  a[b] = b << 1;
                } else {
                  a[b] = b << 1 ^ 283;
                }
              }
              var c = 0;
              var d = 0;
              for (var b = 0; b < 256; b++) {
                var e = d ^ d << 1 ^ d << 2 ^ d << 3 ^ d << 4;
                e = e >>> 8 ^ e & 255 ^ 99;
                f[c] = e;
                g[e] = c;
                var p = a[c];
                var q = a[p];
                var r = a[q];
                var s = a[e] * 257 ^ e * 16843008;
                h[c] = s << 24 | s >>> 8;
                i[c] = s << 16 | s >>> 16;
                j[c] = s << 8 | s >>> 24;
                k[c] = s;
                var s = r * 16843009 ^ q * 65537 ^ p * 257 ^ c * 16843008;
                l[e] = s << 24 | s >>> 8;
                m[e] = s << 16 | s >>> 16;
                n[e] = s << 8 | s >>> 24;
                o[e] = s;
                if (!c) {
                  c = d = 1;
                } else {
                  c = p ^ a[a[a[r ^ p]]];
                  d ^= a[a[d]];
                }
              }
            })();
            var p = [0, 1, 2, 4, 8, 16, 32, 64, 128, 27, 54];
            var q = e.AES = d.extend({
              _doReset: function () {
                if (this._nRounds && this._keyPriorReset === this._key) {
                  return;
                }
                var a = this._keyPriorReset = this._key;
                var b = a.words;
                var c = a.sigBytes / 4;
                var d = this._nRounds = c + 6;
                var e = (d + 1) * 4;
                var g = this._keySchedule = [];
                for (var h = 0; h < e; h++) {
                  if (h < c) {
                    g[h] = b[h];
                  } else {
                    var i = g[h - 1];
                    if (!(h % c)) {
                      i = i << 8 | i >>> 24;
                      i = f[i >>> 24] << 24 | f[i >>> 16 & 255] << 16 | f[i >>> 8 & 255] << 8 | f[i & 255];
                      i ^= p[h / c | 0] << 24;
                    } else if (c > 6 && h % c == 4) {
                      i = f[i >>> 24] << 24 | f[i >>> 16 & 255] << 16 | f[i >>> 8 & 255] << 8 | f[i & 255];
                    }
                    g[h] = g[h - c] ^ i;
                  }
                }
                var j = this._invKeySchedule = [];
                for (var k = 0; k < e; k++) {
                  var h = e - k;
                  if (k % 4) {
                    var i = g[h];
                  } else {
                    var i = g[h - 4];
                  }
                  if (k < 4 || h <= 4) {
                    j[k] = i;
                  } else {
                    j[k] = l[f[i >>> 24]] ^ m[f[i >>> 16 & 255]] ^ n[f[i >>> 8 & 255]] ^ o[f[i & 255]];
                  }
                }
              },
              encryptBlock: function (a, b) {
                this._doCryptBlock(a, b, this._keySchedule, h, i, j, k, f);
              },
              decryptBlock: function (a, b) {
                var c = a[b + 1];
                a[b + 1] = a[b + 3];
                a[b + 3] = c;
                this._doCryptBlock(a, b, this._invKeySchedule, l, m, n, o, g);
                var c = a[b + 1];
                a[b + 1] = a[b + 3];
                a[b + 3] = c;
              },
              _doCryptBlock: function (a, b, c, d, e, f, g, h) {
                var i = this._nRounds;
                var j = a[b] ^ c[0];
                var k = a[b + 1] ^ c[1];
                var l = a[b + 2] ^ c[2];
                var m = a[b + 3] ^ c[3];
                var n = 4;
                for (var o = 1; o < i; o++) {
                  var p = d[j >>> 24] ^ e[k >>> 16 & 255] ^ f[l >>> 8 & 255] ^ g[m & 255] ^ c[n++];
                  var q = d[k >>> 24] ^ e[l >>> 16 & 255] ^ f[m >>> 8 & 255] ^ g[j & 255] ^ c[n++];
                  var r = d[l >>> 24] ^ e[m >>> 16 & 255] ^ f[j >>> 8 & 255] ^ g[k & 255] ^ c[n++];
                  var s = d[m >>> 24] ^ e[j >>> 16 & 255] ^ f[k >>> 8 & 255] ^ g[l & 255] ^ c[n++];
                  j = p;
                  k = q;
                  l = r;
                  m = s;
                }
                var p = (h[j >>> 24] << 24 | h[k >>> 16 & 255] << 16 | h[l >>> 8 & 255] << 8 | h[m & 255]) ^ c[n++];
                var q = (h[k >>> 24] << 24 | h[l >>> 16 & 255] << 16 | h[m >>> 8 & 255] << 8 | h[j & 255]) ^ c[n++];
                var r = (h[l >>> 24] << 24 | h[m >>> 16 & 255] << 16 | h[j >>> 8 & 255] << 8 | h[k & 255]) ^ c[n++];
                var s = (h[m >>> 24] << 24 | h[j >>> 16 & 255] << 16 | h[k >>> 8 & 255] << 8 | h[l & 255]) ^ c[n++];
                a[b] = p;
                a[b + 1] = q;
                a[b + 2] = r;
                a[b + 3] = s;
              },
              keySize: 8
            });
            b.AES = d._createHelper(q);
          })();
          return a.AES;
        });
      }
    });
    var kj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/tripledes.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ni(), Oi(), Yi(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.WordArray;
            var e = c.BlockCipher;
            var f = b.algo;
            var g = [57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26, 18, 10, 2, 59, 51, 43, 35, 27, 19, 11, 3, 60, 52, 44, 36, 63, 55, 47, 39, 31, 23, 15, 7, 62, 54, 46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 28, 20, 12, 4];
            var h = [14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4, 26, 8, 16, 7, 27, 20, 13, 2, 41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32];
            var i = [1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28];
            var j = [{
              "0": 8421888,
              "268435456": 32768,
              "536870912": 8421378,
              "805306368": 2,
              "1073741824": 512,
              "1342177280": 8421890,
              "1610612736": 8389122,
              "1879048192": 8388608,
              "2147483648": 514,
              "2415919104": 8389120,
              "2684354560": 33280,
              "2952790016": 8421376,
              "3221225472": 32770,
              "3489660928": 8388610,
              "3758096384": 0,
              "4026531840": 33282,
              "134217728": 0,
              "402653184": 8421890,
              "671088640": 33282,
              "939524096": 32768,
              "1207959552": 8421888,
              "1476395008": 512,
              "1744830464": 8421378,
              "2013265920": 2,
              "2281701376": 8389120,
              "2550136832": 33280,
              "2818572288": 8421376,
              "3087007744": 8389122,
              "3355443200": 8388610,
              "3623878656": 32770,
              "3892314112": 514,
              "4160749568": 8388608,
              "1": 32768,
              "268435457": 2,
              "536870913": 8421888,
              "805306369": 8388608,
              "1073741825": 8421378,
              "1342177281": 33280,
              "1610612737": 512,
              "1879048193": 8389122,
              "2147483649": 8421890,
              "2415919105": 8421376,
              "2684354561": 8388610,
              "2952790017": 33282,
              "3221225473": 514,
              "3489660929": 8389120,
              "3758096385": 32770,
              "4026531841": 0,
              "134217729": 8421890,
              "402653185": 8421376,
              "671088641": 8388608,
              "939524097": 512,
              "1207959553": 32768,
              "1476395009": 8388610,
              "1744830465": 2,
              "2013265921": 33282,
              "2281701377": 32770,
              "2550136833": 8389122,
              "2818572289": 514,
              "3087007745": 8421888,
              "3355443201": 8389120,
              "3623878657": 0,
              "3892314113": 33280,
              "4160749569": 8421378
            }, {
              "0": 1074282512,
              "16777216": 16384,
              "33554432": 524288,
              "50331648": 1074266128,
              "67108864": 1073741840,
              "83886080": 1074282496,
              "100663296": 1073758208,
              "117440512": 16,
              "134217728": 540672,
              "150994944": 1073758224,
              "167772160": 1073741824,
              "184549376": 540688,
              "201326592": 524304,
              "218103808": 0,
              "234881024": 16400,
              "251658240": 1074266112,
              "8388608": 1073758208,
              "25165824": 540688,
              "41943040": 16,
              "58720256": 1073758224,
              "75497472": 1074282512,
              "92274688": 1073741824,
              "109051904": 524288,
              "125829120": 1074266128,
              "142606336": 524304,
              "159383552": 0,
              "176160768": 16384,
              "192937984": 1074266112,
              "209715200": 1073741840,
              "226492416": 540672,
              "243269632": 1074282496,
              "260046848": 16400,
              "268435456": 0,
              "285212672": 1074266128,
              "301989888": 1073758224,
              "318767104": 1074282496,
              "335544320": 1074266112,
              "352321536": 16,
              "369098752": 540688,
              "385875968": 16384,
              "402653184": 16400,
              "419430400": 524288,
              "436207616": 524304,
              "452984832": 1073741840,
              "469762048": 540672,
              "486539264": 1073758208,
              "503316480": 1073741824,
              "520093696": 1074282512,
              "276824064": 540688,
              "293601280": 524288,
              "310378496": 1074266112,
              "327155712": 16384,
              "343932928": 1073758208,
              "360710144": 1074282512,
              "377487360": 16,
              "394264576": 1073741824,
              "411041792": 1074282496,
              "427819008": 1073741840,
              "444596224": 1073758224,
              "461373440": 524304,
              "478150656": 0,
              "494927872": 16400,
              "511705088": 1074266128,
              "528482304": 540672
            }, {
              "0": 260,
              "1048576": 0,
              "2097152": 67109120,
              "3145728": 65796,
              "4194304": 65540,
              "5242880": 67108868,
              "6291456": 67174660,
              "7340032": 67174400,
              "8388608": 67108864,
              "9437184": 67174656,
              "10485760": 65792,
              "11534336": 67174404,
              "12582912": 67109124,
              "13631488": 65536,
              "14680064": 4,
              "15728640": 256,
              "524288": 67174656,
              "1572864": 67174404,
              "2621440": 0,
              "3670016": 67109120,
              "4718592": 67108868,
              "5767168": 65536,
              "6815744": 65540,
              "7864320": 260,
              "8912896": 4,
              "9961472": 256,
              "11010048": 67174400,
              "12058624": 65796,
              "13107200": 65792,
              "14155776": 67109124,
              "15204352": 67174660,
              "16252928": 67108864,
              "16777216": 67174656,
              "17825792": 65540,
              "18874368": 65536,
              "19922944": 67109120,
              "20971520": 256,
              "22020096": 67174660,
              "23068672": 67108868,
              "24117248": 0,
              "25165824": 67109124,
              "26214400": 67108864,
              "27262976": 4,
              "28311552": 65792,
              "29360128": 67174400,
              "30408704": 260,
              "31457280": 65796,
              "32505856": 67174404,
              "17301504": 67108864,
              "18350080": 260,
              "19398656": 67174656,
              "20447232": 0,
              "21495808": 65540,
              "22544384": 67109120,
              "23592960": 256,
              "24641536": 67174404,
              "25690112": 65536,
              "26738688": 67174660,
              "27787264": 65796,
              "28835840": 67108868,
              "29884416": 67109124,
              "30932992": 67174400,
              "31981568": 4,
              "33030144": 65792
            }, {
              "0": 2151682048,
              "65536": 2147487808,
              "131072": 4198464,
              "196608": 2151677952,
              "262144": 0,
              "327680": 4198400,
              "393216": 2147483712,
              "458752": 4194368,
              "524288": 2147483648,
              "589824": 4194304,
              "655360": 64,
              "720896": 2147487744,
              "786432": 2151678016,
              "851968": 4160,
              "917504": 4096,
              "983040": 2151682112,
              "32768": 2147487808,
              "98304": 64,
              "163840": 2151678016,
              "229376": 2147487744,
              "294912": 4198400,
              "360448": 2151682112,
              "425984": 0,
              "491520": 2151677952,
              "557056": 4096,
              "622592": 2151682048,
              "688128": 4194304,
              "753664": 4160,
              "819200": 2147483648,
              "884736": 4194368,
              "950272": 4198464,
              "1015808": 2147483712,
              "1048576": 4194368,
              "1114112": 4198400,
              "1179648": 2147483712,
              "1245184": 0,
              "1310720": 4160,
              "1376256": 2151678016,
              "1441792": 2151682048,
              "1507328": 2147487808,
              "1572864": 2151682112,
              "1638400": 2147483648,
              "1703936": 2151677952,
              "1769472": 4198464,
              "1835008": 2147487744,
              "1900544": 4194304,
              "1966080": 64,
              "2031616": 4096,
              "1081344": 2151677952,
              "1146880": 2151682112,
              "1212416": 0,
              "1277952": 4198400,
              "1343488": 4194368,
              "1409024": 2147483648,
              "1474560": 2147487808,
              "1540096": 64,
              "1605632": 2147483712,
              "1671168": 4096,
              "1736704": 2147487744,
              "1802240": 2151678016,
              "1867776": 4160,
              "1933312": 2151682048,
              "1998848": 4194304,
              "2064384": 4198464
            }, {
              "0": 128,
              "4096": 17039360,
              "8192": 262144,
              "12288": 536870912,
              "16384": 537133184,
              "20480": 16777344,
              "24576": 553648256,
              "28672": 262272,
              "32768": 16777216,
              "36864": 537133056,
              "40960": 536871040,
              "45056": 553910400,
              "49152": 553910272,
              "53248": 0,
              "57344": 17039488,
              "61440": 553648128,
              "2048": 17039488,
              "6144": 553648256,
              "10240": 128,
              "14336": 17039360,
              "18432": 262144,
              "22528": 537133184,
              "26624": 553910272,
              "30720": 536870912,
              "34816": 537133056,
              "38912": 0,
              "43008": 553910400,
              "47104": 16777344,
              "51200": 536871040,
              "55296": 553648128,
              "59392": 16777216,
              "63488": 262272,
              "65536": 262144,
              "69632": 128,
              "73728": 536870912,
              "77824": 553648256,
              "81920": 16777344,
              "86016": 553910272,
              "90112": 537133184,
              "94208": 16777216,
              "98304": 553910400,
              "102400": 553648128,
              "106496": 17039360,
              "110592": 537133056,
              "114688": 262272,
              "118784": 536871040,
              "122880": 0,
              "126976": 17039488,
              "67584": 553648256,
              "71680": 16777216,
              "75776": 17039360,
              "79872": 537133184,
              "83968": 536870912,
              "88064": 17039488,
              "92160": 128,
              "96256": 553910272,
              "100352": 262272,
              "104448": 553910400,
              "108544": 0,
              "112640": 553648128,
              "116736": 16777344,
              "120832": 262144,
              "124928": 537133056,
              "129024": 536871040
            }, {
              "0": 268435464,
              "256": 8192,
              "512": 270532608,
              "768": 270540808,
              "1024": 268443648,
              "1280": 2097152,
              "1536": 2097160,
              "1792": 268435456,
              "2048": 0,
              "2304": 268443656,
              "2560": 2105344,
              "2816": 8,
              "3072": 270532616,
              "3328": 2105352,
              "3584": 8200,
              "3840": 270540800,
              "128": 270532608,
              "384": 270540808,
              "640": 8,
              "896": 2097152,
              "1152": 2105352,
              "1408": 268435464,
              "1664": 268443648,
              "1920": 8200,
              "2176": 2097160,
              "2432": 8192,
              "2688": 268443656,
              "2944": 270532616,
              "3200": 0,
              "3456": 270540800,
              "3712": 2105344,
              "3968": 268435456,
              "4096": 268443648,
              "4352": 270532616,
              "4608": 270540808,
              "4864": 8200,
              "5120": 2097152,
              "5376": 268435456,
              "5632": 268435464,
              "5888": 2105344,
              "6144": 2105352,
              "6400": 0,
              "6656": 8,
              "6912": 270532608,
              "7168": 8192,
              "7424": 268443656,
              "7680": 270540800,
              "7936": 2097160,
              "4224": 8,
              "4480": 2105344,
              "4736": 2097152,
              "4992": 268435464,
              "5248": 268443648,
              "5504": 8200,
              "5760": 270540808,
              "6016": 270532608,
              "6272": 270540800,
              "6528": 270532616,
              "6784": 8192,
              "7040": 2105352,
              "7296": 2097160,
              "7552": 0,
              "7808": 268435456,
              "8064": 268443656
            }, {
              "0": 1048576,
              "16": 33555457,
              "32": 1024,
              "48": 1049601,
              "64": 34604033,
              "80": 0,
              "96": 1,
              "112": 34603009,
              "128": 33555456,
              "144": 1048577,
              "160": 33554433,
              "176": 34604032,
              "192": 34603008,
              "208": 1025,
              "224": 1049600,
              "240": 33554432,
              "8": 34603009,
              "24": 0,
              "40": 33555457,
              "56": 34604032,
              "72": 1048576,
              "88": 33554433,
              "104": 33554432,
              "120": 1025,
              "136": 1049601,
              "152": 33555456,
              "168": 34603008,
              "184": 1048577,
              "200": 1024,
              "216": 34604033,
              "232": 1,
              "248": 1049600,
              "256": 33554432,
              "272": 1048576,
              "288": 33555457,
              "304": 34603009,
              "320": 1048577,
              "336": 33555456,
              "352": 34604032,
              "368": 1049601,
              "384": 1025,
              "400": 34604033,
              "416": 1049600,
              "432": 1,
              "448": 0,
              "464": 34603008,
              "480": 33554433,
              "496": 1024,
              "264": 1049600,
              "280": 33555457,
              "296": 34603009,
              "312": 1,
              "328": 33554432,
              "344": 1048576,
              "360": 1025,
              "376": 34604032,
              "392": 33554433,
              "408": 34603008,
              "424": 0,
              "440": 34604033,
              "456": 1049601,
              "472": 1024,
              "488": 33555456,
              "504": 1048577
            }, {
              "0": 134219808,
              "1": 131072,
              "2": 134217728,
              "3": 32,
              "4": 131104,
              "5": 134350880,
              "6": 134350848,
              "7": 2048,
              "8": 134348800,
              "9": 134219776,
              "10": 133120,
              "11": 134348832,
              "12": 2080,
              "13": 0,
              "14": 134217760,
              "15": 133152,
              "2147483648": 2048,
              "2147483649": 134350880,
              "2147483650": 134219808,
              "2147483651": 134217728,
              "2147483652": 134348800,
              "2147483653": 133120,
              "2147483654": 133152,
              "2147483655": 32,
              "2147483656": 134217760,
              "2147483657": 2080,
              "2147483658": 131104,
              "2147483659": 134350848,
              "2147483660": 0,
              "2147483661": 134348832,
              "2147483662": 134219776,
              "2147483663": 131072,
              "16": 133152,
              "17": 134350848,
              "18": 32,
              "19": 2048,
              "20": 134219776,
              "21": 134217760,
              "22": 134348832,
              "23": 131072,
              "24": 0,
              "25": 131104,
              "26": 134348800,
              "27": 134219808,
              "28": 134350880,
              "29": 133120,
              "30": 2080,
              "31": 134217728,
              "2147483664": 131072,
              "2147483665": 2048,
              "2147483666": 134348832,
              "2147483667": 133152,
              "2147483668": 32,
              "2147483669": 134348800,
              "2147483670": 134217728,
              "2147483671": 134219808,
              "2147483672": 134350880,
              "2147483673": 134217760,
              "2147483674": 134219776,
              "2147483675": 0,
              "2147483676": 133120,
              "2147483677": 2080,
              "2147483678": 131104,
              "2147483679": 134350848
            }];
            var k = [4160749569, 528482304, 33030144, 2064384, 129024, 8064, 504, 2147483679];
            var l = f.DES = e.extend({
              _doReset: function () {
                var a = this._key;
                var b = a.words;
                var c = [];
                for (var d = 0; d < 56; d++) {
                  var e = g[d] - 1;
                  c[d] = b[e >>> 5] >>> 31 - e % 32 & 1;
                }
                var f = this._subKeys = [];
                for (var j = 0; j < 16; j++) {
                  var k = f[j] = [];
                  var l = i[j];
                  for (var d = 0; d < 24; d++) {
                    k[d / 6 | 0] |= c[(h[d] - 1 + l) % 28] << 31 - d % 6;
                    k[4 + (d / 6 | 0)] |= c[28 + (h[d + 24] - 1 + l) % 28] << 31 - d % 6;
                  }
                  k[0] = k[0] << 1 | k[0] >>> 31;
                  for (var d = 1; d < 7; d++) {
                    k[d] = k[d] >>> (d - 1) * 4 + 3;
                  }
                  k[7] = k[7] << 5 | k[7] >>> 27;
                }
                var m = this._invSubKeys = [];
                for (var d = 0; d < 16; d++) {
                  m[d] = f[15 - d];
                }
              },
              encryptBlock: function (a, b) {
                this._doCryptBlock(a, b, this._subKeys);
              },
              decryptBlock: function (a, b) {
                this._doCryptBlock(a, b, this._invSubKeys);
              },
              _doCryptBlock: function (a, b, c) {
                this._lBlock = a[b];
                this._rBlock = a[b + 1];
                m.call(this, 4, 252645135);
                m.call(this, 16, 65535);
                n.call(this, 2, 858993459);
                n.call(this, 8, 16711935);
                m.call(this, 1, 1431655765);
                for (var d = 0; d < 16; d++) {
                  var e = c[d];
                  var f = this._lBlock;
                  var g = this._rBlock;
                  var h = 0;
                  for (var i = 0; i < 8; i++) {
                    h |= j[i][((g ^ e[i]) & k[i]) >>> 0];
                  }
                  this._lBlock = g;
                  this._rBlock = f ^ h;
                }
                var l = this._lBlock;
                this._lBlock = this._rBlock;
                this._rBlock = l;
                m.call(this, 1, 1431655765);
                n.call(this, 8, 16711935);
                n.call(this, 2, 858993459);
                m.call(this, 16, 65535);
                m.call(this, 4, 252645135);
                a[b] = this._lBlock;
                a[b + 1] = this._rBlock;
              },
              keySize: 2,
              ivSize: 2,
              blockSize: 2
            });
            function m(a, b) {
              var c = (this._lBlock >>> a ^ this._rBlock) & b;
              this._rBlock ^= c;
              this._lBlock ^= c << a;
            }
            function n(a, b) {
              var c = (this._rBlock >>> a ^ this._lBlock) & b;
              this._lBlock ^= c;
              this._rBlock ^= c << a;
            }
            b.DES = e._createHelper(l);
            var o = f.TripleDES = e.extend({
              _doReset: function () {
                var a = this._key;
                var b = a.words;
                this._des1 = l.createEncryptor(d.create(b.slice(0, 2)));
                this._des2 = l.createEncryptor(d.create(b.slice(2, 4)));
                this._des3 = l.createEncryptor(d.create(b.slice(4, 6)));
              },
              encryptBlock: function (a, b) {
                this._des1.encryptBlock(a, b);
                this._des2.decryptBlock(a, b);
                this._des3.encryptBlock(a, b);
              },
              decryptBlock: function (a, b) {
                this._des3.decryptBlock(a, b);
                this._des2.encryptBlock(a, b);
                this._des1.decryptBlock(a, b);
              },
              keySize: 6,
              ivSize: 2,
              blockSize: 2
            });
            b.TripleDES = e._createHelper(o);
          })();
          return a.TripleDES;
        });
      }
    });
    var lj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/rc4.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ni(), Oi(), Yi(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.StreamCipher;
            var e = b.algo;
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
                  var g = e % c;
                  var h = b[g >>> 2] >>> 24 - g % 4 * 8 & 255;
                  f = (f + d[e] + h) % 256;
                  var i = d[e];
                  d[e] = d[f];
                  d[f] = i;
                }
                this._i = this._j = 0;
              },
              _doProcessBlock: function (a, b) {
                a[b] ^= g.call(this);
              },
              keySize: 8,
              ivSize: 0
            });
            function g() {
              var a = this._S;
              var b = this._i;
              var c = this._j;
              var d = 0;
              for (var e = 0; e < 4; e++) {
                b = (b + 1) % 256;
                c = (c + a[b]) % 256;
                var f = a[b];
                a[b] = a[c];
                a[c] = f;
                d |= a[(a[b] + a[c]) % 256] << 24 - e * 8;
              }
              this._i = b;
              this._j = c;
              return d;
            }
            b.RC4 = d._createHelper(f);
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
            b.RC4Drop = d._createHelper(h);
          })();
          return a.RC4;
        });
      }
    });
    var mj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/rabbit.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ni(), Oi(), Yi(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.StreamCipher;
            var e = b.algo;
            var f = [];
            var g = [];
            var h = [];
            var i = e.Rabbit = d.extend({
              _doReset: function () {
                var a = this._key.words;
                var b = this.cfg.iv;
                for (var c = 0; c < 4; c++) {
                  a[c] = (a[c] << 8 | a[c] >>> 24) & 16711935 | (a[c] << 24 | a[c] >>> 8) & 4278255360;
                }
                var d = this._X = [a[0], a[3] << 16 | a[2] >>> 16, a[1], a[0] << 16 | a[3] >>> 16, a[2], a[1] << 16 | a[0] >>> 16, a[3], a[2] << 16 | a[1] >>> 16];
                var e = this._C = [a[2] << 16 | a[2] >>> 16, a[0] & 4294901760 | a[1] & 65535, a[3] << 16 | a[3] >>> 16, a[1] & 4294901760 | a[2] & 65535, a[0] << 16 | a[0] >>> 16, a[2] & 4294901760 | a[3] & 65535, a[1] << 16 | a[1] >>> 16, a[3] & 4294901760 | a[0] & 65535];
                this._b = 0;
                for (var c = 0; c < 4; c++) {
                  j.call(this);
                }
                for (var c = 0; c < 8; c++) {
                  e[c] ^= d[c + 4 & 7];
                }
                if (b) {
                  var f = b.words;
                  var g = f[0];
                  var h = f[1];
                  var i = (g << 8 | g >>> 24) & 16711935 | (g << 24 | g >>> 8) & 4278255360;
                  var k = (h << 8 | h >>> 24) & 16711935 | (h << 24 | h >>> 8) & 4278255360;
                  var l = i >>> 16 | k & 4294901760;
                  var m = k << 16 | i & 65535;
                  e[0] ^= i;
                  e[1] ^= l;
                  e[2] ^= k;
                  e[3] ^= m;
                  e[4] ^= i;
                  e[5] ^= l;
                  e[6] ^= k;
                  e[7] ^= m;
                  for (var c = 0; c < 4; c++) {
                    j.call(this);
                  }
                }
              },
              _doProcessBlock: function (a, b) {
                var c = this._X;
                j.call(this);
                f[0] = c[0] ^ c[5] >>> 16 ^ c[3] << 16;
                f[1] = c[2] ^ c[7] >>> 16 ^ c[5] << 16;
                f[2] = c[4] ^ c[1] >>> 16 ^ c[7] << 16;
                f[3] = c[6] ^ c[3] >>> 16 ^ c[1] << 16;
                for (var d = 0; d < 4; d++) {
                  f[d] = (f[d] << 8 | f[d] >>> 24) & 16711935 | (f[d] << 24 | f[d] >>> 8) & 4278255360;
                  a[b + d] ^= f[d];
                }
              },
              blockSize: 4,
              ivSize: 2
            });
            function j() {
              var a = this._X;
              var b = this._C;
              for (var c = 0; c < 8; c++) {
                g[c] = b[c];
              }
              b[0] = b[0] + 1295307597 + this._b | 0;
              b[1] = b[1] + 3545052371 + (b[0] >>> 0 < g[0] >>> 0 ? 1 : 0) | 0;
              b[2] = b[2] + 886263092 + (b[1] >>> 0 < g[1] >>> 0 ? 1 : 0) | 0;
              b[3] = b[3] + 1295307597 + (b[2] >>> 0 < g[2] >>> 0 ? 1 : 0) | 0;
              b[4] = b[4] + 3545052371 + (b[3] >>> 0 < g[3] >>> 0 ? 1 : 0) | 0;
              b[5] = b[5] + 886263092 + (b[4] >>> 0 < g[4] >>> 0 ? 1 : 0) | 0;
              b[6] = b[6] + 1295307597 + (b[5] >>> 0 < g[5] >>> 0 ? 1 : 0) | 0;
              b[7] = b[7] + 3545052371 + (b[6] >>> 0 < g[6] >>> 0 ? 1 : 0) | 0;
              this._b = b[7] >>> 0 < g[7] >>> 0 ? 1 : 0;
              for (var c = 0; c < 8; c++) {
                var d = a[c] + b[c];
                var e = d & 65535;
                var f = d >>> 16;
                var i = ((e * e >>> 17) + e * f >>> 15) + f * f;
                var j = ((d & 4294901760) * d | 0) + ((d & 65535) * d | 0);
                h[c] = i ^ j;
              }
              a[0] = h[0] + (h[7] << 16 | h[7] >>> 16) + (h[6] << 16 | h[6] >>> 16) | 0;
              a[1] = h[1] + (h[0] << 8 | h[0] >>> 24) + h[7] | 0;
              a[2] = h[2] + (h[1] << 16 | h[1] >>> 16) + (h[0] << 16 | h[0] >>> 16) | 0;
              a[3] = h[3] + (h[2] << 8 | h[2] >>> 24) + h[1] | 0;
              a[4] = h[4] + (h[3] << 16 | h[3] >>> 16) + (h[2] << 16 | h[2] >>> 16) | 0;
              a[5] = h[5] + (h[4] << 8 | h[4] >>> 24) + h[3] | 0;
              a[6] = h[6] + (h[5] << 16 | h[5] >>> 16) + (h[4] << 16 | h[4] >>> 16) | 0;
              a[7] = h[7] + (h[6] << 8 | h[6] >>> 24) + h[5] | 0;
            }
            b.Rabbit = d._createHelper(i);
          })();
          return a.Rabbit;
        });
      }
    });
    var nj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/rabbit-legacy.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ni(), Oi(), Yi(), Zi());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./enc-base64", "./md5", "./evpkdf", "./cipher-core"], d);
          } else {
            d(c.CryptoJS);
          }
        })(a, function (a) {
          (function () {
            var b = a;
            var c = b.lib;
            var d = c.StreamCipher;
            var e = b.algo;
            var f = [];
            var g = [];
            var h = [];
            var i = e.RabbitLegacy = d.extend({
              _doReset: function () {
                var a = this._key.words;
                var b = this.cfg.iv;
                var c = this._X = [a[0], a[3] << 16 | a[2] >>> 16, a[1], a[0] << 16 | a[3] >>> 16, a[2], a[1] << 16 | a[0] >>> 16, a[3], a[2] << 16 | a[1] >>> 16];
                var d = this._C = [a[2] << 16 | a[2] >>> 16, a[0] & 4294901760 | a[1] & 65535, a[3] << 16 | a[3] >>> 16, a[1] & 4294901760 | a[2] & 65535, a[0] << 16 | a[0] >>> 16, a[2] & 4294901760 | a[3] & 65535, a[1] << 16 | a[1] >>> 16, a[3] & 4294901760 | a[0] & 65535];
                this._b = 0;
                for (var e = 0; e < 4; e++) {
                  j.call(this);
                }
                for (var e = 0; e < 8; e++) {
                  d[e] ^= c[e + 4 & 7];
                }
                if (b) {
                  var f = b.words;
                  var g = f[0];
                  var h = f[1];
                  var i = (g << 8 | g >>> 24) & 16711935 | (g << 24 | g >>> 8) & 4278255360;
                  var k = (h << 8 | h >>> 24) & 16711935 | (h << 24 | h >>> 8) & 4278255360;
                  var l = i >>> 16 | k & 4294901760;
                  var m = k << 16 | i & 65535;
                  d[0] ^= i;
                  d[1] ^= l;
                  d[2] ^= k;
                  d[3] ^= m;
                  d[4] ^= i;
                  d[5] ^= l;
                  d[6] ^= k;
                  d[7] ^= m;
                  for (var e = 0; e < 4; e++) {
                    j.call(this);
                  }
                }
              },
              _doProcessBlock: function (a, b) {
                var c = this._X;
                j.call(this);
                f[0] = c[0] ^ c[5] >>> 16 ^ c[3] << 16;
                f[1] = c[2] ^ c[7] >>> 16 ^ c[5] << 16;
                f[2] = c[4] ^ c[1] >>> 16 ^ c[7] << 16;
                f[3] = c[6] ^ c[3] >>> 16 ^ c[1] << 16;
                for (var d = 0; d < 4; d++) {
                  f[d] = (f[d] << 8 | f[d] >>> 24) & 16711935 | (f[d] << 24 | f[d] >>> 8) & 4278255360;
                  a[b + d] ^= f[d];
                }
              },
              blockSize: 4,
              ivSize: 2
            });
            function j() {
              var a = this._X;
              var b = this._C;
              for (var c = 0; c < 8; c++) {
                g[c] = b[c];
              }
              b[0] = b[0] + 1295307597 + this._b | 0;
              b[1] = b[1] + 3545052371 + (b[0] >>> 0 < g[0] >>> 0 ? 1 : 0) | 0;
              b[2] = b[2] + 886263092 + (b[1] >>> 0 < g[1] >>> 0 ? 1 : 0) | 0;
              b[3] = b[3] + 1295307597 + (b[2] >>> 0 < g[2] >>> 0 ? 1 : 0) | 0;
              b[4] = b[4] + 3545052371 + (b[3] >>> 0 < g[3] >>> 0 ? 1 : 0) | 0;
              b[5] = b[5] + 886263092 + (b[4] >>> 0 < g[4] >>> 0 ? 1 : 0) | 0;
              b[6] = b[6] + 1295307597 + (b[5] >>> 0 < g[5] >>> 0 ? 1 : 0) | 0;
              b[7] = b[7] + 3545052371 + (b[6] >>> 0 < g[6] >>> 0 ? 1 : 0) | 0;
              this._b = b[7] >>> 0 < g[7] >>> 0 ? 1 : 0;
              for (var c = 0; c < 8; c++) {
                var d = a[c] + b[c];
                var e = d & 65535;
                var f = d >>> 16;
                var i = ((e * e >>> 17) + e * f >>> 15) + f * f;
                var j = ((d & 4294901760) * d | 0) + ((d & 65535) * d | 0);
                h[c] = i ^ j;
              }
              a[0] = h[0] + (h[7] << 16 | h[7] >>> 16) + (h[6] << 16 | h[6] >>> 16) | 0;
              a[1] = h[1] + (h[0] << 8 | h[0] >>> 24) + h[7] | 0;
              a[2] = h[2] + (h[1] << 16 | h[1] >>> 16) + (h[0] << 16 | h[0] >>> 16) | 0;
              a[3] = h[3] + (h[2] << 8 | h[2] >>> 24) + h[1] | 0;
              a[4] = h[4] + (h[3] << 16 | h[3] >>> 16) + (h[2] << 16 | h[2] >>> 16) | 0;
              a[5] = h[5] + (h[4] << 8 | h[4] >>> 24) + h[3] | 0;
              a[6] = h[6] + (h[5] << 16 | h[5] >>> 16) + (h[4] << 16 | h[4] >>> 16) | 0;
              a[7] = h[7] + (h[6] << 8 | h[6] >>> 24) + h[5] | 0;
            }
            b.RabbitLegacy = d._createHelper(i);
          })();
          return a.RabbitLegacy;
        });
      }
    });
    var oj = zi({
      "../../node_modules/.pnpm/crypto-js@3.1.9-1/node_modules/crypto-js/index.js"(a, b) {
        'use strict';
  
        (function (c, d, e) {
          if (typeof a === "object") {
            b.exports = a = d(Ji(), Ki(), Li(), Mi(), Ni(), Oi(), Pi(), Qi(), Ri(), Si(), Ti(), Ui(), Vi(), Wi(), Xi(), Yi(), Zi(), $i(), _i(), aj(), bj(), cj(), dj(), ej(), fj(), gj(), hj(), ij(), jj(), kj(), lj(), mj(), nj());
          } else if (typeof define === "function" && define.amd) {
            define(["./core", "./x64-core", "./lib-typedarrays", "./enc-utf16", "./enc-base64", "./md5", "./sha1", "./sha256", "./sha224", "./sha512", "./sha384", "./sha3", "./ripemd160", "./hmac", "./pbkdf2", "./evpkdf", "./cipher-core", "./mode-cfb", "./mode-ctr", "./mode-ctr-gladman", "./mode-ofb", "./mode-ecb", "./pad-ansix923", "./pad-iso10126", "./pad-iso97971", "./pad-zeropadding", "./pad-nopadding", "./format-hex", "./aes", "./tripledes", "./rc4", "./rabbit", "./rabbit-legacy"], d);
          } else {
            c.CryptoJS = d(c.CryptoJS);
          }
        })(a, function (a) {
          return a;
        });
      }
    });
    var pj = {
      ESC: 322,
      F1: 288,
      F2: 289,
      F3: 170,
      F5: 166,
      F6: 167,
      F7: 168,
      F8: 169,
      F9: 56,
      F10: 57,
      "~": 243,
      "#1": 157,
      "#2": 158,
      "#3": 160,
      "#4": 164,
      "#5": 165,
      "#6": 159,
      "#7": 161,
      "#8": 162,
      "#9": 163,
      "-": 84,
      "=": 83,
      BACKSPACE: 177,
      TAB: 37,
      Q: 44,
      W: 32,
      E: 38,
      R: 45,
      T: 245,
      Y: 246,
      U: 303,
      P: 199,
      ENTER: 18,
      CAPS: 137,
      A: 34,
      S: 8,
      D: 9,
      F: 23,
      G: 47,
      H: 74,
      K: 311,
      L: 182,
      LEFTSHIFT: 21,
      Z: 20,
      X: 73,
      C: 26,
      V: 0,
      B: 29,
      N: 249,
      M: 244,
      ",": 82,
      ".": 81,
      LEFTCTRL: 36,
      LEFTALT: 19,
      SPACE: 22,
      RIGHTCTRL: 70,
      HOME: 213,
      PAGEUP: 10,
      PAGEDOWN: 11,
      DELETE: 178,
      LEFT: 174,
      RIGHT: 175,
      TOP: 27,
      DOWN: 173,
      NENTER: 201,
      N4: 108,
      N5: 60,
      N6: 107,
      "N+": 96,
      "N-": 97,
      N7: 117,
      N8: 61,
      N9: 118
    };
    var qj = {};
    var rj = {
      MathUtils: () => zk
    };
    Ai(qj, rj);
    var sj;
    var tj;
    var uj = class a {
      constructor(a, b, c) {
        Fi(this, sj);
        const d = Ii(this, sj, tj).call(this, a, b, c);
        this.x = d.x;
        this.y = d.y;
        this.z = d.z;
      }
      equals(a, b, c) {
        const d = Ii(this, sj, tj).call(this, a, b, c);
        return this.x === d.x && this.y === d.y && this.z === d.z;
      }
      add(a, b, c, d) {
        let e = Ii(this, sj, tj).call(this, a, b, c);
        this.x += d ? e.x * d : e.x;
        this.y += d ? e.y * d : e.y;
        this.z += d ? e.z * d : e.z;
        return this;
      }
      addScalar(a) {
        if (typeof a !== "number") {
          throw new Error("Invalid scalar");
        }
        this.x += a;
        this.y += a;
        this.z += a;
        return this;
      }
      sub(a, b, c, d) {
        const e = Ii(this, sj, tj).call(this, a, b, c);
        this.x -= d ? e.x * d : e.x;
        this.y -= d ? e.y * d : e.y;
        this.z -= d ? e.z * d : e.z;
        return this;
      }
      subScalar(a) {
        if (typeof a !== "number") {
          throw new Error("Invalid scalar");
        }
        this.x -= a;
        this.y -= a;
        this.z -= a;
        return this;
      }
      multiply(a, b, c) {
        const d = Ii(this, sj, tj).call(this, a, b, c);
        this.x *= d.x;
        this.y *= d.y;
        this.z *= d.z;
        return this;
      }
      multiplyScalar(a) {
        if (typeof a !== "number") {
          throw new Error("Invalid scalar");
        }
        this.x *= a;
        this.y *= a;
        this.z *= a;
        return this;
      }
      divide(a, b, c) {
        const d = Ii(this, sj, tj).call(this, a, b, c);
        this.x /= d.x;
        this.y /= d.y;
        this.z /= d.z;
        return this;
      }
      divideScalar(a) {
        if (typeof a !== "number") {
          throw new Error("Invalid scalar");
        }
        this.x /= a;
        this.y /= a;
        this.z /= a;
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
      getCenter(b, c, d) {
        const e = Ii(this, sj, tj).call(this, b, c, d);
        return new a((this.x + e.x) / 2, (this.y + e.y) / 2, (this.z + e.z) / 2);
      }
      getDistance(a, b, c) {
        const [d, e, f] = a instanceof Array ? a : typeof a === "object" ? [a.x, a.y, a.z] : [a, b, c];
        if (typeof d !== "number" || typeof e !== "number" || typeof f !== "number") {
          throw new Error("Invalid vector coordinates");
        }
        const [g, h, i] = [this.x - d, this.y - e, this.z - f];
        return Math.sqrt(g * g + h * h + i * i);
      }
      toArray(a) {
        if (typeof a === "number") {
          return [parseFloat(this.x.toFixed(a)), parseFloat(this.y.toFixed(a)), parseFloat(this.z.toFixed(a))];
        }
        return [this.x, this.y, this.z];
      }
      toJSON(a) {
        if (typeof a === "number") {
          return {
            x: parseFloat(this.x.toFixed(a)),
            y: parseFloat(this.y.toFixed(a)),
            z: parseFloat(this.z.toFixed(a))
          };
        }
        var b = {
          x: this.x,
          y: this.y,
          z: this.z
        };
        return b;
      }
      toString(a) {
        return JSON.stringify(this.toJSON(a));
      }
    };
    sj = new WeakSet();
    tj = function (a, b, c) {
      let d = {
        x: 0,
        y: 0,
        z: 0
      };
      if (a instanceof uj) {
        d = a;
      } else if (a instanceof Array) {
        var e = {
          x: a[0],
          y: a[1],
          z: a[2]
        };
        d = e;
      } else if (typeof a === "object") {
        d = a;
      } else {
        var f = {
          x: a,
          y: b,
          z: c
        };
        d = f;
      }
      if (typeof d.x !== "number" || typeof d.y !== "number" || typeof d.z !== "number") {
        throw new Error("Invalid vector coordinates");
      }
      return d;
    };
    var vj = uj;
    var wj;
    var xj;
    var yj = class {
      constructor(a) {
        Fi(this, wj, undefined);
        Fi(this, xj, undefined);
        Gi(this, xj, a ?? 5);
        Gi(this, wj, new Map());
      }
      setTTL(a) {
        Gi(this, xj, a);
      }
      set(a, b, c) {
        Ei(this, wj).set(a, {
          value: b,
          expiration: Date.now() + (c ?? Ei(this, xj)) * 1000
        });
        return this;
      }
      get(a, b = false) {
        const c = Ei(this, wj).get(a);
        const d = c ? b ? true : c.expiration > Date.now() : false;
        if (!c || !d) {
          if (c) {
            Ei(this, wj).delete(a);
          }
          return;
        }
        return c.value;
      }
      has(a, b = false) {
        const c = Ei(this, wj).get(a);
        const d = c ? b ? true : c.expiration > Date.now() : false;
        if (c && !d) {
          Ei(this, wj).delete(a);
        }
        return d;
      }
      delete(a) {
        return Ei(this, wj).delete(a);
      }
      clear() {
        Ei(this, wj).clear();
      }
      values(a = false) {
        const b = [];
        const c = Date.now();
        for (const d of Ei(this, wj).values()) {
          if (a || d.expiration > c) {
            b.push(d.value);
          }
        }
        return b;
      }
      keys(a = false) {
        const b = [];
        const c = Date.now();
        for (const [d, e] of Ei(this, wj).entries()) {
          if (a || e.expiration > c) {
            b.push(d);
          }
        }
        return b;
      }
      entries(a = false) {
        const b = [];
        const c = Date.now();
        for (const [d, e] of Ei(this, wj).entries()) {
          if (a || e.expiration > c) {
            b.push([d, e.value]);
          }
        }
        return b;
      }
    };
    wj = new WeakMap();
    xj = new WeakMap();
    var zj;
    var Aj;
    var Bj;
    var Cj;
    var Dj;
    var Ej;
    var Fj;
    var Gj;
    var Hj;
    var Ij;
    var Jj;
    var Kj;
    var Lj;
    var Mj;
    var Nj;
    var Oj;
    var Pj;
    var Qj;
    var Rj;
    var Sj;
    var Tj;
    var Uj;
    var Vj = class {
      constructor(a, b, c, d, e, f = 30, g = false) {
        Fi(this, Lj);
        Fi(this, Nj);
        Fi(this, Pj);
        Fi(this, Rj);
        Fi(this, Tj);
        Fi(this, zj, undefined);
        Fi(this, Aj, undefined);
        Fi(this, Bj, undefined);
        Fi(this, Cj, undefined);
        Fi(this, Dj, undefined);
        Fi(this, Ej, undefined);
        Fi(this, Fj, undefined);
        Fi(this, Gj, undefined);
        Fi(this, Hj, undefined);
        Fi(this, Ij, undefined);
        Fi(this, Jj, undefined);
        Fi(this, Kj, undefined);
        Gi(this, zj, a);
        Gi(this, Aj, d);
        Gi(this, Bj, e);
        Gi(this, Cj, b);
        Gi(this, Dj, c);
        Gi(this, Ej, g);
        Gi(this, Fj, f);
        Gi(this, Hj, Ei(this, Aj).x / f);
        Gi(this, Ij, Ei(this, Aj).y / f);
        Gi(this, Gj, Ei(this, Hj) * Ei(this, Ij));
        Gi(this, Jj, Ii(this, Lj, Mj).call(this, Ei(this, zj), Ei(this, Fj), Ei(this, Hj), Ei(this, Ij), Ei(this, Ej)));
        Gi(this, Kj, Ii(this, Nj, Oj).call(this, Ei(this, Jj), Ei(this, Gj)));
      }
      get cells() {
        return Ei(this, Jj);
      }
      get cellSize() {
        return Ei(this, Fj);
      }
      get cellWidth() {
        return Ei(this, Hj);
      }
      get cellHeight() {
        return Ei(this, Ij);
      }
      get gridArea() {
        return Ei(this, Kj);
      }
      get gridCoverage() {
        return Ei(this, Kj) / Ei(this, Bj) * 100;
      }
      isPointInsideGrid(a) {
        var b;
        const c = a.x - Ei(this, Cj).x;
        const d = a.y - Ei(this, Cj).y;
        const e = Math.floor(c * Ei(this, Fj) / Ei(this, Aj).x);
        const f = Math.floor(d * Ei(this, Fj) / Ei(this, Aj).y);
        let g = (b = Ei(this, Jj)[e]) == null ? undefined : b[f];
        if (!g && Ei(this, Ej)) {
          g = Ii(this, Rj, Sj).call(this, e, f, Ei(this, Hj), Ei(this, Ij), Ei(this, zj));
          Ei(this, Jj)[e][f] = g;
          if (!g) {
            return false;
          }
          Gi(this, Kj, Ei(this, Kj) + Ei(this, Gj));
        }
        return g ?? false;
      }
    };
    zj = new WeakMap();
    Aj = new WeakMap();
    Bj = new WeakMap();
    Cj = new WeakMap();
    Dj = new WeakMap();
    Ej = new WeakMap();
    Fj = new WeakMap();
    Gj = new WeakMap();
    Hj = new WeakMap();
    Ij = new WeakMap();
    Jj = new WeakMap();
    Kj = new WeakMap();
    Lj = new WeakSet();
    Mj = function (a, b, c, d, e) {
      const f = {};
      for (let g = 0; g < b; g++) {
        f[g] = {};
        if (e) {
          continue;
        }
        for (let e = 0; e < b; e++) {
          const b = Ii(this, Rj, Sj).call(this, g, e, c, d, a);
          if (!b) {
            continue;
          }
          f[g][e] = true;
        }
      }
      return f;
    };
    Nj = new WeakSet();
    Oj = function (a, b) {
      let c = 0;
      for (const d in a) {
        for (const e in a[d]) {
          c += b;
        }
      }
      return c;
    };
    Pj = new WeakSet();
    Qj = function (a, b, c, d) {
      const e = [];
      const f = a * c + Ei(this, Cj).x;
      const g = b * d + Ei(this, Cj).y;
      e.push(new qk(f, g));
      e.push(new qk(f + c, g));
      e.push(new qk(f + c, g + d));
      e.push(new qk(f, g + d));
      return e;
    };
    Rj = new WeakSet();
    Sj = function (a, b, c, d, e) {
      const f = Ii(this, Pj, Qj).call(this, a, b, c, d);
      let g = false;
      for (const h of f) {
        const a = Ik.MathUtils.windingNumber(h, e);
        if (a !== 0) {
          g = true;
          break;
        }
      }
      if (!g) {
        return false;
      }
      for (let g = 0; g < f.length; g++) {
        const a = f[g];
        const b = f[(g + 1) % f.length];
        for (let c = 0; c < e.length; c++) {
          const d = e[c];
          const f = e[(c + 1) % e.length];
          if (Ii(this, Tj, Uj).call(this, a, b, d, f)) {
            return false;
          }
        }
      }
      return true;
    };
    Tj = new WeakSet();
    Uj = function (a, b, c, d) {
      const e = (b.x - a.x) * (d.y - c.y) - (b.y - a.y) * (d.x - c.x);
      const f = (a.y - c.y) * (d.x - c.x) - (a.x - c.x) * (d.y - c.y);
      const g = (a.y - c.y) * (b.x - a.x) - (a.x - c.x) * (b.y - a.y);
      if (e === 0) {
        return f === 0 && g === 0;
      }
      const h = f / e;
      const i = g / e;
      return h >= 0 && h <= 1 && i >= 0 && i <= 1;
    };
    var Wj;
    var Xj;
    var Yj;
    var Zj;
    var $j;
    var _j;
    var ak;
    var bk;
    var ck;
    var dk;
    var ek;
    var fk;
    var gk;
    var hk;
    var ik;
    var jk;
    var kk;
    var lk;
    var mk = class {
      constructor(a, b = undefined, c = undefined) {
        if (b === undefined) b = {};
        if (c === undefined) c = {};
        Fi(this, ck);
        Fi(this, ek);
        Fi(this, gk);
        Fi(this, ik);
        Fi(this, kk);
        Fi(this, Wj, undefined);
        Fi(this, Xj, undefined);
        Fi(this, Yj, undefined);
        Fi(this, Zj, undefined);
        Fi(this, $j, undefined);
        Fi(this, _j, undefined);
        Fi(this, ak, undefined);
        Fi(this, bk, undefined);
        Gi(this, Wj, Ik.getUUID());
        Gi(this, Xj, a);
        Gi(this, Yj, Ii(this, ck, dk).call(this, a));
        Gi(this, Zj, Ii(this, ek, fk).call(this, a));
        Gi(this, $j, Ii(this, kk, lk).call(this, a));
        Gi(this, _j, Ii(this, ik, jk).call(this, Ei(this, Yj), Ei(this, Zj)));
        Gi(this, ak, Ii(this, gk, hk).call(this, Ei(this, Yj), Ei(this, Zj)));
        this.options = b;
        this.data = c;
        if (!this.options.useGrid && !this.options.useLazyGrid) {
          return;
        }
        Gi(this, bk, new Vj(Ei(this, Xj), Ei(this, Yj), Ei(this, Zj), Ei(this, _j), Ei(this, $j), b.gridCellSize, b.useLazyGrid));
      }
      get id() {
        return Ei(this, Wj);
      }
      get center() {
        return Ei(this, ak);
      }
      get min() {
        return Ei(this, Yj);
      }
      get max() {
        return Ei(this, Zj);
      }
      get points() {
        return [...Ei(this, Xj)];
      }
      isPointInside(a) {
        if (a.x < Ei(this, Yj).x || a.x > Ei(this, Zj).x) {
          return false;
        } else if (a.y < Ei(this, Yj).y || a.y > Ei(this, Zj).y) {
          return false;
        }
        if ((this.options.minZ || this.options.maxZ) && a instanceof vj) {
          const b = this.options.minZ ?? -Infinity;
          const c = this.options.maxZ ?? Infinity;
          if (a.z < b || a.z > c) {
            return false;
          }
        }
        if ((this.options.useGrid || this.options.useLazyGrid) && Ei(this, bk)) {
          return Ei(this, bk).isPointInsideGrid(a);
        }
        const b = Ik.MathUtils.windingNumber(a, Ei(this, Xj));
        return b !== 0;
      }
      addPoint(a) {
        Ei(this, Xj).push(a);
      }
      removePoint(a) {
        const b = Ei(this, Xj).findIndex(b => b.x === a.x && b.y === a.y);
        if (b === -1) {
          return;
        }
        Ei(this, Xj).splice(b, 1);
      }
      removeLastPoint() {
        Ei(this, Xj).pop();
      }
      recalculate() {
        Gi(this, Yj, Ii(this, ck, dk).call(this, Ei(this, Xj)));
        Gi(this, Zj, Ii(this, ek, fk).call(this, Ei(this, Xj)));
        Gi(this, $j, Ii(this, kk, lk).call(this, Ei(this, Xj)));
        Gi(this, _j, Ii(this, ik, jk).call(this, Ei(this, Yj), Ei(this, Zj)));
        Gi(this, ak, Ii(this, gk, hk).call(this, Ei(this, Yj), Ei(this, Zj)));
        if (!this.options.useGrid) {
          return;
        }
        Gi(this, bk, new Vj(Ei(this, Xj), Ei(this, Yj), Ei(this, Zj), Ei(this, _j), Ei(this, $j), this.options.gridCellSize, this.options.useLazyGrid));
      }
    };
    Wj = new WeakMap();
    Xj = new WeakMap();
    Yj = new WeakMap();
    Zj = new WeakMap();
    $j = new WeakMap();
    _j = new WeakMap();
    ak = new WeakMap();
    bk = new WeakMap();
    ck = new WeakSet();
    dk = function (a) {
      let b = Number.MAX_SAFE_INTEGER;
      let c = Number.MAX_SAFE_INTEGER;
      for (const d of a) {
        b = Math.min(b, d.x);
        c = Math.min(c, d.y);
      }
      return new qk(b, c);
    };
    ek = new WeakSet();
    fk = function (a) {
      let b = Number.MIN_SAFE_INTEGER;
      let c = Number.MIN_SAFE_INTEGER;
      for (const d of a) {
        b = Math.max(b, d.x);
        c = Math.max(c, d.y);
      }
      return new qk(b, c);
    };
    gk = new WeakSet();
    hk = function (a, b) {
      const c = b.add(a);
      return c.divideScalar(2);
    };
    ik = new WeakSet();
    jk = function (a, b) {
      return b.sub(a);
    };
    kk = new WeakSet();
    lk = function (a) {
      let b = 0;
      for (let c = 0, d = a.length - 1; c < a.length; d = c++) {
        const e = a[c];
        const f = a[d];
        b += e.x * f.y;
        b -= e.y * f.x;
      }
      return Math.abs(b / 2);
    };
    var nk;
    var ok;
    var pk = class a {
      constructor(a, b) {
        Fi(this, nk);
        const c = Ii(this, nk, ok).call(this, a, b);
        this.x = c.x;
        this.y = c.y;
      }
      equals(a, b) {
        const c = Ii(this, nk, ok).call(this, a, b);
        return this.x === c.x && this.y === c.y;
      }
      add(b, c, d) {
        const e = Ii(this, nk, ok).call(this, b, c);
        const f = this.x + (d ? e.x * d : e.x);
        const g = this.y + (d ? e.y * d : e.y);
        return new a(f, g);
      }
      addScalar(b) {
        if (typeof b !== "number") {
          throw new Error("Invalid scalar");
        }
        const c = this.x + b;
        const d = this.y + b;
        return new a(c, d);
      }
      sub(b, c, d) {
        const e = Ii(this, nk, ok).call(this, b, c);
        const f = this.x - (d ? e.x * d : e.x);
        const g = this.y - (d ? e.y * d : e.y);
        return new a(f, g);
      }
      subScalar(b) {
        if (typeof b !== "number") {
          throw new Error("Invalid scalar");
        }
        const c = this.x - b;
        const d = this.y - b;
        return new a(c, d);
      }
      multiply(b, c) {
        const d = Ii(this, nk, ok).call(this, b, c);
        const e = this.x * d.x;
        const f = this.y * d.y;
        return new a(e, f);
      }
      multiplyScalar(b) {
        if (typeof b !== "number") {
          throw new Error("Invalid scalar");
        }
        const c = this.x * b;
        const d = this.y * b;
        return new a(c, d);
      }
      divide(b, c) {
        const d = Ii(this, nk, ok).call(this, b, c);
        const e = this.x / d.x;
        const f = this.y / d.y;
        return new a(e, f);
      }
      divideScalar(b) {
        if (typeof b !== "number") {
          throw new Error("Invalid scalar");
        }
        const c = this.x / b;
        const d = this.y / b;
        return new a(c, d);
      }
      round() {
        const b = Math.round(this.x);
        const c = Math.round(this.y);
        return new a(b, c);
      }
      floor() {
        const b = Math.floor(this.x);
        const c = Math.floor(this.y);
        return new a(b, c);
      }
      ceil() {
        const b = Math.ceil(this.x);
        const c = Math.ceil(this.y);
        return new a(b, c);
      }
      getCenter(b, c) {
        const d = Ii(this, nk, ok).call(this, b, c);
        return new a((this.x + d.x) / 2, (this.y + d.y) / 2);
      }
      getDistance(a, b) {
        const [c, d] = a instanceof Array ? a : typeof a === "object" ? [a.x, a.y] : [a, b];
        if (typeof c !== "number" || typeof d !== "number") {
          throw new Error("Invalid vector coordinates");
        }
        const [e, f] = [this.x - c, this.y - d];
        return Math.sqrt(e * e + f * f);
      }
      toArray(a) {
        if (typeof a === "number") {
          return [parseFloat(this.x.toFixed(a)), parseFloat(this.y.toFixed(a))];
        }
        return [this.x, this.y];
      }
      toJSON(a) {
        if (typeof a === "number") {
          return {
            x: parseFloat(this.x.toFixed(a)),
            y: parseFloat(this.y.toFixed(a))
          };
        }
        var b = {
          x: this.x,
          y: this.y
        };
        return b;
      }
      toString(a) {
        return JSON.stringify(this.toJSON(a));
      }
    };
    nk = new WeakSet();
    ok = function (a, b) {
      let c = {
        x: 0,
        y: 0
      };
      if (a instanceof pk || a instanceof vj) {
        c = a;
      } else if (a instanceof Array) {
        var d = {
          x: a[0],
          y: a[1]
        };
        c = d;
      } else if (typeof a === "object") {
        c = a;
      } else {
        var e = {
          x: a,
          y: b
        };
        c = e;
      }
      if (typeof c.x !== "number" || typeof c.y !== "number") {
        throw new Error("Invalid vector coordinates");
      }
      return c;
    };
    var qk = pk;
    var rk = (a, b, c) => {
      return Math.min(Math.max(a, b), c);
    };
    var sk = (a, b, c) => {
      return b[0] + (c - a[0]) * (b[1] - b[0]) / (a[1] - a[0]);
    };
    var tk = ([a, b, c], [d, e, f]) => {
      const [g, h, i] = [a - d, b - e, c - f];
      return Math.sqrt(g * g + h * h + i * i);
    };
    var uk = (a, b) => {
      if (b) {
        return Math.floor(Math.random() * (b - a + 1) + a);
      } else {
        return Math.floor(Math.random() * a);
      }
    };
    var vk = (a, b) => {
      if (a instanceof qk) {
        return a;
      } else if (a instanceof vj) {
        return new qk(a);
      } else if (a instanceof Array) {
        return new qk(a);
      } else if (typeof a === "object") {
        return new qk(a);
      }
      if (typeof a !== "number" || typeof b !== "number") {
        throw new Error("Invalid vector coordinates");
      }
      return new qk(a, b);
    };
    var wk = (a, b, c) => {
      if (a instanceof vj) {
        return a;
      } else if (a instanceof Array) {
        return new vj(a);
      } else if (typeof a === "object") {
        return new vj(a);
      }
      if (typeof a !== "number" || typeof b !== "number" || typeof c !== "number") {
        throw new Error("Invalid vector coordinates");
      }
      return new vj(a, b, c);
    };
    var xk = (a, b) => {
      let c = 0;
      const d = (a, b, c) => {
        return (b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y);
      };
      for (let e = 0; e < b.length; e++) {
        const f = b[e];
        const g = b[(e + 1) % b.length];
        if (f.y <= a.y) {
          if (g.y > a.y && d(f, g, a) > 0) {
            c++;
          }
        } else if (g.y <= a.y && d(f, g, a) < 0) {
          c--;
        }
      }
      return c;
    };
    var yk = {
      clamp: rk,
      getMapRange: sk,
      getDistance: tk,
      getRandomNumber: uk,
      parseVector2: vk,
      parseVector3: wk,
      windingNumber: xk
    };
    var zk = yk;
    function Ak(a, b) {
      const c = "_";
      const d = Bk((b, c, ...d) => {
        return a(b, ...d);
      }, b);
      return {
        get: function (...a) {
          return d.get(c, ...a);
        },
        reset: function () {
          d.reset(c);
        }
      };
    }
    function Bk(a, b) {
      const c = b.timeToLive || 60000;
      const d = {};
      async function e(b, ...e) {
        let f = d[b];
        if (!f) {
          f = {
            value: null,
            lastUpdated: 0
          };
          d[b] = f;
        }
        const g = Date.now();
        if (f.lastUpdated === 0 || g - f.lastUpdated > c) {
          const [c, d] = await a(f, b, ...e);
          if (c) {
            f.lastUpdated = g;
            f.value = d;
          }
          return d;
        }
        return await new Promise(a => setTimeout(() => a(f.value), 0));
      }
      return {
        get: async function (a, ...b) {
          return await e(a, ...b);
        },
        reset: function (a) {
          const b = d[a];
          if (b) {
            b.lastUpdated = 0;
          }
        }
      };
    }
    function Ck() {
      if (globalThis && typeof globalThis.crypto === "object") {
        return l();
      } else {
        return "";
      }
    }
    function Dk(a) {
      return A(a, A.URL);
    }
    function Ek(a, b) {
      return new Promise((c, d) => {
        const e = Date.now();
        const f = setInterval(() => {
          const d = Date.now() - e > b;
          if (a() || d) {
            clearInterval(f);
            return c(d);
          }
        }, 1);
      });
    }
    function Fk(a) {
      return new Promise(b => setTimeout(() => b(), a));
    }
    function Gk() {
      return Fk(0);
    }
    var Hk = {
      cache: Ak,
      cacheableMap: Bk,
      waitForCondition: Ek,
      getUUID: Ck,
      getStringHash: Dk,
      wait: Fk,
      waitForNextFrame: Gk,
      deflate: Lf,
      inflate: Pf,
      ...qj
    };
    var Ik = Hk;
    var Jk = (a => {
      a[a.hat = 0] = "hat";
      a[a.mask = 1] = "mask";
      a[a.glasses = 2] = "glasses";
      a[a.armor = 3] = "armor";
      a[a.shoes = 4] = "shoes";
      a[a.idcard = 5] = "idcard";
      a[a.mobilephone = 6] = "mobilephone";
      a[a.keyring = 7] = "keyring";
      a[a.bankcard = 8] = "bankcard";
      a[a.backpack = 9] = "backpack";
      return a;
    })(Jk || {});
    var Kk = {};
    var Lk = (a, b) => "__cfx_export_" + a + "_" + b;
    var Mk = new Proxy((a, b) => {
      const c = (a, ...c) => {
        const d = b(...c);
        if (d instanceof Promise) {
          d.then(b => a(b));
        } else {
          a(d);
        }
      };
      const d = GetCurrentResourceName();
      if (d == undefined) {
        throw new Error("Failed to get resource name, are you sure you are using this in a fivem resource?");
      }
      on(Lk(d, a), a => {
        a(c);
      });
    }, {
      apply: (a, b, c) => {
        a(...c);
      },
      get: (a, b) => {
        if (Kk[b] == undefined) {
          Kk[b] = {};
        }
        return new Proxy({}, {
          get: (a, c) => {
            const d = c + "_async";
            return (...a) => {
              return new Promise(async (e, f) => {
                const g = await Ik.waitForCondition(() => GetResourceState(b) === "started", 60000);
                if (g) {
                  return f("Resource " + b + " is not running");
                }
                if (Kk[b][d] === undefined) {
                  emit(Lk(b, c), a => {
                    Kk[b][d] = a;
                  });
                  const a = await Ik.waitForCondition(() => Kk[b][d] !== undefined, 1000);
                  if (a) {
                    return f("Failed to get export " + c + " from resource " + b);
                  }
                }
                try {
                  Kk[b][d](e, ...a);
                } catch (a) {
                  f(a);
                }
              });
            };
          }
        });
      }
    });
    var Nk = new Proxy((a, b) => {
      const c = GetCurrentResourceName();
      if (c == undefined) {
        throw new Error("Failed to get resource name, are you sure you are using this in a fivem resource?");
      } else if (typeof b !== "function") {
        throw new Error("Callback is not a function");
      } else if (typeof a !== "string") {
        throw new Error("Export name must be a string");
      }
      on(Lk(c, a), a => {
        a(b);
      });
    }, {
      apply: (a, b, c) => {
        a(...c);
      },
      get: (a, b) => {
        if (Kk[b] == undefined) {
          Kk[b] = {};
        }
        return new Proxy({}, {
          get: (a, c) => {
            const d = c + "_sync";
            if (Kk[b][d] === undefined) {
              emit(Lk(b, c), a => {
                Kk[b][d] = a;
              });
              if (Kk[b][d] === undefined) {
                if (GetResourceState(b) !== "started") {
                  throw new Error("Resource " + b + " is not running");
                } else {
                  throw new Error("No such export " + c + " in resource " + b);
                }
              }
            }
            return (...a) => {
              try {
                return Kk[b][d](...a);
              } catch (a) {
                throw new Error("An error occurred while calling export " + c + " of resource " + b + " - see above for details");
              }
            };
          }
        });
      }
    });
    on("onResourceStop", a => Kk[a] = undefined);
    var Ok = {
      Async: Mk,
      Sync: Nk
    };
    var Pk = Ok;
    var Qk = Ci(oj());
    var Rk;
    var Sk;
    var Tk;
    var Uk;
    var Vk;
    var Wk;
    var Xk;
    var Yk;
    var Zk;
    var $k;
    var _k;
    var al;
    var bl;
    var cl;
    var dl;
    var el;
    var fl;
    var gl;
    var hl;
    var il;
    var jl = class {
      constructor(a, b) {
        Fi(this, Vk);
        Fi(this, Xk);
        Fi(this, Zk);
        Fi(this, _k);
        Fi(this, bl);
        Fi(this, dl);
        Fi(this, fl);
        Fi(this, hl);
        Fi(this, Rk, undefined);
        Fi(this, Sk, undefined);
        Fi(this, Tk, undefined);
        Fi(this, Uk, {});
        const c = Ii(this, bl, cl).call(this, a);
        const d = Ii(this, fl, gl).call(this, c, b);
        const [e, f, g] = d.split(":").map(a => a.length > 0 ? a : undefined);
        Gi(this, Rk, e);
        Gi(this, Sk, f);
        Gi(this, Tk, g);
      }
      hashString(a) {
        var b;
        const c = Ei(this, Vk, Wk);
        const d = (b = Ei(this, Uk)[c]) == null ? undefined : b[a];
        if (d) {
          return d;
        }
        if (!Ei(this, Uk)[c]) {
          Ei(this, Uk)[c] = {};
        }
        const e = Ii(this, _k, al).call(this, (0, Qk.HmacMD5)(a, c).toString());
        Ei(this, Uk)[c][a] = e;
        if (IsDuplicityVersion()) {
          console.log("[SDK] Hash Debug | Event: " + a + " | Hash: " + e);
        }
        return e;
      }
      encode(a) {
        let b;
        const c = Ei(this, Zk, $k);
        try {
          b = Ii(this, dl, el).call(this, JSON.stringify(a), c);
        } catch (a) {
          console.error("Failed to encode payload");
        }
        return b;
      }
      decode(a) {
        let b;
        const c = Ei(this, Xk, Yk);
        try {
          b = JSON.parse(Ii(this, fl, gl).call(this, a, c));
        } catch (a) {
          console.error("Failed to decode payload");
        }
        return b;
      }
    };
    Rk = new WeakMap();
    Sk = new WeakMap();
    Tk = new WeakMap();
    Uk = new WeakMap();
    Vk = new WeakSet();
    Wk = function () {
      return Ei(this, Rk) ?? Ii(this, hl, il).call(this);
    };
    Xk = new WeakSet();
    Yk = function () {
      return Ei(this, Sk) ?? Ii(this, hl, il).call(this);
    };
    Zk = new WeakSet();
    $k = function () {
      return Ei(this, Tk) ?? Ii(this, hl, il).call(this);
    };
    _k = new WeakSet();
    al = function (a) {
      if (typeof a !== "string") {
        return "";
      }
      return Qk.enc.Base64.stringify(Qk.enc.Utf8.parse(a));
    };
    bl = new WeakSet();
    cl = function (a) {
      if (typeof a !== "string") {
        return "";
      }
      return Qk.enc.Utf8.stringify(Qk.enc.Base64.parse(a));
    };
    dl = new WeakSet();
    el = function (a, b) {
      if (typeof a !== "string" || typeof b !== "string") {
        return "";
      }
      return Qk.AES.encrypt(a, b).toString();
    };
    fl = new WeakSet();
    gl = function (a, b) {
      if (typeof a !== "string" || typeof b !== "string") {
        return "";
      }
      return Qk.AES.decrypt(a, b).toString(Qk.enc.Utf8);
    };
    hl = new WeakSet();
    il = function (a = 128) {
      return Qk.lib.WordArray.random(a / 8).toString();
    };
    var kl;
    var ll = class {
      constructor() {
        Fi(this, kl, undefined);
        const a = GetCurrentResourceName();
        const b = Ik.getStringHash("__npx_sdk:" + a + ":token");
        const c = GetConvar(b, "");
        Gi(this, kl, new jl(c, "0x3F13770"));
      }
      on(a, b) {
        const c = Ei(this, kl).hashString(a);
        return on(c, b);
      }
      onNet(a, b) {
        const c = Ei(this, kl).hashString(a);
        onNet(c, b);
        const d = Ei(this, kl).hashString(a + "-c");
        onNet(d, a => {
          const c = Ik.inflate(a);
          const d = msgpack_unpack(c);
          return b(...d);
        });
      }
      emit(a, ...b) {
        const c = Ei(this, kl).hashString(a);
        return emit(c, ...b);
      }
      emitNet(a, ...b) {
        let c = msgpack_pack(b);
        let d = c.length;
        const e = Ei(this, kl).hashString(a);
        if (d < 16000) {
          TriggerServerEventInternal(e, c, c.length);
        } else {
          TriggerLatentServerEventInternal(e, c, c.length, 128000);
        }
      }
    };
    kl = new WeakMap();
    var ml = new ll();
    var nl = {
      warning: 1,
      log: 2,
      error: 3,
      debug: 4
    };
    var ol = GetConvar(GetCurrentResourceName() + "_logLevel", "");
    var pl = GetConvar("sv_loglevel", "warning");
    (() => {
      pl = (ol == null ? undefined : ol.length) > 0 ? ol : pl;
      if (!nl[pl]) {
        throw new Error("Invalid log level: " + pl);
      }
    })();
    var ql = () => nl[pl] >= nl.warning;
    var rl = () => nl[pl] >= nl.log;
    var sl = () => nl[pl] >= nl.error;
    var tl = () => pl === "debug";
    var ul = {
      warning: (a, ...b) => {
        if (!ql()) {
          return;
        }
        console.log("^3[WARNING] ^7" + a, ...b, "^0");
      },
      log: (a, ...b) => {
        if (!rl()) {
          return;
        }
        console.log("^5[nopixel] ^7" + a, ...b, "^0");
      },
      debug: (a, ...b) => {
        if (!tl()) {
          return;
        }
        console.log("^2[D] " + a, ...b, "^0");
      },
      error: (a, ...b) => {
        if (!sl()) {
          return;
        }
        console.log("^1[ERROR] " + a, ...b, "^0");
      }
    };
    var vl;
    var wl;
    var xl;
    var yl;
    var zl;
    var Al;
    var Bl;
    var Cl;
    var Dl;
    var El;
    var Fl;
    var Gl = class {
      constructor() {
        Fi(this, Al);
        Fi(this, Cl);
        Fi(this, El);
        Fi(this, vl, undefined);
        Fi(this, wl, undefined);
        Fi(this, xl, undefined);
        Fi(this, yl, undefined);
        Fi(this, zl, undefined);
        Gi(this, vl, false);
        Gi(this, wl, new Map());
        Gi(this, xl, GetGameTimer());
        Gi(this, yl, GetCurrentResourceName());
        const a = Ik.getStringHash("__npx_sdk:" + Ei(this, yl) + ":token");
        const b = GetConvar(a, "");
        Gi(this, zl, new jl(b, "0x3F13770"));
        Ii(this, El, Fl).call(this);
      }
      register(a, b) {
        Ii(this, Al, Bl).call(this, "__rpc_req:" + a, async (c, d) => {
          let e;
          let f;
          const g = GetInvokingResource();
          if (g) {
            return;
          }
          const h = Ei(this, zl).decode(c);
          if (!(h == null ? undefined : h.id) || !(h == null ? undefined : h.origin)) {
            return ul.error("[RPC] " + a + " - Invalid metadata received");
          }
          try {
            e = await b(...d);
            f = true;
          } catch (a) {
            e = a.message;
            f = false;
          }
          Ii(this, Cl, Dl).call(this, "__rpc_res:" + h.origin, h.id, [f, e]);
        });
      }
      execute(a, ...b) {
        const c = {
          id: ++Hi(this, xl)._,
          origin: Ei(this, yl)
        };
        const d = new Promise((b, d) => {
          let e = setTimeout(() => d(new Error("RPC timed out | " + a)), 60000);
          var f = {
            resolve: b,
            reject: d,
            timeout: e
          };
          Ei(this, wl).set(c.id, f);
        });
        d.finally(() => Ei(this, wl).delete(c.id));
        Ii(this, Cl, Dl).call(this, "__rpc_req:" + a, Ei(this, zl).encode(c), b);
        return d;
      }
      executeCustom(a, b, ...c) {
        const d = {
          id: ++Hi(this, xl)._,
          origin: Ei(this, yl)
        };
        const e = new Promise((c, e) => {
          let f = setTimeout(() => e(new Error("RPC timed out | " + a)), b.timeout ?? 60000);
          var g = {
            resolve: c,
            reject: e,
            timeout: f
          };
          Ei(this, wl).set(d.id, g);
        });
        e.finally(() => Ei(this, wl).delete(d.id));
        Ii(this, Cl, Dl).call(this, "__rpc_req:" + a, Ei(this, zl).encode(d), c);
        return e;
      }
    };
    vl = new WeakMap();
    wl = new WeakMap();
    xl = new WeakMap();
    yl = new WeakMap();
    zl = new WeakMap();
    Al = new WeakSet();
    Bl = function (a, b) {
      const c = Ei(this, zl).hashString(a);
      onNet(c, b);
      const d = Ei(this, zl).hashString(a + "-c");
      onNet(d, a => {
        const c = Ik.inflate(a);
        const d = msgpack_unpack(c);
        return b(...d);
      });
    };
    Cl = new WeakSet();
    Dl = function (a, ...b) {
      let c = msgpack_pack(b);
      let d = c.length;
      const e = Ei(this, zl).hashString(a);
      if (d < 16000) {
        TriggerServerEventInternal(e, c, c.length);
      } else {
        TriggerLatentServerEventInternal(e, c, c.length, 128000);
      }
    };
    El = new WeakSet();
    Fl = function () {
      if (Ei(this, vl)) {
        return ul.error("SDK RPC handlers already initialized");
      }
      Ii(this, Al, Bl).call(this, "__rpc_res:" + Ei(this, yl), (a, [b, c]) => {
        const d = Ei(this, wl).get(a);
        if (!d) {
          return;
        }
        clearTimeout(d.timeout);
        if (b) {
          d.resolve(c);
        } else {
          d.reject(new Error(c));
        }
      });
      Gi(this, vl, true);
      ul.debug("SDK RPC handlers initialized");
    };
    var Hl = new Gl();
    var Il = Ci(oj());
    var Jl = (a = 128) => {
      return Il.lib.WordArray.random(a / 8).toString();
    };
    var Kl = (a, b) => {
      if (typeof a !== "string" || typeof b !== "string") {
        return "";
      }
      return Il.AES.encrypt(a, b).toString();
    };
    var Ll = (a, b) => {
      if (typeof a !== "string" || typeof b !== "string") {
        return "";
      }
      return Il.AES.decrypt(a, b).toString(Il.enc.Utf8);
    };
    var Ml = a => {
      if (typeof a !== "string") {
        return "";
      }
      return Il.enc.Base64.stringify(Il.enc.Utf8.parse(a));
    };
    var Nl = (a, b) => {
      return Ml((0, Il.HmacMD5)(a, b).toString());
    };
    var Ol = {};
    var Pl = (a, b = undefined) => {
      if (b === undefined) b = Jl();
      if (Ol[a] === undefined) {
        Ol[a] = Nl(a, b);
      }
      return Ol[a];
    };
    var Ql = (a, b = undefined) => {
      if (b === undefined) b = Jl();
      try {
        return Kl(JSON.stringify(a), b);
      } catch (a) {
        console.error("Failed to encode payload");
      }
    };
    var Rl = (a, b = undefined) => {
      if (b === undefined) b = Jl();
      try {
        return JSON.parse(Ll(a, b));
      } catch (a) {
        console.error("Failed to decode payload");
      }
    };
    var Sl;
    var Tl;
    var Ul;
    var Vl;
    var Wl;
    var Xl;
    var Yl;
    var Zl;
    var $l;
    var _l;
    var am;
    var bm;
    var cm;
    var dm;
    var em;
    var fm;
    var gm;
    var hm;
    var im = class {
      constructor() {
        Fi(this, $l);
        Fi(this, am);
        Fi(this, cm);
        Fi(this, em);
        Fi(this, gm);
        Fi(this, Sl, undefined);
        Fi(this, Tl, undefined);
        Fi(this, Ul, undefined);
        Fi(this, Vl, undefined);
        Fi(this, Wl, undefined);
        Fi(this, Xl, undefined);
        Fi(this, Yl, undefined);
        Fi(this, Zl, undefined);
        Gi(this, Sl, GetCurrentResourceName());
        Gi(this, Tl, Jl(64));
        Gi(this, Ul, Jl(64));
        Gi(this, Vl, Jl(64));
        Gi(this, Wl, false);
        Gi(this, Xl, 0);
        Gi(this, Yl, []);
        Gi(this, Zl, new Map());
        Ii(this, $l, _l).call(this, "__npx_sdk:init", Ii(this, gm, hm).bind(this));
      }
      async register(a, b) {
        Ii(this, am, bm).call(this, "__nui_req:" + a, async (c, d) => {
          let e;
          let f;
          const g = Rl(c, Ei(this, Ul));
          if (!(g == null ? undefined : g.id) || !(g == null ? undefined : g.resource)) {
            return ul.error("[NUI] " + a + " - Invalid metadata received");
          }
          try {
            e = await b(...d);
            f = true;
          } catch (a) {
            e = a.message;
            f = false;
          }
          Ii(this, em, fm).call(this, "__nui_res:" + g.resource, g.id, [f, e]);
        });
      }
      remove(a) {
        const b = Pl("__nui_req:" + a, Ei(this, Tl));
        UnregisterRawNuiCallback(b);
      }
      async execute(a, ...b) {
        const c = {
          id: ++Hi(this, Xl)._,
          resource: Ei(this, Sl)
        };
        const d = new Promise((b, d) => {
          let e;
          if (Ei(this, Wl)) {
            e = setTimeout(() => d(new Error("RPC timed out | " + a)), 60000);
          } else {
            e = 0;
          }
          var f = {
            resolve: b,
            reject: d,
            timeout: e
          };
          Ei(this, Zl).set(c.id, f);
        });
        d.finally(() => Ei(this, Zl).delete(c.id));
        if (!Ei(this, Wl)) {
          var e = {
            type: "execute",
            event: "__nui_req:" + a,
            metadata: c,
            args: b
          };
          Ei(this, Yl).push(e);
        } else {
          Ii(this, em, fm).call(this, "__nui_req:" + a, Ql(c, Ei(this, Vl)), b);
        }
        return d;
      }
    };
    Sl = new WeakMap();
    Tl = new WeakMap();
    Ul = new WeakMap();
    Vl = new WeakMap();
    Wl = new WeakMap();
    Xl = new WeakMap();
    Yl = new WeakMap();
    Zl = new WeakMap();
    $l = new WeakSet();
    _l = function (a, b) {
      RegisterNuiCallback(a, ({
        args: a
      }, c) => {
        c(true);
        return b(...a);
      });
    };
    am = new WeakSet();
    bm = function (a, b) {
      if (Ei(this, Wl)) {
        const c = Pl(a, Ei(this, Tl));
        return Ii(this, $l, _l).call(this, c, b);
      }
      var c = {
        type: "on",
        event: a,
        callback: b
      };
      Ei(this, Yl).push(c);
    };
    cm = new WeakSet();
    dm = function (a, ...b) {
      var c = {
        event: a,
        args: b
      };
      SendNuiMessage(JSON.stringify(c, null));
    };
    em = new WeakSet();
    fm = function (a, ...b) {
      if (Ei(this, Wl)) {
        const c = Pl(a, Ei(this, Tl));
        return Ii(this, cm, dm).call(this, c, ...b);
      }
      var c = {
        type: "emit",
        event: a,
        args: b
      };
      Ei(this, Yl).push(c);
    };
    gm = new WeakSet();
    hm = async function () {
      if (Ei(this, Wl)) {
        return ul.error("[NUI] SDK already initialized");
      }
      Gi(this, Wl, true);
      Ii(this, am, bm).call(this, "__nui_res:" + Ei(this, Sl), (a, [b, c]) => {
        const d = Ei(this, Zl).get(a);
        if (!d) {
          return ul.error("[NUI] Invalid response received");
        }
        clearTimeout(d.timeout);
        if (b) {
          d.resolve(c);
        } else {
          d.reject(c);
        }
      });
      Ii(this, cm, dm).call(this, "__npx_sdk:ready", Ml(Ei(this, Tl) + ":" + Ei(this, Ul) + ":" + Ei(this, Vl)));
      ul.debug("[NUI] SDK initialized");
      for (const a of Ei(this, Yl)) {
        if (a.type === "on") {
          Ii(this, am, bm).call(this, a.event, a.callback);
        } else if (a.type === "emit") {
          setTimeout(() => Ii(this, em, fm).call(this, a.event, ...a.args), 1000);
        } else if (a.type === "execute") {
          const b = Ei(this, Zl).get(a.metadata.id);
          if (!b) {
            ul.error("[RPC] " + a.event + " - Failed to execute queued RPC call");
            continue;
          }
          b.timeout = setTimeout(() => b.reject(new Error("RPC timed out | " + a.event)), 60000);
          setTimeout(() => Ii(this, em, fm).call(this, a.event, Ql(a.metadata, Ei(this, Vl)), a.args), 1000);
        }
      }
    };
    var jm;
    var km;
    var lm;
    var mm = class {
      constructor(a) {
        Fi(this, jm, undefined);
        Fi(this, km, undefined);
        Fi(this, lm, new Map());
        Gi(this, jm, a);
        Gi(this, km, false);
        const b = GetCurrentResourceName();
        on("onResourceStop", a => {
          if (a === b) {
            for (const [a, b] of Ei(this, lm).entries()) {
              Pk.Sync[Ei(this, jm)].removeNuiEvent(a);
            }
          }
        });
        on("onResourceStart", async a => {
          if (a === Ei(this, jm)) {
            await Ik.waitForCondition(() => GetResourceState(Ei(this, jm)) === "started", 10000);
            if (Ei(this, km)) {
              for (const [a, b] of Ei(this, lm).entries()) {
                Pk.Sync[Ei(this, jm)].removeNuiEvent(a);
                this.register(a, b);
              }
            }
            Gi(this, km, true);
          }
          if (a === b) {
            await Ik.waitForCondition(() => GetResourceState(Ei(this, jm)) === "started", 10000);
            Gi(this, km, true);
          }
        });
      }
      async execute(a, ...b) {
        return await Pk.Async[Ei(this, jm)].sendNuiEvent(a, b);
      }
      async register(a, b) {
        await Ik.waitForCondition(() => Ei(this, km), 10000);
        const c = Pk.Sync[Ei(this, jm)].registerNuiEvent(a, b);
        if (c) {
          Ei(this, lm).set(a, b);
        }
      }
    };
    jm = new WeakMap();
    km = new WeakMap();
    lm = new WeakMap();
    var nm = class {
      constructor() {
        const a = async (a, b) => {
          return await qm.execute(a, ...b);
        };
        Pk.Async("sendNuiEvent", a);
        const b = (a, b) => {
          qm.register(a, b);
          return true;
        };
        Pk.Sync("registerNuiEvent", b);
        const c = a => {
          qm.remove(a);
        };
        Pk.Sync("removeNuiEvent", c);
      }
    };
    var om = null && mm;
    var pm = null && nm;
    var qm = new im();
    var rm;
    var sm;
    var tm;
    var um = class {
      constructor() {
        Fi(this, rm, undefined);
        Fi(this, sm, undefined);
        Fi(this, tm, undefined);
        Gi(this, tm, false);
        qm.register("__npx_sdk:sockets:init", async () => {
          ul.debug("Sockets", "Initializing sockets...");
          if (Ei(this, tm)) {
            return {
              url: Ei(this, rm),
              API_KEY: Ei(this, sm)
            };
          }
          const a = await new Promise(a => {
            emit("__npx_core:sockets:init", a);
          });
          if (!(a == null ? undefined : a.API_URL) || !(a == null ? undefined : a.API_KEY)) {
            return;
          }
          Gi(this, rm, a.API_URL);
          Gi(this, sm, a.API_KEY);
          Gi(this, tm, true);
          ul.debug("Sockets", "Sockets initialized.");
          return a;
        });
      }
      register(a, b) {
        qm.execute("__npx_sdk:sockets:register", a);
        qm.register("__npx_sdk:sockets:pipe:" + a, async a => {
          return b(a);
        });
      }
      async execute(a, b) {
        return qm.execute("__npx_sdk:sockets:execute", a, b);
      }
    };
    rm = new WeakMap();
    sm = new WeakMap();
    tm = new WeakMap();
    var vm = new um();
    var wm = {
      HasItem: async (a, b) => {
        return await globalThis.exports.inventory.HasItem(a, b);
      },
      GetItemStacks: async (a, b) => {
        return await globalThis.exports.inventory.GetItemStacks(a, b);
      },
      GetAllItemStacks: async a => {
        return await globalThis.exports.inventory.GetAllItemStacks(a);
      },
      GetItemList: async () => {
        return await globalThis.exports.inventory.GetItemList();
      },
      GetPlayerInventories: async () => {
        return await globalThis.exports.inventory.GetPlayerInventories();
      },
      GetWeaponsList: () => {
        return globalThis.exports.inventory.GetWeaponsList();
      },
      GetWeapon: a => {
        return globalThis.exports.inventory.GetWeapon(a);
      },
      OpenInventory: (a, b) => {
        globalThis.exports.inventory.OpenInventory(a, b);
      },
      UseBodySlot: a => {
        return Pk.Async.inventory.UseBodySlot(a);
      },
      SetBodySlotDisabled: (a, b, c) => {
        Pk.Sync.inventory.SetBodySlotDisabled(a, b, c);
      },
      IsBodySlotDisabled: (a, b) => {
        return Pk.Sync.inventory.IsBodySlotDisabled(a, b);
      }
    };
    var xm = {};
    var ym = {
      Cache: () => yj,
      PolyZone: () => mk,
      Thread: () => zm,
      Vector2: () => qk,
      Vector3: () => vj
    };
    Ai(xm, ym);
    var zm = class {
      constructor(a, b, c = "interval") {
        this.callback = a;
        this.delay = b;
        this.mode = c;
        this.scheduled = {};
        this.tick = 0;
        this.data = {};
        this.active = false;
        this.aborted = false;
        this.hooks = new Map([["active", []], ["preStop", []], ["preStart", []], ["afterStop", []], ["afterStart", []], ["stopAborted", []], ["startAborted", []]]);
      }
      get isActive() {
        return this.active;
      }
      async start() {
        if (this.active) {
          return;
        }
        this.aborted = false;
        this.scheduled = {};
        const a = this.hooks.get("preStart") ?? [];
        try {
          for (const b of a) {
            if (!this.aborted) {
              await b.call(this);
            }
          }
        } catch (a) {
          this.aborted = true;
          console.log("Error while calling pre-start hook", a.message);
        }
        if (this.aborted) {
          try {
            const a = this.hooks.get("startAborted") ?? [];
            for (const b of a) {
              await b.call(this);
            }
          } catch (a) {
            console.log("Error while calling start-aborted hook", a.message);
          }
          return;
        }
        this.active = true;
        const b = this.hooks.get("active") ?? [];
        switch (this.mode) {
          case "tick":
            {
              this.threadId = setTick(async () => {
                this.tick += 1;
                try {
                  await this.callback.call(this);
                  for (const a of b) {
                    await a.call(this);
                  }
                } catch (a) {
                  console.log("Error while calling active hook", a.message);
                }
                if (this.delay > 0) {
                  await new Promise(a => setTimeout(a, this.delay));
                }
              });
              break;
            }
          case "interval":
            {
              this.threadId = setInterval(async () => {
                this.tick += 1;
                try {
                  await this.callback.call(this);
                  for (const a of b) {
                    await a.call(this);
                  }
                } catch (a) {
                  console.log("Error while calling active hook", a.message);
                }
              }, this.delay);
              break;
            }
          case "timeout":
            {
              const a = () => {
                if (this.active) {
                  this.threadId = setTimeout(async () => {
                    this.tick += 1;
                    try {
                      await this.callback.call(this);
                      for (const a of b) {
                        await a.call(this);
                      }
                    } catch (a) {
                      console.log("Error while calling active hook", a.message);
                    }
                    return a();
                  }, this.delay);
                }
              };
              a();
              break;
            }
        }
        const c = this.hooks.get("afterStart") ?? [];
        try {
          for (const a of c) {
            await a.call(this);
          }
        } catch (a) {
          console.log("Error while calling after-start hook", a.message);
        }
      }
      async stop() {
        if (!this.active) {
          return;
        }
        const a = this.hooks.get("preStop") ?? [];
        try {
          for (const b of a) {
            if (!this.aborted) {
              await b.call(this);
            }
          }
        } catch (a) {
          this.aborted = true;
          console.log("Error while calling pre-stop hook", a.message);
        }
        this.active = false;
        switch (this.mode) {
          case "tick":
            {
              clearTick(this.threadId);
              break;
            }
          case "interval":
            {
              clearInterval(this.threadId);
              break;
            }
          case "timeout":
            {
              clearTimeout(this.threadId);
              break;
            }
        }
        if (this.aborted) {
          try {
            const a = this.hooks.get("stopAborted") ?? [];
            for (const b of a) {
              await b.call(this);
            }
          } catch (a) {
            console.log("Error while calling stop-aborted hook", a.message);
          }
          return;
        }
        const b = this.hooks.get("afterStop") ?? [];
        try {
          for (const a of b) {
            await a.call(this);
          }
        } catch (a) {
          console.log("Error while calling after-stop hook", a.message);
        }
      }
      abort() {
        this.aborted = true;
      }
      addHook(a, b) {
        var c;
        if ((c = this.hooks.get(a)) == null) {
          undefined;
        } else {
          c.push(b);
        }
      }
      setNextTick(a, b) {
        this.scheduled[a] = this.tick + b;
      }
      canTick(a) {
        return this.scheduled[a] === undefined || this.tick >= this.scheduled[a];
      }
    };
    var Am = {};
    var Bm = {
      GetEntityStateValue: () => Em,
      GetPlayerStateValue: () => Hm,
      RegisterStatebagChangeHandler: () => Jm,
      SetEntityStateValue: () => Fm,
      SetPlayerStateValue: () => Im
    };
    Ai(Am, Bm);
    var Cm = new yj(5000);
    function Dm(a) {
      let b = Cm.get("ent-" + a + "}");
      if (b) {
        return b;
      }
      b = Entity(a);
      Cm.set("ent-" + a + "}", b);
      return b;
    }
    function Em(a, b) {
      const c = Dm(a);
      return c.state[b];
    }
    function Fm(a, b, c, d = false) {
      const e = Dm(a);
      e.state.set(b, c, d);
    }
    function Gm(a) {
      let b = Cm.get("ply-" + a + "}");
      if (b) {
        return b;
      }
      b = Player(a);
      Cm.set("ply-" + a + "}", b);
      return b;
    }
    function Hm(a, b) {
      const c = Gm(a);
      return c.state[b];
    }
    function Im(a, b, c, d = false) {
      const e = Gm(a);
      e.state.set(b, c, d);
    }
    function Jm(a, b, c, d) {
      return AddStateBagChangeHandler(a, null, async function (a, e, f, g, h) {
        if (c && !h) {
          return;
        }
        const i = a.startsWith("player");
        const j = parseInt(a.substring(7));
        const k = i ? GetPlayerFromStateBagName(a) : GetEntityFromStateBagName(a);
        if (!k) {
          return;
        }
        const l = i ? NetworkGetPlayerIndexFromPed(k) === PlayerId() : NetworkGetEntityOwner(k) === PlayerId();
        if (b && !l) {
          return;
        }
        d(j, k, f);
      });
    }
    var Km = {};
    var Lm = {
      GetFuelLevel: () => Tm,
      GetIdentifier: () => Qm,
      GetMetadata: () => Pm,
      HasKey: () => Om,
      IsVinScratched: () => Rm,
      SwapSeat: () => Sm,
      TurnOffEngine: () => Nm,
      TurnOnEngine: () => Mm
    };
    Ai(Km, Lm);
    function Mm(a) {
      Pk.Sync["np-vehicles"].TurnOnEngine(a);
    }
    function Nm(a) {
      Pk.Sync["np-vehicles"].TurnOffEngine(a);
    }
    function Om(a) {
      return Pk.Sync["np-vehicles"].HasVehicleKey(a);
    }
    function Pm(a, b) {
      const c = Em(a, "data");
      if (b) {
        if (c == null) {
          return undefined;
        } else {
          return c[b];
        }
      } else {
        return c;
      }
    }
    function Qm(a) {
      return Em(a, "vin");
    }
    function Rm(a) {
      return Em(a, "vinScratched");
    }
    function Sm(a, b) {
      Pk.Sync["np-vehicles"].SwapVehicleSeat(a, b);
    }
    function Tm(a) {
      return Pm(a, "fuel") ?? 0;
    }
    var Um = async a => {
      const b = typeof a === "number" ? a : GetHashKey(a);
      if (HasModelLoaded(b)) {
        return true;
      }
      RequestModel(b);
      const c = await Ik.waitForCondition(() => HasModelLoaded(b), 3000);
      return !c;
    };
    var Vm = async a => {
      if (HasAnimDictLoaded(a)) {
        return true;
      }
      RequestAnimDict(a);
      const b = await Ik.waitForCondition(() => HasAnimDictLoaded(a), 3000);
      return !b;
    };
    var Wm = async a => {
      if (HasClipSetLoaded(a)) {
        return true;
      }
      RequestClipSet(a);
      const b = await Ik.waitForCondition(() => HasClipSetLoaded(a), 3000);
      return !b;
    };
    var Xm = async a => {
      if (HasStreamedTextureDictLoaded(a)) {
        return true;
      }
      RequestStreamedTextureDict(a, true);
      const b = await Ik.waitForCondition(() => HasStreamedTextureDictLoaded(a), 3000);
      return !b;
    };
    var Ym = async (a, b, c) => {
      const d = typeof a === "number" ? a : GetHashKey(a);
      if (HasWeaponAssetLoaded(d)) {
        return true;
      }
      RequestWeaponAsset(d, b, c);
      const e = await Ik.waitForCondition(() => HasWeaponAssetLoaded(d), 3000);
      return !e;
    };
    var Zm = async a => {
      if (HasNamedPtfxAssetLoaded(a)) {
        return true;
      }
      RequestNamedPtfxAsset(a);
      const b = await Ik.waitForCondition(() => HasNamedPtfxAssetLoaded(a), 3000);
      return !b;
    };
    var $m = {
      loadModel: Um,
      loadTexture: Xm,
      loadAnim: Vm,
      loadClipSet: Wm,
      loadWeaponAsset: Ym,
      loadNamedPtfxAsset: Zm
    };
    var _m = $m;
    var an = (a, ...b) => {
      switch (a) {
        case "coord":
          {
            const [a, c, d] = b;
            return AddBlipForCoord(a, c, d);
          }
        case "area":
          {
            const [a, c, d, e, f] = b;
            return AddBlipForArea(a, c, d, e, f);
          }
        case "radius":
          {
            const [a, c, d, e] = b;
            return AddBlipForRadius(a, c, d, e);
          }
        case "pickup":
          {
            const [a] = b;
            return AddBlipForPickup(a);
          }
        case "entity":
          {
            const [a] = b;
            return AddBlipForEntity(a);
          }
        default:
          {
            console.error(new Error("Invalid Blip Type"));
            return 0;
          }
      }
    };
    var bn = (a, b, c, d, e, f, g, h) => {
      if (typeof c === "number") {
        SetBlipSprite(a, c);
      }
      if (typeof d === "number") {
        SetBlipColour(a, d);
      }
      if (typeof e === "number") {
        SetBlipAlpha(a, e);
      }
      if (typeof f === "number") {
        SetBlipScale(a, f);
      }
      if (typeof g === "boolean") {
        SetBlipRoute(a, g);
      }
      if (typeof h === "boolean") {
        SetBlipAsShortRange(a, h);
      }
      if (typeof b === "string") {
        BeginTextCommandSetBlipName("STRING");
        AddTextComponentString(b);
        EndTextCommandSetBlipName(a);
      }
    };
    var cn = {
      createBlip: an,
      applyBlipSettings: bn
    };
    var dn = cn;
    var en = new Set();
    var fn = new Map();
    var gn = new Set();
    var hn = (a, b) => {
      return en.has(b ? a + "-" + b : a);
    };
    var jn = (a, b) => {
      const c = a + "-enter";
      const d = fn.get(c) ?? [];
      if (!fn.has(c)) {
        fn.set(c, d);
      }
      d.push(b);
    };
    var kn = (a, b) => {
      const c = a + "-exit";
      const d = fn.get(c) ?? [];
      if (!fn.has(c)) {
        fn.set(c, d);
      }
      d.push(b);
    };
    var ln = (a, b, c, d, e = undefined) => {
      if (e === undefined) e = {};
      var f = {
        ...d
      };
      f.data = e;
      f.id = a;
      const g = f;
      g.data.id = a;
      exports["qb-polyzone"].AddPolyZone(b, c, g);
    };
    var mn = (a, b, c, d, e, f, g = undefined) => {
      if (g === undefined) g = {};
      var h = {
        ...f
      };
      h.data = g;
      h.id = a;
      const i = h;
      i.data.id = a;
      exports["qb-polyzone"].AddBoxZone(b, c, d, e, i);
    };
    var nn = (a, b, c, d, e, f, g = undefined) => {
      if (g === undefined) g = {};
      var h = {
        ...f
      };
      h.data = g;
      h.id = a;
      const i = h;
      i.data.id = a;
      exports["np-polytarget"].AddBoxZone(b, c, d, e, i);
    };
    var pn = (a, b, c, d, e, f = undefined) => {
      if (f === undefined) f = {};
      var g = {
        ...e
      };
      g.data = f;
      g.id = a;
      const h = g;
      h.data.id = a;
      exports["qb-polyzone"].AddCircleZone(b, c, d, h);
    };
    var qn = (a, b, c, d, e, f = undefined) => {
      if (f === undefined) f = {};
      var g = {
        ...e
      };
      g.data = f;
      g.id = a;
      const h = g;
      h.data.id = a;
      exports["np-polytarget"].AddCircleZone(b, c, d, h);
    };
    var rn = (a, b, c, d, e = undefined) => {
      if (e === undefined) e = {};
      var f = {
        ...d
      };
      f.data = e;
      const g = f;
      g.data.id = a;
      exports["qb-polyzone"].AddEntityZone(b, c, g);
    };
    var sn = (a, b) => {
      exports["qb-polyzone"].RemoveZone(a, b);
      en.delete(a + "-" + b);
      gn.delete(a);
    };
    var tn = a => {
      gn.add(a);
    };
    var un = {
      isActive: hn,
      onEnter: jn,
      onExit: kn,
      addPolyZone: ln,
      addBoxZone: mn,
      addBoxTarget: nn,
      addCircleZone: pn,
      addCircleTarget: qn,
      addEntityZone: rn,
      removeZone: sn,
      setAsNetworked: tn
    };
    var vn = un;
    var wn = (a, b, c) => {
      globalThis.exports["np-interact"].AddPeekEntryByModel(a, b, c);
    };
    var xn = (a, b, c) => {
      globalThis.exports["np-interact"].AddPeekEntryByPolyTarget(a, b, c);
    };
    var yn = (a, b, c) => {
      globalThis.exports["np-interact"].AddPeekEntryByFlag(a, b, c);
    };
    var zn = (a, b, c) => {
      globalThis.exports["np-interact"].AddPeekEntryByEntityType(a, b, c);
    };
    var An = (a, b, c, d) => {
      var e = {
        id: a,
        coords: [b.x, b.y, b.z],
        options: c,
        context: d
      };
      const f = e;
      globalThis.exports.interactions.AddInteraction(f);
    };
    var Bn = (a, b, c, d) => {
      var e = {
        id: a,
        options: c,
        context: d
      };
      const f = e;
      globalThis.exports.interactions.AddInteractionByModel(b, f);
    };
    var Cn = (a, b, c) => {
      var d = {
        id: a,
        options: b,
        context: c
      };
      const e = d;
      e.context.isPlayer = true;
      globalThis.exports.interactions.AddPedInteraction(e);
    };
    var Dn = (a, b, c) => {
      var d = {
        id: a,
        options: b,
        context: c
      };
      const e = d;
      globalThis.exports.interactions.AddPedInteraction(e);
    };
    var En = (a, b, c) => {
      var d = {
        id: a,
        options: b,
        context: c
      };
      const e = d;
      globalThis.exports.interactions.AddVehicleInteraction(e);
    };
    var Fn = a => {
      globalThis.exports.interactions.RemoveInteraction(a);
    };
    var Gn = a => {
      globalThis.exports.interactions.RemoveVehicleInteraction(a);
    };
    var Hn = a => {
      globalThis.exports.interactions.RemovePedInteraction(a);
    };
    var In = (a, b, c = false, d = null, e = true, f = null) => {
      return new Promise(g => {
        globalThis.exports["np-taskbar"].taskBar(a, b, c, e, f, false, g, d == null ? undefined : d.distance, d == null ? undefined : d.entity);
      });
    };
    var Jn = (a, b, c, d) => {
      return new Promise(e => {
        globalThis.exports["np-phone"].DoPhoneConfirmation(a, b, c, e, d);
      });
    };
    var Kn = (a, b, c = true, d = "home-screen") => {
      var e = {
        action: "notification",
        target_app: d,
        title: a,
        body: b,
        show_even_if_app_active: c
      };
      var f = {
        source: "np-nui",
        app: "phone",
        data: e
      };
      globalThis.exports["np-ui"].SendUIMessage(f);
    };
    var Ln = (a, b, c, d, e, f, g = 0, h = true) => {
      SetTextColour(d[0], d[1], d[2], d[3]);
      if (h) {
        SetTextOutline();
      }
      SetTextScale(0, e);
      SetTextFont(f ?? 0);
      SetTextJustification(g);
      if (g === 2) {
        SetTextWrap(0, 0.575);
      }
      SetTextEntry("STRING");
      AddTextComponentString(c ?? "Dummy text");
      EndTextCommandDisplayText(a, b);
    };
    var Mn = (a, b, c, d, e = 4, f = true, g) => {
      SetDrawOrigin(a.x, a.y, a.z, 0);
      const h = Math.max(zk.getMapRange([0, 10], [0.4, 0.25], b), 0.1);
      Ln(0, 0, c, d, h, e, 0, f);
      if (g) {
        DrawRect(0.002, g.height / 2, g.width, g.height, g.color[0], g.color[1], g.color[2], g.color[3]);
      }
      ClearDrawOrigin();
    };
    var Nn = (a, b, c, d) => {
      globalThis.exports.contacts.open(a, b, c, d, true);
    };
    var On = {
      addPeekEntryByModel: wn,
      addPeekEntryByTarget: xn,
      addPeekEntryByFlag: yn,
      addPeekEntryByType: zn,
      addInteraction: An,
      addInteractionByModel: Bn,
      addPlayerInteraction: Cn,
      addPedInteraction: Dn,
      addVehicleInteraction: En,
      removeInteraction: Fn,
      removePlayerInteraction: Hn,
      removePedInteraction: Hn,
      removeVehicleInteraction: Gn,
      taskBar: In,
      phoneConfirmation: Jn,
      phoneNotification: Kn,
      drawText: Ln,
      drawText3D: Mn,
      customContact: Nn
    };
    var Pn = On;
    var Qn = async a => {
      return globalThis.exports["np-heists"].BankMinigame(a);
    };
    var Rn = async a => {
      return globalThis.exports["np-heists"].DDRMinigame(a);
    };
    var Sn = async a => {
      return globalThis.exports.skillchecks.DirectionMinigame(a);
    };
    var Tn = async () => {
      return globalThis.exports.skillchecks.DrillingMinigame();
    };
    var Un = async a => {
      return globalThis.exports.skillchecks.FlipMinigame(a);
    };
    var Vn = async a => {
      return globalThis.exports.skillchecks.FloodMinigame(a);
    };
    var Wn = async a => {
      return globalThis.exports.skillchecks.TaskBarMinigame(a.difficulty, a.gap, a.iterations, a.useReverse);
    };
    var Xn = async a => {
      return globalThis.exports["np-heists"].MazeMinigame(a);
    };
    var Yn = async a => {
      return globalThis.exports.skillchecks.CrackSafe(a.locks);
    };
    var Zn = async a => {
      return globalThis.exports.skillchecks.SameMinigame(a);
    };
    var $n = async a => {
      return globalThis.exports["np-heists"].ThermiteMinigame(a);
    };
    var _n = async a => {
      return globalThis.exports.skillchecks.UntangleMinigame(a);
    };
    var ao = async a => {
      return globalThis.exports["np-heists"].VarMinigame(a);
    };
    var bo = async a => {
      return globalThis.exports.skillchecks.WordsMinigame(a);
    };
    var co = async a => {
      return globalThis.exports.skillchecks.AlphabetMinigame(a);
    };
    var eo = async a => {
      return globalThis.exports.skillchecks.LockpickMinigame(a);
    };
    var fo = {
      BankMinigame: Qn,
      DDRMinigame: Rn,
      DirectionMinigame: Sn,
      DrillingMinigame: Tn,
      FlipMinigame: Un,
      FloodMinigame: Vn,
      TaskBarMinigame: Wn,
      MazeMinigame: Xn,
      CrackSafe: Yn,
      SameMinigame: Zn,
      ThermiteMinigame: $n,
      UntangleMinigame: _n,
      VarMinigame: ao,
      WordsMinigame: bo,
      AlphabetMinigame: co,
      LockpickMinigame: eo
    };
    var go = fo;
    var ho = {
      async hasPermission(a, b = undefined) {
        if (b === undefined) b = {};
        return await exports.permissions.hasPermission(a, b);
      },
      async getUserPermissions() {
        return await exports.permissions.getUserPermissions();
      },
      async getCharPermissions(a) {
        return await exports.permissions.getCharPermissions();
      },
      async getTotalPermissions() {
        return await exports.permissions.getTotalPermissions();
      }
    };
    var io = {
      RegisterAction: (a, b, c) => {
        return Pk.Sync.contacts.RegisterAction(a, b, c);
      }
    };
    var jo = {
      RegisterEditorHandlerClient: async a => {
        return await globalThis.exports.editor.RegisterEditorHandlerClient(a);
      }
    };
    var ko;
    var lo;
    var mo;
    var no;
    var oo;
    var po;
    var qo;
    var ro;
    var so;
    var to;
    var uo = class {
      constructor(a) {
        Fi(this, so);
        Fi(this, ko, undefined);
        Fi(this, lo, undefined);
        Fi(this, mo, undefined);
        Fi(this, no, undefined);
        Fi(this, oo, undefined);
        Fi(this, po, undefined);
        Fi(this, qo, false);
        Fi(this, ro, []);
        const b = li.parse(a);
        Gi(this, ko, b.codename);
        Gi(this, lo, b.version);
        Gi(this, mo, GetCurrentResourceName());
        Gi(this, no, "nopixel-outfits");
        emit("__npx_core:handshake", b, Ii(this, so, to).bind(this));
        qm.register("__npx_core:handshake", async a => {
          if (a.codename !== Ei(this, ko)) {
            return;
          }
          const b = await Ik.waitForCondition(() => Ei(this, qo), 10000);
          if (b) {
            return;
          }
          return {
            API_URL: Ei(this, oo),
            API_KEY: Ei(this, po)
          };
        });
      }
      get codename() {
        return Ei(this, ko);
      }
      get version() {
        return Ei(this, lo);
      }
      get isReady() {
        return Ei(this, qo);
      }
      onReady(a) {
        if (Ei(this, qo)) {
          a();
        } else {
          Ei(this, ro).push(a);
        }
      }
    };
    ko = new WeakMap();
    lo = new WeakMap();
    mo = new WeakMap();
    no = new WeakMap();
    oo = new WeakMap();
    po = new WeakMap();
    qo = new WeakMap();
    ro = new WeakMap();
    so = new WeakSet();
    to = async function (a) {
      Gi(this, oo, a.API_URL);
      Gi(this, po, a.API_KEY);
      Gi(this, qo, true);
      for (const b of Ei(this, ro)) {
        b();
      }
    };
    /*! Bundled license information:
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
    ;
    function vo(a, b, c, d, e, f, g) {
      try {
        var h = a[f](g);
        var i = h.value;
      } catch (a) {
        c(a);
        return;
      }
      if (h.done) {
        b(i);
      } else {
        Promise.resolve(i).then(d, e);
      }
    }
    function wo(a) {
      return function () {
        var b = this;
        var c = arguments;
        return new Promise(function (d, e) {
          var f = a.apply(b, c);
          function g(a) {
            vo(f, d, e, g, h, "next", a);
          }
          function h(a) {
            vo(f, d, e, g, h, "throw", a);
          }
          g(undefined);
        });
      };
    }
    function xo(a, b) {
      if (!(a instanceof b)) {
        throw new TypeError("Cannot call a class as a function");
      }
    }
    function yo(a, b) {
      for (var c = 0; c < b.length; c++) {
        var d = b[c];
        d.enumerable = d.enumerable || false;
        d.configurable = true;
        if ("value" in d) {
          d.writable = true;
        }
        Object.defineProperty(a, d.key, d);
      }
    }
    function zo(a, b, c) {
      if (b) {
        yo(a.prototype, b);
      }
      if (c) {
        yo(a, c);
      }
      return a;
    }
    function Ao(a, b) {
      var c;
      var d;
      var e;
      var f;
      var g = {
        label: 0,
        sent: function () {
          if (e[0] & 1) {
            throw e[1];
          }
          return e[1];
        },
        trys: [],
        ops: []
      };
      f = {
        next: h(0),
        throw: h(1),
        return: h(2)
      };
      if (typeof Symbol === "function") {
        f[Symbol.iterator] = function () {
          return this;
        };
      }
      return f;
      function h(a) {
        return function (b) {
          return i([a, b]);
        };
      }
      function i(f) {
        if (c) {
          throw new TypeError("Generator is already executing.");
        }
        while (g) {
          try {
            c = 1;
            if (d && (e = f[0] & 2 ? d.return : f[0] ? d.throw || ((e = d.return) && e.call(d), 0) : d.next) && !(e = e.call(d, f[1])).done) {
              return e;
            }
            d = 0;
            if (e) {
              f = [f[0] & 2, e.value];
            }
            switch (f[0]) {
              case 0:
              case 1:
                e = f;
                break;
              case 4:
                g.label++;
                var h = {
                  value: f[1],
                  done: false
                };
                return h;
              case 5:
                g.label++;
                d = f[1];
                f = [0];
                continue;
              case 7:
                f = g.ops.pop();
                g.trys.pop();
                continue;
              default:
                if (!(e = g.trys, e = e.length > 0 && e[e.length - 1]) && (f[0] === 6 || f[0] === 2)) {
                  g = 0;
                  continue;
                }
                if (f[0] === 3 && (!e || f[1] > e[0] && f[1] < e[3])) {
                  g.label = f[1];
                  break;
                }
                if (f[0] === 6 && g.label < e[1]) {
                  g.label = e[1];
                  e = f;
                  break;
                }
                if (e && g.label < e[2]) {
                  g.label = e[2];
                  g.ops.push(f);
                  break;
                }
                if (e[2]) {
                  g.ops.pop();
                }
                g.trys.pop();
                continue;
            }
            f = b.call(a, g);
          } catch (a) {
            f = [6, a];
            d = 0;
          } finally {
            c = e = 0;
          }
        }
        if (f[0] & 5) {
          throw f[1];
        }
        var i = {
          value: f[0] ? f[1] : undefined,
          done: true
        };
        return i;
      }
    }
    var Bo = function () {
      'use strict';
  
      function a() {
        xo(this, a);
      }
      zo(a, null, [{
        key: "Init",
        value: function a() {
          globalThis.exports.focusmanager.RegisterFocusHandler(function (a, b) {
            SetNuiFocus(a, b);
            SetNuiFocusKeepInput(a);
          });
          exports("open", this.open.bind(this));
          exports("close", this.close.bind(this));
          qm.register("outfits:close", this.close.bind(this));
          qm.register("outfits:preview", this.preview.bind(this));
          qm.register("outfits:apply", this.applyOutfit.bind(this));
          qm.register("outfits:save", this.saveOutfit.bind(this));
          qm.register("outfits:delete", this.deleteOutfit.bind(this));
          qm.register("outfits:edit", this.editOutfit.bind(this));
        }
      }, {
        key: "open",
        value: function b(a) {
          exports.focusmanager.SetUIFocus(true, true);
          emit("np-binds:should-execute", false);
          qm.execute("outfits:setData", a);
        }
      }, {
        key: "close",
        value: function a() {
          return wo(function () {
            return Ao(this, function (a) {
              exports.focusmanager.SetUIFocus(false, false);
              qm.execute("outfits:close");
              emit("np-binds:should-execute", true);
              emit("outfits:onClose");
              return [2];
            });
          })();
        }
      }, {
        key: "preview",
        value: function b(a) {
          return wo(function () {
            return Ao(this, function (b) {
              emit("outfits:preview", a);
              return [2];
            });
          })();
        }
      }, {
        key: "applyOutfit",
        value: function b(a) {
          return wo(function () {
            return Ao(this, function (b) {
              emit("outfits:apply", a);
              return [2];
            });
          })();
        }
      }, {
        key: "saveOutfit",
        value: function b(a) {
          return wo(function () {
            return Ao(this, function (b) {
              emit("outfits:save", a);
              return [2];
            });
          })();
        }
      }, {
        key: "deleteOutfit",
        value: function b(a) {
          return wo(function () {
            return Ao(this, function (b) {
              emit("outfits:delete", a);
              return [2];
            });
          })();
        }
      }, {
        key: "editOutfit",
        value: function b(a) {
          return wo(function () {
            return Ao(this, function (b) {
              emit("outfits:edit", a);
              return [2];
            });
          })();
        }
      }]);
      return a;
    }();
    ;
    var Co = new uo({
      codename: "outfits",
      version: "0.0.0"
    });
    setImmediate(function () {
      Bo.Init();
    });
  })();