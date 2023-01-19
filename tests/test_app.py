import os
import unittest
from app import app

class BasicTests(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        app.config['WTF_CSRF_ENABLED'] = False
        app.config['DEBUG'] = False
        self.app = app.test_client()

    def test_upload_file(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Upload File', response.data)

        # test file upload
        with open("testfile.txt", "rb") as fp:
            response = self.app.post("/upload", data={"file": (fp, "testfile.txt")})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'The file format of the uploaded file is: text/plain', response.data)

    def test_404_page(self):
        response = self.app.get('/not-exist')
        self.assertEqual(response.status_code, 404)
        self.assertIn(b'404 Error: Not Found', response.data)

if __name__ == "__main__":
    unittest.main()
