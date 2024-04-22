from flint.flintlib.flint cimport (
    FLINT_BITS as _FLINT_BITS,
    FLINT_VERSION as _FLINT_VERSION,
    __FLINT_RELEASE as _FLINT_RELEASE,
    slong
)
from flint.flint_base.flint_context cimport thectx
from flint.utils.typecheck cimport typecheck
cimport libc.stdlib

from typing import Optional


FLINT_BITS = _FLINT_BITS
FLINT_VERSION = _FLINT_VERSION.decode("ascii")
FLINT_RELEASE = _FLINT_RELEASE


cdef class flint_elem:
    def __repr__(self):
        if thectx.pretty:
            return self.str()
        else:
            return self.repr()

    def __str__(self):
        return self.str()


cdef class flint_scalar(flint_elem):
    pass


cdef class flint_poly(flint_elem):
    """
    Base class for polynomials.
    """

    def __iter__(self):
        cdef long i, n
        n = self.length()
        for i in range(n):
            yield self[i]

    def coeffs(self):
        """
        Returns the coefficients of ``self`` as a list

            >>> from flint import fmpz_poly
            >>> f = fmpz_poly([1,2,3,4,5])
            >>> f.coeffs()
            [1, 2, 3, 4, 5]
        """
        return list(self)

    def str(self, bint ascending=False):
        """
        Convert to a human-readable string (generic implementation for
        all polynomial types).

        If *ascending* is *True*, the monomials are output from low degree to
        high, otherwise from high to low.
        """
        coeffs = [str(c) for c in self]
        if not coeffs:
            return "0"
        s = []
        coeffs = enumerate(coeffs)
        if not ascending:
            coeffs = reversed(list(coeffs))
        for i, c in coeffs:
            if c == "0":
                continue
            else:
                if c.startswith("-") or (" " in c):
                    c = "(" + c + ")"
                if i == 0:
                    s.append("%s" % c)
                elif i == 1:
                    if c == "1":
                        s.append("x")
                    else:
                        s.append("%s*x" % c)
                else:
                    if c == "1":
                        s.append("x^%s" % i)
                    else:
                        s.append("%s*x^%s" % (c, i))
        return " + ".join(s)

    def roots(self):
        """
        Computes all the roots in the base ring of the polynomial.
        Returns a list of all pairs (*v*, *m*) where *v* is the 
        integer root and *m* is the multiplicity of the root.

        To compute complex roots of a polynomial, instead use
        the `.complex_roots()` method, which is available on
        certain polynomial rings.

            >>> from flint import fmpz_poly
            >>> fmpz_poly([1, 2]).roots()
            []
            >>> fmpz_poly([2, 1]).roots()
            [(-2, 1)]
            >>> fmpz_poly([12, 7, 1]).roots()
            [(-3, 1), (-4, 1)]
            >>> (fmpz_poly([-5,1]) * fmpz_poly([-5,1]) * fmpz_poly([-3,1])).roots()
            [(3, 1), (5, 2)]
        """
        factor_fn = getattr(self, "factor", None)
        if not callable(factor_fn):
            raise NotImplementedError("Polynomial has no factor method, roots cannot be determined")

        roots = []
        factors = self.factor()
        for fac, m in factors[1]:
            if fac.degree() == fac[1] == 1:
                v = - fac[0]
                roots.append((v, m))
        return roots

    def complex_roots(self):
        raise AttributeError("Complex roots are not supported for this polynomial")


