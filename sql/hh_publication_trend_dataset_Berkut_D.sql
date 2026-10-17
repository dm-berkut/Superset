WITH weekly AS
(
    SELECT
        toStartOfWeek(published, 1) AS week_start,
        count(*) AS vacancies_count
    FROM default.HH
    GROUP BY week_start
)

SELECT
    week_start,
    vacancies_count,
    avg(vacancies_count) OVER (
        ORDER BY week_start
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS trend_3w
FROM weekly
ORDER BY week_start;