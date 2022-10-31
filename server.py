import json
import time
import urllib.parse
import sqlite3

from sanic import Sanic
from sanic.response import text
from sanic.exceptions import NotFound

from sanic_limiter import Limiter

def get_remote_address(request):
    return request.ip

app = Sanic("receiveCoords")
limiter = Limiter(app, key_func=get_remote_address)

connection = sqlite3.connect("giftmap-halloween22.db")
c = connection.cursor()

c.execute('''CREATE TABLE IF NOT EXISTS "log" (
	"id"	INTEGER,
	"timestamp"	INTEGER,
	"rand"	INTEGER,
	"typ"	TEXT,
	"ip"	TEXT,
	"gift_string" TEXT,
	"x"	REAL,
	"y"	REAL,
	"z"	REAL,
	PRIMARY KEY("id" AUTOINCREMENT)
);''')
connection.commit()

def ctime():
    return int(time.time())

@app.route('/result')
async def result(result):
    return text('result')

@limiter.limit("10/minute")
@app.exception(NotFound)
async def add_new_pumpkin(request, exception):
    info = json.loads(urllib.parse.unquote(request.path).replace("/", ""))

    c.execute("INSERT INTO log('timestamp','ip', 'gift_string', 'x','y','z', 'typ', 'rand') VALUES (?,?,?,?,?,?,?,?)", (ctime(), request.ip, info["gift_string"], info["x"], info['y'], info['z'], info['typ'], info['rand']))
    connection.commit()
    return text("ok")

app.run(host="0.0.0.0", port=13625)