cdef class flint_mpoly_context(flint_elem):
    """
    Base class for multivariate ring contexts
    """

    _ctx_cache = None

    def __cinit__(self):
        self._init = False

    def __init__(self, int nvars, names):
        if nvars < 0:
            raise ValueError("cannot have a negative amount of variables")
        elif len(names) != nvars:
            raise ValueError("number of variables must match lens of variable names")
        self.py_names = tuple(bytes(name, 'utf-8') if not isinstance(name, bytes) else name for name in names)
        self.c_names = <char**>libc.stdlib.malloc(nvars * sizeof(char *))
        self._init = True
        for i in range(nvars):
            self.c_names[i] = self.py_names[i]

    def __dealloc__(self):
        if self._init:
            libc.stdlib.free(self.c_names)
        self._init = False

    def __str__(self):
        return self.__repr__()

    def __repr__(self):
        return f"{self.__class__.__name__}({self.nvars()}, '{self.ordering()}', {self.names()})"

    def name(self, long i):
        if not 0 <= i < len(self.py_names):
            raise IndexError("variable name index out of range")
        return self.py_names[i].decode('utf-8')

    def names(self):
        return tuple(name.decode('utf-8') for name in self.py_names)

    def gens(self):
        return tuple(self.gen(i) for i in range(self.nvars()))

    @staticmethod
    def create_cache_key(slong nvars, ordering: str, names: str):
        nametup = tuple(name.strip() for name in names.split(','))
        if len(nametup) != nvars:
            if len(nametup) != 1:
                raise ValueError("Number of variables does not equal number of names")
            nametup = tuple(nametup[0] + str(i) for i in range(nvars))
        return nvars, ordering, nametup

    @classmethod
    def get_context(cls, slong nvars=1, ordering: str = "lex", names: Optional[str] = "x", nametup: Optional[tuple] = None):
        if nvars <= 0:
            nvars = 1

        if nametup is None and names is not None:
            key = cls.create_cache_key(nvars, ordering, names)
        elif len(nametup) != nvars:
            raise ValueError("Number of variables does not equal number of names")
        else:
            key = (nvars, ordering, nametup)

        ctx = cls._ctx_cache.get(key)
        if ctx is None:
            ctx = cls(*key)
            cls._ctx_cache[key] = ctx
        return ctx

    @classmethod
    def from_context(cls, ctx: flint_mpoly_context):
        return cls.get_context(
            nvars=ctx.nvars(),
            ordering=ctx.ordering(),
            names=None,
            nametup=tuple(str(s, 'utf-8') for s in ctx.py_names)
        )

    @classmethod
    def joint_context(cls, *ctxs):
        vars = set()
        for ctx in ctxs:
            if not typecheck(ctx, cls):
                raise ValueError(f"{ctx} is not a {cls}")
            else:
                for var in ctx.py_names:
                    vars.add(var)
        return cls.get_context(nvars=len(vars), nametup=tuple(vars))


cdef class flint_mpoly(flint_elem):
    """
    Base class for multivariate polynomials.
    """

    def leading_coefficient(self):
        return self.coefficient(0)

    def __hash__(self):
        s = repr(self)
        return hash(s)

    def to_dict(self):
        d = {}
        for i in range(len(self)):
            d[self.exponent_tuple(i)] = self.coefficient(i)
        return d


cdef class flint_series(flint_elem):
    """
    Base class for power series.
    """
    def __iter__(self):
        cdef long i, n
        n = self.length()
        for i in range(n):
            yield self[i]

    def coeffs(self):
        return list(self)


cdef class flint_mat(flint_elem):
    """
    Base class for matrices.
    """

    def repr(self):
        # XXX
        return "%s(%i, %i, [%s])" % (type(self).__name__,
            self.nrows(), self.ncols(), (", ".join(map(str, self.entries()))))

    def str(self, *args, **kwargs):
        tab = self.table()
        if len(tab) == 0 or len(tab[0]) == 0:
            return "[]"
        tab = [[r.str(*args, **kwargs) for r in row] for row in tab]
        widths = []
        for i in xrange(len(tab[0])):
            w = max([len(row[i]) for row in tab])
            widths.append(w)
        for i in xrange(len(tab)):
            tab[i] = [s.rjust(widths[j]) for j, s in enumerate(tab[i])]
            tab[i] = "[" + (", ".join(tab[i])) + "]"
        return "\n".join(tab)

    def entries(self):
        cdef long i, j, m, n
        m = self.nrows()
        n = self.ncols()
        L = [None] * (m * n)
        for i from 0 <= i < m:
            for j from 0 <= j < n:
                L[i*n + j] = self[i, j]
        return L

    def __iter__(self):
        cdef long i, j, m, n
        m = self.nrows()
        n = self.ncols()
        for i from 0 <= i < m:
            for j from 0 <= j < n:
                yield self[i, j]

    def table(self):
        cdef long i, m, n
        m = self.nrows()
        n = self.ncols()
        L = self.entries()
        return [L[i*n : (i+1)*n] for i in range(m)]

    # supports mpmath conversions
    tolist = table


cdef class flint_rational_function(flint_elem):
    pass
