#' Calculate HPOP Billion
#'
#' `calculate_hpop_billion()` calculates country-level HPOP Billion based on
#' indicator level changes.
#'
#' @inherit transform_hpop_data return details params
#' @inheritParams calculate_hpop_contributions
#' @inheritParams add_hpop_populations
#'
#' @export
calculate_hpop_billion <- function(df,
                                   year = "year",
                                   start_year = 2018,
                                   end_year = 2019:2025,
                                   iso3 = "iso3",
                                   ind = "ind",
                                   population = "population",
                                   pop_year = 2025,
                                   transform_value = "transform_value",
                                   contribution = stringr::str_replace(transform_value, "transform_value", "contribution"),
                                   contribution_pct = paste0(contribution, "_percent"),
                                   contribution_pct_total_pop = paste0(contribution, "_percent_total_pop"),
                                   scenario = NULL,
                                   ind_ids = billion_ind_codes("hpop")) {
  assert_columns(df, iso3, ind, year, transform_value)
  assert_ind_ids(ind_ids, "hpop")
  assert_unique_rows(df, ind, iso3, year, scenario, ind_ids)
  assert_same_length(transform_value, contribution)
  assert_same_length(contribution, contribution_pct)
  assert_years(start_year, end_year)

  # calculate the contribution_pct (change) and contribution for component HPOP indicators
  contr_df <- calculate_hpop_contributions(
    df = df,
    year = year,
    start_year = start_year,
    end_year = end_year,
    iso3 = iso3,
    ind = ind,
    population = population,
    transform_value = transform_value,
    contribution = contribution,
    contribution_pct = contribution_pct,
    contribution_pct_total_pop = contribution_pct_total_pop,
    scenario = scenario,
    ind_ids = ind_ids
  )

  # calculate the Billion based off the change
  change_df <- calculate_hpop_billion_change(
    df = contr_df,
    change = contribution_pct,
    contribution = contribution,
    ind = ind,
    iso3 = iso3,
    year = year,
    end_year = end_year,
    pop_year = pop_year,
    scenario = scenario,
    ind_ids = ind_ids
  )

  # return Billions with the rest of the original data
  dplyr::bind_rows(contr_df, change_df) %>%
    dplyr::ungroup()
}

#' Calculate the HPOP Billion using columns of change
#'
#' `calculate_hpop_billion_change()` uses the standard HPOP methodology to calculate
#' the Billions estimates for all end years. It is used within [calculate_hpop_billion()]
#' to calculate the Billion and return the data in long format. Called by itself,
#' it expects a column of changes to be passed in, and
#' returns the Billion for all `end_year` values.
#'
#' @inheritParams calculate_hpop_billion
#' @param change Column name of column(s) with change value
#'
#' @export
calculate_hpop_billion_change <- function(df,
                                          change = "contribution_percent",
                                          contribution = "contribution",
                                          ind = "ind",
                                          iso3 = "iso3",
                                          year = "year",
                                          population = "population",
                                          end_year = 2019:2025,
                                          pop_year = 2025,
                                          scenario = NULL,
                                          ind_ids = billion_ind_codes("hpop")) {
  assert_columns(df, change, ind, iso3, year, scenario)
  assert_ind_ids(ind_ids, "hpop")

  df <- billionaiRe_add_columns(df, c(contribution, population), NA_real_)

  # only calculate Billion using relevant indicators and years and correct for child nutrition

  change_df <- df %>%
    dplyr::filter(
      .data[[year]] %in% c(!!end_year),
      .data[[ind]] %in% !!ind_ids
    ) %>%
    dplyr::mutate(!!sym(ind) := ifelse(.data[[ind]] %in% ind_ids[c("wasting", "overweight")],
      "child_nutrition",
      .data[[ind]]
    )) %>%
    dplyr::group_by(dplyr::across(dplyr::any_of(c(iso3, scenario, ind, year)))) %>%
    dplyr::summarize(dplyr::across(
      dplyr::all_of(change),
      ~ sum(.x, na.rm = TRUE)
    ), # for child_nutrition
    .groups = "drop"
    )

  # add population groups

  change_df <- dplyr::left_join(change_df,
    generate_hpop_populations(pop_year),
    by = c(iso3 = "iso3", ind = "ind")
  )

  # calculate billions for each contribution column

  bill_df_list <- purrr::map2(change,
    contribution,
    calculate_hpop_billion_single,
    df = change_df,
    iso3 = iso3,
    ind = ind,
    year = year,
    pop_year = pop_year,
    scenario = scenario
  )

  # join back together
  bill_df <- purrr::reduce(bill_df_list,
    dplyr::left_join,
    by = c(iso3, ind, year, scenario)
  )

  # add population column (adding here instead of in calc_single() to not generate multiple columns)
  bill_df <- dplyr::mutate(
    bill_df,
    !!sym(population) := wppdistro::get_population(
      .data[[iso3]],
      year = !!pop_year
    )
  )

  bill_df
}

