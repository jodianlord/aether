from flask import Flask

app = Flask('http://localhost:8080')

@app.route('/helloFlask')
def hello():
    return 'Hello, World!'

hello()