from flint._flint cimport ulong, slong
from flint.flintlib.arb cimport arb_struct, arb_t, arb_ptr
from flint.flintlib.fmpq cimport fmpq_t
from flint.flintlib.fmpz cimport fmpz_t
from flint.flintlib.arf cimport arf_t
from flint.flintlib.mag cimport mag_t

cdef extern from "acb.h":
    ctypedef struct acb_struct:
        arb_struct real
        arb_struct imag

    ctypedef acb_struct * acb_ptr
    ctypedef const acb_struct * acb_srcptr
    ctypedef acb_struct acb_t[1]

    arb_ptr acb_realref(const acb_t x)
    arb_ptr acb_imagref(const acb_t x)

    acb_ptr _acb_vec_init(long n)
    void _acb_vec_clear(acb_ptr v, long n)
    void _acb_vec_sort_pretty(acb_ptr vec, long len)
    void acb_printd(const acb_t z, long digits)

    void acb_init(acb_t x)
    void acb_clear(acb_t x)
    int acb_is_zero(const acb_t z)
    int acb_is_one(const acb_t z)
    int acb_is_exact(const acb_t z)
    int acb_is_finite(const acb_t x)
    void acb_indeterminate(acb_t x)
    void acb_zero(acb_t z)
    void acb_one(acb_t z)
    void acb_onei(acb_t z)
    void acb_set(acb_t z, const acb_t x)
    void acb_set_round(acb_t z, const acb_t x, long prec)
    void acb_neg_round(acb_t z, const acb_t x, long prec)
    void acb_swap(acb_t z, acb_t x)
    int acb_equal(const acb_t x, const acb_t y)
    int acb_eq(const acb_t x, const acb_t y)
    int acb_ne(const acb_t x, const acb_t y)
    int acb_overlaps(const acb_t x, const acb_t y)
    int acb_contains_zero(const acb_t x)
    int acb_contains_fmpq(const acb_t x, const fmpq_t y)
    int acb_contains_fmpz(const acb_t x, const fmpz_t y)
    int acb_contains(const acb_t x, const acb_t y)
    int acb_contains_interior(const acb_t x, const acb_t y)
    int acb_get_unique_fmpz(fmpz_t z, const acb_t x)
    int acb_contains_int(const acb_t x)
    void acb_union(acb_t z, const acb_t x, const acb_t y, long prec)
    void acb_set_ui(acb_t z, ulong c)
    void acb_set_si(acb_t z, long c)
    void acb_set_fmpz(acb_t z, const fmpz_t c)
    void acb_set_round_fmpz(acb_t z, const fmpz_t y, long prec)
    void acb_set_fmpq(acb_t z, const fmpq_t c, long prec)
    void acb_set_arb(acb_t z, const arb_t c)
    void acb_set_round_arb(acb_t z, const arb_t x, long prec)
    void acb_trim(acb_t z, const acb_t x)
    void acb_add_error_arf(acb_t x, const arf_t err)
    void acb_add_error_mag(acb_t x, const mag_t err)
    void acb_get_mag(mag_t z, const acb_t x)
    void acb_get_mag_lower(mag_t z, const acb_t x)
    void acb_get_abs_ubound_arf(arf_t u, const acb_t z, long prec)
    void acb_get_abs_lbound_arf(arf_t u, const acb_t z, long prec)
    void acb_get_rad_ubound_arf(arf_t u, const acb_t z, long prec)
    void acb_arg(arb_t r, const acb_t z, long prec)
    void acb_add(acb_t z, const acb_t x, const acb_t y, long prec)
    void acb_sub(acb_t z, const acb_t x, const acb_t y, long prec)
    void acb_add_ui(acb_t z, const acb_t x, ulong c, long prec)
    void acb_sub_ui(acb_t z, const acb_t x, ulong c, long prec)
    void acb_add_fmpz(acb_t z, const acb_t x, const fmpz_t y, long prec)
    void acb_add_arb(acb_t z, const acb_t x, const arb_t y, long prec)
    void acb_sub_fmpz(acb_t z, const acb_t x, const fmpz_t y, long prec)
    void acb_sub_arb(acb_t z, const acb_t x, const arb_t y, long prec)
    void acb_neg(acb_t z, const acb_t x)
    void acb_conj(acb_t z, const acb_t x)
    void acb_abs(arb_t u, const acb_t z, long prec)
    void acb_sgn(acb_t u, const acb_t z, long prec)
    void acb_csgn(arb_t u, const acb_t z)
    void acb_get_real(arb_t u, const acb_t z)
    void acb_get_imag(arb_t u, const acb_t z)

    void acb_real_abs(acb_t res, const acb_t z, int analytic, long prec)
    void acb_real_sgn(acb_t res, const acb_t z, int analytic, long prec)
    void acb_real_heaviside(acb_t res, const acb_t z, int analytic, long prec)
    void acb_real_floor(acb_t res, const acb_t z, int analytic, long prec)
    void acb_real_ceil(acb_t res, const acb_t z, int analytic, long prec)
    void acb_real_max(acb_t res, const acb_t x, const acb_t y, int analytic, long prec)
    void acb_real_min(acb_t res, const acb_t x, const acb_t y, int analytic, long prec)
    void acb_real_sqrtpos(acb_t res, const acb_t z, int analytic, long prec)

    void acb_sqrt_analytic(acb_t res, const acb_t z, int analytic, long prec)
    void acb_rsqrt_analytic(acb_t res, const acb_t z, int analytic, long prec)
    void acb_log_analytic(acb_t res, const acb_t z, int analytic, long prec)
    void acb_pow_analytic(acb_t res, const acb_t z, const acb_t w, int analytic, long prec)

    void acb_mul_ui(acb_t z, const acb_t x, ulong y, long prec)
    void acb_mul_si(acb_t z, const acb_t x, long y, long prec)
    void acb_mul_fmpz(acb_t z, const acb_t x, const fmpz_t y, long prec)
    void acb_mul_arb(acb_t z, const acb_t x, const arb_t y, long prec)
    void acb_mul_onei(acb_t z, const acb_t x)
    void acb_mul(acb_t z, const acb_t x, const acb_t y, long prec)
    void acb_mul_2exp_si(acb_t z, const acb_t x, long e)
    void acb_mul_2exp_fmpz(acb_t z, const acb_t x, const fmpz_t c)
    void acb_addmul(acb_t z, const acb_t x, const acb_t y, long prec)
    void acb_submul(acb_t z, const acb_t x, const acb_t y, long prec)
    void acb_addmul_ui(acb_t z, const acb_t x, ulong y, long prec)
    void acb_addmul_si(acb_t z, const acb_t x, long y, long prec)
    void acb_submul_ui(acb_t z, const acb_t x, ulong y, long prec)
    void acb_submul_si(acb_t z, const acb_t x, long y, long prec)
    void acb_addmul_fmpz(acb_t z, const acb_t x, const fmpz_t y, long prec)
    void acb_submul_fmpz(acb_t z, const acb_t x, const fmpz_t y, long prec)
    void acb_addmul_arb(acb_t z, const acb_t x, const arb_t y, long prec)
    void acb_submul_arb(acb_t z, const acb_t x, const arb_t y, long prec)
    void acb_inv(acb_t z, const acb_t x, long prec)
    void acb_div(acb_t z, const acb_t x, const acb_t y, long prec)
    void acb_div_ui(acb_t z, const acb_t x, ulong c, long prec)
    void acb_div_si(acb_t z, const acb_t x, long c, long prec)
    void acb_div_arb(acb_t z, const acb_t x, const arb_t c, long prec)
    void acb_div_fmpz(acb_t z, const acb_t x, const fmpz_t c, long prec)
    void acb_cube(acb_t y, const acb_t x, long prec)
    void acb_pow_fmpz(acb_t y, const acb_t b, const fmpz_t e, long prec)
    void acb_pow_ui(acb_t y, const acb_t b, ulong e, long prec)
    void acb_pow_si(acb_t y, const acb_t b, long e, long prec)
    void acb_const_pi(acb_t x, long prec)
    void acb_log(acb_t r, const acb_t z, long prec)
    void acb_exp(acb_t r, const acb_t z, long prec)
    void acb_exp_pi_i(acb_t r, const acb_t z, long prec)
    void acb_sin(acb_t r, const acb_t z, long prec)
    void acb_cos(acb_t r, const acb_t z, long prec)
    void acb_sin_cos(acb_t s, acb_t c, const acb_t z, long prec)
    void acb_tan(acb_t r, const acb_t z, long prec)
    void acb_cot(acb_t r, const acb_t z, long prec)
    void acb_sec(acb_t r, const acb_t z, long prec)
    void acb_csc(acb_t r, const acb_t z, long prec)
    void acb_sin_pi(acb_t r, const acb_t z, long prec)
    void acb_cos_pi(acb_t r, const acb_t z, long prec)
    void acb_sin_cos_pi(acb_t s, acb_t c, const acb_t z, long prec)
    void acb_tan_pi(acb_t r, const acb_t z, long prec)
    void acb_cot_pi(acb_t r, const acb_t z, long prec)
    void acb_sinh(acb_t r, const acb_t z, long prec)
    void acb_cosh(acb_t r, const acb_t z, long prec)
    void acb_sinh_cosh(acb_t s, acb_t c, const acb_t z, long prec)
    void acb_tanh(acb_t r, const acb_t z, long prec)
    void acb_coth(acb_t r, const acb_t z, long prec)
    void acb_sech(acb_t r, const acb_t z, long prec)
    void acb_csch(acb_t r, const acb_t z, long prec)
    void acb_sinc(acb_t r, const acb_t z, long prec)
    void acb_sinc_pi(acb_t r, const acb_t z, long prec)
    void acb_pow_arb(acb_t z, const acb_t x, const arb_t y, long prec)
    void acb_pow(acb_t r, const acb_t x, const acb_t y, long prec)
    void acb_sqrt(acb_t y, const acb_t x, long prec)
    void acb_rsqrt(acb_t y, const acb_t x, long prec)
    void acb_rising_ui_bs(acb_t y, const acb_t x, ulong n, long prec)
    void acb_rising_ui_rs(acb_t y, const acb_t x, ulong n, ulong m, long prec)
    void acb_rising_ui_rec(acb_t y, const acb_t x, ulong n, long prec)
    void acb_rising_ui(acb_t z, const acb_t x, ulong n, long prec)
    void acb_rising2_ui_bs(acb_t u, acb_t v, const acb_t x, ulong n, long prec)
    void acb_rising2_ui_rs(acb_t u, acb_t v, const acb_t x, ulong n, ulong m, long prec)
    void acb_rising2_ui(acb_t u, acb_t v, const acb_t x, ulong n, long prec)
    void acb_rising_ui_get_mag(mag_t bound, const acb_t s, ulong n)
    void acb_rising(acb_t y, const acb_t x, const acb_t n, long prec)

    void acb_gamma(acb_t y, const acb_t x, long prec)
    void acb_rgamma(acb_t y, const acb_t x, long prec)
    void acb_lgamma(acb_t y, const acb_t x, long prec)
    void acb_digamma(acb_t y, const acb_t x, long prec)
    void acb_zeta(acb_t z, const acb_t s, long prec)
    void acb_hurwitz_zeta(acb_t z, const acb_t s, const acb_t a, long prec)
    void acb_polylog(acb_t w, const acb_t s, const acb_t z, long prec)
    void acb_polylog_si(acb_t w, long s, const acb_t z, long prec)
    void acb_agm1(acb_t m, const acb_t z, long prec)
    void acb_agm1_cpx(acb_ptr m, const acb_t z, long len, long prec)
    void acb_agm(acb_t res, const acb_t a, const acb_t b, long prec)
    void acb_expm1(acb_t r, const acb_t z, long prec)
    void acb_log1p(acb_t r, const acb_t z, long prec)
    void acb_asin(acb_t r, const acb_t z, long prec)
    void acb_acos(acb_t r, const acb_t z, long prec)
    void acb_atan(acb_t r, const acb_t z, long prec)
    void acb_asinh(acb_t r, const acb_t z, long prec)
    void acb_acosh(acb_t r, const acb_t z, long prec)
    void acb_atanh(acb_t r, const acb_t z, long prec)
    void acb_log_sin_pi(acb_t res, const acb_t z, long prec)

    void acb_polygamma(acb_t w, const acb_t s, const acb_t z, long prec)
    void acb_log_barnes_g(acb_t w, const acb_t z, long prec)
    void acb_barnes_g(acb_t w, const acb_t z, long prec)

    void acb_bernoulli_poly_ui(acb_t res, ulong n, const acb_t x, long prec)

    void acb_lambertw(acb_t z, const acb_t x, const fmpz_t k, int flags, long prec)

    long acb_rel_error_bits(const acb_t x)
    long acb_rel_accuracy_bits(const acb_t x)
    long acb_bits(const acb_t x)

    void acb_root_ui(acb_t z, const acb_t x, ulong k, long prec)
