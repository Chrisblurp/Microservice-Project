from flask import Flask, request, jsonify
import jwt
import datetime

app = Flask(__name__)
SECRET_KEY = "supersecretkey"

@app.route("/")
def home():
    return {"message": "Auth Service Running"}

@app.route("/health")
def health():
    return {"status": "ok"}

@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()

    username = data.get("username")
    password = data.get("password")

    # Simple mock authentication
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
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return jsonify({"valid": True, "user": decoded["user"]})
    except:
        return jsonify({"valid": False}), 401

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4000)