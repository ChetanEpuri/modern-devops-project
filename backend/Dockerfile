# Stage 1: Build
FROM python:3.11-slim AS builder
WORKDIR /app
RUN pip install --no-cache-dir flask

# Stage 2: Final image
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY app.py .

# Non-root user for security
RUN useradd -u 10001 appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]