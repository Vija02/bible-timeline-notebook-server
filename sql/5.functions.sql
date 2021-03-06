\c overrise  

CREATE OR REPLACE FUNCTION viewer() RETURNS "user" AS $$
  SELECT *
  FROM "user"
  WHERE id = current_setting('jwt.claims.user_id')::INTEGER
$$ LANGUAGE SQL STABLE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION viewer TO standard_user;

CREATE OR REPLACE FUNCTION get_chapter_of_the_day() RETURNS chapter_of_the_day AS $$
  SELECT * FROM chapter_of_the_day WHERE chapter_date = (CURRENT_TIMESTAMP AT TIME ZONE 'Europe/London')::DATE;
$$ LANGUAGE SQL STABLE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION get_chapter_of_the_day TO standard_user;

CREATE OR REPLACE FUNCTION chapter_of_the_day_esv(c chapter_of_the_day)
RETURNS SETOF esv as $$  
  SELECT * FROM esv WHERE book_id = c.book_id AND chapter = c.chapter
$$ language sql stable;

GRANT EXECUTE ON FUNCTION chapter_of_the_day_esv TO standard_user;