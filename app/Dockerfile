
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
COPY src/ .

RUN pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "app.py"]
