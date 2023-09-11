from flint.flintlib.acb cimport acb_t, acb_ptr
from flint.flintlib.dirichlet cimport dirichlet_group_t, dirichlet_char_t
from flint.flintlib.flint cimport ulong, slong
from flint.flintlib.acb_poly cimport acb_poly_t
from flint.flintlib.fmpz cimport fmpz_t
from flint.flintlib.arb cimport arb_t, arb_ptr
from flint.flintlib.mag cimport mag_t, mag_struct
from flint.flintlib.acb cimport acb_struct, acb_srcptr
from flint.flintlib.fmpq cimport fmpq_t
from flint.flintlib.arf cimport arf_t
from flint.flintlib.arb cimport arb_srcptr

cdef extern from "acb_dirichlet.h":
    ctypedef struct acb_dirichlet_roots_struct:
        ulong order
        ulong reduced_order
        acb_t z
        slong size
        slong depth
        acb_ptr Z
        int use_pow

    ctypedef acb_dirichlet_roots_struct acb_dirichlet_roots_t[1]

    ctypedef struct acb_dirichlet_hurwitz_precomp_struct:
        acb_struct s
        mag_struct err
        acb_ptr coeffs
        int deflate
        slong A
        slong N
        slong K

    ctypedef acb_dirichlet_hurwitz_precomp_struct acb_dirichlet_hurwitz_precomp_t[1]


