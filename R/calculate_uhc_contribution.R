#' Calculate UHC contribution
#'
#' `calculate_uhc_contribution()` calculates country-level UHC contributions, in
#' total population and percents, based on indicator level data. Calculates it
#' for each country-year combination in the provided data, and for specific
#' scenarios if specified.
#'
#' @inherit calculate_uhc_billion return details params
#' @inherit calculate_hpop_contributions params
#' @inherit add_hpop_populations params
#'
#' @export
calculate_uhc_contribution <- function(df,
                                       year = "year",
                                       iso3 = "iso3",
                                       ind = "ind",
                                       start_year = 2018,
                                       end_year = 2019:2025,
                                       pop_year = 2025,
                                       transform_value = "transform_value",
                                       contribution = stringr::str_replace(transform_value, "transform_value", "contribution"),
                                       contribution_pct = paste0(contribution, "_percent"),
                                       scenario = NULL,
                                       ind_ids = billion_ind_codes("uhc", include_calculated = TRUE)) {
  assert_columns(df, year, iso3, ind, scenario, transform_value)
  assert_same_length(transform_value, contribution)
  assert_same_length(contribution, contribution_pct)
  assert_years(start_year, end_year)
  assert_unique_rows(df, ind, iso3, year, scenario, ind_ids)

  df <- billionaiRe_add_columns(df, c(contribution, contribution_pct), NA_real_) %>%
    dplyr::mutate("_population_temp" := wppdistro::get_population(.data[[iso3]], year = pop_year)) %>%
    dplyr::group_by(dplyr::across(dplyr::any_of(c(iso3, ind, scenario))))

  for (i in 1:length(contribution)) {
    df <- df %>%
      dplyr::mutate(
        !!sym(contribution_pct[i]) := dplyr::case_when(
          !(.data[[ind]] %in% ind_ids) ~ .data[[contribution_pct[i]]],
          !(.data[[year]] %in% end_year) ~ .data[[contribution_pct[i]]],
          TRUE ~ (.data[[transform_value[i]]] - .data[[transform_value[i]]][.data[[year]] == !!start_year])
        ),
        !!sym(contribution[i]) := dplyr::case_when(
          !(.data[[ind]] %in% ind_ids) ~ .data[[contribution[i]]],
          !(.data[[year]] %in% end_year) ~ .data[[contribution[i]]],
          TRUE ~ .data[["_population_temp"]] * .data[[contribution_pct[i]]] / 100
        )
      )
  }

  dplyr::select(df, -"_population_temp") %>%
    dplyr::ungroup()
}
