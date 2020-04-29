import os

from flask import Flask, json, Response

app = Flask(__name__)

@app.route('/status', methods=['GET'])
def get_status():
    data = {
        'status': 'up',
    }
    js = json.dumps(data)

    resp = Response(js, status=200, mimetype='application/json')

    return resp

@app.route('/')
def hello_world():
    target = os.environ.get('TARGET', 'World')
    platform = os.environ.get('K_SERVICE', 'My_App')
    return 'Hello {}, My name is {} and I am running on cloud run\n'.format(target,platform)

if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080)))
