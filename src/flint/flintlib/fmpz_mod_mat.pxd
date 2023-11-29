from flint.flintlib.flint cimport ulong, slong, fmpz_struct, flint_rand_t
from flint.flintlib.fmpz cimport fmpz_t
from flint.flintlib.fmpz_mod cimport fmpz_mod_ctx_t
from flint.flintlib.fmpz_mat cimport fmpz_mat_t
from flint.flintlib.fmpz_mod_poly cimport fmpz_mod_poly_t


cdef extern from "flint/fmpz_mod_mat.h":
    ctypedef struct fmpz_mod_mat_struct:
        fmpz_mat_t mat
        fmpz_t mod
    ctypedef fmpz_mod_mat_struct fmpz_mod_mat_t[1]


cdef extern from "flint/fmpz_mod_mat.h":
    # This is not exposed in the docs:
    int fmpz_mod_mat_equal(const fmpz_mod_mat_t mat1, const fmpz_mod_mat_t mat2);


cdef extern from "flint/fmpz_mod_mat.h":
    fmpz_struct * fmpz_mod_mat_entry(const fmpz_mod_mat_t mat, slong i, slong j)
    void fmpz_mod_mat_set_entry(fmpz_mod_mat_t mat, slong i, slong j, const fmpz_t val)
    void fmpz_mod_mat_init(fmpz_mod_mat_t mat, slong rows, slong cols, const fmpz_t n)
    void fmpz_mod_mat_init_set(fmpz_mod_mat_t mat, const fmpz_mod_mat_t src)
    void fmpz_mod_mat_clear(fmpz_mod_mat_t mat)
    slong fmpz_mod_mat_nrows(const fmpz_mod_mat_t mat)
    slong fmpz_mod_mat_ncols(const fmpz_mod_mat_t mat)
    void _fmpz_mod_mat_set_mod(fmpz_mod_mat_t mat, const fmpz_t n)
    void fmpz_mod_mat_one(fmpz_mod_mat_t mat)
    void fmpz_mod_mat_zero(fmpz_mod_mat_t mat)
    void fmpz_mod_mat_swap(fmpz_mod_mat_t mat1, fmpz_mod_mat_t mat2)
    void fmpz_mod_mat_swap_entrywise(fmpz_mod_mat_t mat1, fmpz_mod_mat_t mat2)
    int fmpz_mod_mat_is_empty(const fmpz_mod_mat_t mat)
    int fmpz_mod_mat_is_square(const fmpz_mod_mat_t mat)
    void _fmpz_mod_mat_reduce(fmpz_mod_mat_t mat)
    void fmpz_mod_mat_randtest(fmpz_mod_mat_t mat, flint_rand_t state)
    void fmpz_mod_mat_window_init(fmpz_mod_mat_t window, const fmpz_mod_mat_t mat, slong r1, slong c1, slong r2, slong c2)
    void fmpz_mod_mat_window_clear(fmpz_mod_mat_t window)
    void fmpz_mod_mat_concat_horizontal(fmpz_mod_mat_t res, const fmpz_mod_mat_t mat1, const fmpz_mod_mat_t mat2)
    void fmpz_mod_mat_concat_vertical(fmpz_mod_mat_t res, const fmpz_mod_mat_t mat1, const fmpz_mod_mat_t mat2)
    void fmpz_mod_mat_print_pretty(const fmpz_mod_mat_t mat)
    int fmpz_mod_mat_is_zero(const fmpz_mod_mat_t mat)
    void fmpz_mod_mat_set(fmpz_mod_mat_t B, const fmpz_mod_mat_t A)
    void fmpz_mod_mat_transpose(fmpz_mod_mat_t B, const fmpz_mod_mat_t A)
    void fmpz_mod_mat_set_fmpz_mat(fmpz_mod_mat_t A, const fmpz_mat_t B)
    void fmpz_mod_mat_get_fmpz_mat(fmpz_mat_t A, const fmpz_mod_mat_t B)
    void fmpz_mod_mat_add(fmpz_mod_mat_t C, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B)
    void fmpz_mod_mat_sub(fmpz_mod_mat_t C, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B)
    void fmpz_mod_mat_neg(fmpz_mod_mat_t B, const fmpz_mod_mat_t A)
    void fmpz_mod_mat_scalar_mul_si(fmpz_mod_mat_t B, const fmpz_mod_mat_t A, slong c)
    void fmpz_mod_mat_scalar_mul_ui(fmpz_mod_mat_t B, const fmpz_mod_mat_t A, ulong c)
    void fmpz_mod_mat_scalar_mul_fmpz(fmpz_mod_mat_t B, const fmpz_mod_mat_t A, fmpz_t c)
    void fmpz_mod_mat_mul(fmpz_mod_mat_t C, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B)
    # unimported types  {'thread_pool_handle'}
    # void _fmpz_mod_mat_mul_classical_threaded_pool_op(fmpz_mod_mat_t D, const fmpz_mod_mat_t C, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B, int op, thread_pool_handle * threads, slong num_threads)
    void _fmpz_mod_mat_mul_classical_threaded_op(fmpz_mod_mat_t D, const fmpz_mod_mat_t C, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B, int op)
    void fmpz_mod_mat_mul_classical_threaded(fmpz_mod_mat_t C, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B)
    void fmpz_mod_mat_sqr(fmpz_mod_mat_t B, const fmpz_mod_mat_t A)
    void fmpz_mod_mat_mul_fmpz_vec(fmpz_struct * c, const fmpz_mod_mat_t A, const fmpz_struct * b, slong blen)
    void fmpz_mod_mat_mul_fmpz_vec_ptr(fmpz_struct * const * c, const fmpz_mod_mat_t A, const fmpz_struct * const * b, slong blen)
    void fmpz_mod_mat_fmpz_vec_mul(fmpz_struct * c, const fmpz_struct * a, slong alen, const fmpz_mod_mat_t B)
    void fmpz_mod_mat_fmpz_vec_mul_ptr(fmpz_struct * const * c, const fmpz_struct * const * a, slong alen, const fmpz_mod_mat_t B)
    void fmpz_mod_mat_trace(fmpz_t trace, const fmpz_mod_mat_t mat)
    slong fmpz_mod_mat_rref(slong * perm, fmpz_mod_mat_t mat)
    void fmpz_mod_mat_strong_echelon_form(fmpz_mod_mat_t mat)
    slong fmpz_mod_mat_howell_form(fmpz_mod_mat_t mat)
    int fmpz_mod_mat_inv(fmpz_mod_mat_t B, fmpz_mod_mat_t A)
    slong fmpz_mod_mat_lu(slong * P, fmpz_mod_mat_t A, int rank_check)
    void fmpz_mod_mat_solve_tril(fmpz_mod_mat_t X, const fmpz_mod_mat_t L, const fmpz_mod_mat_t B, int unit)
    void fmpz_mod_mat_solve_triu(fmpz_mod_mat_t X, const fmpz_mod_mat_t U, const fmpz_mod_mat_t B, int unit)
    int fmpz_mod_mat_solve(fmpz_mod_mat_t X, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B)
    int fmpz_mod_mat_can_solve(fmpz_mod_mat_t X, const fmpz_mod_mat_t A, const fmpz_mod_mat_t B)
    void fmpz_mod_mat_similarity(fmpz_mod_mat_t M, slong r, fmpz_t d)
    void fmpz_mod_mat_charpoly(fmpz_mod_poly_t p, const fmpz_mod_mat_t M, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_mat_minpoly(fmpz_mod_poly_t p, const fmpz_mod_mat_t M, const fmpz_mod_ctx_t ctx)