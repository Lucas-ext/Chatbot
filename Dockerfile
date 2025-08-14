FROM python:3.11-slim

WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia código e o banco sqlite (leitura)
COPY . .
# Se o DB for somente leitura, considere ajustar permissões ou montar volume
# RUN chmod 444 /app/base_chatbot.db

ENV PORT=8080
EXPOSE 8080

# 2 workers e 4 threads costumam ser ok para I/O-bound (ajuste se precisar)
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app", "--workers", "2", "--threads", "4", "--timeout", "120"]
