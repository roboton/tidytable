#' Extract the first, last, or nth value from a vector
#'
#' @description
#' Extract the first, last, or nth value from a vector.
#'
#' Note: These are simple wrappers around `vctrs::vec_slice()`.
#'
#' @param x A vector
#' @param n For `nth.()`, a number specifying the position to grab.
#' @param default The default value if the value doesn't exist.
#' @param na_rm If `TRUE` ignores missing values.
#'
#' @export
#'
#' @examples
#' vec <- letters
#'
#' first.(vec)
#' last.(vec)
#' nth.(vec, 4)
first. <- function(x, default = NA, na_rm = FALSE) {
  nth.(x, 1L, default, na_rm)
}

#' @rdname first.
#' @export
last. <- function(x, default = NA, na_rm = FALSE) {
  nth.(x, -1L, default, na_rm)
}

#' @rdname first.
#' @export
nth. <- function(x, n, default = NA, na_rm = FALSE) {
  if (na_rm) {
    x <- x[!vec_equal_na(x)]
  }

  size <- vec_size(x)
  if (n < 0) {
    n <- size + n + 1
  }

  if (n > size || n == 0) {
    vec_cast(default, vec_ptype(x))
  } else {
    vec_slice(x, n)
  }
}
