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

COPY start-application.sh /start-application.sh

RUN chmod +x /start-application.sh

EXPOSE 8000

ENTRYPOINT ["/start-application.sh"]