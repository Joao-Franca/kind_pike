# Use uma imagem oficial do Python como imagem pai
FROM python:3.10-slim

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Define variáveis de ambiente para evitar a criação de arquivos .pyc
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# Instala os pacotes necessários especificados em requirements.txt
# --no-cache-dir para não armazenar o cache do pip e manter a imagem menor
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Comando para rodar a aplicação
# --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]