FROM python:3.12-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Railway sets PORT env var at runtime
ENV PYTHONUNBUFFERED=1

# Use exec form for proper signal handling
CMD ["sh", "-c", "gunicorn app:app --bind 0.0.0.0:${PORT:-5000} --workers 1 --timeout 120"]
