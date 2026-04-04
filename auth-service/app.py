from flask import Flask, request, jsonify
import jwt
import datetime
import time
import os

app = Flask(__name__)
SECRET_KEY = "supersecretkey"
start_time = time.time()

@app.route("/")
def home():
    return {"message": "Auth Service Running"}

@app.route("/health")
def health():
    return {"status": "ok"}

@app.route("/status")
def status():
    return {
        "status": "running",
        "service": "authentication",
        "uptime_seconds": round(time.time() - start_time, 2),
        "timestamp": datetime.datetime.utcnow().isoformat()
    }

@app.route("/metrics")
def metrics():
    return {
        "service": "auth-service",
        "uptime_seconds": round(time.time() - start_time, 2),
        "python_version": "3.11",
        "jwt_enabled": True
    }

@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")
    
    if username == "admin" and password == "password":
        token = jwt.encode(
            {
                "user": username,
                "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=1)
            },
            SECRET_KEY,
            algorithm="HS256"
        )
        return jsonify({"token": token})
    return jsonify({"error": "Invalid credentials"}), 401

@app.route("/verify", methods=["POST"])
def verify():
    token = request.headers.get("Authorization")
    try:
        if token and token.startswith('Bearer '):
            token = token[7:]
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return jsonify({"valid": True, "user": decoded["user"]})
    except:
        return jsonify({"valid": False}), 401

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4000)
