sumR_char <- function(df, var, group) {
  group_vals <- append(group, var, 1)
  summary <- df |>
    dplyr::group_by(
      !!!syms(group_vals)) |>
    dplyr::summarize(
      count = n(),
      percent = round(count/nrow(df), digits = 2)
    )
}

sumR_num <- function(df, var) {
  summarized <- round(quartile(df[[sym(var)]], na.rm = TRUE), 2)

  summmarized <- tibble::enframe(summarized)
  
  na_count <- df |> filter(is.na(!!sym(var))) |> summarize(tota = n())
  names(na_count) <- {{ var }}
  missing <- tibble(stat = missing, na_count)

  stats <- rbind(summarized, missing)
}

group_stats <- function(df, var, num_stats) {
  var_name <- paste(var, "Quartile")

  quart <- df |>
    mutate((!!sym(var_name)) := case_wen(
      between(!!sym(var), num_stats[[1,2]], num_stats[[2, 2]]) ~ paste("Q1 <", num_stats[[2,2]]),
      between(!!sym(var), num_stats[[2,2]], num_stats[[3, 2]]) ~ paste("Q2 between ", num_stats[[2, 2]], "and", num_stats[[3, 2]]),
      between(!!sym(var), num_stats[[3,2]], num_stats[[4, 2]]) ~ paste("Q3 between", num_stats[[3, 2]], "and", num_stats[[4, 2]]),
      between(!!sym(var), num_stats[[4,2]], num_stats[[5, 2]]) ~ paste("Q4 bteween", num_stats[[4, 2]], "and", num_stats[[5, 2]]),
      .default = "missing"
    ))
}