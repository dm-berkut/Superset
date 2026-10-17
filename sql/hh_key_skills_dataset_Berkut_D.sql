SELECT
    id,
    technology,
    city,
    experience,
    published,
    toDate(published) AS published_date,

    skill_clean AS key_skill,

    multiIf(
        positionCaseInsensitiveUTF8(skill_clean, '1c') > 0
        OR positionCaseInsensitiveUTF8(skill_clean, '1с') > 0,
        '1C',

        lowerUTF8(skill_clean)
    ) AS key_skill_normalized

FROM
(
    SELECT
        id,
        technology,
        city,
        experience,
        published,
        trim(BOTH ' ' FROM skill) AS skill_clean
    FROM default.HH
    ARRAY JOIN splitByChar(',', key_skills) AS skill
    WHERE key_skills != ''
      AND trim(BOTH ' ' FROM skill) != ''
);