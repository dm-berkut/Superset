SELECT
    id,
    technology,
    name,
    company,
    city,
    salary_display,
    salary_from,
    salary_to,
    salary_currency,
    experience,

    if(employment = '', 'Не указано', employment) AS employment_clean,
    if(schedule = '', 'Не указано', schedule) AS schedule_clean,

    published,
    toDate(published) AS published_date,

    CAST(
        multiIf(
            salary_currency = 'EUR', salary_raw * 87,
            salary_currency = 'USD', salary_raw * 77,
            salary_raw
        ) AS Nullable(Int64)
    ) AS salary_avg_rub

FROM
(
    SELECT
        *,
        multiIf(
            salary_from > 0 AND salary_to > 0, toFloat64((salary_from + salary_to) / 2),
            salary_from > 0 AND salary_to = 0, toFloat64(salary_from),
            salary_from = 0 AND salary_to > 0, toFloat64(salary_to),
            NULL
        ) AS salary_raw
    FROM default.HH
);