# from here on is parsed
    void acb_dirichlet_roots_init(acb_dirichlet_roots_t roots, ulong n, slong num, slong prec)
    void acb_dirichlet_roots_clear(acb_dirichlet_roots_t roots)
    void acb_dirichlet_root(acb_t res, const acb_dirichlet_roots_t roots, ulong k, slong prec)
    void acb_dirichlet_powsum_term(acb_ptr res, arb_t log_prev, ulong * prev, const acb_t s, ulong k, int integer, int critical_line, slong len, slong prec)
    void acb_dirichlet_powsum_sieved(acb_ptr res, const acb_t s, ulong n, slong len, slong prec)
    void acb_dirichlet_powsum_smooth(acb_ptr res, const acb_t s, ulong n, slong len, slong prec)
    void acb_dirichlet_zeta(acb_t res, const acb_t s, slong prec)
    void acb_dirichlet_zeta_jet(acb_t res, const acb_t s, int deflate, slong len, slong prec)
    void acb_dirichlet_zeta_bound(mag_t res, const acb_t s)
    void acb_dirichlet_zeta_deriv_bound(mag_t der1, mag_t der2, const acb_t s)
    void acb_dirichlet_eta(acb_t res, const acb_t s, slong prec)
    void acb_dirichlet_xi(acb_t res, const acb_t s, slong prec)
    void acb_dirichlet_zeta_rs_f_coeffs(acb_ptr f, const arb_t p, slong n, slong prec)
    void acb_dirichlet_zeta_rs_d_coeffs(arb_ptr d, const arb_t sigma, slong k, slong prec)
    void acb_dirichlet_zeta_rs_bound(mag_t err, const acb_t s, slong K)
    void acb_dirichlet_zeta_rs_r(acb_t res, const acb_t s, slong K, slong prec)
    void acb_dirichlet_zeta_rs(acb_t res, const acb_t s, slong K, slong prec)
    void acb_dirichlet_zeta_jet_rs(acb_t res, const acb_t s, slong len, slong prec)
    void acb_dirichlet_hurwitz(acb_t res, const acb_t s, const acb_t a, slong prec)
    void acb_dirichlet_hurwitz_precomp_init(acb_dirichlet_hurwitz_precomp_t pre, const acb_t s, int deflate, ulong A, ulong K, ulong N, slong prec)
    void acb_dirichlet_hurwitz_precomp_init_num(acb_dirichlet_hurwitz_precomp_t pre, const acb_t s, int deflate, double num_eval, slong prec)
    void acb_dirichlet_hurwitz_precomp_clear(acb_dirichlet_hurwitz_precomp_t pre)
    void acb_dirichlet_hurwitz_precomp_choose_param(ulong * A, ulong * K, ulong * N, const acb_t s, double num_eval, slong prec)
    void acb_dirichlet_hurwitz_precomp_bound(mag_t res, const acb_t s, ulong A, ulong K, ulong N)
    void acb_dirichlet_hurwitz_precomp_eval(acb_t res, const acb_dirichlet_hurwitz_precomp_t pre, ulong p, ulong q, slong prec)
    void acb_dirichlet_lerch_phi_integral(acb_t res, const acb_t z, const acb_t s, const acb_t a, slong prec)
    void acb_dirichlet_lerch_phi_direct(acb_t res, const acb_t z, const acb_t s, const acb_t a, slong prec)
    void acb_dirichlet_lerch_phi(acb_t res, const acb_t z, const acb_t s, const acb_t a, slong prec)
    void acb_dirichlet_stieltjes(acb_t res, const fmpz_t n, const acb_t a, slong prec)
    void acb_dirichlet_chi(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, ulong n, slong prec)
    void acb_dirichlet_chi_vec(acb_ptr v, const dirichlet_group_t G, const dirichlet_char_t chi, slong nv, slong prec)
    void acb_dirichlet_pairing(acb_t res, const dirichlet_group_t G, ulong m, ulong n, slong prec)
    void acb_dirichlet_pairing_char(acb_t res, const dirichlet_group_t G, const dirichlet_char_t a, const dirichlet_char_t b, slong prec)
    void acb_dirichlet_gauss_sum_naive(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_gauss_sum_factor(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_gauss_sum_order2(acb_t res, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_gauss_sum_theta(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_gauss_sum(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_gauss_sum_ui(acb_t res, const dirichlet_group_t G, ulong a, slong prec)
    void acb_dirichlet_jacobi_sum_naive(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi1, const dirichlet_char_t chi2, slong prec)
    void acb_dirichlet_jacobi_sum_factor(acb_t res,  const dirichlet_group_t G, const dirichlet_char_t chi1, const dirichlet_char_t chi2, slong prec)
    void acb_dirichlet_jacobi_sum_gauss(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi1, const dirichlet_char_t chi2, slong prec)
    void acb_dirichlet_jacobi_sum(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi1,  const dirichlet_char_t chi2, slong prec)
    void acb_dirichlet_jacobi_sum_ui(acb_t res, const dirichlet_group_t G, ulong a, ulong b, slong prec)
    void acb_dirichlet_chi_theta_arb(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, const arb_t t, slong prec)
    void acb_dirichlet_ui_theta_arb(acb_t res, const dirichlet_group_t G, ulong a, const arb_t t, slong prec)
    ulong acb_dirichlet_theta_length(ulong q, const arb_t t, slong prec)
    void acb_dirichlet_qseries_powers_naive(acb_t res, const arb_t x, int p, const ulong * a, const acb_dirichlet_roots_t z, slong len, slong prec)
    void acb_dirichlet_qseries_powers_smallorder(acb_t res, const arb_t x, int p, const ulong * a, const acb_dirichlet_roots_t z, slong len, slong prec)
    void acb_dirichlet_dft_conrey(acb_ptr w, acb_srcptr v, const dirichlet_group_t G, slong prec)
    void acb_dirichlet_dft(acb_ptr w, acb_srcptr v, const dirichlet_group_t G, slong prec)
    void acb_dirichlet_root_number_theta(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_root_number(acb_t res, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_l_hurwitz(acb_t res, const acb_t s, const acb_dirichlet_hurwitz_precomp_t precomp, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_l_euler_product(acb_t res, const acb_t s, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void _acb_dirichlet_euler_product_real_ui(arb_t res, ulong s, const signed char * chi, int mod, int reciprocal, slong prec)
    void acb_dirichlet_l(acb_t res, const acb_t s, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_l_fmpq(acb_t res, const fmpq_t s, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_l_fmpq_afe(acb_t res, const fmpq_t s, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    void acb_dirichlet_l_vec_hurwitz(acb_ptr res, const acb_t s, const acb_dirichlet_hurwitz_precomp_t precomp, const dirichlet_group_t G, slong prec)
    void acb_dirichlet_l_jet(acb_ptr res, const acb_t s, const dirichlet_group_t G, const dirichlet_char_t chi, int deflate, slong len, slong prec)
    void _acb_dirichlet_l_series(acb_ptr res, acb_srcptr s, slong slen, const dirichlet_group_t G, const dirichlet_char_t chi, int deflate, slong len, slong prec)
    void acb_dirichlet_l_series(acb_poly_t res, const acb_poly_t s, const dirichlet_group_t G, const dirichlet_char_t chi, int deflate, slong len, slong prec)
    void acb_dirichlet_hardy_theta(acb_ptr res, const acb_t t, const dirichlet_group_t G, const dirichlet_char_t chi, slong len, slong prec)
    void acb_dirichlet_hardy_z(acb_t res, const acb_t t, const dirichlet_group_t G, const dirichlet_char_t chi, slong len, slong prec)
    void _acb_dirichlet_hardy_theta_series(acb_ptr res, acb_srcptr t, slong tlen, const dirichlet_group_t G, const dirichlet_char_t chi, slong len, slong prec)
    void acb_dirichlet_hardy_theta_series(acb_poly_t res, const acb_poly_t t, const dirichlet_group_t G, const dirichlet_char_t chi, slong len, slong prec)
    void _acb_dirichlet_hardy_z_series(acb_ptr res, acb_srcptr t, slong tlen, const dirichlet_group_t G, const dirichlet_char_t chi, slong len, slong prec)
    void acb_dirichlet_hardy_z_series(acb_poly_t res, const acb_poly_t t, const dirichlet_group_t G, const dirichlet_char_t chi, slong len, slong prec)
    void acb_dirichlet_gram_point(arb_t res, const fmpz_t n, const dirichlet_group_t G, const dirichlet_char_t chi, slong prec)
    ulong acb_dirichlet_turing_method_bound(const fmpz_t p)
    int _acb_dirichlet_definite_hardy_z(arb_t res, const arf_t t, slong * pprec)
    void _acb_dirichlet_isolate_gram_hardy_z_zero(arf_t a, arf_t b, const fmpz_t n)
    void _acb_dirichlet_isolate_rosser_hardy_z_zero(arf_t a, arf_t b, const fmpz_t n)
    void _acb_dirichlet_isolate_turing_hardy_z_zero(arf_t a, arf_t b, const fmpz_t n)
    void acb_dirichlet_isolate_hardy_z_zero(arf_t a, arf_t b, const fmpz_t n)
    void _acb_dirichlet_refine_hardy_z_zero(arb_t res, const arf_t a, const arf_t b, slong prec)
    void acb_dirichlet_hardy_z_zero(arb_t res, const fmpz_t n, slong prec)
    void acb_dirichlet_hardy_z_zeros(arb_ptr res, const fmpz_t n, slong len, slong prec)
    void acb_dirichlet_zeta_zero(acb_t res, const fmpz_t n, slong prec)
    void acb_dirichlet_zeta_zeros(acb_ptr res, const fmpz_t n, slong len, slong prec)
    void _acb_dirichlet_exact_zeta_nzeros(fmpz_t res, const arf_t t)
    void acb_dirichlet_zeta_nzeros(arb_t res, const arb_t t, slong prec)
    void acb_dirichlet_backlund_s(arb_t res, const arb_t t, slong prec)
    void acb_dirichlet_backlund_s_bound(mag_t res, const arb_t t)
    void acb_dirichlet_zeta_nzeros_gram(fmpz_t res, const fmpz_t n)
    slong acb_dirichlet_backlund_s_gram(const fmpz_t n)
    void acb_dirichlet_platt_scaled_lambda(arb_t res, const arb_t t, slong prec)
    void acb_dirichlet_platt_scaled_lambda_vec(arb_ptr res, const fmpz_t T, slong A, slong B, slong prec)
    void acb_dirichlet_platt_multieval(arb_ptr res, const fmpz_t T, slong A, slong B, const arb_t h, const fmpz_t J, slong K, slong sigma, slong prec)
    void acb_dirichlet_platt_multieval_threaded(arb_ptr res, const fmpz_t T, slong A, slong B, const arb_t h, const fmpz_t J, slong K, slong sigma, slong prec)
    void acb_dirichlet_platt_ws_interpolation(arb_t res, arf_t deriv, const arb_t t0, arb_srcptr p, const fmpz_t T, slong A, slong B, slong Ns_max, const arb_t H, slong sigma, slong prec)
    slong _acb_dirichlet_platt_local_hardy_z_zeros(arb_ptr res, const fmpz_t n, slong len, const fmpz_t T, slong A, slong B, const arb_t h, const fmpz_t J, slong K, slong sigma_grid, slong Ns_max, const arb_t H, slong sigma_interp, slong prec)
    slong acb_dirichlet_platt_local_hardy_z_zeros(arb_ptr res, const fmpz_t n, slong len, slong prec)
    slong acb_dirichlet_platt_hardy_z_zeros(arb_ptr res, const fmpz_t n, slong len, slong prec)
    slong acb_dirichlet_platt_zeta_zeros(acb_ptr res, const fmpz_t n, slong len, slong prec)
