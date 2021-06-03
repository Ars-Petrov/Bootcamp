from robot.libraries.BuiltIn import BuiltIn

class Work:
    builtin_lib: BuiltIn = BuiltIn()
    def Mult_table(self, amount):
        sql = """SELECT DISTINCT prod.prod_id, title FROM bootcamp.cust_hist AS cust INNER JOIN bootcamp.products AS prod ON cust.prod_id=prod.prod_id WHERE "customerid" < %(amount)s"""
        params = {"amount": amount}
        return self.get_postgresql_lib().execute_sql_string_mapped(sql, **params)

    def Insert_sql(self, category, categoryname):
        sql = """INSERT INTO bootcamp.categories (category, categoryname) VALUES (%(category)s, %(name)s); SELECT category FROM bootcamp.categories"""
        params = {"category": category, "name": categoryname}
        return self.get_postgresql_lib().execute_sql_string_mapped(sql, **params)

    def Table_Count(self):
        sql = """SELECT COUNT(*) FROM bootcamp.categories"""
        return self.get_postgresql_lib().execute_sql_string_mapped(sql)

    def get_postgresql_lib(self):
        return self.builtin_lib.get_library_instance("DB")