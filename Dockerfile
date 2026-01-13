FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt uvicorn

COPY . .

RUN sed -i 's/\r$//' start-application.sh \
    && chmod +x start-application.sh

EXPOSE 8000

CMD ["/bin/bash", "-c", "if [ -f /workspace/start-application.sh ]; then exec /workspace/start-application.sh; elif [ -f /start-application.sh ]; then exec /start-application.sh; else echo 'Warning: start-application.sh not found, starting server directly...'; exec uvicorn application:app --host 0.0.0.0 --port 8000; fi"]