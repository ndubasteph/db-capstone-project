```python
!pip install mysql-connector-python
```

    Requirement already satisfied: mysql-connector-python in c:\users\nd(strengr)\appdata\local\programs\python\python311\lib\site-packages (8.0.32)
    Requirement already satisfied: protobuf<=3.20.3,>=3.11.0 in c:\users\nd(strengr)\appdata\local\programs\python\python311\lib\site-packages (from mysql-connector-python) (3.20.3)
    


```python
import mysql.connector as connector
```


```python
connection = connector.connect(user = "root", password = "jomocin", db ="LittleLemonDB")
```


```python
cursor = connection.cursor()
```


```python
show_tables_query = "SHOW tables" 
cursor.execute(show_tables_query)
```


```python
results = cursor.fetchall()
print(results)
```

    [('bookings',), ('customers',), ('deliverystatus',), ('menu',), ('menuitem',), ('menus',), ('orders',), ('ordersview',), ('staff',)]
    


```python
promotion_querry = """"SELECT CONCAT(Customers.FirstName, ',', Customers.LastName) AS 'FullName', Orders.TotalCost
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID WHERE Orders.TotalCost > 60;"""


```


```python
cursor.execute(promotion_querry)
```


    ---------------------------------------------------------------------------

    MySQLInterfaceError                       Traceback (most recent call last)

    File ~\AppData\Local\Programs\Python\Python311\Lib\site-packages\mysql\connector\connection_cext.py:608, in CMySQLConnection.cmd_query(self, query, raw, buffered, raw_as_string)
        607         query = query.encode("utf-8")
    --> 608     self._cmysql.query(
        609         query,
        610         raw=raw,
        611         buffered=buffered,
        612         raw_as_string=raw_as_string,
        613         query_attrs=self._query_attrs,
        614     )
        615 except MySQLInterfaceError as err:
    

    MySQLInterfaceError: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '"SELECT CONCAT(Customers.FirstName, ',', Customers.LastName) AS 'FullName', Orde' at line 1

    
    The above exception was the direct cause of the following exception:
    

    ProgrammingError                          Traceback (most recent call last)

    Cell In[8], line 1
    ----> 1 cursor.execute(promotion_querry)
    

    File ~\AppData\Local\Programs\Python\Python311\Lib\site-packages\mysql\connector\cursor_cext.py:330, in CMySQLCursor.execute(self, operation, params, multi)
        325             raise ProgrammingError(
        326                 "Not all parameters were used in the SQL statement"
        327             )
        329 try:
    --> 330     result = self._cnx.cmd_query(
        331         stmt,
        332         raw=self._raw,
        333         buffered=self._buffered,
        334         raw_as_string=self._raw_as_string,
        335     )
        336 except MySQLInterfaceError as err:
        337     raise get_mysql_exception(
        338         msg=err.msg, errno=err.errno, sqlstate=err.sqlstate
        339     ) from err
    

    File ~\AppData\Local\Programs\Python\Python311\Lib\site-packages\mysql\connector\connection_cext.py:616, in CMySQLConnection.cmd_query(self, query, raw, buffered, raw_as_string)
        608     self._cmysql.query(
        609         query,
        610         raw=raw,
       (...)
        613         query_attrs=self._query_attrs,
        614     )
        615 except MySQLInterfaceError as err:
    --> 616     raise get_mysql_exception(
        617         err.errno, msg=err.msg, sqlstate=err.sqlstate
        618     ) from err
        619 except AttributeError as err:
        620     addr = (
        621         self._unix_socket if self._unix_socket else f"{self._host}:{self._port}"
        622     )
    

    ProgrammingError: 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '"SELECT CONCAT(Customers.FirstName, ',', Customers.LastName) AS 'FullName', Orde' at line 1



```python

```