#' Calculate the HPOP Billion for one column of change
#'
#' @inheritParams calculate_hpop_billion
#' @param change Column name of column with change value
calculate_hpop_billion_single <- function(change,
                                          contribution,
                                          df,
                                          iso3,
                                          ind,
                                          year,
                                          pop_year,
                                          scenario) {

  # calculate Billion contributions

  contr_df <- df %>%
    dplyr::mutate(
      "_delta_temp" := .data[[change]] / 100,
      "_od_temp" := 1 - abs(.data[["_delta_temp"]]),
      "_pos_temp" := .data[["_delta_temp"]] > 0
    ) %>%
    dplyr::group_by(dplyr::across(dplyr::any_of(c(iso3, year, scenario, "_pop_group_temp", "_pos_temp")))) %>%
    dplyr::summarize("_product_temp" := 1 - prod(.data[["_od_temp"]]),
      "_pop_group_population_temp" := unique(.data[["_pop_group_population_temp"]]),
      "_sumi_temp" := sum(.data[["_delta_temp"]]),
      .groups = "drop"
    ) %>%
    dplyr::group_by(dplyr::across(dplyr::any_of(c(iso3, year, scenario)))) %>%
    dplyr::summarize("hpop_healthier_plus" := sum(.data[["_pop_group_population_temp"]] * .data[["_product_temp"]] * .data[["_pos_temp"]]),
      "hpop_healthier_minus" := -sum(.data[["_pop_group_population_temp"]] * .data[["_product_temp"]] * !.data[["_pos_temp"]]),
      "hpop_healthier_plus_dbl_cntd" := sum(.data[["_pop_group_population_temp"]] * .data[["_sumi_temp"]] * .data[["_pos_temp"]]),
      "hpop_healthier_minus_dbl_cntd" := sum(.data[["_pop_group_population_temp"]] * .data[["_sumi_temp"]] * !.data[["_pos_temp"]]),
      .groups = "drop"
    ) %>%
    dplyr::mutate(
      "hpop_healthier" := .data[["hpop_healthier_plus"]] + .data[["hpop_healthier_minus"]],
      "hpop_healthier_dbl_cntd" := .data[["hpop_healthier_plus_dbl_cntd"]] + .data[["hpop_healthier_minus_dbl_cntd"]]
    ) %>%
    tidyr::pivot_longer(dplyr::all_of(c(
      "hpop_healthier_plus",
      "hpop_healthier_minus",
      "hpop_healthier",
      "hpop_healthier_plus_dbl_cntd",
      "hpop_healthier_minus_dbl_cntd",
      "hpop_healthier_dbl_cntd"
    )),
    names_to = ind,
    values_to = contribution
    )

  # creating new columns called change with contributions, to present change / % contribution for Billion
  contr_df[, change] <- contr_df[, contribution]

  contr_df %>%
    dplyr::mutate(
      "_total_pop_temp" := wppdistro::get_population(iso3, pop_year),
      dplyr::across(
        dplyr::all_of(!!change),
        ~ 100 * .x / .data[["_total_pop_temp"]]
      )
    ) %>%
    dplyr::select(-"_total_pop_temp")
}


