import json
import sqlite3

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

connection = sqlite3.connect("giftmap-halloween22.db")
connection.row_factory = dict_factory
c = connection.cursor()

c.execute('''SELECT * FROM log WHERE typ == 'gift' GROUP BY gift_string;''')
a = {}
for k in c.fetchall():
    a['x'+str(int(float(k["gift_string"])))] = {"x": k["x"], "y": k["y"], "z": k["z"]}
print(json.dumps(a))
print("")
print(len(a))
