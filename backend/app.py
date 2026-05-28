from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/api/products', methods=['GET'])
def get_products():
    return jsonify([
        {"id": 1, "name": "Cloud Optimizer Pro", "price": 49.99},
        {"id": 2, "name": "GitOps Automator", "price": 99.99}
    ])

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy", "environment": os.getenv("ENV", "development")}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)