#' Generate HPOP Population Table
#'
#' `generate_hpop_populations()` creates the country/population data frame necessary
#' for correcting double counting within the HPOP Billion calculation. This is used
#' within `calculate_hpop_billion()`.
#'
#' Because the underlying data from the wppdistro package is not publicly distributed
#' for specific small WHO member states, this is not exported as an already created
#' (and thus publicly available) table within the billionaiRe package, but instead
#' dynamically generated each R session.
#'
#' @return Data frame in long format.
#' @inheritParams add_hpop_populations
#'
#' @export
generate_hpop_populations <- function(pop_year) {
  dplyr::tibble(
    iso3 = whoville::who_member_states(),
    under_5_urban_male = wppdistro::get_population(iso3, pop_year, age_range = "under_5", rural_urb = "urban", sex = "male"),
    btwn_5_14_urban_male = wppdistro::get_population(iso3, pop_year, age_range = "btwn_5_14", rural_urb = "urban", sex = "male"),
    btwn_15_18_urban_male = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "urban", sex = "male") / 2,
    btwn_18_19_urban_male = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "urban", sex = "male") / 2,
    over_19_urban_male = wppdistro::get_population(iso3, pop_year, age_range = "over_19", rural_urb = "urban", sex = "male"),
    under_5_rural_male = wppdistro::get_population(iso3, pop_year, age_range = "under_5", rural_urb = "rural", sex = "male"),
    btwn_5_14_rural_male = wppdistro::get_population(iso3, pop_year, age_range = "btwn_5_14", rural_urb = "rural", sex = "male"),
    btwn_15_18_rural_male = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "rural", sex = "male") / 2,
    btwn_18_19_rural_male = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "rural", sex = "male") / 2,
    over_19_rural_male = wppdistro::get_population(iso3, pop_year, age_range = "over_19", rural_urb = "rural", sex = "male"),
    under_5_urban_female = wppdistro::get_population(iso3, pop_year, age_range = "under_5", rural_urb = "urban", sex = "female"),
    btwn_5_14_urban_female = wppdistro::get_population(iso3, pop_year, age_range = "btwn_5_14", rural_urb = "urban", sex = "female"),
    btwn_15_18_urban_female = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "urban", sex = "female") / 2,
    btwn_18_19_urban_female = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "urban", sex = "female") / 2,
    over_19_urban_female = wppdistro::get_population(iso3, pop_year, age_range = "over_19", rural_urb = "urban", sex = "female"),
    under_5_rural_female = wppdistro::get_population(iso3, pop_year, age_range = "under_5", rural_urb = "rural", sex = "female"),
    btwn_5_14_rural_female = wppdistro::get_population(iso3, pop_year, age_range = "btwn_5_14", rural_urb = "rural", sex = "female"),
    btwn_15_18_rural_female = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "rural", sex = "female") / 2,
    btwn_18_19_rural_female = wppdistro::get_population(iso3, pop_year, age_range = "15_19", rural_urb = "rural", sex = "female") / 2,
    over_19_rural_female = wppdistro::get_population(iso3, pop_year, age_range = "over_19", rural_urb = "rural", sex = "female")
  ) %>%
    tidyr::pivot_longer(-c("iso3"),
      names_to = "_pop_group_temp",
      values_to = "_pop_group_population_temp"
    ) %>%
    dplyr::full_join(billionaiRe::pop_links, by = c("_pop_group_temp" = "pop_group"))
}


#' Calculate the change for vectors, used in [calculate_hpop_billion()]
#'
#' @param transform_value Vector of transform values
#' @param year Vector of years
#' @param start_year Start year
calculate_hpop_change_vector <- function(transform_value,
                                         year,
                                         start_year) {
  if (start_year %in% year) {
    transform_value - transform_value[year == start_year]
  } else {
    NA_real_
  }
}
