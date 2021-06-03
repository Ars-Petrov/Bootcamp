*** Variables ***
${insert_SQL}            INSERT INTO bootcamp.categories (category, categoryname) values (%(category)s, %(name)s) returning category
${select_SQL}            SELECT category FROM bootcamp.categories
${count_SQL}             SELECT COUNT(category) FROM bootcamp.categories
${remove_SQL}            DELETE FROM bootcamp.categories where category=17 returning ''
${table_name}            bootcamp.categories