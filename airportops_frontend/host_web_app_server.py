from http.server import HTTPServer, BaseHTTPRequestHandler
import ssl
import socketserver
import http
import os

if os.path.exists("cert.pem"):
    print("KEY PRESENT")
else:
    print("KEY NOT PRESENT")

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain("cert.pem")
server_address = ('0.0.0.0', 4443)
handler = http.server.SimpleHTTPRequestHandler
with socketserver.TCPServer(server_address, handler) as httpd:
    httpd.socket = context.wrap_socket(httpd.socket, server_side=True)
    httpd.serve_forever()
