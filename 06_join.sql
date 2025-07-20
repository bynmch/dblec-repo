-- JOIN
SELECT
       a.menu_name
     , b.category_name
  FROM tbl_menu a
  JOIN tbl_category b ON a.category_code = b.category_code;