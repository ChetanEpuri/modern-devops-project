from flask import Flask, jsonify
import os
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time

app = Flask(__name__)

# Define custom metrics
REQUEST_COUNT = Counter(
    'app_requests_total',
    'Total number of requests',
    ['method', 'endpoint', 'status']
)

REQUEST_LATENCY = Histogram(
    'app_request_latency_seconds',
    'Request latency in seconds',
    ['endpoint']
)

@app.before_request
def start_timer():
    app.config['start_time'] = time.time()

@app.after_request
def record_metrics(response):
    from flask import request
    latency = time.time() - app.config.get('start_time', time.time())
    REQUEST_COUNT.labels(
        method=request.method,
        endpoint=request.path,
        status=response.status_code
    ).inc()
    REQUEST_LATENCY.labels(endpoint=request.path).observe(latency)
    return response

@app.route('/api/products', methods=['GET'])
def get_products():
    return jsonify([
        {"id": 1, "name": "Cloud Optimizer Pro", "price": 49.99},
        {"id": 2, "name": "GitOps Automator", "price": 99.99},
        {"id": 3, "name": "DevOps Master Kit", "price": 149.99}
    ])

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy", "environment": os.getenv("ENV", "development")}), 200

@app.route('/metrics', methods=['GET'])
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)