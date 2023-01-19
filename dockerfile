FROM python:3.8-slim-buster

# Set environment varibles
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy application code
COPY . .

# Expose port
EXPOSE 5000

# Run the command to start uWSGI
CMD ["flask", "run", "--host=0.0.0.0"]
