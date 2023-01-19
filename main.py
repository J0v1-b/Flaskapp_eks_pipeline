from flask import Flask, request, render_template
import os
import magic

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('upload.html')

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    file.save(os.path.join('uploads', file.filename))
    file_path = os.path.join('uploads', file.filename)
    file_format = magic.from_file(file_path, mime=True)
    return 'The file format of the uploaded file is: {}'.format(file_format)

if __name__ == '__main__':
    app.run(debug=True)
